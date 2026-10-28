 
 
_G.__LOLCAT_FORCE_MODE = "Hybrid"
local INSTANCE = {}
_G.__lolcatBSS = INSTANCE
local SHUTDOWN_HOOK
task.spawn(function()
    while _G.__lolcatBSS == INSTANCE do
        task.wait(0.6)
    end
    if SHUTDOWN_HOOK then pcall(SHUTDOWN_HOOK) end
end)

local HttpService
pcall(function() HttpService = game:GetService("HttpService") end)
local UIS
pcall(function() UIS = game:GetService("UserInputService") end)

 
 
 
 
 
 
 
 
 
 
do
local env = getfenv()

if env.__kittyDestroy then pcall(env.__kittyDestroy) end

assert(Drawing and Drawing.new, "lolcat requires the Matcha Drawing API")

local V = Vector2.new
local RGB = Color3.fromRGB
 
 
local CNEW = (type(Color3) == "table" and type(Color3.new) == "function") and Color3.new
    or function(r, g, b) return RGB((r or 0) * 255, (g or 0) * 255, (b or 0) * 255) end
local floor, ceil = math.floor, math.ceil
local min, max, clamp = math.min, math.max, math.clamp
local cos, sin, pi = math.cos, math.sin, math.pi

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()

local Fonts = Drawing.Fonts or {}
local F_SYS  = Fonts.System or 1
local F_BOLD = Fonts.SystemBold or 2

 
 
 
local C = {
    bg     = RGB(19, 20, 23),
    panel  = RGB(25, 27, 31),
    side   = RGB(22, 24, 27),
    card   = RGB(34, 37, 42),
    cardHi = RGB(43, 47, 53),
    track  = RGB(53, 58, 65),
    hair   = RGB(44, 48, 55),
    text   = RGB(233, 235, 240),
    dim    = RGB(150, 156, 166),
    head   = RGB(138, 145, 157),
    faint  = RGB(100, 105, 114),
    white  = RGB(255, 255, 255),
    black  = RGB(0, 0, 0),
    red    = RGB(255, 106, 118),
}
local ACCENT = RGB(126, 138, 255)
local accent = ACCENT

 
local THEMES = {
    Purple = { accent = RGB(126, 138, 255), bg = RGB(19, 20, 23) },
    Blue   = { accent = RGB(96, 168, 255),  bg = RGB(17, 21, 27) },
    Mint   = { accent = RGB(90, 220, 168),  bg = RGB(16, 23, 21) },
    Amber  = { accent = RGB(255, 186, 96),  bg = RGB(24, 21, 16) },
    Rose   = { accent = RGB(255, 118, 156), bg = RGB(25, 17, 22) },
    Mono   = { accent = RGB(226, 231, 240), bg = RGB(17, 18, 20) },
}

local function mix(a, b, t)
    t = clamp(t or 0, 0, 1)
     
     
     
     
    return CNEW(a.R + (b.R - a.R) * t, a.G + (b.G - a.G) * t, a.B + (b.B - a.B) * t)
end

local function approach(value, goal, speed, dt)
    return value + (goal - value) * (1 - math.exp(-(dt or 0.016) * speed))
end

 
local BTN = RGB(0, 0, 0)
local BTN_HI = RGB(0, 0, 0)
local function refreshButtonColors()
     
    BTN = mix(C.bg, accent, 0.86)
    BTN_HI = mix(BTN, C.white, 0.16)
end

local dragging = false

 
 
local busyUntil = 0
local function touchBusy(seconds)
    local until_ = os.clock() + (seconds or 0.45)
    if until_ > busyUntil then busyUntil = until_ end
end

 
 
 
local pool, used = {}, {}

 
 
 
local function wrap(instance)
    local cache, supported = {}, {}
    return setmetatable({}, {
        __index = function(_, key) return instance[key] end,
        __newindex = function(_, key, value)
            if supported[key] == false then return end
            if cache[key] == value then return end

            if supported[key] == nil then
                 
                 
                local ok = pcall(function() instance[key] = value end)
                supported[key] = ok
                if ok then cache[key] = value end
            else
                instance[key] = value
                cache[key] = value
            end
        end,
    })
end

local function take(kind)
    used[kind] = (used[kind] or 0) + 1
    local list = pool[kind]
    if not list then list = {}; pool[kind] = list end
    local o = list[used[kind]]
    if not o then
        local ok, created = pcall(Drawing.new, kind)
        if not ok or not created then return nil end
        o = wrap(created)
        list[used[kind]] = o
        pcall(function()
            if kind == "Square" then
                o.Filled = true
            elseif kind == "Text" then
                o.Outline = false
                o.Center = false
            end
        end)
    end
    o.Visible = true
    return o
end

local function beginFrame()
    for k in pairs(used) do used[k] = 0 end
end

local function endFrame()
    for kind, list in pairs(pool) do
        local n = used[kind] or 0
        for i = n + 1, #list do
            local o = list[i]
            if o and o.Visible ~= false then pcall(function() o.Visible = false end) end
        end
    end
end

local function hideAll()
    for _, list in pairs(pool) do
        for i = 1, #list do pcall(function() list[i].Visible = false end) end
    end
end

 
 
 
 
 
local function rect(x, y, w, h, color, a, round, z)
    if w <= 0 or h <= 0 or (a or 1) <= 0.004 then return end
    local o = take("Square")
    if not o then return end
    o.Position = V(x, y)
    o.Size = V(max(1, w), max(1, h))
    o.Color = color
    o.Transparency = clamp(a or 1, 0, 1)
    o.Filled = true
    o.ZIndex = z or 20
    o.Corner = round or 0
end

local function stroke(x, y, w, h, color, a, round, z, thickness)
    if w <= 0 or h <= 0 or (a or 1) <= 0.004 then return end
    local o = take("Square")
    if not o then return end
    o.Position = V(x, y)
    o.Size = V(max(1, w), max(1, h))
    o.Color = color
    o.Transparency = clamp(a or 1, 0, 1)
    o.Filled = false
    o.Thickness = thickness or 1
    o.ZIndex = z or 21
    o.Corner = round or 0
end

local function line(x1, y1, x2, y2, color, a, z, thickness)
    if (a or 1) <= 0.004 then return end
    local o = take("Line")
    if not o then return end
    o.From = V(x1, y1)
    o.To = V(x2, y2)
    o.Color = color
    o.Transparency = clamp(a or 1, 0, 1)
    o.Thickness = thickness or 1
    o.ZIndex = z or 24
end

local function circle(x, y, r, color, a, filled, z)
    if r <= 0 or (a or 1) <= 0.004 then return end
    local o = take("Circle")
    if not o then return end
    o.Position = V(x, y)
    o.Radius = r
    o.Filled = filled == true
    o.NumSides = 24
    o.Thickness = 1
    o.Color = color
    o.Transparency = clamp(a or 1, 0, 1)
    o.ZIndex = z or 25
end

local function text(x, y, str, size, color, a, bold, z, center)
    str = tostring(str or "")
    if str == "" or (a or 1) <= 0.004 then return end
    local o = take("Text")
    if not o then return end
    o.Text = str
    o.Position = V(x, y)
    o.Size = floor(size + 0.5)
    o.Font = bold and F_BOLD or F_SYS
    o.Color = color
    o.Transparency = clamp(a or 1, 0, 1)
    o.ZIndex = z or 30
    o.Center = center == true
end

 
local function textWidth(str, size, bold)
    return #tostring(str or "") * size * (bold and 0.545 or 0.505)
end

local function fit(str, width, size, bold)
    str = tostring(str or "")
    if textWidth(str, size, bold) <= width then return str end
    local limit = max(1, floor(width / (size * (bold and 0.545 or 0.505))) - 2)
    if limit <= 1 then return string.sub(str, 1, 1) end
    return string.sub(str, 1, limit) .. ".."
end

 
 
 
local PATHS = {
    home   = {{1,9,10,1},{10,1,19,9},{3,8,3,18},{3,18,8,18},{8,18,8,12},{8,12,12,12},{12,12,12,18},{12,18,17,18},{17,18,17,8}},
    script = {{6,4,2,10},{2,10,6,16},{14,4,18,10},{18,10,14,16},{12,3,8,17}},
    layers = {{2,6,10,2},{10,2,18,6},{18,6,10,10},{10,10,2,6},{2,10,10,14},{10,14,18,10},{2,14,10,18},{10,18,18,14}},
    bolt   = {{11,1,3,11},{3,11,9,11},{9,11,8,19},{8,19,17,8},{17,8,11,8},{11,8,11,1}},
    shield = {{3,3,10,1},{10,1,17,3},{17,3,16,12},{16,12,10,19},{10,19,4,12},{4,12,3,3},{7,9,9,12},{9,12,14,6}},
    palette= {{3,4,17,4},{17,4,17,16},{17,16,3,16},{3,16,3,4},{7,4,7,16},{12,4,12,16}},
    power  = {{10,1,10,10},{5,4,2,8},{2,8,2,14},{2,14,6,18},{6,18,14,18},{14,18,18,14},{18,14,18,8},{18,8,15,4}},
    sliders= {{2,5,6,5},{10,5,18,5},{6,2,6,8},{10,2,10,8},{6,2,10,2},{6,8,10,8},{2,15,11,15},{15,15,18,15},{11,12,15,12},{11,18,15,18},{11,12,11,18},{15,12,15,18}},
    close  = {{5,5,15,15},{15,5,5,15}},
    minus  = {{3,10,17,10}},
    check  = {{4,10,8,14},{8,14,16,5}},
    key    = {{3,6,17,6},{17,6,17,15},{17,15,3,15},{3,15,3,6},{6,10,7,10},{10,10,11,10},{13,10,14,10},{7,13,13,13}},
    info   = {{10,5,10,6},{10,9,10,15},{8,15,12,15}},
    dot    = {{9.3,9.3,10.7,10.7}},
    down   = {{5,7,10,12},{10,12,15,7}},
    up     = {{5,12,10,7},{10,7,15,12}},
    plant  = {{5,12,15,12},{6,12,7.5,18},{7.5,18,12.5,18},{12.5,18,14,12},{10,12,10,7},{10,7,6.5,5},{10,7,14,4.5}},
    swords = {{3.5,16.5,15,5},{5.5,18.5,17,7},{4,13,7,16},{13,4,16,7}},
    cube   = {{3,6,10,2},{10,2,17,6},{17,6,10,10},{10,10,3,6},{3,6,3,14},{3,14,10,18},{10,18,17,14},{17,14,17,6},{10,10,10,18}},
    gauge  = {{3,15,4.5,9.5},{4.5,9.5,7.5,6.5},{7.5,6.5,12,5.5},{12,5.5,15.5,7},{15.5,7,17.5,10.5},{17.5,10.5,17,15},{10,14,14,9.5},{3,15,17,15}},
    clock  = {{3,10,10,3},{10,3,17,10},{17,10,10,17},{10,17,3,10},{10,6,10,10},{10,10,13.5,11.5}},
}
do
    local sun = {}
    for i = 0, 11 do
        local t, u = i * pi / 6, (i + 1) * pi / 6
        sun[#sun + 1] = {10 + cos(t) * 4.2, 10 + sin(t) * 4.2, 10 + cos(u) * 4.2, 10 + sin(u) * 4.2}
    end
    for i = 0, 7 do
        local t = i * pi / 4
        sun[#sun + 1] = {10 + cos(t) * 7, 10 + sin(t) * 7, 10 + cos(t) * 9.4, 10 + sin(t) * 9.4}
    end
    PATHS.sun = sun

    local gear = {}
    for i = 0, 11 do
        local t, u = i * pi / 6, (i + 1) * pi / 6
        gear[#gear + 1] = {10 + cos(t) * 7, 10 + sin(t) * 7, 10 + cos(u) * 7, 10 + sin(u) * 7}
        if i % 2 == 0 then
            gear[#gear + 1] = {10 + cos(t) * 7, 10 + sin(t) * 7, 10 + cos(t) * 10, 10 + sin(t) * 10}
        end
    end
    for i = 0, 7 do
        local t, u = i * pi / 4, (i + 1) * pi / 4
        gear[#gear + 1] = {10 + cos(t) * 2.6, 10 + sin(t) * 2.6, 10 + cos(u) * 2.6, 10 + sin(u) * 2.6}
    end
    PATHS.gear = gear
end

local function icon(name, x, y, size, color, a, z)
    local strokes = PATHS[name] or PATHS.dot
    local k = size / 20
    local th = max(1, size / 12)
    for i = 1, #strokes do
        local p = strokes[i]
        line(x + p[1] * k, y + p[2] * k, x + p[3] * k, y + p[4] * k, color, a, z, th)
    end
end

 
 
 
local Pointer = { X = 0, Y = 0, Down = false, Click = false, Used = false, Blocked = false, DT = 0, Active = true }

local function inside(x, y, w, h)
    return Pointer.X >= x and Pointer.X <= x + w and Pointer.Y >= y and Pointer.Y <= y + h
end

local function keyDown(vk)
    local ok, result = pcall(iskeypressed, vk)
    return ok and result == true
end

local keyState = {}

local function pollKeys(vk)
    local last = keyState[vk]
    local now = keyDown(vk)
    keyState[vk] = now
    return now and not last
end

local pollFrame = 0
local function pollInput(dt)
    local x, y

     
     
    pcall(function() x, y = mouse.X, mouse.Y end)
    if type(x) ~= "number" or type(y) ~= "number" then
        pcall(function()
            local p = mouse.Position
            if p then x, y = p.X, p.Y end
        end)
    end
    if (type(x) ~= "number" or type(y) ~= "number") and type(getmousepos) == "function" then
        pcall(function()
            local p = getmousepos()
            if p then x, y = p.X, p.Y end
        end)
    end

     
    local inject = _G.__kittyInject
    if type(inject) == "table" then
        if type(inject.x) == "number" then x = inject.x end
        if type(inject.y) == "number" then y = inject.y end
    end

    x, y = tonumber(x) or Pointer.X, tonumber(y) or Pointer.Y
    Pointer.X, Pointer.Y = x, y

    local active = true
    pcall(function() if type(isrbxactive) == "function" then active = isrbxactive() end end)
    Pointer.Active = active

    local down = false
    pcall(function() down = ismouse1pressed() == true end)
    if type(inject) == "table" then
        if inject.down ~= nil then down = inject.down == true end
        active = true
    end

    down = down and (active or type(inject) == "table")
    Pointer.Click = down and not Pointer.Down
    Pointer.Down = down
    if type(inject) == "table" and inject.click then
        Pointer.Click = true
        inject.click = false
    end
    if type(inject) == "table" and inject.release then
        Pointer.Click = false
        inject.release = false
    end
    Pointer.Used = false
    Pointer.Blocked = false
    Pointer.DT = dt or 0.016
end

 
local function clickFree()
    return Pointer.Click and not Pointer.Used
end

local function claimClick()
    Pointer.Click = false
    Pointer.Used = true
end

local TEXT_KEYS = {
    [32] = " ", [8] = "", [65] = "a", [66] = "b", [67] = "c", [68] = "d", [69] = "e",
    [70] = "f", [71] = "g", [72] = "h", [73] = "i", [74] = "j", [75] = "k", [76] = "l",
    [77] = "m", [78] = "n", [79] = "o", [80] = "p", [81] = "q", [82] = "r", [83] = "s",
    [84] = "t", [85] = "u", [86] = "v", [87] = "w", [88] = "x", [89] = "y", [90] = "z",
}

 
 
 
local Row = {}
Row.__index = Row

function Row:Set(value)
    local kind = self.Type

    if kind == "Toggle" then
        self.State = value and true or false
    elseif kind == "Slider" then
        self.Value = clamp(tonumber(value) or self.Value or self.Min, self.Min, self.Max)
    elseif kind == "Dropdown" then
        local pick = type(value) == "table" and value[1] or value
        if pick ~= nil then self.Selected = tostring(pick) end
    elseif kind == "InputLabel" then
        self.Text = tostring(value or "")
    end

    local payload
    if kind == "Toggle" then payload = self.State
    elseif kind == "Slider" then payload = self.Value
    elseif kind == "Dropdown" then payload = self.Selected
    elseif kind == "InputLabel" then payload = self.Text
    end

    if self.Callback then pcall(self.Callback, payload) end
    return self
end

function Row:Get()
    if self.Type == "Toggle" then return self.State end
    if self.Type == "Slider" then return self.Value end
    if self.Type == "Dropdown" then return { self.Selected } end
    if self.Type == "InputLabel" then return self.Text end
    return self.Value
end

function Row:SetRisk()
    self.Risk = true
    return self
end

function Row:SetName(name) self.Title = tostring(name); return self end
function Row:GetName() return self.Title end
function Row:Change(info) info = info or {}; if info.Name then self.Title = info.Name end; return self end

local function newRow(kind, fields)
    fields.Type = kind
    return setmetatable(fields, Row)
end

 
 
 
local Groupbox = {}
Groupbox.__index = Groupbox

local function pushRow(self, row)
    row.Parent = self
    self.Elements[#self.Elements + 1] = row
    return row
end

function Groupbox:AddButton(info)
    info = info or {}
    return pushRow(self, newRow("Button", {
        Title = tostring(info.Name or info.Title or "Button"),
        Callback = info.OnClick or info.Callback,
        Description = info.Description,
    }))
end

function Groupbox:AddToggle(info)
    info = info or {}
    return pushRow(self, newRow("Toggle", {
        Title = tostring(info.Name or info.Title or "Toggle"),
        State = (info.State == true),
        Callback = info.OnChanged or info.Callback,
        Description = info.Description,
    }))
end

function Groupbox:AddSlider(info)
    info = info or {}
    local lo = tonumber(info.MinValue or info.Min) or 0
    local hi = tonumber(info.MaxValue or info.Max) or 100
    if hi <= lo then hi = lo + 1 end
    return pushRow(self, newRow("Slider", {
        Title = tostring(info.Name or info.Title or "Slider"),
        Min = lo, Max = hi,
        Value = clamp(tonumber(info.CurrentValue or info.Default or info.Value) or lo, lo, hi),
        Step = tonumber(info.Step) or 1,
        Suffix = tostring(info.Suffix or ""),
        Callback = info.OnChanged or info.Callback,
        Description = info.Description,
        Digits = info.Digits,
    }))
end

function Groupbox:AddDropdown(info)
    info = info or {}
    local options = {}
    for i, option in ipairs(info.Options or {}) do options[i] = tostring(option) end
    local pick = info.Selected or info.Default
    if type(pick) == "table" then pick = pick[1] end
    return pushRow(self, newRow("Dropdown", {
        Title = tostring(info.Name or info.Title or "Dropdown"),
        Options = options,
        Selected = tostring(pick or options[1] or ""),
        Callback = info.OnSelecting or info.OnChanged or info.Callback,
        Description = info.Description,
    }))
end

function Groupbox:AddTextLabel(info)
    info = info or {}
    return pushRow(self, newRow("TextLabel", {
        Title = tostring(info.Title or info.Name or ""),
        Live = info.Live,
        Description = info.Description,
        Dim = info.Dim == true,
    }))
end

function Groupbox:AddInputLabel(info)
    info = info or {}
    return pushRow(self, newRow("InputLabel", {
        Title = tostring(info.Name or info.Title or "Input"),
        Text = tostring(info.Text or ""),
        Placeholder = tostring(info.Placeholder or ""),
        Callback = info.OnChanged or info.Callback,
        Description = info.Description,
    }))
end

function Groupbox:AddDivider(info)
    info = info or {}
    return pushRow(self, newRow("Divider", { Title = tostring(info.Title or "") }))
end

function Groupbox:AddParagraph(info)
    info = info or {}
    return pushRow(self, newRow("Paragraph", { Title = tostring(info.Title or info.Text or "") }))
end

 
 
 
local WindowClass = {}
WindowClass.__index = WindowClass

local KittyGui = {}
local windows = {}

local function round1(n) return floor(n + 0.5) end

function KittyGui:CreateWindow(info)
    info = info or {}

    local size = info.size or info.Size
    local w, h = 880, 600
    if size ~= nil then
        pcall(function()
            w = tonumber(size.X) or w
            h = tonumber(size.Y) or h
        end)
    end

    local window = setmetatable({
        Title = tostring(info.title or info.Title or "menu"),
        MiniTitle = tostring(info.subtitle or info.MiniTitle or ""),
        Icon = info.icon or "dot",
        W = w,
        H = h,
        X = 0,
        Y = 0,
        Placed = false,
        Visible = info.startOpen ~= false,
        Anim = 0,
        Tabs = {},
        ActiveTab = nil,
        Keybind = 112,
        Accent = accent,
        Notifications = {},
        Drag = nil,
        Dropdown = nil,
        DropdownRect = nil,
        Dialog = nil,
        Search = "",
        SearchFocus = false,
        Alive = true,
        Reduced = false,
    }, WindowClass)

    local accentColor = info.theme and (info.theme.accent or info.accentA)
    if accentColor then window.Accent = accentColor end
    if info.theme and info.theme.Base and info.theme.Base.R then window.Bg = info.theme.Base end

    windows[#windows + 1] = window
    return window
end

function WindowClass:CreateTab(info)
    info = info or {}
    local tab = {
        Type = "Tab",
        Name = tostring(info.Name or info.Title or "Tab"),
        Icon = tostring(info.Icon or info.icon or info.Image or "dot"),
        Parent = self,
        Groupboxes = {},
        Locked = false,
    }
    tab.AddGroupbox = function(_, config)
        config = config or {}
        local side = config.Side or config.side
        local group = {
            Type = "Groupbox",
            Name = tostring(config.Name or "section"),
            Side = side,
            Parent = tab,
            Elements = {},
            Collapsed = false,
        }
        setmetatable(group, Groupbox)
        tab.Groupboxes[#tab.Groupboxes + 1] = group
        return group
    end
    self.Tabs[#self.Tabs + 1] = tab
    if not self.ActiveTab then self.ActiveTab = tab end
    return tab
end

function WindowClass:SetMenuKey(vk)
    self.Keybind = tonumber(vk) or 112
end

function WindowClass:Minimize()
     
     
     
    self.Visible = false
    self.Minimized = true
    self.SearchFocus = false
    self.NeedsClear = true
    touchBusy(0.6)
end

function WindowClass:Open()
    self.Visible = true
    self.Minimized = false
    touchBusy(0.6)
end

function WindowClass:Toggle()
    self.Visible = not self.Visible
    self.Minimized = not self.Visible
    self.SearchFocus = false
    if not self.Visible then self.NeedsClear = true end
    touchBusy(0.6)
end

function WindowClass:IsOpen() return self.Visible end

function WindowClass:SetTheme(name)
    local theme = THEMES[name]
    if not theme then return false end
    self.ThemeName = name
    self.Accent = theme.accent
    self.Bg = theme.bg
    touchBusy(0.4)
    return true
end

function WindowClass:NeedsDraw()
    if not self.Alive then return true end

    local target = self.Visible and 1 or 0
    if math.abs(self.Anim - target) > 0.002 then return true end

    if not self.Visible then return self.NeedsClear == true or self.Minimized == true end

    if os.clock() < busyUntil then return true end
    if Pointer.Click or Pointer.Down or self.Drag then return true end
    if self.Dirty or self.Dropdown or self.Dialog then return true end

     
     
    if self.LastPX ~= Pointer.X or self.LastPY ~= Pointer.Y then
        local over = Pointer.X >= self.X - 6 and Pointer.X <= self.X + self.W + 6
            and Pointer.Y >= self.Y - 6 and Pointer.Y <= self.Y + self.H + 6
        if over or self.WasOver then return true end
    end

    return false
end

function WindowClass:Notify(info)
    info = info or {}
    touchBusy((tonumber(info.Duration) or 4) + 0.4)
    local entry = {
        Title = tostring(info.Title or "lolcat"),
        Content = tostring(info.Content or ""),
        Left = tonumber(info.Duration) or 4,
        Kind = tostring(info.Type or "info"),
        Anim = 0,
    }
    self.Notifications[#self.Notifications + 1] = entry
    while #self.Notifications > 4 do table.remove(self.Notifications, 1) end
    return entry
end

function WindowClass:Confirm(info)
    info = info or {}
    self.Dialog = {
        Title = tostring(info.Title or "Confirm"),
        Text = tostring(info.Text or ""),
        Text2 = tostring(info.Text2 or ""),
        Confirm = tostring(info.Confirm or "Confirm"),
        OnConfirm = info.OnConfirm,
    }
end

function WindowClass:Destroy()
    self.Alive = false
    self.Visible = false
    for i = #windows, 1, -1 do
        if windows[i] == self then table.remove(windows, i) end
    end
    hideAll()
end

 
 
 
local TOPBAR = 40
local SIDEBAR = 172
local PAD = 14
local GAP = 14
local ROW_GAP = 3

function WindowClass:Bounds()
    local a = self.Anim
    return self.X, self.Y + (1 - a) * 8, self.W, self.H, a
end

local function sideOf(tab, index)
    local left, right = {}, {}
    for i, group in ipairs(tab.Groupboxes) do
        local side = group.Side
        if side == "Right" or side == "right" or side == 2 then
            right[#right + 1] = group
        elseif side == "Left" or side == "left" or side == 1 then
            left[#left + 1] = group
        else
            if i % 2 == 1 then left[#left + 1] = group else right[#right + 1] = group end
        end
    end
    return left, right
end

local function wrapText(str, width, size)
    local chars = max(8, floor(width / (size * 0.505)))
    local lines, line = {}, ""
    for word in string.gmatch(tostring(str or ""), "%S+") do
        local candidate = line == "" and word or (line .. " " .. word)
        if #candidate <= chars then
            line = candidate
        else
            if line ~= "" then lines[#lines + 1] = line end
            line = word
        end
    end
    if line ~= "" then lines[#lines + 1] = line end
    if #lines == 0 then lines[1] = "" end
    return lines
end

local function measureElement(row, colW)
    local kind = row.Type
    if kind == "Paragraph" then
        return 12 + #wrapText(row.Title, colW - 8, 11) * 13
    elseif kind == "Divider" then
        return 20
    elseif kind == "TextLabel" then
        return row.Description and row.Description ~= "" and 30 or 18
    end
    return 0
end

local function columnHeights(groups, colW, rowH)
    local rows, fixed = 0, 0
    for _, group in ipairs(groups) do
        fixed = fixed + 22
        for _, row in ipairs(group.Elements) do
            local h = measureElement(row, colW)
            if h > 0 then fixed = fixed + h + ROW_GAP else rows = rows + 1 end
        end
        fixed = fixed + 6
    end
    return rows * (rowH + ROW_GAP) + fixed, rows, fixed
end

local function pickRowHeight(groupsA, groupsB, colW, avail)
    for h = 30, 17, -1 do
        local aTotal = columnHeights(groupsA, colW, h)
        local bTotal = columnHeights(groupsB, colW, h)
        if aTotal <= avail and bTotal <= avail then return h end
    end
    return 17
end

 
 
local function balance(left, right, colW)
    local REF = 24

    local function total(list) return (columnHeights(list, colW, REF)) end

    local l, r = total(left), total(right)
    local from, to = (l > r) and left or right
    local other = (l > r) and right or left

    local moved = 0
    while #from > 1 and moved < 3 do
        local before = max(total(from), total(other))

        local candidate = from[#from]
        table.remove(from, #from)
        other[#other + 1] = candidate

        local after = max(total(from), total(other))
        if after >= before - 1 then
            table.remove(other, #other)
            from[#from + 1] = candidate
            break
        end

        moved = moved + 1
    end
end

 
 
 
local drawRow

local function toggleRow(row, x, y, w, h, alpha)
    local hover = inside(x, y, w, h) and not Pointer.Blocked
    local on = row.State == true

     
    row.Anim = approach(row.Anim or (on and 1 or 0), on and 1 or 0, 22, Pointer.DT)
    local k = clamp(row.Anim, 0, 1)
    if k > 0.001 and k < 0.999 then touchBusy(0.25) end

    rect(x, y, w, h, hover and C.cardHi or C.card, alpha * (hover and 0.95 or 0.8), 5, 22)

    text(x + 10, y + h / 2 - 7, fit(row.Title, w - 62, 12, false), 12, C.text, alpha * 0.92, false, 31)

    local pw, ph = 30, 16
    local px, py = x + w - pw - 10, y + (h - ph) / 2

    rect(px, py, pw, ph, mix(C.track, accent, k), alpha * (0.7 + 0.28 * k), ph / 2, 23)
    circle(px + ph / 2 + (pw - ph) * k, py + ph / 2, 5.2, mix(C.dim, C.white, k), alpha * 0.95, true, 24)

    if hover and clickFree() then
        row.State = not row.State
        claimClick()
        touchBusy(0.4)
        if row.Callback then pcall(row.Callback, row.State) end
    end
end

local function sliderRow(row, x, y, w, h, alpha)
    local hover = inside(x, y, w, h) and not Pointer.Blocked
    rect(x, y, w, h, hover and C.cardHi or C.card, alpha * (hover and 0.95 or 0.8), 5, 22)

    local value = row.Value or row.Min or 0
    local label = row.Suffix ~= "" and (round1(value) .. row.Suffix) or tostring(round1(value))
    local labelW = textWidth(label, 11, true) + 6

    local trackX = x + floor(w * 0.44)
    local trackW = w - (trackX - x) - labelW - 16
    if trackW < 24 then trackW = 24 end
    local trackY = y + h / 2 - 2

    text(x + 10, y + h / 2 - 7, fit(row.Title, trackX - x - 14, 12, false), 12, C.text, alpha * 0.92, false, 31)

    rect(trackX, trackY, trackW, 4, C.track, alpha * 0.85, 2, 23)
    local t = clamp((value - row.Min) / max(0.0001, row.Max - row.Min), 0, 1)
    rect(trackX, trackY, trackW * t, 4, accent, alpha * 0.95, 2, 24)
    circle(trackX + trackW * t, trackY + 2, 4.6, C.white, alpha, true, 25)

    text(x + w - 10 - textWidth(label, 11, true), y + h / 2 - 6.5, label, 11, C.dim, alpha * 0.9, true, 31)

     
     
     
    local onTrack = Pointer.X >= trackX - 7 and Pointer.X <= trackX + trackW + 7
        and Pointer.Y >= y and Pointer.Y <= y + h

    if onTrack and hover and Pointer.Down and (Pointer.Click or row.Dragging) then
        row.Dragging = true
        local rel = clamp((Pointer.X - trackX) / max(1, trackW), 0, 1)
        local raw = row.Min + rel * (row.Max - row.Min)
        local step = row.Step or 1
        if step >= 1 then raw = floor(raw / step + 0.5) * step end
        raw = clamp(raw, row.Min, row.Max)
        if raw ~= row.Value then
            row.Value = raw
            if row.Callback then pcall(row.Callback, raw) end
        end
        claimClick()
    end

    if not Pointer.Down then row.Dragging = false end
end

local function dropdownRow(row, x, y, w, h, alpha, window)
    local hover = inside(x, y, w, h) and not Pointer.Blocked
    local open = window.Dropdown == row
    rect(x, y, w, h, (hover or open) and C.cardHi or C.card, alpha * (hover and 0.95 or 0.8), 5, 22)

    text(x + 10, y + h / 2 - 7, fit(row.Title, w * 0.4, 12, false), 12, C.text, alpha * 0.92, false, 31)

    local bw, bh = min(140, floor(w * 0.46)), h - 8
    local bx, by = x + w - bw - 8, y + 4
    rect(bx, by, bw, bh, open and mix(C.card, accent, 0.18) or C.track, alpha * 0.75, 4, 23)
    stroke(bx, by, bw, bh, open and accent or C.hair, alpha * (open and 0.8 or 0.6), 4, 24)
    text(bx + 8, by + bh / 2 - 6, fit(row.Selected, bw - 32, 11, false), 11, C.text, alpha * 0.9, false, 31)
    icon("down", bx + bw - 15, by + bh / 2 - 5, 10, open and accent or C.dim, alpha * 0.9, 31)

    row.Anchor = { x = bx, y = by, w = bw, h = bh }

    if hover and clickFree() and Pointer.Click then
        window.Dropdown = open and nil or row
        window.SearchFocus = false
        claimClick()
    end
end

local function buttonRow(row, x, y, w, h, alpha)
    local hover = inside(x, y, w, h) and not Pointer.Blocked
    local base = row.Risk and mix(C.bg, C.red, 0.66) or BTN
    local fill = hover and (row.Risk and mix(base, C.white, 0.10) or BTN_HI) or base

    rect(x, y, w, h, fill, alpha * 0.96, 5, 22)
    stroke(x, y, w, h, row.Risk and mix(C.red, C.white, 0.12) or mix(accent, C.white, 0.10), alpha * 0.45, 5, 23)
    text(x + w / 2, y + h / 2 - 7, fit(row.Title, w - 20, 12, true), 12,
        C.white, alpha * 0.98, true, 31, true)

    if hover and clickFree() then
        claimClick()
        if row.Callback then pcall(row.Callback) end
    end
end

local function textRow(row, x, y, w, alpha)
    local value = row.Title
    if row.Live then
        local ok, live = pcall(row.Live)
        if ok then value = tostring(live) end
    end
    if value == "" then return end
    text(x + 2, y + 1, fit(value, w - 6, 11, false), 11, row.Dim and C.dim or C.text, alpha * 0.78, false, 31)
    if row.Description and row.Description ~= "" then
        text(x + 2, y + 14, fit(row.Description, w - 6, 10, false), 10, C.faint, alpha * 0.8, false, 31)
    end
end

local function dividerRow(row, x, y, w, alpha)
    local label = string.upper(row.Title or "")
    local wl = label ~= "" and textWidth(label, 9, true) + 10 or 0
    if label ~= "" then
        text(x + 2, y + 3, label, 9, C.faint, alpha * 0.9, true, 31)
    end
    line(x + wl + 2, y + 7, x + w, y + 7, C.hair, alpha * 0.7, 24, 1)
end

local function paragraphRow(row, x, y, w, alpha, colW)
    local lines = wrapText(row.Title, colW - 8, 11)
    for i, entry in ipairs(lines) do
        text(x + 2, y + 2 + (i - 1) * 13, entry, 11, C.dim, alpha * 0.75, false, 31)
    end
end

 
 
 
local function renderNotifications(window, dt, vp)
    local n = #window.Notifications
    for i = n, 1, -1 do
        local note = window.Notifications[i]
        note.Left = note.Left - dt
        if note.Left <= 0 then table.remove(window.Notifications, i) end
    end

    local y = 18
    for i = 1, #window.Notifications do
        local note = window.Notifications[i]
        note.Anim = approach(note.Anim, 1, 12, dt)
        local a = note.Anim * clamp(note.Left / 0.4, 0, 1)
        local w = 250
        local h = 46
        local x = vp.X - w - 18
        rect(x, y, w, h, C.panel, a * 0.97, 6, 60)
        stroke(x, y, w, h, note.Kind == "error" and C.red or C.hair, a * 0.6, 6, 61)
        rect(x, y + 10, 3, h - 20, note.Kind == "error" and C.red or accent, a * 0.9, 2, 62)
        text(x + 12, y + 9, fit(note.Title, w - 24, 12, true), 12, C.text, a, true, 62)
        text(x + 12, y + 25, fit(note.Content, w - 24, 10, false), 10, C.dim, a * 0.85, false, 62)
        y = y + h + 8
    end
end

local function renderDialog(window, x, y, w, h)
    local d = window.Dialog
    if not d then return end

    rect(x, y, w, h, C.black, 0.5, 0, 90)

    local pw, ph = 330, 138
    local px, py = x + (w - pw) / 2, y + (h - ph) / 2
    rect(px, py, pw, ph, C.panel, 1, 8, 91)
    stroke(px, py, pw, ph, C.hair, 0.8, 8, 92)

    text(px + 18, py + 16, d.Title, 14, C.text, 1, true, 93)
    text(px + 18, py + 42, fit(d.Text, pw - 36, 11, false), 11, C.dim, 0.9, false, 93)
    if d.Text2 ~= "" then text(px + 18, py + 58, fit(d.Text2, pw - 36, 11, false), 11, C.dim, 0.9, false, 93) end

    local bw, bh = (pw - 46) / 2, 30
    local by = py + ph - bh - 16

    for index = 1, 2 do
        local bx = px + 18 + (index - 1) * (bw + 10)
        local hover = inside(bx, by, bw, bh)
        local confirm = index == 1
        rect(bx, by, bw, bh, confirm and mix(C.card, C.red, 0.35) or C.card, hover and 1 or 0.9, 5, 93)
        text(bx + bw / 2, by + bh / 2 - 7, confirm and d.Confirm or "Cancel", 12,
            confirm and C.red or C.text, 0.95, false, 94, true)
        if hover and Pointer.Click then
            window.Dialog = nil
            claimClick()
            if confirm and d.OnConfirm then pcall(d.OnConfirm) end
            return
        end
    end
end

local function drawTabs(window, bounds, alpha)
    local x, y, w, h = bounds.x, bounds.y, bounds.w, bounds.h
    local top = y + TOPBAR
    local bottom = y + h

    rect(x, top, SIDEBAR, bottom - top, C.side, alpha * 0.96, 0, 12)
    line(x + SIDEBAR, top + 1, x + SIDEBAR, bottom - 1, C.hair, alpha * 0.8, 13, 1)

     
    local sx, sy, sw, sh = x + 12, top + 12, SIDEBAR - 24, 28
    local searchHover = inside(sx, sy, sw, sh) and not Pointer.Blocked
    rect(sx, sy, sw, sh, C.card, alpha * (searchHover and 1 or 0.8), 5, 14)
    stroke(sx, sy, sw, sh, window.SearchFocus and accent or C.hair, alpha * (window.SearchFocus and 0.9 or 0.5), 5, 15)
    icon("sliders", sx + 8, sy + 7, 14, window.SearchFocus and accent or C.dim, alpha * 0.9, 16)

    local query = window.Search
    local shown = query ~= "" and query or "search"
    text(sx + 28, sy + 8, fit(shown, sw - 44, 11, false), 11,
        query ~= "" and C.text or C.faint, alpha * 0.9, false, 16)

    local clearHover = query ~= "" and inside(sx + sw - 22, sy + 6, 16, 16) and not Pointer.Blocked
    if query ~= "" then
        icon("close", sx + sw - 20, sy + 9, 10, clearHover and C.red or C.faint, alpha * 0.95, 16)
        if clearHover and clickFree() then
            window.Search = ""
            window.SearchFocus = false
            claimClick()
        end
    end

    if searchHover and clickFree() then
        if window.SearchFocus and query ~= "" then
            window.Search = ""
        end
        window.SearchFocus = true
        claimClick()
    end

    if window.SearchFocus then
        for vk, char in pairs(TEXT_KEYS) do
            if pollKeys(vk) then
                if vk == 8 then
                    window.Search = string.sub(window.Search, 1, max(0, #window.Search - 1))
                elseif #window.Search < 18 then
                    window.Search = window.Search .. char
                end
            end
        end
        if pollKeys(13) then window.SearchFocus = false end
        if Pointer.Click and not inside(sx - 12, sy - 12, SIDEBAR, sh + 24) then
            window.SearchFocus = false
            window.Search = ""
        end
    end

    local needle = string.lower(window.Search)
    local rowY = sy + sh + 10
    local shownTabs = {}

    for _, tab in ipairs(window.Tabs) do
        if needle == "" or string.find(string.lower(tab.Name), needle, 1, true) then
            shownTabs[#shownTabs + 1] = tab
        end
    end

    for _, tab in ipairs(shownTabs) do
        local hover = inside(x + 8, rowY, SIDEBAR - 16, 30) and not Pointer.Blocked
        local active = window.ActiveTab == tab

        if active then
            rect(x + 8, rowY, SIDEBAR - 16, 30, mix(C.card, accent, 0.18), alpha * 0.95, 5, 14)
        elseif hover then
            rect(x + 8, rowY, SIDEBAR - 16, 30, C.card, alpha * 0.55, 5, 14)
        end

        if dragging then
             
            rect(x + 22, rowY + 12, 7, 7, active and accent or C.dim, alpha * 0.85, 3, 16)
        else
            icon(tab.Icon, x + 18, rowY + 8, 15, active and accent or C.dim, alpha * (active and 1 or 0.75), 16)
        end
        text(x + 42, rowY + 9, fit(tab.Name, SIDEBAR - 58, 12, active), 12,
            active and C.text or C.dim, alpha * (active and 1 or 0.8), active, 16)

        if hover and clickFree() then
            window.ActiveTab = tab
            window.Dropdown = nil
            window.SearchFocus = false
            claimClick()
        end

        rowY = rowY + 32
    end

     
    local pw, ph = SIDEBAR - 24, 42
    local px, py = x + 12, bottom - ph - 12
    rect(px, py, pw, ph, C.card, alpha * 0.55, 5, 14)

    local name, display
    pcall(function() name = lp.Name end)
    pcall(function() display = lp.DisplayName end)
    name = tostring(name or "player")
    display = tostring(display or name)
    if display == "" then display = name end

     
     
    rect(px, py + 9, 3, ph - 18, accent, alpha * 0.9, 2, 15)
    text(px + 12, py + 8, fit(display, pw - 24, 11, true), 11, C.text, alpha * 0.9, true, 16)
    text(px + 12, py + 23, fit("@" .. name, pw - 24, 10, false), 10, C.faint, alpha * 0.9, false, 16)
end

function WindowClass:Render(dt, vp)
    local alive = self.Alive

    if not alive then return end

    self.HitRects = {}
    self.LastPX, self.LastPY = Pointer.X, Pointer.Y
    self.Dirty = false

    self.Anim = approach(self.Anim, self.Visible and 1 or 0, 16, dt)
    if self.Anim <= 0.01 and not self.Visible then
        self.Anim = 0
        self.Dropdown = nil
        self.DropdownRect = nil
        self.NeedsClear = false

         
         
         
        if self.Minimized == true then
            local size = 38
            local ix = clamp(self.X, 6, max(6, vp.X - size - 6))
            local iy = clamp(self.Y, 6, max(6, vp.Y - size - 6))
            local acc = self.Accent or ACCENT
            rect(ix + 2, iy + 3, size, size, C.black, 0.12, 9, 40)
            rect(ix, iy, size, size, self.Bg or C.bg, 0.97, 9, 41)
            stroke(ix, iy, size, size, acc, 0.9, 9, 42)
            icon(self.Icon or "bolt", ix + 11, iy + 11, 16, acc, 0.98, 43)
            if Pointer.Click and clickFree() and inside(ix, iy, size, size) then
                self:Open()
                claimClick()
            end
        end
        return
    end

    accent = self.Accent or ACCENT
    refreshButtonColors()

    if self.Dialog then Pointer.Blocked = true end

     
    local maxW = max(360, vp.X - 24)
    local maxH = max(260, vp.Y - 24)
    if self.W > maxW then self.W = maxW end
    if self.H > maxH then self.H = maxH end

     
     
    if not self.Placed then
        self.X = floor((vp.X - self.W) / 2)
        self.Y = floor((vp.Y - self.H) / 2)
        self.Placed = true
    end

    self.X = clamp(self.X, 6, max(6, vp.X - self.W - 6))
    self.Y = clamp(self.Y, 6, max(6, vp.Y - self.H - 6))

    local a = self.Anim
     
    local slide = self.Visible and (1 - a) * 10 or (1 - a) * 26
    local x, y = self.X, self.Y + slide
    local w, h = self.W, self.H

    self.WasOver = Pointer.X >= x - 6 and Pointer.X <= x + w + 6 and Pointer.Y >= y - 6 and Pointer.Y <= y + h + 6

    dragging = self.Drag ~= nil

     
     
    if not dragging then
        for i = 4, 1, -1 do
            rect(x - i * 3, y - i * 2, w + i * 6, h + i * 4, C.black, a * 0.05, 10 + i, 8)
        end
    end
    rect(x, y, w, h, self.Bg or C.bg, a * 0.98, 9, 10)
    stroke(x, y, w, h, C.hair, a * 0.9, 9, 11)
    rect(x, y, w, TOPBAR, C.panel, a * 0.98, 9, 11)
    line(x + 1, y + TOPBAR, x + w - 1, y + TOPBAR, C.hair, a * 0.9, 12, 1)

     
    icon(self.Icon, x + 14, y + 12, 16, accent, a * 0.95, 15)
    text(x + 38, y + 11, self.Title, 14, C.text, a, true, 15)
    if self.MiniTitle ~= "" then
        text(x + 38 + textWidth(self.Title, 14, true) + 10, y + 14, self.MiniTitle, 10, C.faint, a * 0.95, false, 15)
    end

    local cx, cy = x + w - 30, y + 10
    local closeHover = inside(cx, cy, 20, 20) and self.Visible and not Pointer.Blocked
    if closeHover then rect(cx, cy, 20, 20, C.card, a, 5, 15) end
    icon("minus", cx + 4, cy + 4, 12, closeHover and C.text or C.dim, a * 0.95, 16)

    if closeHover and clickFree() and Pointer.Click then
        self:Minimize()
        self.Dropdown = nil
        claimClick()
    end

     
    if Pointer.Click and inside(x, y, w, TOPBAR) and not closeHover then
        self.Drag = { dx = Pointer.X - x, dy = Pointer.Y - y }
        claimClick()
    end
    if Pointer.Down and self.Drag then
        self.X = clamp(Pointer.X - self.Drag.dx, 6, max(6, vp.X - w - 6))
        self.Y = clamp(Pointer.Y - self.Drag.dy, 6, max(6, vp.Y - h - 6))
        x, y = self.X, self.Y + slide
    end
    if not Pointer.Down then self.Drag = nil end
    dragging = self.Drag ~= nil

     
     
     
     
     
    if dragging then
        rect(x, y + TOPBAR, SIDEBAR, h - TOPBAR, C.side, a * 0.96, 0, 12)
        line(x + SIDEBAR, y + TOPBAR + 1, x + SIDEBAR, y + h - 1, C.hair, a * 0.8, 13, 1)
        rect(x + SIDEBAR + 1, y + TOPBAR + 1, w - SIDEBAR - 1, h - TOPBAR - 1, C.bg, a * 0.55, 0, 12)
        text(x + SIDEBAR + PAD, y + TOPBAR + 12, "Moving window", 11, C.faint, a * 0.85, false, 31)
        circle(x + SIDEBAR + PAD + textWidth("Moving window", 11, false) + 8, y + TOPBAR + 18, 3, accent, a * 0.8, true, 31)
        text(x + SIDEBAR + PAD, y + TOPBAR + 28, "release to drop it here", 10, C.faint, a * 0.6, false, 31)
        return
    end

    drawTabs(self, { x = x, y = y, w = w, h = h }, a)

     
    local colX0 = x + SIDEBAR + PAD
    local colY0 = y + TOPBAR + PAD
    local contentW = w - SIDEBAR - PAD * 2
    local contentH = h - TOPBAR - PAD * 2
    local colW = (contentW - GAP) / 2

    local tab = self.ActiveTab
    if not tab then return end

    local left, right = sideOf(tab, 0)
    balance(left, right, colW)
    local rowH = pickRowHeight(left, right, colW, contentH)

     
    if self.Dropdown and self.DropdownRect then
        local p = self.DropdownRect
        if inside(p.x, p.y, p.w, p.h) then
            Pointer.Blocked = true
        elseif Pointer.Click and not self.Dialog then
            self.Dropdown = nil
            claimClick()
        end
    end

    local needle = string.lower(self.Search)
    local function visible(row)
        if needle == "" then return true end
        return string.find(string.lower(row.Title or ""), needle, 1, true) ~= nil
    end

    local function drawColumn(groups, columnX)
        local cursor = colY0
        for _, group in ipairs(groups) do
            local shown = {}
            for _, row in ipairs(group.Elements) do
                if row.Type == "Divider" or visible(row) then shown[#shown + 1] = row end
            end
            if #shown > 0 then
                text(columnX + 2, cursor, string.upper(group.Name), 9, C.head or C.faint, a, true, 31)
                cursor = cursor + 20

                for _, row in ipairs(shown) do
                    local kind = row.Type
                    if kind ~= "Divider" and kind ~= "Paragraph" and kind ~= "TextLabel" then
                        self.HitRects[#self.HitRects + 1] = { x = columnX, y = cursor, w = colW, h = rowH, row = row }
                    end
                    if kind == "Divider" then
                        dividerRow(row, columnX, cursor, colW, a)
                        cursor = cursor + 20 + ROW_GAP
                    elseif kind == "Paragraph" then
                        paragraphRow(row, columnX, cursor, colW, a, colW)
                        cursor = cursor + measureElement(row, colW) + ROW_GAP
                    elseif kind == "TextLabel" then
                        textRow(row, columnX, cursor, colW, a)
                        cursor = cursor + measureElement(row, colW) + ROW_GAP
                    else
                        if kind == "Toggle" then toggleRow(row, columnX, cursor, colW, rowH, a)
                        elseif kind == "Slider" then sliderRow(row, columnX, cursor, colW, rowH, a)
                        elseif kind == "Dropdown" then dropdownRow(row, columnX, cursor, colW, rowH, a, self)
                        elseif kind == "Button" then buttonRow(row, columnX, cursor, colW, rowH, a)
                        elseif kind == "InputLabel" then
                            toggleRow(row, columnX, cursor, colW, rowH, a)
                        end
                        cursor = cursor + rowH + ROW_GAP
                    end
                end
                cursor = cursor + 6
            end
        end
        return cursor
    end

    drawColumn(left, colX0)
    drawColumn(right, colX0 + colW + GAP)

     
    if self.Dropdown then
        local row = self.Dropdown
        local anchor = row.Anchor
        if anchor then
            local lineH = 20
            local panelW = max(anchor.w, 150)
            local panelH = #row.Options * lineH + 8
            local px = anchor.x + anchor.w - panelW
            local py = anchor.y + anchor.h + 4

            if py + panelH > y + h - 8 then
                py = anchor.y - panelH - 4
            end
            px = clamp(px, x + 8, x + w - panelW - 8)
            py = clamp(py, y + TOPBAR + 6, y + h - panelH - 8)

            self.DropdownRect = { x = px, y = py, w = panelW, h = panelH }

            rect(px, py, panelW, panelH, C.panel, a, 6, 65)
            stroke(px, py, panelW, panelH, accent, a * 0.55, 6, 66)

            for i, option in ipairs(row.Options) do
                local oy = py + 4 + (i - 1) * lineH
                local hover = inside(px + 4, oy, panelW - 8, lineH)
                if hover then rect(px + 4, oy, panelW - 8, lineH, C.card, a * 0.95, 4, 66) end
                if option == row.Selected then
                    rect(px + 4, oy, 2, lineH, accent, a, 1, 67)
                end
                text(px + 12, oy + 4, fit(option, panelW - 24, 11, false), 11,
                    option == row.Selected and C.text or C.dim, a * 0.95, false, 67)

                if hover and Pointer.Click then
                    row.Selected = option
                    self.Dropdown = nil
                    claimClick()
                    if row.Callback then pcall(row.Callback, option) end
                    break
                end
            end
        end
    end

    if self.Dialog then renderDialog(self, x, y, w, h) end
end

function WindowClass:RenderNotes(dt, vp)
    if not self.Alive then return end
    renderNotifications(self, dt, vp)
end

function WindowClass:DebugLayout()
    local contentH = self.H - TOPBAR - PAD * 2
    local colW = (self.W - SIDEBAR - PAD * 2 - GAP) / 2
    local out = {}

    for _, tab in ipairs(self.Tabs) do
        local left, right = sideOf(tab, 0)
        balance(left, right, colW)
        local rowH = pickRowHeight(left, right, colW, contentH)
        out[#out + 1] = {
            name = tab.Name,
            rowH = rowH,
            left = columnHeights(left, colW, rowH),
            right = columnHeights(right, colW, rowH),
            leftGroups = #left,
            rightGroups = #right,
            avail = contentH,
            colW = colW,
        }
    end

    return out
end

function WindowClass:HandleKey()
    if self.Keybind and self.Keybind > 0 and self.Visible ~= nil then
        if pollKeys(self.Keybind) then
            self.Visible = not self.Visible
            self.Dropdown = nil
            self.SearchFocus = false
            if not self.Visible then self.NeedsClear = true end
            touchBusy(0.6)
        end
    end
end

 
 
 
local frame = 0
local connection

connection = RS.Heartbeat:Connect(function(dt)
    frame = frame + 1
    dt = clamp(dt or 0.016, 0, 0.1)

    pollInput(dt)

    for i = #windows, 1, -1 do
        if not windows[i].Alive then table.remove(windows, i) end
    end

     
     
    local needDraw = false
    for i = 1, #windows do
        if windows[i]:NeedsDraw() then needDraw = true; break end
    end

    if needDraw then
        beginFrame()

        local camera = workspace.CurrentCamera
        local vp = camera and camera.ViewportSize or V(1280, 720)

        for i = 1, #windows do
            local window = windows[i]
            local ok, err = pcall(window.Render, window, dt, vp)
            if not ok then
                if window.LastError ~= tostring(err) then
                    window.LastError = tostring(err)
                    warn("[kitty] render: " .. tostring(err))
                end
            end
            local okNotes, errNotes = pcall(window.RenderNotes, window, dt, vp)
            if not okNotes and window.LastNotesError ~= tostring(errNotes) then
                window.LastNotesError = tostring(errNotes)
                warn("[kitty] notes: " .. tostring(errNotes))
            end
        end

        endFrame()
    end

     
     
    for i = 1, #windows do
        local window = windows[i]
        local okKey, errKey = pcall(window.HandleKey, window)
        if not okKey and window.LastKeyError ~= tostring(errKey) then
            window.LastKeyError = tostring(errKey)
            warn("[kitty] key: " .. tostring(errKey))
        end
    end
end)

env.__kittyDestroy = function()
    if connection then connection:Disconnect() end
    for i = #windows, 1, -1 do
        local window = windows[i]
        window.Alive = false
        windows[i] = nil
    end
    hideAll()
end

env.KittyGui = KittyGui
env.KittyGui.Windows = windows
env.KittyGui.Pointer = Pointer
_G.KittyGui = KittyGui
end
 
 
 
 
 
 
 
 
 
 
local env = getfenv()
local KittyGui = env.KittyGui or _G.KittyGui

if type(KittyGui) ~= "table" then
    error("lolcat: kittygui core is not loaded")
end

local HttpService
pcall(function() HttpService = game:GetService("HttpService") end)

local CONFIG_FOLDER = "lolcatbss"

local VK = {
    f1 = 112, f2 = 113, f3 = 114, f4 = 115, f5 = 116, f6 = 117, f7 = 118, f8 = 119,
    f9 = 120, f10 = 121, f11 = 122, f12 = 123,
    insert = 45, home = 36, delete = 46, ["end"] = 35, ["tab"] = 9, escape = 27,
}

local ICONS = {
    home = "home", sun = "sun", plant = "plant", swords = "swords",
    box = "cube", layers = "layers", gauge = "gauge", clock = "clock",
    gear = "gear", dot = "dot", spark = "info", power = "power",
    play = "bolt", bolt = "bolt", shield = "shield", palette = "palette",
    key = "key", script = "script", sliders = "sliders",
}

local function iconName(name)
    name = tostring(name or "")
    return ICONS[name] or (name ~= "" and name or "dot")
end

local function short(text, limit)
    text = tostring(text or "")
    if #text <= limit then return text end
    return string.sub(text, 1, limit - 2) .. ".."
end

local app

local liveRows = {}
local firstSelected = false

 
 
 
local Section = {}
Section.__index = Section

local function newSection(tab, name, side)
    local group = tab:AddGroupbox({ Name = tostring(name or "Section"), Side = side })

    return setmetatable({ Group = group, Tab = tab, Side = side }, Section)
end

function Section:Toggle(label, value, callback, tip)
    return self.Group:AddToggle({
        Name = tostring(label),
        State = value == true,
        OnChanged = callback,
        Description = tostring(tip or ""),
    })
end

function Section:Slider(label, value, step, lo, hi, suffix, callback, tip)
    return self.Group:AddSlider({
        Name = tostring(label),
        CurrentValue = tonumber(value) or tonumber(lo) or 0,
        MinValue = tonumber(lo) or 0,
        MaxValue = tonumber(hi) or 100,
        Step = tonumber(step) or 1,
        Suffix = tostring(suffix or ""),
        OnChanged = callback,
        Description = tostring(tip or ""),
    })
end

function Section:Dropdown(label, selected, choices, _multi, callback, tip)
    local default = type(selected) == "table" and selected[1] or selected

    return self.Group:AddDropdown({
        Name = tostring(label),
        Options = choices,
        Selected = default,
        OnSelecting = callback,
        Description = tostring(tip or ""),
    })
end

function Section:Button(label, callback)
    return self.Group:AddButton({ Name = tostring(label), OnClick = callback })
end

function Section:Label(fn)
    local row = self.Group:AddTextLabel({ Title = "" })

    liveRows[#liveRows + 1] = { row = row, fn = fn }

    local ok, value = pcall(fn)
    if ok then row.Title = short(value, 60) end

    return row
end

function Section:Info(text)
    return self.Group:AddParagraph({ Title = tostring(text or "") })
end

function Section:Divider(text)
    return self.Group:AddDivider({ Title = tostring(text or "") })
end

function Section:Keybind(label) return self:Label(function() return tostring(label) .. ": F1" end) end
function Section:Textbox(label) return self:Label(function() return tostring(label) end) end
function Section:Colorpicker(label) return self:Label(function() return tostring(label) end) end

 
 
 
local TabProxy = {}
TabProxy.__index = TabProxy

local function proxyTab(tab)
    return setmetatable({ Tab = tab }, TabProxy)
end

function TabProxy:Section(name, side, _desc)
    return newSection(self.Tab, name, side)
end

 
 
 
local window = {}

local function ensureFolder()
    pcall(function()
        if type(makefolder) == "function" and type(isfolder) == "function" and not isfolder(CONFIG_FOLDER) then
            makefolder(CONFIG_FOLDER)
        end
    end)
end

local function configPath(name)
    return CONFIG_FOLDER .. "/" .. tostring(name) .. ".json"
end

local function keepSettingsLast()
    if not app or not app.SettingsTab then return end

    for index, tab in ipairs(app.Tabs) do
        if tab == app.SettingsTab and index ~= #app.Tabs then
            table.remove(app.Tabs, index)
            app.Tabs[#app.Tabs + 1] = app.SettingsTab
            return
        end
    end
end

function window:Tab(name, icon)
    local tab = app:CreateTab({ Name = tostring(name), Icon = iconName(icon) })

    keepSettingsLast()

    if not firstSelected then
        firstSelected = true
        app.ActiveTab = tab
    end

    return proxyTab(tab)
end

local THEME_LIST = { "Purple", "Blue", "Mint", "Amber", "Rose", "Mono" }

function window:AddSettingsTab(icon)
    if icon then app.SettingsTab.Icon = iconName(icon) end
    keepSettingsLast()

     
     
    if not window.__interfaceAdded then
        window.__interfaceAdded = true

        local group = app.SettingsTab:AddGroupbox({ Name = "Interface", Side = "Left" })

        group:AddDropdown({
            Name = "Theme",
            Options = THEME_LIST,
            Selected = app.ThemeName or "Purple",
            OnSelecting = function(value) app:SetTheme(value) end,
        })

        group:AddButton({
            Name = "Centre the window",
            OnClick = function() app.Placed = false end,
        })

        group:AddButton({
            Name = "Hide menu (F1 to reopen)",
            OnClick = function() app:Minimize() end,
        })
    end

    return proxyTab(app.SettingsTab)
end

function window:SettingsSection(name, side)
    return newSection(app.SettingsTab, name, side)
end

function window:IsOpen() return app.Visible == true end
function window:Open() app:Open() end
function window:Close() app:Minimize() end

function window:SetMenuKey(key)
    local code = VK[string.lower(tostring(key or ""))]
    if code then app:SetMenuKey(code) end
end

function window:Destroy()
    pcall(function() app:Destroy() end)
end

function window:Notify(title, text, duration, kind)
    Lib:Notify(title, text, duration, kind)
end

function window:SaveConfig(name)
    if type(writefile) ~= "function" or not HttpService then return end

    local ok, payload = pcall(function()
        local out = {}

        for _, tab in ipairs(app.Tabs) do
            local values = {}

            for _, group in ipairs(tab.Groupboxes) do
                for _, row in ipairs(group.Elements) do
                    local kind = row.Type
                    if kind == "Toggle" then
                        values[row.Title] = row.State
                    elseif kind == "Slider" then
                        values[row.Title] = row.Value
                    elseif kind == "Dropdown" then
                        values[row.Title] = row.Selected
                    end
                end
            end

            out[tab.Name] = values
        end

        return out
    end)

    if not ok then return end

    local encoded
    ok, encoded = pcall(function() return HttpService:JSONEncode(payload) end)
    if not ok then return end

    ensureFolder()
    pcall(function() writefile(configPath(name), encoded) end)
end

 
 
 
function window:ConfigSignature()
    if not app then return "" end

    local parts = {}

    for _, tab in ipairs(app.Tabs) do
        for _, group in ipairs(tab.Groupboxes) do
            for _, row in ipairs(group.Elements) do
                local kind = row.Type
                if kind == "Toggle" then
                    parts[#parts + 1] = tab.Name .. "/" .. row.Title .. "=" .. tostring(row.State)
                elseif kind == "Slider" then
                    parts[#parts + 1] = tab.Name .. "/" .. row.Title .. "=" .. tostring(row.Value)
                elseif kind == "Dropdown" then
                    parts[#parts + 1] = tab.Name .. "/" .. row.Title .. "=" .. tostring(row.Selected)
                end
            end
        end
    end

    return table.concat(parts, ";")
end

function window:LoadConfig(name)
    if type(readfile) ~= "function" or type(isfile) ~= "function" or not HttpService then return end

    local path = configPath(name)

    local ok, decoded = pcall(function()
        if not isfile(path) then return nil end
        return HttpService:JSONDecode(readfile(path))
    end)

    if not ok or type(decoded) ~= "table" then return end

    for _, tab in ipairs(app.Tabs) do
        local values = decoded[tab.Name]

        if type(values) == "table" then
            for _, group in ipairs(tab.Groupboxes) do
                for _, row in ipairs(group.Elements) do
                    local saved = values[row.Title]

                    if saved ~= nil and row.Type ~= "Button" and row.Type ~= "TextLabel"
                        and row.Type ~= "Divider" and row.Type ~= "Paragraph" then
                        pcall(function() row:Set(saved) end)
                    end
                end
            end
        end
    end
end

 
 
 
local Lib = {}

function Lib:Category(_name) end

function Lib:Notify(title, text, duration, kind)
    if not app then return end

    local tone = string.lower(tostring(kind or "info"))

    app:Notify({
        Title = tostring(title or "lolcat"),
        Content = tostring(text or ""),
        Duration = tonumber(duration) or 4,
        Type = (tone == "error" or tone == "warn" or tone == "warning") and "error" or "info",
    })
end

function Lib:Dialog(options)
    options = options or {}

    app:Confirm({
        Title = tostring(options.title or "Confirm"),
        Text = tostring(options.text or ""),
        Confirm = tostring(options.confirm or "Confirm"),
        OnConfirm = options.onConfirm,
    })
end

function Lib:CreateWindow(config)
    config = config or {}

    app = KittyGui:CreateWindow({
        title = config.title or "menu",
        subtitle = config.subtitle or "",
        size = config.size,
        startOpen = config.startOpen ~= false,
        theme = config.theme,
        icon = "bolt",
    })

    app.SettingsTab = app:CreateTab({ Name = "Settings", Icon = "gear" })

    return window
end

 
 
 
 
 
 
 
 
 
 
task.spawn(function()
    while _G.__lolcatBSS == INSTANCE do
        local w = app
        if w then
            for _, entry in ipairs(liveRows) do
                if w.Alive == false then break end
                local ok, value = pcall(entry.fn)
                if ok then
                    local text = short(value, 60)
                    if entry.row.Title ~= text then
                        entry.row.Title = text
                        w.Dirty = true
                    end
                end
            end
        end
        task.wait(0.2)
    end
end)

env.LolcatWindow = window
env.LolcatLib = Lib
local Engine
local function initEngine()
    local Engine = {}
    local Workspace = game:GetService("Workspace")
    local Plrs      = game:GetService("Players")
    local RS        = game:GetService("ReplicatedStorage")
    local lp        = Plrs.LocalPlayer

    
    
    
    
    local function findEvents()
        local fallback
        for _, c in ipairs(RS:GetChildren()) do
            if c.Name == "Events" then
                fallback = fallback or c
                for _, ch in ipairs(c:GetChildren()) do
                    local cl = ch.ClassName
                    if cl == "RemoteEvent" or cl == "RemoteFunction" or cl == "UnreliableRemoteEvent" then
                        return c
                    end
                end
            end
        end
        return fallback
    end

    local Events = findEvents()

    local function getRemote(name)
        local ev = Events and Events:FindFirstChild(name)
        if not ev then
            Events = findEvents()
            ev = Events and Events:FindFirstChild(name)
        end
        if not ev then
            local found = RS:FindFirstChild(name, true)
            if found then
                local cl = found.ClassName
                if cl == "RemoteEvent" or cl == "RemoteFunction" or cl == "UnreliableRemoteEvent" then
                    ev = found
                end
            end
        end
        return ev
    end

    local function remotesReady()
        return getRemote("ItemUseCommand") ~= nil
            or getRemote("ToolCollect") ~= nil
            or getRemote("PlayerActivesCommand") ~= nil
    end

    local floor  = math.floor
    local insert = table.insert

    local function clamp(v, a, b)
        if v < a then return a end
        if v > b then return b end
        return v
    end

    local function try(f, ...)
        local ok, res = pcall(f, ...)
        if ok then return res end
        return nil
    end

    
    
    
    
    
    
    local bg
    bg = function(fn)
        local claimed = false
        local function body()
            if claimed then return end
            claimed = true
            fn()
        end
        if type(task) == "table" and type(task.spawn) == "function" then
            pcall(function() task.spawn(body) end)
        end
        if claimed then return end
        if type(spawn) == "function" then
            pcall(function() spawn(body) end)
        end
    end

    local function safeText(obj)
        if not obj then return "" end
        local ok, res = pcall(function()
            local v = obj.Text
            if type(v) == "string" then return v end
            return nil
        end)
        return (ok and type(res) == "string") and res or ""
    end

    
    
    
    local S = {
        farm_on       = false,
        
        
        
        
         
         
         
         
        hybrid        = (function()
                            local forced = _G.__LOLCAT_FORCE_MODE
                            if type(forced) == "string" then
                                return string.lower(forced) == "hybrid"
                            end
                            return (_G.LOLCAT_HYBRID == true)
                                or (type(_G.LOLCAT_MODE) == "string" and string.lower(_G.LOLCAT_MODE) == "hybrid")
                                or false
                        end)(),
        field         = "Dandelion Field",
        farm_mode     = "Orbit / Circle Turns",
        close_r       = 12,
        full_pct      = 90,
        glide_speed   = 80,
         
         
        walk_speed    = 0,
         
         
         
        speed_override = false,
        walk_force    = false,
        force_tween   = 1400,
        travel_mode   = "Pathfinding",
         
        walk_method   = "Offsets",
        path_trace    = false,
        sprinkler     = "Auto",
        dig_tool      = false,
        face_center   = false,
        face_bubbles  = false,
        face_balloons = false,
        face_flame    = false,
        face_camera   = false,
         
         
         
         
        face_hz       = 10,
        noclip        = true,   
        world_noclip  = true,   
        reset_mode    = false,

        auto_polar_quests  = false,
        polar_only         = false,
         
         
         
         
        quests_auto        = false,
        quest_bypass       = true,
        quest_bears        = true,
        quest_others       = false,
         
         
         
         
        quest_pick         = "All enabled",
         
         
         
         
         
         
        quest_target       = "Auto",
        quest_follow       = true,
        qk_pollen          = true,
        qk_mobs            = true,
        qk_puff            = true,
        qk_tokens          = true,
         
         
        quest_hunt         = 40,
        quest_pass         = 20,
        quest_mode         = "Farm + quests",
        quest_check        = 25,
        polar_kill_mobs    = false,
        polar_catch_petals = false,
        polar_farm_fields  = false,        farm_under_balloons = false,
        farm_under_clouds   = false,
        farm_flames         = false,
        farm_sprouts        = false,
        catch_coconuts     = false,
        catch_stars        = false,
        convert_balloon     = false,
         
         
        balloon_convert     = true,
        collect_tokens      = false,
         
         
        collect_duped       = true,

         
         
         
         
        mark_target        = true,

         
         
         
        kill_crab    = false,
        kill_beetle  = false,
        kill_bear    = false,
        kill_vicious = false,
        kill_mondo   = false,
         
         
        mondo_loot   = true,
         
         
         
        vicious_cd   = 0,
        mondo_cd     = 0,

         
         
         
        misc         = {},
        misc_any     = false,
         
         
         
        misc_gap     = 12,
        misc_status  = "Off",

        nectar_farm   = false,
        nectar_repeat = true,
        nectar_extra  = false,
        nectar_mode   = "Growth %",
        nectar_collect_pct   = 100,
        nectar_collect_every = 1,
         
         
        nectar_slots  = { "None", "None", "None", "None", "None" },
         
         
        nectar_planters = {
            ["Plastic Planter"]      = false,
            ["Candy Planter"]        = false,
            ["Red Clay Planter"]     = false,
            ["Blue Clay Planter"]    = false,
            ["Tacky Planter"]        = false,
            ["Pesticide Planter"]    = false,
            ["Heat-Treated Planter"] = false,
            ["Hydroponic Planter"]   = false,
            ["Petal Planter"]        = false,
            ["Plenty Planter"]       = false,
            ["Paper Planter"]        = false,
            ["Sticker Planter"]      = false,
        },
    }

     
     
     
     
    S.travel_mode = "Pathfinding"

     
     
     
     
     
     
     
     
    S.dig  = { interval = 0.2, last = 0, uiOpen = false, converting = false, convCooldown = 0 }
    S.face = {
        fieldCache = nil, fieldAt = 0,
         
         
         
         
        minAngle = 0.05,
        wroteAt = 0, resolvedAt = 0, target = nil, autoOff = false, autoAt = 0,
        mode = "off", pauseUntil = 0, lastTick = 0, spin = 0, autoTried = false,
    }

    local MODE_INDEX = {
        ["Middle Only"] = 0, ["Close Middle"] = 1, ["Orbit / Circle Turns"] = 2,
        ["Square / Box Turns"] = 3, ["Serpentine / Snake"] = 4, ["Whole Field"] = 2,
    }
    local SPRINK_REPS = {
        ["Off"] = 0, ["Basic"] = 1, ["Silver"] = 2, ["Gold"] = 3, ["Diamond"] = 4, ["Supreme"] = 1,
    }

    
    
    
    
    local function fireEvent(name, arg)
        local ev = getRemote(name)
        if not ev then return false end
        local call
        if ev.ClassName == "RemoteFunction" then
            call = function() return ev:InvokeServer(arg) end
        elseif arg ~= nil then
            call = function() return ev:FireServer(arg) end
        else
            call = function() return ev:FireServer() end
        end
        local ok = pcall(call)
        return ok
    end

    

    local myHive, forceReturn, collecting, currentField, needSprinkler
    local status = "Off"
    local FeaturesActive = true
    
    
    
    local facingTarget = nil
    local sprinklerBusy = false
    local lastSprinklerField = nil
    local lastSprinklerAt = 0

    
    
    
    local function getHRP()
        local c = lp and lp.Character
        return c and c:FindFirstChild("HumanoidRootPart")
    end

    local function getHum()
        local c = lp and lp.Character
        return c and c:FindFirstChildOfClass("Humanoid")
    end

    local function isAlive()
        local hum = getHum()
        return hum ~= nil and hum.Health > 0
    end

     
     
     
     
     
     
    Engine.anyFeatureOn = function()
        if S.hard_off then return false end
        return S.farm_on == true
            or S.misc_any == true
            or S.nectar_farm == true
            or S.kill_beetle == true or S.kill_bear == true
            or S.kill_vicious == true or S.kill_mondo == true or S.kill_crab == true
            or S.auto_polar_quests == true or S.polar_only == true
            or S.quests_auto == true
            or S.quest_mode == "Quests only"
    end

     
     
     
     
     
     
    Engine.spinAutoRotate = function(on)
        local hum = getHum()
        local addr = hum and hum.Address
        if not addr or type(memory_write) ~= "function" then return false end
        return pcall(function()
            memory_write("byte", addr + 457, on and 1 or 0)
        end)
    end

     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
    Engine.walkAnim = Engine.walkAnim or { on = false, x = 0, z = 0 }

    Engine.walkAnimDrive = function(on, dirX, dirZ)
        if type(memory_write) ~= "function" then return false end
        local wa = Engine.walkAnim
        local was = wa.on
        wa.on = on and true or false
        wa.x, wa.z = tonumber(dirX) or 0, tonumber(dirZ) or 0
        if was and not wa.on then
             
             
            pcall(function()
                local hum = getHum()
                local addr = hum and hum.Address
                if not addr then return end
                memory_write("float", addr + 0x134, 0)
                memory_write("float", addr + 0x138, 0)
                memory_write("float", addr + 0x13C, 0)
            end)
        end
        return true
    end

    do
        pcall(function()
            local runSvc = RunService or game:GetService("RunService")
            runSvc.RenderStepped:Connect(function()
                local wa = Engine.walkAnim
                if not wa or not wa.on then return end
                local hum = getHum()
                local addr = hum and hum.Address
                if not addr then return end
                local x, z = wa.x, wa.z
                local len = math.sqrt(x * x + z * z)
                if len > 0.001 then x, z = x / len, z / len end
                pcall(function()
                    memory_write("float", addr + 0x134, x)
                    memory_write("float", addr + 0x138, 0)
                    memory_write("float", addr + 0x13C, z)
                end)
            end)
        end)
    end

    local function isOn()
        return Engine.anyFeatureOn() and isAlive() and FeaturesActive
    end

    local function rbxActive()
        local ok, v = pcall(function() return isrbxactive() end)
        if ok and type(v) == "boolean" then return v end
        return true
    end

    
    
    
    local BASE_PART_CLASSES = {
        Part = true, MeshPart = true, UnionOperation = true, WedgePart = true,
        CornerWedgePart = true, TrussPart = true, SpawnLocation = true,
        Seat = true, VehicleSeat = true,
    }

    local function isPart(obj)
        return obj ~= nil and BASE_PART_CLASSES[obj.ClassName] == true
    end

    local function isGuiObject(obj)
        local cl = obj and obj.ClassName
        return cl == "Frame" or cl == "TextLabel" or cl == "TextButton"
            or cl == "ImageLabel" or cl == "ImageButton" or cl == "TextBox"
            or cl == "ScrollingFrame" or cl == "CanvasGroup"
            or cl == "ViewportFrame" or cl == "VideoFrame"
    end

    local function isGuiButton(obj)
        local cl = obj and obj.ClassName
        return cl == "TextButton" or cl == "ImageButton"
    end

    local function applyWalkCollisions()
        local c = lp and lp.Character
        if not c then return end
        for _, p in ipairs(c:GetDescendants()) do
            if isPart(p) then
                pcall(function() p.CanCollide = true end)
            end
        end
    end

    local worldNoCollideDone = false
    local function applyWorldNoCollide()
        if worldNoCollideDone then return end
        worldNoCollideDone = true
        bg(function()
            pcall(function()
                local folders = { Workspace:FindFirstChild("FieldDecos") }
                local decs = Workspace:FindFirstChild("Decorations")
                if decs then insert(folders, decs:FindFirstChild("Misc")) end
                for _, f in ipairs(folders) do
                    if f then
                        for _, obj in ipairs(f:GetDescendants()) do
                            if isPart(obj)
                               and not string.find(string.lower(obj.Name or ""), "ladder", 1, true) then
                                obj.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end)
    end

    
    
    
    local function makeLookAt(eye, target)
        local cf = try(function() return CFrame.lookAt(eye, target) end)
        if cf then return cf end
         
         
         
        return try(function() return CFrame.lookAt(eye, target) end)
    end

    
    
    
    local function flatYaw(fromPos, toPos)
        local dx = toPos.X - fromPos.X
        local dz = toPos.Z - fromPos.Z
        if (dx * dx + dz * dz) < 0.0001 then return nil end
        return math.atan2(-dx, -dz)
    end

    local function currentYaw(cf)
        local ok, ry = pcall(function()
            local _, y = cf:ToOrientation()
            return y
        end)
        if ok and type(ry) == "number" then return ry end
        local look = cf.LookVector
        return math.atan2(-look.X, -look.Z)
    end

    
    local function clampYawDelta(d, maxStep)
        d = ((d + math.pi) % (2 * math.pi)) - math.pi
        if d > maxStep then return maxStep end
        if d < -maxStep then return -maxStep end
        return d
    end

    local FACE_TURN_STEP = 0.30   
    local FACE_MOVE_LIMIT = 8     

    
    
    
    
    local glideActive, glideActiveSince = false, 0
    local walkingWithKeys = false   
    local lastMoveMode, lastMoveAt = "Idle", 0   

    local function glideOwnsRotation()
        return glideActive and (tick() - glideActiveSince) < 50
    end

    local function facePosition(targetPos)
        local hrp = getHRP()
        if not hrp or not targetPos then return false end
         
         
         
        if S.face.pauseUntil and S.face.pauseUntil > tick() then return false end

        local pos = hrp.Position
        local flat = Vector3.new(targetPos.X, pos.Y, targetPos.Z)
        if (flat - pos).Magnitude < 0.3 then return false end

         
         
         
         
        local yaw = flatYaw(pos, flat)
        if not yaw then return false end

         
         
         
         
         
        local hum = getHum()
        if hum then
            if not S.face.spinTried then
                S.face.spinTried = true
                S.face.spinOff = Engine.spinAutoRotate(false)
                S.face.spinAt = tick()
            elseif S.face.spinOff and (tick() - (S.face.spinAt or 0)) > 1 then
                S.face.spinAt = tick()
                Engine.spinAutoRotate(false)
            end
            if not S.face.autoTried then
                S.face.autoTried = true
                local okA = pcall(function() hum.AutoRotate = false end)
                if okA and not S.face.spinOff then S.face.autoOff = true end
            end
        end
        local delta = 0
        local look = try(function() return hrp.CFrame.LookVector end)
        if look then
            local cur = math.atan2(-look.X, -look.Z)
            delta = ((yaw - cur + math.pi) % (2 * math.pi)) - math.pi
            if math.abs(delta) < S.face.minAngle then return true end
        end

         
         
         
         
         
        local nowFace = tick()
        local hz = tonumber(S.face_hz) or 10
        if hz < 1 then hz = 1 elseif hz > 60 then hz = 60 end
        if nowFace - (S.face.wroteAt or 0) < (1 / hz) then return true end
        S.face.wroteAt = nowFace
        S.face.writes = (S.face.writes or 0) + 1

        local velA = try(function() return hrp.AssemblyLinearVelocity end)
        local okW = pcall(function()
             
             
             
            hrp.CFrame = CFrame.new(pos.X, pos.Y, pos.Z) * CFrame.Angles(0, yaw, 0)
        end)
        if not okW then
            pcall(function()
                hrp.CFrame = CFrame.lookAt(pos, Vector3.new(targetPos.X, pos.Y, targetPos.Z))
            end)
        end
         
         
        if velA then pcall(function() hrp.AssemblyLinearVelocity = velA end) end

        
        if S.face_camera and not walkingWithKeys then
            pcall(function()
                local cam = Workspace.CurrentCamera
                if cam then
                    local camPos = cam.CFrame.Position
                    local camLook = makeLookAt(camPos, Vector3.new(targetPos.X, camPos.Y, targetPos.Z))
                    if camLook then cam.CFrame = camLook end
                end
            end)
        end
    end

     
     
     
     
    local function restoreFacing()
        if S.face_balloons or S.face_bubbles or S.face_center or S.face_flame then return end
        local hum = getHum()
         
         
         
        if S.face.spinOff then Engine.spinAutoRotate(true) end
        if hum then pcall(function() hum.AutoRotate = true end) end
        S.face.spinOff = false
        S.face.spinTried = false
        S.face.spinAt = 0
        S.face.autoOff = false
        S.face.target = nil
        S.face.spin = 0
        S.face.autoTried = false
    end

    
    
    
    local function getPartPos(part)
        if not part then return nil end
        local p = try(function() return part.Position end)
        if p and p.X then return p end
        local cf = try(function() return part.CFrame end)
        if cf and cf.Position and cf.Position.X then return cf.Position end
        if part.ClassName == "Model" then
            local pp = try(function() return part.PrimaryPart and part.PrimaryPart.Position end)
            if pp and pp.X then return pp end
            local bp = try(function() return part:FindFirstChildWhichIsA("BasePart", true) end)
            if bp then
                local bpPos = try(function() return bp.Position end)
                if bpPos and bpPos.X then return bpPos end
            end
        end
        return nil
    end

    local function partOf(obj)
        if not obj then return nil end
        local p = try(function() return obj.Position end)
        if p and p.X then return obj end
        local pp = try(function() return obj.PrimaryPart end)
        if pp then return pp end
        local ok, kids = pcall(function() return obj:GetChildren() end)
        if ok then
            for _, ch in ipairs(kids) do
                local cl = ch.ClassName
                if cl == "Part" or cl == "MeshPart" or cl == "UnionOperation"
                    or cl == "WedgePart" or cl == "CornerWedgePart" or cl == "TrussPart"
                    or cl == "SpawnLocation" or cl == "Seat" or cl == "VehicleSeat" then
                    return ch
                end
            end
        end
        return nil
    end

    local function padPos(pad)
        if not pad then return nil end
        return getPartPos(pad)
    end

    local HiveTool = {}

    HiveTool.top = function(pad)
        if not pad then return 0 end
        local pos = getPartPos(pad)
        if not pos then return 0 end
        local szY = try(function() return pad.Size.Y end) or 2
        if szY > 8 then szY = 2 end
        return pos.Y + szY / 2 + 2
    end

    HiveTool.part = function(obj)
        if not obj then return nil end
        if isPart(obj) and getPartPos(obj) then return obj end
        if obj.ClassName == "Model" then
            local primary = try(function() return obj.PrimaryPart end)
            if isPart(primary) and getPartPos(primary) then return primary end
            local bp = try(function() return obj:FindFirstChildWhichIsA("BasePart", true) end)
            if isPart(bp) and getPartPos(bp) then return bp end
            local kids = try(function() return obj:GetChildren() end)
            if kids then
                for _, ch in ipairs(kids) do
                    if isPart(ch) and getPartPos(ch) then return ch end
                end
            end
        end
        return nil
    end

    HiveTool.pad = function(hive)
        if not hive then return nil end
        for _, name in ipairs({ "Platform", "Pad", "Spawn", "Spot", "Floor" }) do
            local child = hive:FindFirstChild(name)
            if child then
                local direct = HiveTool.part(child)
                if direct then return direct end
                local val = try(function() return child.Value end)
                local fromVal = HiveTool.part(val)
                if fromVal then return fromVal end
            end
        end
        for _, p in ipairs(hive:GetChildren()) do
            local nl = string.lower(p.Name)
            if string.find(nl, "pad", 1, true) or string.find(nl, "plat", 1, true) then
                local found = HiveTool.part(p)
                if found then return found end
                local val = try(function() return p.Value end)
                local fromVal = HiveTool.part(val)
                if fromVal then return fromVal end
            end
        end
        local primary = try(function() return hive.PrimaryPart end)
        if isPart(primary) and getPartPos(primary) then return primary end
        return HiveTool.part(hive)
    end

    HiveTool.anchor = function(hive)
        local pad = HiveTool.pad(hive)
        local pos = padPos(pad)
        if not pos then return nil end
        return Vector3.new(pos.X, HiveTool.top(pad), pos.Z)
    end

    HiveTool.owner = function(hive)
        if not hive then return nil end
        local owner = hive:FindFirstChild("Owner") or hive:FindFirstChild("Player")
        if not owner then return nil end
        return try(function() return owner.Value end)
    end

    HiveTool.unclaimed = function()
        local honey = Workspace:FindFirstChild("Honeycombs") or Workspace:FindFirstChild("Hives")
        if not honey then return nil end
        for _, hive in ipairs(honey:GetChildren()) do
            local owner = hive:FindFirstChild("Owner") or hive:FindFirstChild("Player")
            if owner and HiveTool.owner(hive) == nil then return hive end
        end
        return nil
    end

    local function autoDetectHiveInstant()
        local honey = Workspace:FindFirstChild("Honeycombs") or Workspace:FindFirstChild("Hives")
        if not honey then return nil end

        local myName    = lp.Name:lower()
        local myDisplay = (lp.DisplayName or ""):lower()
        local myUserId  = lp.UserId

        
        for _, hive in ipairs(honey:GetChildren()) do
            local ownerObj = hive:FindFirstChild("Owner") or hive:FindFirstChild("Player")
            if ownerObj then
                local ov = try(function() return ownerObj.Value end)
                if ov then
                    if ov == lp then
                        myHive = hive; return hive
                    elseif (typeof and typeof(ov) == "Instance") or type(ov) == "userdata" then
                        local nm = try(function() return ov.Name end)
                        if nm and type(nm) == "string" and (nm:lower() == myName or nm:lower() == myDisplay) then
                            myHive = hive; return hive
                        end
                    elseif type(ov) == "string" then
                        local s = ov:lower()
                        if s == myName or s == myDisplay then
                            myHive = hive; return hive
                        end
                    elseif type(ov) == "number" and ov == myUserId then
                        myHive = hive; return hive
                    end
                end
            end
        end

        
        local sp = lp:FindFirstChild("SpawnPos")
        if sp and sp.Value then
            local spPos = (typeof and typeof(sp.Value) == "CFrame" and sp.Value.Position) or sp.Value
            if spPos and type(spPos.X) == "number" then
                for _, hive in ipairs(honey:GetChildren()) do
                    local pp = padPos(HiveTool.pad(hive))
                    if pp and (pp - spPos).Magnitude <= 14 then
                        myHive = hive; return hive
                    end
                end
            end
        end

        
        for _, hive in ipairs(honey:GetChildren()) do
            for _, attr in ipairs({ "Owner", "Player", "UserId", "Username", "OwnerName" }) do
                local val = hive:GetAttribute(attr)
                if val then
                    if type(val) == "string" and (val:lower() == myName or val:lower() == myDisplay) then
                        myHive = hive; return hive
                    elseif type(val) == "number" and val == myUserId then
                        myHive = hive; return hive
                    end
                end
            end
        end

        
        local hrp = getHRP()
        if hrp then
            for _, hive in ipairs(honey:GetChildren()) do
                local pp = padPos(HiveTool.pad(hive))
                if pp and (pp - hrp.Position).Magnitude <= 35 then
                    myHive = hive; return hive
                end
            end
        end

        return myHive
    end

    local function setHiveManual()
        local honey = Workspace:FindFirstChild("Honeycombs") or Workspace:FindFirstChild("Hives")
        local hrp = getHRP()
        if not honey or not hrp then return end
        local best, bestDist = nil, math.huge
        for _, hive in ipairs(honey:GetChildren()) do
            local pp = padPos(HiveTool.pad(hive))
            if pp then
                local d = (pp - hrp.Position).Magnitude
                if d < bestDist then bestDist = d; best = hive end
            end
        end
        if best and bestDist <= 60 then myHive = best end
    end

    
    
    
    local glideYaw   = nil     
    local glideSpeed = 0       
     
     
     
     
     
     
    local function flightNoclip(on)
        local shared = Engine.noclipTravel
        if shared then shared(on) end
    end

    local function moveToVelocity(targetPos, speed, thr, modeLabel, noAnim)
         
         
         
         
        local glide = Engine.flyTo
        if type(glide) == "function" then
            return glide(targetPos, speed, thr, modeLabel or "Glide", false)
        end
        return false
    end

    local Nav = {}
    if _G then _G.__lolcatNav = Nav end
     
     
     
    Engine.nav = Nav

    Nav.routes = {
        ["Hive1"] = { { -114, 2, 272 }, { -3, 2, 300 }, { -3, 2, 320 }, { -3, 2, 331 } },
        ["Hive2"] = { { -114, 2, 272 }, { -40, 2, 300 }, { -40, 2, 320 }, { -40, 2, 331 } },
        ["Hive3"] = { { -114, 2, 272 }, { -77, 2, 300 }, { -77, 2, 320 }, { -77, 2, 331 } },
        ["Hive4"] = { { -114, 2, 272 }, { -113, 2, 300 }, { -113, 2, 320 }, { -113, 2, 331 } },
        ["Hive5"] = { { -114, 2, 272 }, { -150, 2, 300 }, { -150, 2, 320 }, { -150, 2, 331 } },
        ["Hive6"] = { { -114, 2, 272 }, { -187, 2, 300 }, { -187, 2, 320 }, { -187, 2, 331 } },
        ["Dandelion Field"] = { { -114, 2, 272 }, { -110, 1, 255 }, { -108, 1, 230 }, { -112, 1, 210 }, { -115, 1, 190 }, { -100, 1, 176 }, { -74, 1, 174 }, { -52, 1, 190 }, { -31, 1, 205 }, { -31, 1, 221 } },
        ["Sunflower Field"] = { { -114, 2, 272 }, { -130, 1, 260 }, { -160, 1, 240 }, { -180, 1, 220 }, { -195, 1, 200 }, { -209, 1, 177 } },
        ["Mushroom Field"] = { { -114, 2, 272 }, { -108, 1, 240 }, { -112, 1, 217 }, { -111, 1, 200 }, { -118, 1, 185 }, { -122, 1, 160 }, { -120, 1, 140 }, { -100, 1, 125 }, { -90, 1, 112 } },
        ["Blue Flower Field"] = { { -114, 2, 272 }, { -90, 1, 260 }, { -50, 1, 250 }, { -10, 1, 245 }, { 30, 1, 240 }, { 60, 1, 230 }, { 90, 1, 210 }, { 110, 1, 180 }, { 130, 1, 150 }, { 147, 1, 120 }, { 147, 1, 99 } },
        ["Clover Field"] = { { -114, 2, 272 }, { -60, 1, 290 }, { 0, 1, 285 }, { 60, 1, 280 }, { 120, 1, 275 }, { 160, 1, 270 }, { 200, 3, 285 }, { 216, 17, 300 }, { 216, 20, 273 }, { 200, 25, 265 }, { 190, 27, 255 }, { 185, 30, 240 }, { 170, 32, 225 }, { 158, 32, 210 }, { 158, 32, 196 } },
        ["Spider Field"] = { { -114, 2, 272 }, { -3, 2, 160 }, { -3, 5, 145 }, { -3, 8, 130 }, { -3, 11, 115 }, { -3, 14, 100 }, { -3, 17, 88 }, { -3, 17, 45 }, { -25, 17, 15 }, { -43, 18, -14 } },
        ["Bamboo Field"] = { { -114, 2, 272 }, { -3, 2, 160 }, { -3, 5, 145 }, { -3, 8, 130 }, { -3, 11, 115 }, { -3, 14, 100 }, { -3, 17, 88 }, { -3, 17, 45 }, { 40, 17, 20 }, { 80, 17, 0 }, { 110, 17, -20 }, { 133, 18, -26 } },
        ["Strawberry Field"] = { { -114, 2, 272 }, { -3, 2, 160 }, { -3, 5, 145 }, { -3, 8, 130 }, { -3, 11, 115 }, { -3, 14, 100 }, { -3, 17, 88 }, { -3, 17, 45 }, { -40, 17, 20 }, { -90, 17, 0 }, { -140, 17, -5 }, { -178, 18, -10 } },
        ["Rose Field"] = { { -114, 2, 272 }, { -3, 2, 160 }, { -3, 5, 145 }, { -3, 8, 130 }, { -3, 11, 115 }, { -3, 14, 100 }, { -3, 17, 88 }, { -3, 17, 45 }, { -260, 17, 20 }, { -300, 17, 60 }, { -327, 17, 100 }, { -327, 18, 129 } },
        ["Pine Tree Forest"] = { { -114, 2, 272 }, { -96, 2, 269 }, { -86, 15.5, 254 }, { -65, 2, 233 }, { -30, 2, 195 }, { -3, 2, 160 }, { -3, 5, 145 }, { -3, 8, 130 }, { -3, 11, 115 }, { -3, 14, 100 }, { -3, 17, 88 }, { -3, 17, 95 }, { -60, 4, 95 }, { -120, 4, 95 }, { -160, 19, 96 }, { -190, 4, 95 }, { -240, 4, 95 }, { -300, 4, 95 }, { -330, 4, 90 }, { -339, 4, 80 }, { -339, 4, 70 }, { -339, 18, 62 }, { -339, 23, 50 }, { -339, 26, 40 }, { -339, 30, 30 }, { -339, 34, 20 }, { -339, 37, 10 }, { -339, 41, 0 }, { -339, 45, -10 }, { -339, 49, -20 }, { -339, 52, -30 }, { -339, 56, -40 }, { -339, 60, -50 }, { -339, 64, -62 }, { -320, 65, -100 }, { -329, 65, -150 }, { -329, 65, -187 } },
        ["Cactus Field"] = { { -114, 2, 272 }, { -3, 2, 160 }, { -3, 5, 145 }, { -3, 8, 130 }, { -3, 11, 115 }, { -3, 14, 100 }, { -3, 17, 88 }, { -3, 17, 45 }, { -260, 17, 20 }, { -339, 17, 62 }, { -339, 29, 40 }, { -339, 41, 20 }, { -339, 53, 0 }, { -339, 65, -62 }, { -300, 65, -120 }, { -240, 65, -110 }, { -188, 65, -102 } },
        ["Pumpkin Patch"] = { { -114, 2, 272 }, { -3, 2, 160 }, { -3, 5, 145 }, { -3, 8, 130 }, { -3, 11, 115 }, { -3, 14, 100 }, { -3, 17, 88 }, { -3, 17, 45 }, { -260, 17, 20 }, { -339, 17, 62 }, { -339, 29, 40 }, { -339, 41, 20 }, { -339, 53, 0 }, { -339, 65, -62 }, { -300, 65, -120 }, { -240, 65, -150 }, { -188, 65, -184 } },
        ["Pineapple Patch"] = { { -114, 2, 272 }, { -3, 2, 160 }, { -3, 5, 145 }, { -3, 8, 130 }, { -3, 11, 115 }, { -3, 14, 100 }, { -3, 17, 88 }, { -3, 17, 45 }, { -260, 17, 20 }, { -339, 17, 62 }, { -339, 29, 40 }, { -339, 41, 20 }, { -339, 53, 0 }, { -339, 65, -62 }, { -300, 65, -120 }, { -150, 65, -150 }, { 0, 65, -150 }, { 150, 65, -180 }, { 220, 65, -200 }, { 256, 65, -207 } },
        ["Stump Field"] = { { -114, 2, 272 }, { -3, 2, 160 }, { -3, 5, 145 }, { -3, 8, 130 }, { -3, 11, 115 }, { -3, 14, 100 }, { -3, 17, 88 }, { -3, 17, 45 }, { -260, 17, 20 }, { -339, 17, 62 }, { -339, 29, 40 }, { -339, 41, 20 }, { -339, 53, 0 }, { -339, 65, -62 }, { -300, 65, -120 }, { -250, 65, -200 }, { -100, 65, -220 }, { 100, 65, -220 }, { 250, 65, -200 }, { 300, 65, -170 }, { 319, 65, -147 }, { 319, 73, -120 }, { 319, 82, -90 }, { 319, 90, -60 }, { 319, 99, -26 }, { 360, 99, -60 }, { 400, 97, -120 }, { 424, 94, -175 } },
        ["Mountain Top Field"] = { { -114, 2, 272 }, { -3, 2, 160 }, { -3, 5, 145 }, { -3, 8, 130 }, { -3, 11, 115 }, { -3, 14, 100 }, { -3, 17, 88 }, { -3, 17, 45 }, { -260, 17, 20 }, { -339, 17, 62 }, { -339, 29, 40 }, { -339, 41, 20 }, { -339, 53, 0 }, { -339, 65, -62 }, { -300, 65, -120 }, { -250, 65, -238 }, { -200, 80, -238 }, { -160, 95, -238 }, { -116, 115, -238 }, { -60, 115, -200 }, { -55, 115, -160 }, { -55, 115, -77 }, { -20, 130, -77 }, { 20, 145, -77 }, { 60, 160, -77 }, { 84, 173, -77 }, { 90, 173, -110 }, { 80, 174, -150 }, { 77, 174, -166 } },
        ["Coconut Field"] = { { -114, 2, 272 }, { -150, 1, 340 }, { -175, 1, 330 }, { -195, 1, 320 }, { -211, 1, 316 }, { -211, 4, 326 }, { -211, 9, 338 }, { -211, 14, 350 }, { -209, 14, 360 }, { -209, 14, 416 }, { -225, 14, 430 }, { -235, 14, 410 }, { -245, 14, 380 }, { -260, 14, 360 }, { -280, 14, 350 }, { -300, 14, 350 }, { -312, 30, 350 }, { -323, 30, 350 }, { -335, 43, 352 }, { -335, 47, 362 }, { -360, 47, 390 }, { -400, 47, 415 }, { -410, 47, 420 }, { -425, 57, 425 }, { -425, 69, 440 }, { -400, 69, 460 }, { -345, 69, 485 }, { -300, 69, 480 }, { -254, 68.9, 469 } },
        ["Pepper Patch"] = { { -114, 2, 272 }, { -150, 1, 340 }, { -175, 1, 330 }, { -195, 1, 320 }, { -211, 1, 316 }, { -211, 4, 326 }, { -211, 9, 338 }, { -211, 14, 350 }, { -209, 14, 360 }, { -209, 14, 416 }, { -225, 14, 430 }, { -235, 14, 410 }, { -245, 14, 380 }, { -260, 14, 360 }, { -280, 14, 350 }, { -300, 14, 350 }, { -312, 30, 350 }, { -323, 30, 350 }, { -335, 43, 352 }, { -335, 47, 362 }, { -360, 47, 390 }, { -400, 47, 415 }, { -410, 47, 420 }, { -425, 57, 425 }, { -425, 69, 440 }, { -400, 69, 460 }, { -345, 69, 485 }, { -345, 78.4, 472 }, { -340, 78.4, 460 }, { -340, 94.5, 478 }, { -340, 94.5, 505 }, { -340, 108, 525 }, { -380, 108, 535 }, { -425, 108, 535 }, { -445, 120.2, 535 }, { -489, 120.2, 536 } },
        ["Ant Field"] = { { -114, 2, 272 }, { -60, 1, 300 }, { -20, 1, 330 }, { 20, 1, 340 }, { 50, 3, 370 }, { 70, 8, 400 }, { 85, 15, 430 }, { 92, 22, 470 }, { 95, 29, 520 }, { 96, 29, 560 }, { 96, 30, 595 } },
    }

     
     
     
     
     
     
     
     
    Nav.legRoutes = {
        ["Pepper Patch"] = {
            Vector3.new(-113.5, 4.9, 271.0),
            Vector3.new(-211.1, 5.7, 324.3),
            Vector3.new(-211.5, 17.0, 352.3),
            Vector3.new(-306.2, 17.1, 348.4),
            Vector3.new(-310.1, 32.7, 346.8),
            Vector3.new(-327.4, 33.6, 355.3),
            Vector3.new(-332.9, 50.0, 359.9),
            Vector3.new(-416.5, 50.0, 417.0),
            Vector3.new(-427.6, 59.5, 422.5),
            Vector3.new(-427.5, 71.5, 436.2),
            Vector3.new(-374.5, 71.5, 454.8),
            Vector3.new(-361.8, 81.4, 455.4),
            Vector3.new(-362.3, 81.4, 466.4),
            Vector3.new(-362.6, 97.9, 471.9),
            Vector3.new(-397.4, 97.5, 507.0),
            Vector3.new(-406.9, 110.9, 524.2),
            Vector3.new(-438.0, 110.9, 523.9),
            Vector3.new(-457.7, 123.2, 524.3),
        },
        ["Tunnel Bear"] = {
            Vector3.new(-113.9, 4.9, 271.6),
            Vector3.new(-112.4, 4.0, 222.4),
            Vector3.new(11.1, 10.5, 134.5),
            Vector3.new(10.5, 20.0, 11.2),
            Vector3.new(207.0, 21.0, -17.1),
            Vector3.new(204.7, 41.3, 50.7),
            Vector3.new(223.4, 41.3, 48.9),
            Vector3.new(224.8, 68.0, -84.3),
            Vector3.new(265.1, 68.0, -85.1),
            Vector3.new(262.6, 68.0, -45.7),
            Vector3.new(277.4, 81.5, -44.9),
            Vector3.new(285.9, 98.8, -44.9),
            Vector3.new(281.4, 6.3, -44.4),
        },
        ["King Beetle"] = {
            Vector3.new(-113.6, 4.9, 271.2),
            Vector3.new(-111.4, 4.0, 235.1),
            Vector3.new(74.6, 4.0, 109.4),
            Vector3.new(224.5, 4.0, 110.1),
            Vector3.new(220.0, 18.5, 130.4),
            Vector3.new(218.7, 4.1, 140.6),
            Vector3.new(194.3, 4.1, 172.0),
        },
        ["King Beetle Return"] = {
            Vector3.new(123.7, 4.1, 143.7),
            Vector3.new(123.1, 4.0, 129.5),
            Vector3.new(56.1, 4.0, 97.7),
        },
    }
     
    ;(function()  
 
 
 
 
 

local AtlasGraphData = (function()
 
 
local ATLAS_NODE_DATA = [==[
1|47,30,479;2|47,30,492;3|47,30,505;4|47,30,518;5|47,30,531;6|47,30,544;7|47,30,557;8|60,30,479;9|60,30,492;10|60,30,505;11|60,30,518;12|60,30,531;13|60,30,544;14|60,30,557;15|73,30,479;16|73,30,492;17|73,30,505;18|73,30,518;19|73,30,531;20|73,30,544;21|73,30,557;22|86,30,479;23|86,30,492;24|86,30,505;
25|86,30,518;26|86,30,531;27|86,30,544;28|86,30,557;31|99,30,505;32|99,30,518;33|99,30,531;34|99,30,544;35|99,30,557;38|112,30,505;39|112,30,518;40|112,30,531;41|112,30,544;42|112,30,557;43|89,18,-61;44|89,18,-48;45|89,18,-35;46|89,18,-22;47|89,18,-9;48|89,18,4;49|102,18,-61;50|102,18,-48;51|102,18,-35;52|102,18,-22;
53|102,18,-9;54|102,18,4;55|115,18,-61;56|115,18,-48;57|115,18,-35;58|115,18,-22;59|115,18,-9;60|115,18,4;61|128,18,-61;62|128,18,-48;63|128,18,-35;64|128,18,-22;65|128,18,-9;66|128,18,4;67|141,18,-61;68|141,18,-48;69|141,18,-35;70|141,18,-22;71|141,18,-9;72|141,18,4;73|154,18,-61;74|154,18,-48;75|154,18,-35;76|154,18,-22;
77|154,18,-9;78|154,18,4;79|167,18,-61;80|167,18,-48;81|167,18,-35;82|167,18,-22;83|167,18,-9;84|167,18,4;85|180,18,-61;86|180,18,-48;87|180,18,-35;88|180,18,-22;89|180,18,-9;90|180,18,4;91|193,18,-61;92|193,18,-48;93|193,18,-35;94|193,18,-22;95|193,18,-9;96|193,18,4;97|206,18,-61;98|206,18,-48;99|206,18,-35;100|206,18,-22;
101|206,18,-9;102|206,18,4;103|29,18,-48;104|29,18,-35;105|29,18,-22;106|29,18,-9;107|29,18,4;108|29,18,17;109|29,18,30;110|29,18,43;112|42,18,-48;113|42,18,-35;114|42,18,-22;115|42,18,-9;116|42,18,4;117|42,18,17;118|42,18,30;119|42,18,43;121|55,18,-48;122|55,18,-35;123|55,18,-22;124|55,18,-9;125|55,18,4;126|55,18,17;
127|55,18,30;128|55,18,43;130|68,18,-48;131|68,18,-35;132|68,18,-22;133|68,18,-9;134|68,18,4;135|68,18,17;136|68,18,30;137|68,18,43;139|81,18,-48;140|81,18,-35;141|81,18,-22;142|81,18,-9;143|81,18,4;144|81,18,17;146|81,18,43;147|81,18,56;148|-132,18,4;149|-132,18,17;151|-132,18,43;152|-132,18,56;153|-119,18,4;154|-119,18,17;
155|-119,18,30;156|-119,18,43;157|-119,18,56;158|-106,18,4;159|-106,18,17;160|-106,18,30;161|-106,18,43;162|-106,18,56;163|169,18,20;164|169,18,33;165|169,18,46;166|169,18,59;167|182,18,20;168|182,18,33;169|182,18,46;171|195,18,20;172|195,18,33;173|195,18,46;174|195,18,59;176|92,34,36;177|92,34,49;178|92,34,62;179|105,34,23;180|105,34,36;
181|105,34,49;182|105,34,62;183|118,34,23;184|118,34,36;185|118,34,49;186|118,34,62;188|131,34,36;189|131,34,49;190|131,34,62;192|144,34,36;193|144,34,49;194|144,34,62;195|157,34,23;196|157,34,36;197|157,34,49;198|157,34,62;199|121,2,149;200|121,2,162;201|121,2,175;202|121,2,188;203|121,2,201;204|121,2,214;205|121,2,227;206|121,2,240;
207|134,2,149;208|134,2,162;209|134,2,175;210|134,2,188;211|134,2,201;212|134,2,214;213|134,2,227;214|134,2,240;215|147,2,149;216|147,2,162;217|147,2,175;218|147,2,188;219|147,2,201;220|147,2,214;221|147,2,227;222|147,2,240;223|160,2,149;224|160,2,162;225|160,2,175;226|160,2,188;227|160,2,201;228|160,2,214;229|160,2,227;230|160,2,240;
231|173,2,149;232|173,2,162;233|173,2,175;234|173,2,188;235|173,2,201;236|173,2,214;237|173,2,227;238|173,2,240;239|186,2,149;240|186,2,162;241|186,2,175;242|186,2,188;243|186,2,201;244|186,2,214;245|186,2,227;246|186,2,240;247|199,2,149;248|199,2,162;249|199,2,175;250|199,2,188;251|199,2,201;252|199,2,214;253|199,2,227;254|199,2,240;
255|212,2,149;256|212,2,162;257|212,2,175;258|212,2,188;259|212,2,201;260|212,2,214;261|212,2,227;262|212,2,240;263|225,2,149;264|225,2,162;265|225,2,175;266|225,2,188;267|225,2,201;268|225,2,214;269|225,2,227;270|225,2,240;271|238,2,149;272|238,2,162;273|238,2,175;274|238,2,188;275|238,2,201;276|238,2,214;277|238,2,227;278|238,2,240;
279|29,2,68;280|29,2,81;281|29,2,94;282|29,2,107;283|29,2,120;284|42,2,68;285|42,2,81;286|42,2,94;287|42,2,107;288|42,2,120;289|55,2,68;290|55,2,81;291|55,2,94;292|55,2,107;293|55,2,120;294|68,2,68;295|68,2,81;296|68,2,94;297|68,2,107;298|68,2,120;299|81,2,68;300|81,2,81;301|81,2,94;302|81,2,107;
303|81,2,120;304|94,2,68;305|94,2,81;306|94,2,94;307|94,2,107;308|94,2,120;309|107,2,68;310|107,2,81;311|107,2,94;312|107,2,107;313|107,2,120;314|120,2,68;315|120,2,81;316|120,2,94;317|120,2,107;318|120,2,120;319|133,2,68;320|133,2,81;321|133,2,94;322|133,2,107;323|133,2,120;324|146,2,68;325|146,2,81;326|146,2,94;
327|146,2,107;328|146,2,120;329|159,2,68;330|159,2,81;331|159,2,94;332|159,2,107;333|159,2,120;334|172,2,68;335|172,2,81;336|172,2,94;337|172,2,107;338|172,2,120;339|185,2,68;340|185,2,81;341|185,2,94;342|185,2,107;343|185,2,120;344|198,2,68;345|198,2,81;346|198,2,94;347|198,2,107;348|198,2,120;349|211,2,68;350|211,2,81;
351|211,2,94;352|211,2,107;353|211,2,120;354|224,2,68;355|224,2,81;356|224,2,94;357|224,2,107;358|224,2,120;359|237,2,68;360|237,2,81;361|237,2,94;362|237,2,107;363|237,2,120;364|272,2,82;365|272,2,95;366|272,2,108;367|272,2,121;368|285,2,82;369|285,2,95;370|285,2,108;371|285,2,121;372|298,2,82;373|298,2,95;374|298,2,108;
375|298,2,121;376|311,2,82;377|311,2,95;378|311,2,108;379|311,2,121;380|324,2,82;381|324,2,95;382|324,2,108;383|324,2,121;384|337,2,82;385|337,2,95;386|337,2,108;387|337,2,121;388|287,56,63;389|287,56,76;390|287,56,89;391|300,56,63;392|300,56,76;393|300,56,89;394|313,56,63;395|313,56,76;396|313,56,89;397|326,56,63;398|326,56,76;
399|326,56,89;400|-372,66,-214;401|-372,66,-201;402|-372,66,-188;403|-372,66,-175;404|-372,66,-162;405|-372,66,-149;406|-372,66,-136;407|-372,66,-123;408|-372,66,-110;409|-372,66,-97;410|-372,66,-84;411|-372,66,-71;412|-359,66,-214;413|-359,66,-201;414|-359,66,-188;415|-359,66,-175;416|-359,66,-162;417|-359,66,-149;418|-359,66,-136;419|-359,66,-123;420|-359,66,-110;421|-359,66,-97;422|-359,66,-84;
423|-359,66,-71;424|-346,66,-214;425|-346,66,-201;426|-346,66,-188;427|-346,66,-175;428|-346,66,-162;429|-346,66,-149;430|-346,66,-136;431|-346,66,-123;432|-346,66,-110;433|-346,66,-97;434|-346,66,-84;435|-346,66,-71;436|-333,66,-214;437|-333,66,-201;438|-333,66,-188;439|-333,66,-175;440|-333,66,-162;441|-333,66,-149;442|-333,66,-136;443|-333,66,-123;444|-333,66,-110;445|-333,66,-97;446|-333,66,-84;
447|-333,66,-71;448|-320,66,-214;449|-320,66,-201;450|-320,66,-188;451|-320,66,-175;452|-320,66,-162;453|-320,66,-149;454|-320,66,-136;455|-320,66,-123;456|-320,66,-110;457|-320,66,-97;458|-320,66,-84;459|-320,66,-71;460|-307,66,-214;461|-307,66,-201;462|-307,66,-188;463|-307,66,-175;464|-307,66,-162;465|-307,66,-149;466|-307,66,-136;467|-307,66,-123;468|-307,66,-110;469|-307,66,-97;470|-307,66,-84;
471|-307,66,-71;472|-294,66,-214;473|-294,66,-201;474|-294,66,-188;475|-294,66,-175;476|-294,66,-162;477|-294,66,-149;478|-294,66,-136;479|-294,66,-123;480|-294,66,-110;481|-294,66,-97;482|-294,66,-84;483|-294,66,-71;484|-281,66,-214;485|-281,66,-201;486|-281,66,-188;487|-281,66,-175;488|-281,66,-162;489|-281,66,-149;490|-281,66,-136;491|-281,66,-123;492|-281,66,-110;493|-281,66,-97;494|-281,66,-84;
495|-281,66,-71;496|-268,66,-214;497|-268,66,-201;498|-268,66,-188;499|-268,66,-175;500|-268,66,-162;501|-268,66,-149;502|-268,66,-136;503|-268,66,-123;504|-268,66,-110;505|-268,66,-97;506|-268,66,-84;507|-268,66,-71;509|-255,66,-201;510|-255,66,-188;511|-255,66,-175;512|-255,66,-162;514|-255,66,-136;515|-255,66,-123;516|-255,66,-110;517|-255,66,-97;518|-255,66,-84;519|-255,66,-71;520|-242,66,-214;
521|-242,66,-201;522|-242,66,-188;523|-242,66,-175;524|-242,66,-162;525|-242,66,-149;526|-242,66,-136;527|-242,66,-123;528|-242,66,-110;529|-242,66,-97;530|-242,66,-84;531|-242,66,-71;532|-229,66,-214;533|-229,66,-201;534|-229,66,-188;535|-229,66,-175;536|-229,66,-162;537|-229,66,-149;538|-229,66,-136;539|-229,66,-123;540|-229,66,-110;541|-229,66,-97;542|-229,66,-84;543|-229,66,-71;544|-216,66,-214;
545|-216,66,-201;546|-216,66,-188;547|-216,66,-175;548|-216,66,-162;549|-216,66,-149;550|-216,66,-136;551|-216,66,-123;552|-216,66,-110;553|-216,66,-97;554|-216,66,-84;555|-216,66,-71;556|-203,66,-214;557|-203,66,-201;558|-203,66,-188;559|-203,66,-175;560|-203,66,-162;561|-203,66,-149;562|-203,66,-136;563|-203,66,-123;564|-203,66,-110;565|-203,66,-97;566|-203,66,-84;568|-190,66,-214;569|-190,66,-201;
570|-190,66,-188;571|-190,66,-175;572|-190,66,-162;573|-190,66,-149;574|-190,66,-136;575|-190,66,-123;576|-190,66,-110;577|-190,66,-97;578|-190,66,-84;579|-190,66,-71;580|-177,66,-214;581|-177,66,-201;582|-177,66,-188;583|-177,66,-175;584|-177,66,-162;585|-177,66,-149;586|-177,66,-136;587|-177,66,-123;588|-177,66,-110;589|-177,66,-97;590|-177,66,-84;591|-177,66,-71;592|-164,66,-214;593|-164,66,-201;
594|-164,66,-188;595|-164,66,-175;596|-164,66,-162;597|-164,66,-149;598|-164,66,-136;599|-164,66,-123;600|-164,66,-110;601|-164,66,-97;602|-164,66,-84;603|-164,66,-71;604|-151,66,-214;605|-151,66,-201;606|-151,66,-188;607|-151,66,-175;608|-151,66,-162;609|-151,66,-149;610|-151,66,-136;611|-151,66,-123;612|-151,66,-110;613|-151,66,-97;614|-151,66,-84;615|-151,66,-71;616|-138,66,-214;617|-138,66,-201;
618|-138,66,-188;619|-138,66,-175;620|-138,66,-162;621|-138,66,-149;622|-138,66,-136;623|-138,66,-123;624|-138,66,-110;625|-138,66,-97;626|-138,66,-84;627|-138,66,-71;628|-125,66,-214;629|-125,66,-201;630|-125,66,-188;631|-125,66,-175;632|-125,66,-162;633|-125,66,-149;634|-125,66,-136;635|-125,66,-123;637|-125,66,-97;638|-125,66,-84;640|108,31,137;641|108,31,150;642|108,31,163;643|108,31,176;
644|108,31,189;645|108,31,202;646|108,31,215;647|108,31,228;648|108,31,241;649|108,31,254;650|121,31,137;651|121,31,150;652|121,31,163;653|121,31,176;654|121,31,189;655|121,31,202;656|121,31,215;657|121,31,228;658|121,31,241;659|121,31,254;660|134,31,137;661|134,31,150;662|134,31,163;663|134,31,176;664|134,31,189;665|134,31,202;666|134,31,215;667|134,31,228;
668|134,31,241;669|134,31,254;670|147,31,137;671|147,31,150;672|147,31,163;673|147,31,176;674|147,31,189;675|147,31,202;676|147,31,215;677|147,31,228;678|147,31,241;679|147,31,254;680|160,31,137;681|160,31,150;682|160,31,163;683|160,31,176;684|160,31,189;685|160,31,202;686|160,31,215;687|160,31,228;688|160,31,241;689|160,31,254;690|173,31,137;691|173,31,150;
692|173,31,163;693|173,31,176;694|173,31,189;695|173,31,202;696|173,31,215;697|173,31,228;698|173,31,241;699|173,31,254;700|186,31,137;701|186,31,150;702|186,31,163;703|186,31,176;704|186,31,189;705|186,31,202;706|186,31,215;707|186,31,228;708|186,31,241;709|186,31,254;710|199,31,137;711|199,31,150;712|199,31,163;713|199,31,176;714|199,31,189;715|199,31,202;
716|199,31,215;717|199,31,228;718|199,31,241;719|199,31,254;720|212,31,137;721|212,31,150;722|212,31,163;723|212,31,176;724|212,31,189;725|212,31,202;726|212,31,215;727|212,31,228;728|212,31,241;729|212,31,254;730|225,31,137;731|225,31,150;732|225,31,163;733|225,31,176;734|225,31,189;735|225,31,202;736|225,31,215;737|225,31,228;738|225,31,241;740|238,31,137;
741|238,31,150;742|238,31,163;743|238,31,176;744|238,31,189;745|238,31,202;746|238,31,215;747|238,31,228;748|238,31,241;750|251,31,137;751|251,31,150;752|251,31,163;753|251,31,176;754|251,31,189;755|251,31,202;756|251,31,215;757|251,31,228;758|251,31,241;760|272,31,159;761|272,31,172;762|285,31,159;763|285,31,172;764|298,31,159;765|298,31,172;766|311,31,159;
767|311,31,172;768|324,31,159;769|324,31,172;770|337,31,159;771|337,31,172;772|350,31,159;773|350,31,172;774|363,31,159;775|363,31,172;776|291,49,185;777|291,49,198;778|304,49,185;779|304,49,198;780|317,49,185;781|317,49,198;782|330,49,185;783|330,49,198;786|300,59,209;787|300,59,222;788|313,59,209;789|313,59,222;790|326,59,209;791|326,59,222;792|339,59,209;
793|339,59,222;794|308,71,228;795|308,71,241;796|308,71,254;797|321,71,228;798|321,71,241;799|321,71,254;800|334,71,228;802|334,71,254;803|347,71,228;804|347,71,241;805|347,71,254;806|-310,69,430;807|-310,69,443;808|-310,69,456;809|-310,69,469;810|-310,69,482;811|-310,69,495;812|-310,69,508;813|-297,69,430;814|-297,69,443;815|-297,69,456;816|-297,69,469;817|-297,69,482;
818|-297,69,495;819|-297,69,508;820|-284,69,430;821|-284,69,443;822|-284,69,456;823|-284,69,469;824|-284,69,482;825|-284,69,495;826|-284,69,508;827|-271,69,430;828|-271,69,443;829|-271,69,456;830|-271,69,469;831|-271,69,482;832|-271,69,495;833|-271,69,508;834|-258,69,430;835|-258,69,443;836|-258,69,456;837|-258,69,469;838|-258,69,482;839|-258,69,495;840|-258,69,508;841|-245,69,430;
842|-245,69,443;843|-245,69,456;844|-245,69,469;845|-245,69,482;846|-245,69,495;847|-245,69,508;848|-232,69,430;849|-232,69,443;850|-232,69,456;851|-232,69,469;852|-232,69,482;853|-232,69,495;854|-232,69,508;855|-219,69,430;856|-219,69,443;857|-219,69,456;858|-219,69,469;859|-219,69,482;860|-219,69,495;861|-219,69,508;862|-206,69,430;863|-206,69,443;864|-206,69,456;865|-206,69,469;
866|-206,69,482;867|-206,69,495;868|-206,69,508;869|-118,2,214;870|-118,2,227;871|-118,2,240;872|-118,2,253;873|-105,2,214;874|-105,2,227;875|-105,2,240;876|-105,2,253;877|-92,2,214;878|-92,2,227;879|-92,2,240;880|-92,2,253;881|-79,2,214;882|-79,2,227;883|-79,2,240;884|-79,2,253;885|-66,2,214;886|-66,2,227;887|-66,2,240;888|-66,2,253;889|-53,2,214;
890|-53,2,227;891|-53,2,240;892|-53,2,253;893|-40,2,214;894|-40,2,227;895|-40,2,240;896|-40,2,253;897|-27,2,214;898|-27,2,227;899|-27,2,240;900|-27,2,253;901|-14,2,214;902|-14,2,227;903|-14,2,240;904|-14,2,253;905|-1,2,214;906|-1,2,227;907|-1,2,240;908|-1,2,253;909|12,2,214;910|12,2,227;911|12,2,240;912|12,2,253;913|25,2,214;
914|25,2,227;915|25,2,240;916|25,2,253;917|38,2,214;918|38,2,227;919|38,2,240;920|38,2,253;921|51,2,214;922|51,2,227;923|51,2,240;924|51,2,253;925|20,174,-241;929|20,174,-189;930|20,174,-176;931|20,174,-163;932|20,174,-150;933|20,174,-137;934|20,174,-124;935|20,174,-111;936|33,174,-241;937|33,174,-228;938|33,174,-215;939|33,174,-202;940|33,174,-189;
941|33,174,-176;942|33,174,-163;943|33,174,-150;944|33,174,-137;945|33,174,-124;946|33,174,-111;947|46,174,-241;948|46,174,-228;949|46,174,-215;950|46,174,-202;951|46,174,-189;952|46,174,-176;953|46,174,-163;954|46,174,-150;955|46,174,-137;956|46,174,-124;957|46,174,-111;958|59,174,-241;959|59,174,-228;960|59,174,-215;961|59,174,-202;962|59,174,-189;963|59,174,-176;964|59,174,-163;
965|59,174,-150;966|59,174,-137;967|59,174,-124;968|59,174,-111;969|72,174,-241;970|72,174,-228;971|72,174,-215;972|72,174,-202;973|72,174,-189;974|72,174,-176;975|72,174,-163;976|72,174,-150;977|72,174,-137;978|72,174,-124;979|72,174,-111;980|85,174,-241;981|85,174,-228;982|85,174,-215;983|85,174,-202;984|85,174,-189;985|85,174,-176;986|85,174,-163;987|85,174,-150;988|85,174,-137;
989|85,174,-124;990|85,174,-111;991|98,174,-241;992|98,174,-228;993|98,174,-215;994|98,174,-202;995|98,174,-189;996|98,174,-176;997|98,174,-163;998|98,174,-150;999|98,174,-137;1000|98,174,-124;1001|98,174,-111;1003|111,174,-228;1004|111,174,-215;1005|111,174,-202;1006|111,174,-189;1007|111,174,-176;1008|111,174,-163;1009|111,174,-150;1010|111,174,-137;1011|111,174,-124;1012|111,174,-111;1015|124,174,-215;
1016|124,174,-202;1017|124,174,-189;1018|124,174,-176;1019|124,174,-163;1020|124,174,-150;1021|124,174,-137;1022|124,174,-124;1023|124,174,-111;1027|-44,174,-129;1028|-44,174,-116;1029|-44,174,-103;1030|-31,174,-168;1031|-31,174,-155;1032|-31,174,-142;1033|-31,174,-129;1034|-31,174,-116;1035|-31,174,-103;1036|-18,174,-168;1037|-18,174,-155;1038|-18,174,-142;1039|-18,174,-129;1040|-18,174,-116;1041|-18,174,-103;1048|-50,230,-591;
1049|-50,230,-578;1050|-50,230,-565;1051|-50,230,-552;1052|-50,230,-539;1053|-50,230,-526;1054|-50,230,-513;1055|-50,230,-500;1056|-50,230,-487;1057|-50,230,-474;1058|-50,230,-461;1059|-37,230,-591;1060|-37,230,-578;1061|-37,230,-565;1062|-37,230,-552;1063|-37,230,-539;1064|-37,230,-526;1065|-37,230,-513;1066|-37,230,-500;1067|-37,230,-487;1068|-37,230,-474;1069|-37,230,-461;1070|-24,230,-591;1071|-24,230,-578;1072|-24,230,-565;
1073|-24,230,-552;1074|-24,230,-539;1075|-24,230,-526;1076|-24,230,-513;1077|-24,230,-500;1078|-24,230,-487;1079|-24,230,-474;1080|-24,230,-461;1081|-11,230,-591;1082|-11,230,-578;1083|-11,230,-565;1084|-11,230,-552;1085|-11,230,-539;1086|-11,230,-526;1087|-11,230,-513;1088|-11,230,-500;1089|-11,230,-487;1090|-11,230,-474;1091|-11,230,-461;1092|2,230,-591;1093|2,230,-578;1094|2,230,-565;1095|2,230,-552;1096|2,230,-539;
1097|2,230,-526;1098|2,230,-513;1099|2,230,-500;1100|2,230,-487;1101|2,230,-474;1102|2,230,-461;1110|15,230,-500;1111|15,230,-487;1112|15,230,-474;1113|15,230,-461;1121|28,230,-500;1122|28,230,-487;1123|28,230,-474;1124|28,230,-461;1132|41,230,-500;1133|41,230,-487;1134|41,230,-474;1135|41,230,-461;1143|54,230,-500;1144|54,230,-487;1145|54,230,-474;1146|54,230,-461;1147|67,230,-591;1148|67,230,-578;
1149|67,230,-565;1150|67,230,-552;1151|67,230,-539;1152|67,230,-526;1153|67,230,-513;1154|67,230,-500;1155|67,230,-487;1156|67,230,-474;1157|67,230,-461;1158|80,230,-591;1159|80,230,-578;1160|80,230,-565;1161|80,230,-552;1162|80,230,-539;1163|80,230,-526;1164|80,230,-513;1165|80,230,-500;1166|80,230,-487;1167|80,230,-474;1168|80,230,-461;1169|93,230,-591;1170|93,230,-578;1171|93,230,-565;1172|93,230,-552;
1173|93,230,-539;1174|93,230,-526;1175|93,230,-513;1176|93,230,-500;1177|93,230,-487;1178|93,230,-474;1179|93,230,-461;1180|106,230,-591;1181|106,230,-578;1182|106,230,-565;1183|106,230,-552;1184|106,230,-539;1185|106,230,-526;1186|106,230,-513;1187|106,230,-500;1188|106,230,-487;1189|106,230,-474;1190|106,230,-461;1191|119,230,-591;1192|119,230,-578;1193|119,230,-565;1194|119,230,-552;1195|119,230,-539;1196|119,230,-526;
1197|119,230,-513;1198|119,230,-500;1199|119,230,-487;1200|119,230,-474;1201|119,230,-461;1202|-157,1,71;1203|-157,1,84;1204|-157,1,97;1205|-157,1,110;1206|-157,1,123;1207|-157,1,136;1208|-157,1,149;1209|-157,1,162;1210|-157,1,175;1211|-157,1,188;1213|-144,1,71;1214|-144,1,84;1215|-144,1,97;1216|-144,1,110;1217|-144,1,123;1218|-144,1,136;1219|-144,1,149;1220|-144,1,162;1221|-144,1,175;
1222|-144,1,188;1223|-144,1,201;1224|-131,1,71;1225|-131,1,84;1226|-131,1,97;1227|-131,1,110;1228|-131,1,123;1231|-131,1,162;1232|-131,1,175;1233|-131,1,188;1234|-131,1,201;1235|-118,1,71;1236|-118,1,84;1237|-118,1,97;1238|-118,1,110;1239|-118,1,123;1240|-118,1,136;1241|-118,1,149;1242|-118,1,162;1243|-118,1,175;1244|-118,1,188;1245|-118,1,201;1246|-105,1,71;1247|-105,1,84;
1248|-105,1,97;1249|-105,1,110;1250|-105,1,123;1251|-105,1,136;1252|-105,1,149;1253|-105,1,162;1254|-105,1,175;1255|-105,1,188;1256|-105,1,201;1257|-92,1,71;1258|-92,1,84;1259|-92,1,97;1260|-92,1,110;1261|-92,1,123;1262|-92,1,136;1263|-92,1,149;1264|-92,1,162;1265|-92,1,175;1266|-92,1,188;1267|-92,1,201;1268|-79,1,71;1269|-79,1,84;1270|-79,1,97;1271|-79,1,110;
1272|-79,1,123;1273|-79,1,136;1274|-79,1,149;1275|-79,1,162;1276|-79,1,175;1277|-79,1,188;1278|-79,1,201;1279|-66,1,71;1280|-66,1,84;1281|-66,1,97;1282|-66,1,110;1283|-66,1,123;1284|-66,1,136;1285|-66,1,149;1286|-66,1,162;1287|-66,1,175;1288|-66,1,188;1289|-66,1,201;1290|-53,1,71;1291|-53,1,84;1292|-53,1,97;1294|-53,1,123;1295|-53,1,136;1296|-53,1,149;
1297|-53,1,162;1298|-53,1,175;1299|-53,1,188;1300|-53,1,201;1301|-40,1,71;1302|-40,1,84;1303|-40,1,97;1304|-40,1,110;1305|-40,1,123;1306|-40,1,136;1307|-40,1,149;1308|-40,1,162;1309|-40,1,175;1310|-40,1,188;1311|-40,1,201;1312|-27,1,71;1313|-27,1,84;1314|-27,1,97;1315|-27,1,110;1316|-27,1,123;1317|-27,1,136;1318|-27,1,149;1319|-27,1,162;1320|-27,1,175;
1321|-27,1,188;1322|-27,1,201;1323|-535,121,470;1324|-535,121,483;1325|-535,121,496;1326|-535,121,509;1327|-535,121,522;1328|-535,121,535;1329|-535,121,548;1330|-535,121,561;1331|-535,121,574;1332|-535,121,587;1333|-535,121,600;1334|-522,121,470;1335|-522,121,483;1336|-522,121,496;1337|-522,121,509;1338|-522,121,522;1339|-522,121,535;1340|-522,121,548;1341|-522,121,561;1342|-522,121,574;1343|-522,121,587;1344|-522,121,600;
1345|-509,121,470;1346|-509,121,483;1347|-509,121,496;1348|-509,121,509;1349|-509,121,522;1350|-509,121,535;1351|-509,121,548;1352|-509,121,561;1353|-509,121,574;1354|-509,121,587;1355|-509,121,600;1356|-496,121,470;1357|-496,121,483;1358|-496,121,496;1359|-496,121,509;1360|-496,121,522;1361|-496,121,535;1362|-496,121,548;1363|-496,121,561;1364|-496,121,574;1365|-496,121,587;1366|-496,121,600;1367|-483,121,470;1368|-483,121,483;
1369|-483,121,496;1370|-483,121,509;1371|-483,121,522;1372|-483,121,535;1373|-483,121,548;1374|-483,121,561;1375|-483,121,574;1376|-483,121,587;1377|-483,121,600;1378|-470,121,470;1379|-470,121,483;1380|-470,121,496;1381|-470,121,509;1382|-470,121,522;1383|-470,121,535;1384|-470,121,548;1385|-470,121,561;1386|-470,121,574;1387|-470,121,587;1388|-470,121,600;1389|-457,121,470;1390|-457,121,483;1391|-457,121,496;1392|-457,121,509;
1393|-457,121,522;1394|-457,121,535;1395|-457,121,548;1396|-457,121,561;1397|-457,121,574;1398|-457,121,587;1399|-457,121,600;1400|-444,121,470;1401|-444,121,483;1402|-444,121,496;1403|-444,121,509;1404|-444,121,522;1405|-444,121,535;1406|-444,121,548;1407|-444,121,561;1408|-444,121,574;1409|-444,121,587;1410|-444,121,600;1411|-544,136,369;1412|-544,136,382;1413|-544,136,395;1414|-544,136,408;1415|-544,136,421;1416|-544,136,434;
1417|-544,136,447;1418|-544,136,460;1419|-531,136,369;1420|-531,136,382;1421|-531,136,395;1422|-531,136,408;1423|-531,136,421;1424|-531,136,434;1425|-531,136,447;1426|-531,136,460;1427|-518,136,369;1428|-518,136,382;1429|-518,136,395;1430|-518,136,408;1431|-518,136,421;1432|-518,136,434;1433|-518,136,447;1434|-518,136,460;1435|-505,136,369;1437|-505,136,395;1438|-505,136,408;1439|-505,136,421;1442|-505,136,460;1443|-492,136,369;
1444|-492,136,382;1445|-492,136,395;1448|-492,136,434;1449|-492,136,447;1450|-492,136,460;1451|-479,136,369;1452|-479,136,382;1453|-479,136,395;1456|-479,136,434;1457|-479,136,447;1458|-479,136,460;1459|-466,136,369;1460|-466,136,382;1461|-466,136,395;1462|-466,136,408;1463|-466,136,421;1464|-466,136,434;1465|-466,136,447;1466|-466,136,460;1467|-453,136,369;1468|-453,136,382;1469|-453,136,395;1470|-453,136,408;1471|-453,136,421;
1472|-453,136,434;1473|-453,136,447;1474|-453,136,460;1475|-440,136,369;1476|-440,136,382;1477|-440,136,395;1478|-440,136,408;1479|-440,136,421;1480|-440,136,434;1481|-440,136,447;1482|-440,136,460;1483|-372,66,-252;1484|-372,66,-239;1485|-372,66,-226;1486|-359,66,-252;1487|-359,66,-239;1488|-359,66,-226;1489|-346,66,-252;1490|-346,66,-239;1491|-346,66,-226;1492|-333,66,-252;1493|-333,66,-239;1494|-333,66,-226;1495|-320,66,-252;
1496|-320,66,-239;1497|-320,66,-226;1498|-307,66,-252;1499|-307,66,-239;1500|-307,66,-226;1501|-294,66,-252;1502|-294,66,-239;1503|-294,66,-226;1504|-281,66,-252;1505|-281,66,-239;1506|-281,66,-226;1507|-268,66,-252;1508|-268,66,-239;1509|-268,66,-226;1510|-255,66,-252;1511|-255,66,-239;1512|-255,66,-226;1513|-242,66,-252;1514|-242,66,-239;1515|-242,66,-226;1517|-435,66,-48;1518|-435,66,-35;1519|-435,66,-22;1520|-435,66,-9;
1521|-435,66,4;1522|-435,66,17;1523|-435,66,30;1526|-422,66,-61;1527|-422,66,-48;1528|-422,66,-35;1529|-422,66,-22;1530|-422,66,-9;1531|-422,66,4;1532|-422,66,17;1533|-422,66,30;1534|-422,66,43;1536|-409,66,-61;1537|-409,66,-48;1538|-409,66,-35;1539|-409,66,-22;1540|-409,66,-9;1541|-409,66,4;1542|-409,66,17;1543|-409,66,30;1544|-409,66,43;1545|-409,66,56;1546|-396,66,-61;1547|-396,66,-48;
1548|-396,66,-35;1549|-396,66,-22;1550|-396,66,-9;1551|-396,66,4;1552|-396,66,17;1553|-396,66,30;1554|-396,66,43;1555|-396,66,56;1556|-383,66,-61;1557|-383,66,-48;1558|-383,66,-35;1559|-383,66,-22;1560|-383,66,-9;1561|-383,66,4;1562|-383,66,17;1563|-383,66,30;1564|-383,66,43;1565|-383,66,56;1566|-474,66,-110;1567|-474,66,-97;1568|-474,66,-84;1569|-461,66,-110;1570|-461,66,-97;1571|-461,66,-84;
1573|-448,66,-97;1574|-448,66,-84;1576|-435,66,-97;1577|-435,66,-84;1580|-422,66,-84;1583|-409,66,-84;1585|-396,66,-97;1586|-396,66,-84;1587|-383,66,-110;1588|-383,66,-97;1589|-383,66,-84;1590|-474,88,-129;1591|-474,88,-116;1592|-461,88,-129;1593|-461,88,-116;1594|-448,88,-129;1595|-448,88,-116;1596|-435,88,-129;1597|-435,88,-116;1598|-422,88,-129;1599|-422,88,-116;1600|-409,88,-129;1601|-409,88,-116;1602|-396,88,-129;
1603|-396,88,-116;1604|-383,88,-129;1605|-383,88,-116;1606|-396,88,-245;1607|-396,88,-232;1608|-396,88,-219;1609|-396,88,-206;1610|-396,88,-193;1611|-396,88,-180;1612|-396,88,-167;1613|-396,88,-154;1614|-396,88,-141;1615|-383,88,-245;1616|-383,88,-232;1617|-383,88,-219;1618|-383,88,-206;1619|-383,88,-193;1620|-383,88,-180;1621|-383,88,-167;1622|-383,88,-154;1623|-383,88,-141;1624|-472,102,-247;1625|-472,102,-234;1626|-472,102,-221;
1627|-472,102,-208;1628|-459,102,-247;1629|-459,102,-234;1630|-459,102,-221;1631|-459,102,-208;1632|-446,102,-247;1633|-446,102,-234;1634|-446,102,-221;1635|-446,102,-208;1636|-470,109,-188;1637|-470,109,-175;1638|-470,109,-162;1639|-470,109,-149;1640|-470,109,-136;1641|-457,109,-188;1644|-457,109,-149;1645|-457,109,-136;1646|-444,109,-188;1649|-444,109,-149;1650|-444,109,-136;1651|-431,109,-188;1652|-431,109,-175;1655|-431,109,-136;1656|-418,109,-188;
1657|-418,109,-175;1658|-418,109,-162;1659|-418,109,-149;1660|-418,109,-136;1661|-405,109,-188;1662|-405,109,-175;1663|-405,109,-162;1664|-405,109,-149;1665|-405,109,-136;1667|-531,66,-10;1668|-531,66,3;1669|-531,66,16;1671|-518,66,-23;1675|-518,66,29;1676|-505,66,-23;1680|-505,66,29;1681|-492,66,-23;1682|-492,66,-10;1683|-492,66,3;1684|-492,66,16;1685|-492,66,29;1686|-479,66,-23;1687|-479,66,-10;1688|-479,66,3;
1689|-479,66,16;1690|-479,66,29;1691|-466,66,-23;1692|-466,66,-10;1693|-466,66,3;1694|-466,66,16;1695|-466,66,29;1696|197,66,-247;1697|197,66,-234;1698|197,66,-221;1699|197,66,-208;1700|197,66,-195;1701|197,66,-182;1702|197,66,-169;1703|210,66,-247;1704|210,66,-234;1705|210,66,-221;1706|210,66,-208;1707|210,66,-195;1708|210,66,-182;1709|210,66,-169;1710|223,66,-247;1711|223,66,-234;1712|223,66,-221;
1713|223,66,-208;1714|223,66,-195;1715|223,66,-182;1716|223,66,-169;1717|236,66,-247;1718|236,66,-234;1719|236,66,-221;1720|236,66,-208;1721|236,66,-195;1722|236,66,-182;1723|236,66,-169;1724|249,66,-247;1725|249,66,-234;1726|249,66,-221;1727|249,66,-208;1728|249,66,-195;1729|249,66,-182;1730|249,66,-169;1731|262,66,-247;1732|262,66,-234;1733|262,66,-221;1734|262,66,-208;1735|262,66,-195;1736|262,66,-182;
1737|262,66,-169;1738|275,66,-247;1739|275,66,-234;1740|275,66,-221;1741|275,66,-208;1742|275,66,-195;1743|275,66,-182;1744|275,66,-169;1745|288,66,-247;1746|288,66,-234;1747|288,66,-221;1748|288,66,-208;1749|288,66,-195;1750|288,66,-182;1751|288,66,-169;1752|301,66,-247;1753|301,66,-234;1754|301,66,-221;1755|301,66,-208;1756|301,66,-195;1757|301,66,-182;1758|301,66,-169;1759|314,66,-247;1760|314,66,-234;
1761|314,66,-221;1762|314,66,-208;1763|314,66,-195;1764|314,66,-182;1765|314,66,-169;1766|130,66,-139;1767|130,66,-126;1768|130,66,-113;1769|130,66,-100;1770|130,66,-87;1771|143,66,-139;1772|143,66,-126;1773|143,66,-113;1774|143,66,-100;1775|143,66,-87;1776|156,66,-139;1777|156,66,-126;1778|156,66,-113;1779|156,66,-100;1780|156,66,-87;1781|169,66,-139;1782|169,66,-126;1783|169,66,-113;1784|169,66,-100;
1785|169,66,-87;1786|182,66,-139;1787|182,66,-126;1788|182,66,-113;1789|182,66,-100;1790|182,66,-87;1792|195,66,-126;1793|195,66,-113;1794|195,66,-100;1795|195,66,-87;1797|208,66,-126;1798|208,66,-113;1799|208,66,-100;1800|208,66,-87;1801|221,66,-139;1802|221,66,-126;1803|221,66,-113;1804|221,66,-100;1805|221,66,-87;1806|234,66,-139;1807|234,66,-126;1808|234,66,-113;1809|234,66,-100;1810|234,66,-87;
1811|247,66,-139;1812|247,66,-126;1813|247,66,-113;1814|247,66,-100;1815|247,66,-87;1816|260,66,-139;1817|260,66,-126;1818|260,66,-113;1819|260,66,-100;1820|260,66,-87;1821|273,66,-139;1822|273,66,-126;1823|273,66,-113;1824|273,66,-100;1825|273,66,-87;1826|286,66,-139;1827|286,66,-126;1828|286,66,-113;1829|286,66,-100;1830|286,66,-87;1831|-389,18,90;1832|-389,18,103;1833|-389,18,116;1838|-376,18,90;
1839|-376,18,103;1840|-376,18,116;1841|-376,18,129;1842|-376,18,142;1843|-376,18,155;1844|-376,18,168;1845|-363,18,90;1846|-363,18,103;1847|-363,18,116;1848|-363,18,129;1849|-363,18,142;1850|-363,18,155;1851|-363,18,168;1852|-350,18,90;1853|-350,18,103;1854|-350,18,116;1855|-350,18,129;1856|-350,18,142;1857|-350,18,155;1858|-350,18,168;1859|-337,18,90;1860|-337,18,103;1861|-337,18,116;1862|-337,18,129;
1863|-337,18,142;1864|-337,18,155;1865|-337,18,168;1866|-324,18,90;1867|-324,18,103;1868|-324,18,116;1869|-324,18,129;1870|-324,18,142;1871|-324,18,155;1872|-324,18,168;1873|-311,18,90;1874|-311,18,103;1875|-311,18,116;1876|-311,18,129;1877|-311,18,142;1878|-311,18,155;1879|-311,18,168;1880|-298,18,90;1881|-298,18,103;1882|-298,18,116;1883|-298,18,129;1884|-298,18,142;1885|-298,18,155;1886|-298,18,168;
1887|-285,18,90;1888|-285,18,103;1889|-285,18,116;1890|-285,18,129;1891|-285,18,142;1892|-285,18,155;1893|-285,18,168;1894|-272,18,90;1895|-272,18,103;1896|-272,18,116;1897|-272,18,129;1898|-272,18,142;1899|-272,18,155;1900|-272,18,168;1906|-379,18,188;1907|-379,18,201;1908|-379,18,214;1909|-379,18,227;1910|-379,18,240;1911|-366,18,188;1912|-366,18,201;1913|-366,18,214;1914|-366,18,227;1915|-366,18,240;
1916|-353,18,188;1917|-353,18,201;1918|-353,18,214;1919|-353,18,227;1920|-353,18,240;1921|-340,18,188;1922|-340,18,201;1923|-340,18,214;1924|-340,18,227;1925|-340,18,240;1926|-327,18,188;1927|-327,18,201;1928|-327,18,214;1929|-327,18,227;1930|-327,18,240;1931|-314,18,188;1932|-314,18,201;1933|-314,18,214;1934|-314,18,227;1935|-314,18,240;1936|-423,44,264;1937|-423,44,277;1938|-423,44,290;1939|-423,44,303;
1940|-410,44,264;1943|-410,44,303;1944|-397,44,264;1945|-397,44,277;1946|-397,44,290;1947|-397,44,303;1948|-384,44,264;1949|-384,44,277;1950|-384,44,290;1951|-384,44,303;1952|-371,44,264;1953|-371,44,277;1954|-371,44,290;1955|-371,44,303;1956|-358,44,264;1957|-358,44,277;1958|-358,44,290;1959|-358,44,303;1961|-345,44,277;1962|-345,44,290;1963|-345,44,303;1965|-332,44,277;1966|-332,44,290;1967|-332,44,303;
1969|-319,44,277;1970|-319,44,290;1971|-319,44,303;1973|-306,44,277;1974|-306,44,290;1975|-306,44,303;1977|-293,44,277;1978|-293,44,290;1979|-293,44,303;1980|-385,18,317;1981|-385,18,330;1982|-372,18,317;1984|-359,18,317;1985|-359,18,330;1986|-346,18,317;1987|-346,18,330;1988|-333,18,317;1989|-333,18,330;1990|-320,18,317;1991|-320,18,330;1992|-307,18,317;1993|-307,18,330;1994|-294,18,317;1995|-294,18,330;
1996|-281,18,317;1997|-281,18,330;1998|-382,66,175;1999|-382,66,188;2005|-369,66,175;2006|-369,66,188;2010|-369,66,240;2011|-369,66,253;2012|-356,66,175;2013|-356,66,188;2017|-356,66,240;2018|-356,66,253;2019|-343,66,175;2020|-343,66,188;2021|-343,66,201;2022|-343,66,214;2023|-343,66,227;2024|-343,66,240;2026|-330,66,175;2027|-330,66,188;2028|-330,66,201;2029|-330,66,214;2030|-330,66,227;2031|-330,66,240;
2033|-317,66,175;2034|-317,66,188;2035|-317,66,201;2036|-317,66,214;2037|-317,66,227;2038|-317,66,240;2039|-317,66,253;2040|-304,66,175;2041|-304,66,188;2042|-304,66,201;2043|-304,66,214;2044|-304,66,227;2045|-304,66,240;2046|-304,66,253;2047|-379,48,359;2048|-379,48,372;2049|-379,48,385;2050|-379,48,398;2051|-366,48,359;2052|-366,48,372;2053|-366,48,385;2054|-366,48,398;2055|-353,48,359;2056|-353,48,372;
2057|-353,48,385;2059|-340,48,359;2060|-340,48,372;2061|-340,48,385;2062|-340,48,398;2063|-327,48,359;2064|-327,48,372;2065|-327,48,385;2066|-327,48,398;2067|-314,48,359;2068|-314,48,372;2069|-314,48,385;2070|-314,48,398;2071|-301,48,359;2072|-301,48,372;2073|-301,48,385;2074|-301,48,398;2075|-523,48,384;2076|-523,48,397;2077|-523,48,410;2078|-510,48,384;2079|-510,48,397;2080|-510,48,410;2081|-497,48,384;
2082|-497,48,397;2084|-484,48,384;2085|-484,48,397;2087|-471,48,384;2088|-471,48,397;2090|-458,48,384;2091|-458,48,397;2093|-445,48,384;2094|-445,48,397;2096|-432,48,384;2097|-432,48,397;2099|-419,48,384;2100|-419,48,397;2103|-406,48,397;2105|-393,48,384;2106|-393,48,397;2107|-393,48,410;2120|-496,48,427;2121|-496,48,440;2122|-496,48,453;2123|-496,48,466;2124|-496,48,479;2125|-496,48,492;2126|-496,48,505;
2127|-496,48,518;2128|-496,48,531;2129|-496,48,544;2130|-496,48,557;2131|-496,48,570;2144|-432,70,426;2145|-432,70,439;2146|-432,70,452;2147|-432,70,465;2148|-419,70,426;2149|-419,70,439;2150|-419,70,452;2151|-419,70,465;2152|-406,70,426;2153|-406,70,439;2154|-406,70,452;2155|-406,70,465;2156|-393,70,426;2157|-393,70,439;2158|-393,70,452;2159|-393,70,465;2168|-358,80,449;2169|-358,80,462;2170|-345,80,436;
2171|-345,80,449;2172|-345,80,462;2173|-332,80,436;2174|-332,80,449;2175|-332,80,462;2176|-319,80,436;2177|-319,80,449;2178|-319,80,462;2179|-14,2,162;2180|-14,2,175;2181|-14,2,188;2182|-14,2,201;2183|-1,2,162;2184|-1,2,175;2185|-1,2,188;2186|-1,2,201;2187|12,2,162;2188|12,2,175;2189|12,2,188;2190|12,2,201;2191|25,2,162;2192|25,2,175;2193|25,2,188;2194|25,2,201;
2195|38,2,162;2196|38,2,175;2197|38,2,188;2198|38,2,201;2199|51,2,162;2200|51,2,175;2201|51,2,188;2202|51,2,201;2203|-196,2,267;2204|-196,2,280;2205|-196,2,293;2206|-196,2,306;2207|-196,2,319;2208|-196,2,332;2210|-183,2,267;2211|-183,2,280;2212|-183,2,293;2213|-183,2,306;2214|-183,2,319;2215|-183,2,332;2217|-170,2,267;2218|-170,2,280;2219|-170,2,293;2220|-170,2,306;
2221|-170,2,319;2222|-170,2,332;2224|-157,2,267;2225|-157,2,280;2226|-157,2,293;2227|-157,2,306;2228|-157,2,319;2229|-157,2,332;2231|-144,2,267;2232|-144,2,280;2233|-144,2,293;2234|-144,2,306;2235|-144,2,319;2236|-144,2,332;2238|-131,2,267;2239|-131,2,280;2240|-131,2,293;2241|-131,2,306;2242|-131,2,319;2243|-131,2,332;2245|-118,2,267;2246|-118,2,280;2247|-118,2,293;2248|-118,2,306;
2249|-118,2,319;2250|-118,2,332;2252|-105,2,267;2253|-105,2,280;2254|-105,2,293;2255|-105,2,306;2256|-105,2,319;2257|-105,2,332;2259|-92,2,267;2260|-92,2,280;2261|-92,2,293;2262|-92,2,306;2263|-92,2,319;2264|-92,2,332;2267|-79,2,280;2268|-79,2,293;2269|-79,2,306;2270|-79,2,319;2271|-79,2,332;2273|-66,2,267;2274|-66,2,280;2275|-66,2,293;2276|-66,2,306;2277|-66,2,319;
2278|-66,2,332;2280|-53,2,267;2282|-53,2,293;2283|-53,2,306;2284|-53,2,319;2285|-53,2,332;2287|-40,2,267;2289|-40,2,293;2290|-40,2,306;2291|-40,2,319;2292|-40,2,332;2294|-27,2,267;2295|-27,2,280;2296|-27,2,293;2297|-27,2,306;2298|-27,2,319;2299|-27,2,332;2302|-14,2,280;2303|-14,2,293;2304|-14,2,306;2305|-14,2,319;2306|-14,2,332;2309|-1,2,280;2310|-1,2,293;
2311|-1,2,306;2312|-1,2,319;2313|-1,2,332;2315|12,2,267;2316|12,2,280;2317|12,2,293;2318|12,2,306;2319|12,2,319;2320|12,2,332;2321|12,2,345;2322|25,2,267;2323|25,2,280;2324|25,2,293;2325|25,2,306;2326|25,2,319;2329|38,2,267;2330|38,2,280;2331|38,2,293;2332|38,2,306;2333|38,2,319;2336|51,2,267;2337|51,2,280;2338|51,2,293;2339|51,2,306;
2340|51,2,319;2343|-273,2,288;2344|-273,2,301;2346|-260,2,288;2347|-260,2,301;2348|-260,2,314;2349|-247,2,288;2350|-247,2,301;2351|-247,2,314;2352|-234,2,288;2353|-234,2,301;2354|-234,2,314;2355|-221,2,288;2356|-221,2,301;2357|-221,2,314;2358|-208,2,288;2359|-208,2,301;2360|-208,2,314;2361|25,2,133;2362|25,2,146;2363|38,2,133;2364|38,2,146;2365|51,2,133;2366|51,2,146;
2367|67,17,167;2368|67,17,180;2369|67,17,193;2370|67,17,206;2371|67,17,219;2372|67,17,232;2373|67,17,245;2374|80,17,167;2375|80,17,180;2376|80,17,193;2377|80,17,206;2378|80,17,219;2379|80,17,232;2380|80,17,245;2381|93,17,167;2382|93,17,180;2383|93,17,193;2384|93,17,206;2385|93,17,219;2386|93,17,232;2388|-94,18,-61;2389|-94,18,-48;2390|-94,18,-35;2391|-94,18,-22;
2392|-94,18,-9;2393|-94,18,4;2394|-94,18,17;2395|-94,18,30;2396|-94,18,43;2397|-81,18,-61;2398|-81,18,-48;2399|-81,18,-35;2400|-81,18,-22;2401|-81,18,-9;2402|-81,18,4;2403|-81,18,17;2404|-81,18,30;2405|-81,18,43;2406|-68,18,-61;2407|-68,18,-48;2408|-68,18,-35;2409|-68,18,-22;2410|-68,18,-9;2411|-68,18,4;2412|-68,18,17;2413|-68,18,30;2414|-68,18,43;2415|-55,18,-61;
2416|-55,18,-48;2417|-55,18,-35;2418|-55,18,-22;2419|-55,18,-9;2420|-55,18,4;2421|-55,18,17;2422|-55,18,30;2423|-55,18,43;2424|-42,18,-61;2425|-42,18,-48;2426|-42,18,-35;2427|-42,18,-22;2428|-42,18,-9;2429|-42,18,4;2430|-42,18,17;2431|-42,18,30;2432|-42,18,43;2433|-29,18,-61;2434|-29,18,-48;2435|-29,18,-35;2436|-29,18,-22;2437|-29,18,-9;2438|-29,18,4;2439|-29,18,17;
2440|-29,18,30;2441|-29,18,43;2442|-16,18,-61;2443|-16,18,-48;2444|-16,18,-35;2445|-16,18,-22;2446|-16,18,-9;2447|-16,18,4;2448|-16,18,17;2449|-16,18,30;2450|-16,18,43;2451|-3,18,-61;2452|-3,18,-48;2453|-3,18,-35;2454|-3,18,-22;2455|-3,18,-9;2456|-3,18,4;2457|-3,18,17;2458|-3,18,30;2459|-3,18,43;2460|10,18,-61;2461|10,18,-48;2462|10,18,-35;2463|10,18,-22;
2464|10,18,-9;2465|10,18,4;2466|10,18,17;2467|10,18,30;2468|10,18,43;2470|64,63,272;2471|64,63,285;2473|64,63,311;2474|64,63,324;2475|77,63,259;2476|77,63,272;2477|77,63,285;2478|77,63,298;2479|77,63,311;2480|77,63,324;2481|90,63,259;2482|90,63,272;2483|90,63,285;2484|90,63,298;2485|90,63,311;2486|90,63,324;2487|103,63,259;2488|103,63,272;2489|103,63,285;
2490|103,63,298;2491|103,63,311;2493|-218,18,-61;2494|-218,18,-48;2495|-218,18,-35;2496|-218,18,-22;2497|-218,18,-9;2498|-218,18,4;2499|-218,18,17;2500|-218,18,30;2501|-218,18,43;2502|-205,18,-61;2503|-205,18,-48;2504|-205,18,-35;2505|-205,18,-22;2506|-205,18,-9;2507|-205,18,4;2508|-205,18,17;2509|-205,18,30;2510|-205,18,43;2511|-192,18,-61;2512|-192,18,-48;2513|-192,18,-35;2514|-192,18,-22;
2515|-192,18,-9;2516|-192,18,4;2517|-192,18,17;2518|-192,18,30;2519|-192,18,43;2520|-179,18,-61;2521|-179,18,-48;2522|-179,18,-35;2523|-179,18,-22;2524|-179,18,-9;2525|-179,18,4;2526|-179,18,17;2527|-179,18,30;2528|-179,18,43;2529|-166,18,-61;2530|-166,18,-48;2531|-166,18,-35;2532|-166,18,-22;2533|-166,18,-9;2534|-166,18,4;2535|-166,18,17;2536|-166,18,30;2537|-166,18,43;2538|-153,18,-61;
2539|-153,18,-48;2540|-153,18,-35;2541|-153,18,-22;2542|-153,18,-9;2543|-153,18,4;2544|-153,18,17;2545|-153,18,30;2546|-153,18,43;2547|-140,18,-61;2548|-140,18,-48;2549|-140,18,-35;2550|-140,18,-22;2551|-140,18,-9;2552|-140,18,4;2553|-140,18,17;2554|-140,18,30;2555|-140,18,43;2556|378,94,-221;2557|378,94,-208;2558|378,94,-195;2559|378,94,-182;2560|378,94,-169;2561|378,94,-156;2562|378,94,-143;
2563|378,94,-130;2564|391,94,-221;2565|391,94,-208;2566|391,94,-195;2567|391,94,-182;2568|391,94,-169;2569|391,94,-156;2570|391,94,-143;2571|391,94,-130;2572|404,94,-221;2573|404,94,-208;2574|404,94,-195;2575|404,94,-182;2576|404,94,-169;2577|404,94,-156;2578|404,94,-143;2579|404,94,-130;2580|417,94,-221;2581|417,94,-208;2582|417,94,-195;2583|417,94,-182;2584|417,94,-169;2585|417,94,-156;2586|417,94,-143;
2587|417,94,-130;2588|430,94,-221;2589|430,94,-208;2590|430,94,-195;2591|430,94,-182;2592|430,94,-169;2593|430,94,-156;2594|430,94,-143;2595|430,94,-130;2596|443,94,-221;2597|443,94,-208;2598|443,94,-195;2599|443,94,-182;2600|443,94,-169;2601|443,94,-156;2602|443,94,-143;2603|443,94,-130;2604|456,94,-221;2605|456,94,-208;2606|456,94,-195;2607|456,94,-182;2608|456,94,-169;2609|456,94,-156;2610|456,94,-143;
2611|456,94,-130;2612|469,94,-221;2613|469,94,-208;2614|469,94,-195;2615|469,94,-182;2616|469,94,-169;2617|469,94,-156;2618|469,94,-143;2619|469,94,-130;2620|-246,2,71;2621|-246,2,84;2622|-246,2,97;2623|-246,2,110;2624|-246,2,123;2625|-246,2,136;2626|-246,2,149;2627|-246,2,162;2628|-246,2,175;2629|-246,2,188;2630|-246,2,201;2631|-246,2,214;2632|-246,2,227;2633|-246,2,240;2635|-233,2,71;
2636|-233,2,84;2637|-233,2,97;2638|-233,2,110;2639|-233,2,123;2640|-233,2,136;2641|-233,2,149;2642|-233,2,162;2643|-233,2,175;2644|-233,2,188;2645|-233,2,201;2646|-233,2,214;2647|-233,2,227;2648|-233,2,240;2649|-233,2,253;2650|-220,2,71;2651|-220,2,84;2652|-220,2,97;2653|-220,2,110;2654|-220,2,123;2655|-220,2,136;2656|-220,2,149;2657|-220,2,162;2658|-220,2,175;2659|-220,2,188;
2660|-220,2,201;2661|-220,2,214;2662|-220,2,227;2663|-220,2,240;2664|-220,2,253;2665|-207,2,71;2666|-207,2,84;2667|-207,2,97;2668|-207,2,110;2669|-207,2,123;2670|-207,2,136;2671|-207,2,149;2672|-207,2,162;2673|-207,2,175;2674|-207,2,188;2675|-207,2,201;2676|-207,2,214;2677|-207,2,227;2678|-207,2,240;2679|-207,2,253;2680|-194,2,71;2681|-194,2,84;2682|-194,2,97;2683|-194,2,110;
2684|-194,2,123;2685|-194,2,136;2686|-194,2,149;2687|-194,2,162;2688|-194,2,175;2689|-194,2,188;2690|-194,2,201;2691|-194,2,214;2692|-194,2,227;2693|-194,2,240;2694|-194,2,253;2695|-181,2,71;2696|-181,2,84;2697|-181,2,97;2698|-181,2,110;2699|-181,2,123;2700|-181,2,136;2701|-181,2,149;2702|-181,2,162;2703|-181,2,175;2704|-181,2,188;2705|-181,2,201;2706|-181,2,214;2707|-181,2,227;
2708|-181,2,240;2709|-181,2,253;2710|-168,2,71;2711|-168,2,84;2712|-168,2,97;2713|-168,2,110;2714|-168,2,123;2715|-168,2,136;2716|-168,2,149;2717|-168,2,162;2718|-168,2,175;2719|-168,2,188;2720|-168,2,201;2721|-168,2,214;2722|-168,2,227;2723|-168,2,240;2724|-168,2,253;2725|-283,17,380;2726|314,134,20;2727|219,2,150;2728|123,2,140;2729|34,6,336;2730|31,14,350;2731|18,14,360;
2732|87,12,332;2733|69,12,335;2734|59,14,343;2735|61,14,357;2736|50,14,373;2737|27,14,397;2738|5,14,406;2739|29,14,374;2740|82,25,348;2741|74,26,367;2742|63,25,384;2743|40,33,426;2744|3,32,418;2745|52,32,458;2746|68,32,452;2747|226,45,481;2748|206,45,464;2749|186,45,445;2750|152,45,443;2751|169,45,461;2752|190,45,484;2753|169,45,503;2754|148,45,480;2755|131,45,462;
2756|140,32,405;2757|151,32,417;2758|129,33,437;2759|114,33,426;2760|96,32,440;2761|107,32,457;2762|95,32,468;2763|96,32,488;2764|121,33,495;2765|137,33,512;2766|119,43,468;2767|81,32,447;2768|76,32,466;2769|165,32,521;2770|176,32,545;2771|170,32,573;2772|166,32,706;2773|107,32,701;2774|19,32,692;2775|16,50,627;2776|14,66,554;2777|14,66,535;2778|14,72,515;2779|14,73,484;
2780|8,72,461;2781|-7,63,460;2782|32,72,492;2783|146,32,527;2784|150,32,557;2785|166,32,558;2786|135,32,557;2787|123,32,556;2788|122,32,544;2789|133,32,544;2790|122,33,530;2791|132,32,530;2792|33,22,414;2793|27,11,348;2794|16,11,353;2795|75,5,293;2796|-213,13,341;2797|-222,17,351;2798|-233,18,349;2799|-237,18,339;2800|-247,18,341;2801|-245,18,351;2802|-233,17,365;2803|-233,18,387;
2804|-261,17,326;2805|-232,4,278;2806|-233,4,265;2807|-222,4,270;2808|-209,4,267;2809|-131,5,254;2810|-131,5,239;2811|-131,5,227;2812|-144,5,253;2813|-144,5,238;2814|-157,4,253;2815|-155,5,238;2816|-152,4,219;2817|-141,5,223;2818|11,8,146;2819|-1,8,146;2820|-14,8,146;2821|11,11,132;2822|-1,11,132;2823|-14,11,132;2824|11,14,117;2825|-1,14,117;2826|-14,14,117;2827|11,17,102;
2828|-1,17,102;2829|-14,17,102;2830|11,20,87;2831|-1,20,87;2832|-14,20,87;2833|11,20,72;2834|-1,20,72;2835|-11,20,75;2836|10.5,20,58;2837|-2,20,57;2838|-21,20,70;2839|-15,20,57;2840|-281,17,362;2841|-290,19,351;2842|-281,19,343;2843|-261,17,364;2844|-259,17,342;2845|-238,17,356;2846|-200,6,337;2847|-47,5,287;2848|-52,5,278;2849|-42,5,278;2850|-221,14,343;2851|-225,4,319;
2852|-256,17,337;2853|-265,17,343;2854|56,5,218;2855|104,34,180;2856|78,23,149;2857|256,34,156;2858|259,33,184;2859|282,33,183;2860|261,45,252;2861|261,45,240;2862|261,45,227;2863|261,45,215;2864|261,40,202;2865|278,45,252;2866|278,46,240;2867|278,46,227;2868|282,40,204;2869|292,48,219;2870|102,19,173;2871|102,19,186;2872|60,4,218;2873|288,47,202;2874|247,4,107;2875|247,4,94;
2876|262,4,94;2877|262,4,107;2878|279,4,133;2879|291,4,133;2880|304,4,133;2881|345,4,77;2882|331,4,66;2883|345,13,101;2884|344,24,131;2885|289,48,132;2886|266,58,131;2887|268,58,118;2888|319,58,133;2889|286,58,112;2890|304,62,105;2891|273,58,85;2892|256,58,77;2893|256,58,91;2894|256,58,115;2895|256,58,131;2896|247,49,103;2897|-76,20,56;2898|-95,20,56;2899|167,20,51;
2900|205,28,6;2901|206,36,32;2902|209,41,51;2903|217,41,49;2904|216,41,55;2905|234,41,55;2906|217,48,27;2907|217,54,9;2908|217,61,-14;2909|217,68,-37;2910|217,68,-60;2911|236,49,27;2912|237,54,8;2913|238,62,-16;2914|239,68,-38;2915|241,68,-63;2916|217,68,-81;2917|250,68,-36;2918|251,68,-15;2919|251,68,14;2920|251,75,24;2921|251,71,35;2922|256,67,52;2923|250,64,62;
2924|262,70,66;2925|275,70,66;2926|289,70,66;2927|303,70,66;2928|317,70,66;2929|317,84,80;2930|303,83,80;2931|289,83,80;2932|275,83,80;2933|262,83,80;2934|275,92,93;2935|289,92,93;2936|303,92,93;2937|317,92,93;2938|317,92,116;2939|303,92,116;2940|289,92,116;2941|275,92,116;2942|262,83,128;2943|275,83,128;2944|289,83,128;2945|303,83,128;2946|317,83,128;2947|317,70,142;
2948|303,70,142;2949|289,70,142;2950|275,70,142;2951|251,20,61;2952|252,20,49;2953|254,20,37;2954|258,29,36;2955|266,29,37;2956|266,29,49;2957|279,29,49;2958|279,29,37;2959|294,37,49;2960|294,37,37;2961|314,37,49;2962|314,37,37;2963|-124,20,20;2964|-106,33,-23;2965|-115,33,-23;2966|-122,33,-23;2967|-130,33,-23;2968|-129,33,-34;2969|-122,33,-34;2970|-115,33,-34;2971|-106,33,-34;
2972|-129,28,-13;2973|-118,26,-14;2974|-112,25,-13;2975|-113,20,-4;2976|163,20,50;2977|107,22,-64;2978|69,19,48;2979|62,19,52;2980|66,19,62;2981|52,19,56;2982|72,19,61;2983|37,19,59;2984|31,19,53;2985|284.5,66,-72;2986|284.5,88,-51;2987|284.5,88,-46;2988|284.5,6,-46;2989|403,6,-37;2990|166,67,-158;2991|166,66,-68;2992|148,66,-68;2993|223,66,-154;2994|234,66,-154;2995|247,66,-154;
2996|260,66,-154;2997|273,66,-154;2998|286,66,-154;2999|299,66,-154;3000|312,66,-154;3001|325,66,-154;3002|338,66,-154;3003|310,66,-142;3004|326,66,-142;3005|342,66,-142;3006|296,66,-133;3007|296,66,-120;3008|296,66,-107;3009|296,66,-94;3010|296,66,-81;3011|296,66,-72;3012|272,66,-72;3013|272,66,-62;3014|279,66,-62;3015|302,66,-35;3016|283,66,-35;3017|261,66,-36;3018|261,66,-53;3019|302,66,-62;
3020|293,82,-45;3021|270,82,-45;3022|342,66,-126;3023|342,66,-112;3024|359,66,-126;3025|359,66,-112;3026|374,66,-106;3027|374,66,-84;3028|395,66,-71;3029|418,66,-74;3030|431,70,-81;3031|310,74,-120;3032|326,74,-120;3033|326,79,-104;3034|310,79,-104;3035|310,84,-90;3036|326,84,-90;3037|326,89,-75;3038|310,89,-75;3039|310,94,-60;3040|326,94,-60;3041|326,99,-45;3042|310,99,-45;3043|310,103,-28;
3044|326,103,-28;3045|336,91,-76;3046|336,91,-90;3047|349,92,-84;3048|364,91,-76;3049|363,92,-90;3050|349,91,-98;3051|326,103,-18;3052|310,103,-18;3053|310,103,-5;3054|326,103,-5;3055|287,103,-25;3056|287,103,-14;3057|287,103,-2;3058|275,103,0;3059|263,103,0;3060|285,103,12;3061|275,103,12;3062|263,103,12;3063|284,103,26;3064|275,103,26;3065|263,103,26;3066|275,109,-10;3067|275,110,-30;
3068|264,110,-30;3069|265,109,-11;3070|264,110,-21;3071|314,133,4;3072|314,135,31;3073|296,122,12;3074|296,122,39;3075|329,69,-184;3076|329,72,-199;3077|365,93,-215;3078|370,85,-240;3079|372,88,-250;3080|374,88,-269;3081|392,88,-271;3082|411,88,-273;3083|430,88,-275;3084|447,88,-276;3085|394,88,-259;3086|413,88,-259;3087|436,88,-259;3088|478,88,-253;3089|487,88,-240;3090|443,101,-288;3091|421,101,-286;
3092|400,101,-284;3093|387,101,-283;3094|402,101,-302;3095|384,101,-323;3096|404,117,-316;3097|389,116,-331;3098|384,115,-340;3099|401,116,-358;3100|417,117,-374;3101|432,117,-389;3102|448,117,-405;3103|455,123,-413;3104|461,130,-408;3105|462,130,-381;3106|402,130,-334;3107|417,130,-353;3108|432,130,-372;3109|447,130,-391;3110|417,130,-323;3111|423,131,-333;3112|431,130,-314;3113|485,130,-406;3114|457,130,-356;3115|445,133,-303;
3116|444,130,-338;3117|447,130,-332;3118|460,137,-320;3119|461,137,-313;3120|494,138,-345;3121|504,138,-324;3122|496,138,-365;3123|523,138,-316;3124|554,142,-363;3125|535,138,-384;3126|464,130,-295;3127|475,130,-289;3128|514,130,-276;3129|562,130,-300;3130|609,130,-324;3131|613,123,-332;3132|609,112,-340;3133|600,104,-352;3134|599,104,-362;3135|617,104,-372;3136|603,104,-382;3137|-304,66,-65;3138|-396,66,-107;3139|-402,66,-96;
3140|-447,68,-103;3141|-422,68,-91;3142|-405,79,-110;3143|-411,79,-110;3144|-424,79,-110;3145|-437,79,-110;3146|-416,79,-102;3147|-407,88,-206;3148|-418,88,-206;3149|-407,88,-219;3150|-418,88,-219;3151|-428,89,-225;3152|-417,89,-233;3153|-415,89,-246;3154|-423,96,-247;3155|-424,96,-235;3156|-431,96,-236;3157|-433,96,-245;3158|-441,103,-233;3159|-436,103,-206;3160|-432,110,-196;3161|-406,110,-196;3162|-194,87,-224;3163|-141,110,-224;
3164|-116,118,-224;3165|-117,118,-186;3166|-117,118,-169;3167|-95,118,-166;3168|-87,118,-147;3169|-87,118,-95;3170|-79,118,-86;3171|-103,119,-81;3172|17,148,-83;3173|84,176,-81;3174|99,177,-71;3175|45,161,-71;3176|17,148,-71;3177|-34,125,-71;3178|17,148,-60;3179|17,88,-60;3180|-88,118,-125;3181|-97,127,-103;3182|-97,127,-122;3183|-105,128,-114;3184|-118,127,-114;3185|-113,119,-81;3186|-113,119,-71;3187|-103,119,-71;
3188|-454,66,-8;3189|-454,66,6;3190|-365,68,-66;3191|-360,68,-55;3192|-358,68,55;3193|-358,68,73;3194|-378,68,70;3195|-414,63,81;3196|-327,68,-70;3197|-351,68,-69;3198|-317,68,-65;3199|-328,54,-26;3200|-328,36,21;3201|-328,20,77;3202|-350,54,-26;3203|-350,36,21;3204|-350,20,77;3205|-445,42,111;3206|-392,20,111;3207|-392,20,97;3208|-419,25,103;3209|-420,23,154;3210|-420,25,140;3211|-435,41,131;
3212|-436,37,157;3213|-460,41,132;3214|-472,47,130;3215|-474,60,112;3216|-449,41,143;3217|-477,48,143;3218|-446,37,160;3219|-462,37,158;3220|-483,37,162;3221|-446,30,172;3222|-464,30,168;3223|-491,30,172;3224|-456,30,165;3225|-429,30,95;3226|-439,37,91;3227|-450,37,86;3228|-464,37,86;3229|-483,37,83;3230|-426,30,85;3231|-414,26,90;3232|-407,26,126;3233|-438,30,79;3234|-458,30,81;3235|-468,30,81;
3236|-263,18,159;3237|-263,18,174;3238|-278,18,174;3239|-263,18,189;3240|-278,18,189;3241|-263,18,204;3242|-278,18,204;3243|-263,18,219;3244|-278,18,219;3245|-263,18,234;3246|-278,18,234;3247|-285,18,189.5;3248|-285,18,204;3249|-285,18,221;3250|-268,18,247;3251|-262,18,245;3252|-268,27,262;3253|-249,27,270;3254|-251,27,253;3255|-282,20,245;3256|-263,30,134;3257|-263,50,88;3258|-238,34,77;3259|-206,34,77;
3260|-194,29,63;3261|-269,51,70;3262|-275,51,58;3263|-293,51,52;3264|-312,51,52;3265|-312,69,36;3266|-315,68,5;3267|-308,68,5;3268|-280,74,0;3269|-268,74,0;3270|-251,55,-1;3271|-228,55,-1;3272|-260,45,-52;3273|-260,45,-23;3274|-260,45,3;3275|-259,45,23;3276|-267,51,81;3277|-276,51,74;3278|-287,51,73;3279|-298,51,80;3280|-311,51,80;3281|-306,68,-13;3282|-298,74,4;3283|-285,74,22;
3284|-317,68,-26;3285|-339,44,271;3286|-321,44,271;3287|-339,66,253;3288|-397,28,128;3289|-353,73,222;3290|-353,73,213;3291|-353,73,204;3292|-184,28,53;3293|-229,35,50;3294|-227,68,-54;3295|-318,51,45;3296|-307,51,44;3297|-304,52,52;3298|-340,46,256;3299|-331,46,259;3300|-350,46,259;3301|-467,47,125;3302|-471,47,125;3303|-483,47,125;3304|-483,47,130;3305|-477,47,133;3306|-468,47,134;3307|-471,116,-71;
3308|-456,116,-71;3309|-441,116,-71;3310|-426,116,-71;3311|-411,116,-71;3312|-396,116,-71;3315|-471,116,-56;3316|-456,116,-56;3317|-441,116,-56;3318|-426,116,-56;3319|-411,116,-56;3320|-396,116,-56;3321|-381,116,-56;3323|-471,116,-41;3324|-456,116,-41;3325|-441,116,-41;3326|-426,116,-41;3327|-411,116,-41;3328|-396,116,-41;3329|-381,116,-41;3330|-366,116,-41;3331|-471,116,-26;3332|-456,116,-26;3333|-441,116,-26;3334|-426,116,-26;
3335|-411,116,-26;3336|-396,116,-26;3337|-381,116,-26;3338|-366,116,-26;3339|-471,116,-11;3340|-456,116,-11;3341|-441,116,-11;3342|-426,116,-11;3343|-411,116,-11;3344|-396,116,-11;3345|-381,116,-11;3346|-366,116,-11;3347|-471,116,4;3348|-456,116,4;3349|-441,116,4;3350|-426,116,4;3351|-411,116,4;3352|-396,116,4;3353|-381,116,4;3354|-366,116,4;3355|-471,116,19;3356|-456,116,19;3357|-441,116,19;3358|-426,116,19;
3359|-411,116,19;3360|-396,116,19;3361|-381,116,19;3362|-366,116,19;3363|-471,116,34;3365|-441,116,34;3366|-426,116,34;3367|-411,116,34;3368|-396,116,34;3369|-381,116,34;3370|-366,116,34;3371|-471,116,49;3372|-456,116,49;3373|-441,116,49;3374|-426,116,49;3375|-411,116,49;3376|-396,116,49;3377|-381,116,49;3378|-366,116,49;3379|-471,116,64;3380|-456,116,64;3381|-441,116,64;3382|-426,116,64;3383|-411,116,64;
3384|-396,116,64;3385|-381,116,64;3387|-463,116,40;3388|-451,116,28;3389|-457,116,33;3390|16,176,-88;3391|-17,176,-179;3392|-39,177,-189;3393|-4,176,-189;3394|-51,184,-210;3395|-29,184,-210;3396|-2,184,-210;3397|-2,184,-224;3398|-34,184,-227;3399|-11,184,-238;3400|-39,194,-241;3401|-38,206,-250;3402|-130,232,-250;3403|-340,134,-250;3404|-340,132,-265;3405|-340,132,-292;3406|-340,132,-301;3407|-340,132,-338;3408|-340,132,-349;
3409|-340,132,-380;3410|-20,176,-188;3411|-25,176,-198;3412|10,179,-232;3413|10,179,-208;3414|142,182,-219;3415|125,182,-232;3416|201.84,162.279,-198.208;3417|132,170,-178.5;3418|132,170,-187;3419|144,169,-182;3420|153,160,-185;3421|163,160,-154;3422|200,160,-162;3423|225,160,-196;3424|147,160,-162;3425|49,229,-408;3426|44,232,-418;3427|23,229,-409;3428|21,232,-418;3429|94,229,-424;3430|140,229,-455;3431|152,231,-450;3432|163,231,-444;
3433|173,241,-429;3434|182,241,-422;3435|187,248,-398;3436|187,248,-387;3437|186,256,-368;3438|185,256,-354;3439|184,263,-340;3440|179,263,-329;3441|172,273,-318;3442|163,273,-309;3443|154,279,-295;3444|144,279,-289;3445|131,285,-277;3446|119,285,-278;3447|90,310,-284;3448|34,304,-298;3449|-18,310,-283;3450|-17,313,-270;3451|34,304,-325;3452|35,199,-330;3453|21,192,-300;3454|11,195,-301;3455|-46,195,-303;3456|-86,183,-323;
3457|-92,183,-296;3458|-60,183,-305;3459|33,236,-512;3460|-494,52,410;3461|-300,17,343;3462|-324,33,349;3463|-413,50,412;3464|-434,50,407;3465|-380,72,458;3466|-381,72,446;3467|-406,50,387;3468|-320,95,471;3469|-320,95,481;3470|-320,95,491;3471|-320,95,501;3472|-320,95,511;3473|-328,95,471;3474|-328,95,481;3475|-328,95,491;3476|-328,95,501;3477|-328,95,511;3478|-328,95,521;3479|-336,95,471;3480|-336,95,481;
3481|-336,95,491;3482|-336,95,501;3483|-336,95,511;3484|-336,95,521;3485|-344,95,471;3486|-344,95,481;3487|-344,95,491;3488|-344,95,501;3489|-344,95,511;3490|-344,95,521;3491|-352,95,471;3492|-352,95,481;3493|-352,95,491;3494|-352,95,501;3495|-352,95,511;3496|-352,95,521;3497|-360,95,471;3498|-360,95,481;3499|-360,95,491;3500|-360,95,501;3501|-360,95,511;3502|-360,95,521;3503|-368,95,471;3504|-368,95,481;
3505|-368,95,491;3506|-368,95,501;3507|-368,95,511;3508|-376,95,471;3509|-376,95,481;3510|-376,95,491;3511|-376,95,501;3512|-376,95,511;3513|-384,95,471;3514|-384,95,481;3515|-384,95,491;3516|-384,95,501;3517|-392,95,471;3518|-392,95,481;3519|-392,95,491;3520|-392,95,501;3521|-400,95,471;3522|-400,95,481;3523|-400,95,491;3524|-400,95,501;3525|-408,95,471;3526|-408,95,481;3527|-408,95,491;3528|-416,95,471;
3529|-416,95,481;3530|-416,95,491;3531|-424,95,471;3532|-424,95,481;3533|-432,95,471;3534|-432,95,481;3535|-344,95,528;3536|-433,109,604;3537|-433,109,594;3538|-433,109,584;3539|-433,109,574;3540|-433,109,564;3541|-433,109,554;3542|-433,109,544;3543|-433,109,534;3544|-433,109,524;3545|-433,109,514;3546|-433,109,504;3547|-433,109,494;3548|-423,109,604;3549|-423,109,594;3550|-423,109,584;3551|-423,109,574;3552|-423,109,564;
3553|-423,109,554;3554|-423,109,544;3555|-423,109,534;3556|-423,109,524;3557|-423,109,514;3558|-423,109,504;3559|-413,109,594;3560|-413,109,584;3561|-413,109,574;3563|-413,109,554;3564|-413,109,544;3565|-413,109,534;3566|-413,109,524;3567|-413,109,514;3568|-403,109,584;3569|-403,109,574;3571|-403,109,554;3572|-403,109,544;3573|-403,109,534;3574|-403,109,524;3575|-403,109,514;3576|-393,109,574;3578|-393,109,554;3579|-393,109,544;
3580|-393,109,534;3581|-393,109,524;3582|-393,109,514;3583|-383,109,564;3584|-383,109,554;3585|-383,109,544;3586|-383,109,534;3587|-383,109,524;3588|-373,109,554;3589|-373,109,544;3590|-373,109,534;3591|-373,109,524;3592|-363,109,544;3593|-363,109,534;3594|-353,109,534;3595|-413,109,504;3596|-184,72,509;3597|-137.071,72.886,499.714;3598|-177.377,73.638,533.573;3599|-368,81,459;3600|-368,81,449;3601|-483,142,411;3602|-543,123,462;3603|-534,123,462;
3604|-525,123,462;3605|-516,123,462;3606|-507,123,462;3607|-498,123,462;3608|-489,123,462;3609|-480,123,462;3610|-471,123,462;3611|-462,123,462;3612|-453,123,462;3613|-444,123,462;3614|-204,17,370;3615|-315,82,415;3616|-285,79,416;3617|-370,88,436;3618|-352,89,431;3619|-334,89,423;3620|-335,88,406;3621|-350,88,411;3622|-371,87,420;3623|-378,81,410;3624|-387,81,395;3625|-393,81,374;3626|-398,92,361;3627|-410,101,349;
3628|-394,91,348;3629|-394,90,308;3630|-353,46,350;3631|-458,122,347;3632|131,65,281;3633|142,65,270;3634|114,65,296;3635|152,65,259;3636|121,65,259;3637|127,65,311;3638|146,65,297;3639|129,65,335;3640|173,66,309;3641|175,65,329;3642|157,65,345;3643|165,71,353;3644|182,71,338;3645|192,71,351;3646|177,71,364;3647|197,77,357;3648|183,77,370;3649|204,77,391;3650|216,77,381;3651|221,84,387;
3652|209,84,397;3653|236,84,407;3654|228,84,414;3655|242,89,414;3656|234,89,420;3657|252,91,435;3658|158,65,327;
]==]
local ATLAS_LABELS = {
    [1] = "Jump",
    [2] = "Jump1",
    [3] = "CoconutJump",
    [4] = "MultiJump",
    [5] = "Drop",
    [6] = "Wait",
    [7] = "Reset",
    [8] = "Night",
    [9] = "DiamondGlider",
    [10] = "Diamond1",
    [11] = "Diamond2",
    [12] = "Diamond3",
    [13] = "Diamond4",
    [14] = "Diamond5",
    [15] = "Diamond6",
    [16] = "KingBeetle",
    [17] = "Treat Dispenser",
    [18] = "20BeeGate",
    [19] = "Cactus Field",
    [20] = "Clover Field",
    [21] = "Mountain Top Field",
    [22] = "Pineapple Patch",
    [23] = "Rose Field",
    [24] = "Pumpkin Patch",
    [25] = "Bamboo Field",
    [26] = "Brown Bear",
    [27] = "Star Hall",
    [28] = "Blue HQ",
    [29] = "Strawberry Field",
    [30] = "Badge Guild",
    [31] = "Blue Flower Field",
    [32] = "Mythic Meteor Shower",
    [33] = "Honey Bee",
    [34] = "Pine Tree Forest",
    [35] = "Polar Bear",
    [36] = "Spider Field",
    [37] = "Stump Field",
    [38] = "Slingshot",
    [39] = "RedPortal",
    [40] = "BlueCannon",
    [41] = "YellowCannon",
    [42] = "BluePortal",
}
local ATLAS_WALK_DATA = [==[
1|2;8;9;2745
2|1;3;8;9;10
3|2;4;9;10;11
4|3;5;10;11;12
5|4;6;11;12;13
6|5;7;12;13;14
7|6;13;14
8|1;2;9;15;16;2745;2768
9|1;2;3;8;10;15;16;17
10|2;3;4;9;11;16;17;18
11|3;4;5;10;12;17;18;19
12|4;5;6;11;13;18;19;20
13|5;6;7;12;14;19;20;21
14|6;7;13;20;21
15|8;9;16;22;23;2745;2768
16|8;9;10;15;17;22;23;24
17|9;10;11;16;18;23;24;25
18|10;11;12;17;19;24;25;26
19|11;12;13;18;20;25;26;27
20|12;13;14;19;21;26;27;28
21|13;14;20;27;28
22|15;16;23;2762;2763;2768
23|15;16;17;22;24;31;2763
24|16;17;18;23;25;31;32
25|17;18;19;24;26;31;32;33
26|18;19;20;25;27;32;33;34
27|19;20;21;26;28;33;34;35
28|20;21;27;34;35
31|23;24;25;32;38;39;2763
32|24;25;26;31;33;38;39;40
33|25;26;27;32;34;39;40;41
34|26;27;28;33;35;40;41;42
35|27;28;34;41;42
38|31;32;39;2763;2764;2765;2790;2791
39|31;32;33;38;40;2765;2790;2791
40|32;33;34;39;41;2765;2788;2790
41|33;34;35;40;42;2787;2788;2790
42|34;35;41;2787;2788
43|44;49;50
44|43;45;50;51;130;139;140
45|44;46;50;51;52;130;139;140;141
46|45;47;51;52;53;140;141;142
47|46;48;52;53;54;141;142;143
48|47;53;54;142;143;144
49|43;50;56;2977
50|43;44;45;49;51;56;57
51|44;45;46;50;52;56;57;58
52|45;46;47;51;53;57;58;59
53|46;47;48;52;54;58;59;60
54|47;48;53;59;60;142;143;144
55|56;61;62
56|49;50;51;55;57;61;62;63
57|50;51;52;56;58;62;63;64
58|51;52;53;57;59;63;64;65
59|52;53;54;58;60;64;65;66
60|53;54;59;65;66
61|55;56;62;67;68
62|55;56;57;61;63;67;68;69
63|56;57;58;62;64;68;69;70
64|57;58;59;63;65;69;70;71
65|58;59;60;64;66;70;71;72
66|59;60;65;71;72
67|61;62;68;73;74
68|61;62;63;67;69;73;74;75
69|62;63;64;68;70;74;75;76
70|63;64;65;69;71;75;76;77
71|64;65;66;70;72;76;77;78
72|65;66;71;77;78
73|67;68;74;79;80
74|67;68;69;73;75;79;80;81
75|68;69;70;74;76;80;81;82
76|69;70;71;75;77;81;82;83
77|70;71;72;76;78;82;83;84
78|71;72;77;83;84;163
79|73;74;80;85;86
80|73;74;75;79;81;85;86;87
81|74;75;76;80;82;86;87;88
82|75;76;77;81;83;87;88;89
83|76;77;78;82;84;88;89;90
84|77;78;83;89;90;163;167
85|79;80;86;91
86|79;80;81;85;87;92;93
87|80;81;82;86;88;92;93;94
88|81;82;83;87;89;93;94;95
89|82;83;84;88;90;94;95;96
90|83;84;89;95;96;163;167;171
91|85;92;97
92|86;87;91;93;98;99
93|86;87;88;92;94;98;99;100
94|87;88;89;93;95;99;100;101
95|88;89;90;94;96;100;101;102
96|89;90;95;101;102;167;171
97|91;98
98|92;93;97;99
99|92;93;94;98;100
100|93;94;95;99;101;2900
101|94;95;96;100;102
102|95;96;101;171
103|104;112;113;2460;2461;2462
104|103;105;112;113;114;2461;2462;2463
105|104;106;113;114;115;2462;2463;2464
106|105;107;114;115;116;2463;2464;2465
107|106;108;115;116;117;2464;2465;2466
108|107;109;116;117;118;2465;2466;2467
109|108;110;117;118;119;2466;2467;2468
110|109;118;119;2467;2468;2984
112|103;104;113;121;122
113|103;104;105;112;114;121;122;123
114|104;105;106;113;115;122;123;124
115|105;106;107;114;116;123;124;125
116|106;107;108;115;117;124;125;126
117|107;108;109;116;118;125;126;127
118|108;109;110;117;119;126;127;128
119|109;110;118;127;128
121|112;113;122;130;131
122|112;113;114;121;123;130;131;132
123|113;114;115;122;124;131;132;133
124|114;115;116;123;125;132;133;134
125|115;116;117;124;126;133;134;135
126|116;117;118;125;127;134;135;136
127|117;118;119;126;128;135;136;137
128|118;119;127;136;137
130|44;45;121;122;131;139;140
131|121;122;123;130;132;139;140;141
132|122;123;124;131;133;140;141;142
133|123;124;125;132;134;141;142;143
134|124;125;126;133;135;142;143;144
135|125;126;127;134;136;143;144
136|126;127;128;135;137;144
137|127;128;136
139|44;45;130;131;140
140|44;45;46;130;131;132;139;141
141|45;46;47;131;132;133;140;142
142|46;47;48;54;132;133;134;141;143
143|47;48;54;133;134;135;142;144
144|48;54;134;135;136;143
146|147;2978;2982
147|146;290;295;300;2978;2982
148|149;153;154;2551;2552;2553;2975
149|148;153;154;2552;2553;2554;2963
151|152;156;157;2546;2555
152|151;156;157;1213;1224;2546;2555;3292
153|148;149;154;158;159;2393;2551;2552;2553;2975
154|148;149;153;155;158;159;160;2963
155|154;156;159;160;161;2963
156|151;152;155;157;160;161;162
157|151;152;156;161;162;1224;1235;1246;2555
158|153;154;159;2392;2393;2394;2975
159|153;154;155;158;160;2393;2394;2395
160|154;155;156;159;161;2394;2395;2396
161|155;156;157;160;162;2395;2396;2405;2898
162|156;157;161;1235;1246;1257;2396;2898
163|78;84;90;164;167;168
164|163;165;167;168;169
165|164;166;168;169;2899
166|165;169;329;334;339;2899
167|84;90;96;163;164;168;171;172
168|163;164;165;167;169;171;172;173
169|164;165;166;168;172;173;174;2899
171|90;96;102;167;168;172
172|167;168;169;171;173
173|168;169;172;174
174|169;173;339;344;349
176|135;146;177;180;181
177|137;146;147;176;178;180;181;182;290
178|147;177;181;182;295;300;305;310
179|48;54;180;183;184
180|176;177;179;181;183;184;185
181|176;177;178;180;182;184;185;186
182|177;178;181;185;186;305;310;315
183|54;60;66;179;180;184;188
184|179;180;181;183;185;188;189
185|180;181;182;184;186;188;189;190
186|181;182;185;189;190;310;315;320
188|183;184;185;189;192;193
189|184;185;186;188;190;192;193;194
190|185;186;189;193;194;315;320;325
192|188;189;193;196;197
193|188;189;190;192;194;196;197;198
194|189;190;193;197;198;320;325;330
195|72;78;90;163;164;165;167;168;196
196|90;163;164;165;167;168;169;192;193;195;197
197|164;165;166;168;192;193;194;196;198;2899
198|165;166;169;193;194;197;325;330;335
199|200;207;208;2728
200|199;201;207;208;209
201|200;202;208;209;210
202|201;203;209;210;211
203|202;204;210;211;212
204|203;205;211;212;213
205|204;206;212;213;214
206|205;213;214
207|199;200;208;215;216;2728
208|199;200;201;207;209;215;216;217
209|200;201;202;208;210;216;217;218
210|201;202;203;209;211;217;218;219
211|202;203;204;210;212;218;219;220
212|203;204;205;211;213;219;220;221
213|204;205;206;212;214;220;221;222
214|205;206;213;221;222
215|207;208;216;223;224
216|207;208;209;215;217;223;224;225
217|208;209;210;216;218;224;225;226
218|209;210;211;217;219;225;226;227
219|210;211;212;218;220;226;227;228
220|211;212;213;219;221;227;228;229
221|212;213;214;220;222;228;229;230
222|213;214;221;229;230
223|215;216;224;231;232
224|215;216;217;223;225;231;232;233
225|216;217;218;224;226;232;233;234
226|217;218;219;225;227;233;234;235
227|218;219;220;226;228;234;235;236
228|219;220;221;227;229;235;236;237
229|220;221;222;228;230;236;237;238
230|221;222;229;237;238
231|223;224;232;239;240
232|223;224;225;231;233;239;240;241
233|224;225;226;232;234;240;241;242
234|225;226;227;233;235;241;242;243
235|226;227;228;234;236;242;243;244
236|227;228;229;235;237;243;244;245
237|228;229;230;236;238;244;245;246
238|229;230;237;245;246
239|231;232;240;247;248
240|231;232;233;239;241;247;248;249
241|232;233;234;240;242;248;249;250
242|233;234;235;241;243;249;250;251
243|234;235;236;242;244;250;251;252
244|235;236;237;243;245;251;252;253
245|236;237;238;244;246;252;253;254
246|237;238;245;253;254
247|239;240;248;255;256
248|239;240;241;247;249;255;256;257
249|240;241;242;248;250;256;257;258
250|241;242;243;249;251;257;258;259
251|242;243;244;250;252;258;259;260
252|243;244;245;251;253;259;260;261
253|244;245;246;252;254;260;261;262
254|245;246;253;261;262
255|247;248;256;263;264;2727
256|247;248;249;255;257;263;264;265;2727
257|248;249;250;256;258;264;265;266
258|249;250;251;257;259;265;266;267
259|250;251;252;258;260;266;267;268
260|251;252;253;259;261;267;268;269
261|252;253;254;260;262;268;269;270
262|253;254;261;269;270
263|255;256;264;271;272;2727
264|255;256;257;263;265;271;272;273;2727
265|256;257;258;264;266;272;273;274
266|257;258;259;265;267;273;274;275
267|258;259;260;266;268;274;275;276
268|259;260;261;267;269;275;276;277
269|260;261;262;268;270;276;277;278
270|261;262;269;277;278
271|263;264;272
272|263;264;265;271;273
273|264;265;266;272;274
274|265;266;267;273;275
275|266;267;268;274;276
276|267;268;269;275;277
277|268;269;270;276;278
278|269;270;277
279|280;284;285
280|279;281;284;285;286
281|280;282;285;286;287
282|281;283;286;287;288
283|282;287;288;2361;2363;2365
284|279;280;285;289;290
285|279;280;281;284;286;289;290;291
286|280;281;282;285;287;290;291;292
287|281;282;283;286;288;291;292;293
288|282;283;287;292;293;2361;2363;2365
289|284;285;290;294;295
290|284;285;286;289;291;294;295;296
291|285;286;287;290;292;295;296;297
292|286;287;288;291;293;296;297;298
293|287;288;292;297;298;2363;2365
294|289;290;295;299;300
295|289;290;291;294;296;299;300;301
296|290;291;292;295;297;300;301;302
297|291;292;293;296;298;301;302;303
298|292;293;297;302;303;2365
299|294;295;300;304;305
300|294;295;296;299;301;304;305;306
301|295;296;297;300;302;305;306;307
302|296;297;298;301;303;306;307;308
303|297;298;302;307;308
304|299;300;305;309;310
305|299;300;301;304;306;309;310;311
306|300;301;302;305;307;310;311;312
307|301;302;303;306;308;311;312;313
308|302;303;307;312;313
309|304;305;310;314;315
310|304;305;306;309;311;314;315;316
311|305;306;307;310;312;315;316;317
312|306;307;308;311;313;316;317;318
313|307;308;312;317;318
314|309;310;315;319;320
315|309;310;311;314;316;319;320;321
316|310;311;312;315;317;320;321;322
317|311;312;313;316;318;321;322;323
318|312;313;317;322;323
319|314;315;320;324;325
320|314;315;316;319;321;324;325;326
321|315;316;317;320;322;325;326;327
322|316;317;318;321;323;326;327;328
323|317;318;322;327;328
324|319;320;325;329;330
325|319;320;321;324;326;329;330;331
326|320;321;322;325;327;330;331;332
327|321;322;323;326;328;331;332;333
328|322;323;327;332;333
329|324;325;330;334;335
330|324;325;326;329;331;334;335;336
331|325;326;327;330;332;335;336;337
332|326;327;328;331;333;336;337;338
333|327;328;332;337;338
334|329;330;335;339;340
335|329;330;331;334;336;339;340;341
336|330;331;332;335;337;340;341;342
337|331;332;333;336;338;341;342;343
338|332;333;337;342;343
339|334;335;340;344;345
340|334;335;336;339;341;344;345;346
341|335;336;337;340;342;345;346;347
342|336;337;338;341;343;346;347;348
343|337;338;342;347;348
344|339;340;345;349;350;174,1
345|339;340;341;344;346;349;350;351
346|340;341;342;345;347;350;351;352
347|341;342;343;346;348;351;352;353
348|342;343;347;352;353
349|344;345;350;354;355
350|344;345;346;349;351;354;355;356
351|345;346;347;350;352;355;356;357
352|346;347;348;351;353;356;357;358
353|347;348;352;357;358
354|349;350;355;359;360
355|349;350;351;354;356;359;360;361
356|350;351;352;355;357;360;361;362
357|351;352;353;356;358;361;362;363
358|352;353;357;362;363;2727,16
359|354;355;360
360|354;355;356;359;361;2875
361|355;356;357;360;362;2874;2875
362|356;357;358;361;363;2874;2875
363|357;358;362;2874
364|365;368;369;2876
365|364;366;368;369;370;2876;2877
366|365;367;369;370;371;2876;2877
367|366;370;371;2878
368|364;365;369;372;373
369|364;365;366;368;370;372;373;374
370|365;366;367;369;371;373;374;375
371|366;367;370;374;375;2878;2879
372|368;369;373;376;377
373|368;369;370;372;374;376;377;378;2880
374|369;370;371;373;375;377;378;379
375|370;371;374;378;379;2879;2880
376|372;373;377;380;381
377|372;373;374;376;378;380;381;382
378|373;374;375;377;379;381;382;383
379|374;375;378;382;383;2880
380|376;377;381;384;385;2882
381|376;377;378;380;382;384;385;386
382|377;378;379;381;383;385;386
383|378;379;382
384|380;381;385;2881;2882
385|380;381;382;384;386
386|381;382;385;387
387|386
388|389;391;392
389|388;390;391;392;393
390|389;392;393;2887;2889;2890,2;2891
391|388;389;392;394;395
392|388;389;390;391;393;394;395;396
393|389;390;392;395;396;2890,2
394|391;392;395;397;398
395|391;392;393;394;396;397;398;399
396|392;393;395;398;399;2890,2
397|394;395;398
398|394;395;396;397;399
399|395;396;398
400|401;412;413;1484;1485;1488
401|400;402;412;413;414;1485
402|401;403;413;414;415
403|402;404;414;415;416
404|403;405;415;416;417
405|404;406;416;417;418
406|405;407;417;418;419
407|406;408;418;419;420;1587
408|407;409;419;420;421;1587;1588
409|408;410;420;421;422;1587;1588;1589
410|409;411;421;422;423;1556;1586;1588;1589
411|410;422;423;1556;1557;1589;3190
412|400;401;413;424;425;1485;1488;1491
413|400;401;402;412;414;424;425;426
414|401;402;403;413;415;425;426;427
415|402;403;404;414;416;426;427;428
416|403;404;405;415;417;427;428;429
417|404;405;406;416;418;428;429;430
418|405;406;407;417;419;429;430;431
419|406;407;408;418;420;430;431;432
420|407;408;409;419;421;431;432;433
421|408;409;410;420;422;432;433;434
422|409;410;411;421;423;433;434;435
423|410;411;422;434;435;1556;3190;3191;3197
424|412;413;425;436;437;1488;1491;1494
425|412;413;414;424;426;436;437;438
426|413;414;415;425;427;437;438;439
427|414;415;416;426;428;438;439;440
428|415;416;417;427;429;439;440;441
429|416;417;418;428;430;440;441;442
430|417;418;419;429;431;441;442;443
431|418;419;420;430;432;442;443;444
432|419;420;421;431;433;443;444;445
433|420;421;422;432;434;444;445;446
434|421;422;423;433;435;445;446;447
435|422;423;434;446;447;3197
436|424;425;437;448;449;1491;1494;1497
437|424;425;426;436;438;448;449;450
438|425;426;427;437;439;449;450;451
439|426;427;428;438;440;450;451;452
440|427;428;429;439;441;451;452;453
441|428;429;430;440;442;452;453;454
442|429;430;431;441;443;453;454;455
443|430;431;432;442;444;454;455;456
444|431;432;433;443;445;455;456;457
445|432;433;434;444;446;456;457;458
446|433;434;435;445;447;457;458;459
447|434;435;446;458;459;3196
448|436;437;449;460;461;1494;1497;1500
449|436;437;438;448;450;460;461;462
450|437;438;439;449;451;461;462;463
451|438;439;440;450;452;462;463;464
452|439;440;441;451;453;463;464;465
453|440;441;442;452;454;464;465;466
454|441;442;443;453;455;465;466;467
455|442;443;444;454;456;466;467;468
456|443;444;445;455;457;467;468;469
457|444;445;446;456;458;468;469;470
458|445;446;447;457;459;469;470;471
459|446;447;458;470;471;3196;3198
460|448;449;461;472;473;1497;1500;1503
461|448;449;450;460;462;472;473;474
462|449;450;451;461;463;473;474;475
463|450;451;452;462;464;474;475;476
464|451;452;453;463;465;475;476;477
465|452;453;454;464;466;476;477;478
466|453;454;455;465;467;477;478;479
467|454;455;456;466;468;478;479;480
468|455;456;457;467;469;479;480;481
469|456;457;458;468;470;480;481;482
470|457;458;459;469;471;481;482;483
471|458;459;470;482;483;3137;3198
472|460;461;473;484;485;1500;1503;1506
473|460;461;462;472;474;484;485;486
474|461;462;463;473;475;485;486;487
475|462;463;464;474;476;486;487;488
476|463;464;465;475;477;487;488;489
477|464;465;466;476;478;488;489;490
478|465;466;467;477;479;489;490;491
479|466;467;468;478;480;490;491;492
480|467;468;469;479;481;491;492;493
481|468;469;470;480;482;492;493;494
482|469;470;471;481;483;493;494;495
483|470;471;482;494;495;3137
484|472;473;485;496;497;1503;1506;1509
485|472;473;474;484;486;496;497;498
486|473;474;475;485;487;497;498;499
487|474;475;476;486;488;498;499;500
488|475;476;477;487;489;499;500;501
489|476;477;478;488;490;500;501;502
490|477;478;479;489;491;501;502;503
491|478;479;480;490;492;502;503;504
492|479;480;481;491;493;503;504;505
493|480;481;482;492;494;504;505;506
494|481;482;483;493;495;505;506;507
495|482;483;494;506;507;3137
496|484;485;497;509;1506;1509;1512
497|484;485;486;496;498;509;510
498|485;486;487;497;499;509;510;511
499|486;487;488;498;500;510;511;512
500|487;488;489;499;501;511;512
501|488;489;490;500;502;512;514
502|489;490;491;501;503;514;515
503|490;491;492;502;504;514;515;516
504|491;492;493;503;505;516;517
505|492;493;494;504;506;516;517;518
506|493;494;495;505;507;517;518;519
507|494;495;506;518;519
509|496;497;498;510;520;521;522
510|497;498;499;509;511;521;522;523
511|498;499;500;510;512;522;523;524
512|499;500;501;511;523;524
514|501;502;503;515;525;526;527
515|502;503;514;526;527
516|503;504;505;517;527;528;529
517|504;505;506;516;518;528;529;530
518|505;506;507;517;519;529;530;531
519|506;507;518;530;531;3270
520|509;521;532;533;1512;1514;1515
521|509;510;520;522;532;533;534
522|509;510;511;521;523;533;534;535
523|510;511;512;522;524;534;535;536
524|511;512;523;525;535;536;537
525|514;524;526;536;537;538
526|514;515;525;527;537;538;539
527|514;515;516;526;528;538;539;540
528|516;517;527;529;539;540;541
529|516;517;518;528;530;540;541;542
530|517;518;519;529;531;541;542;543
531|518;519;530;542;543;3270;3294
532|520;521;533;544;545;1515
533|520;521;522;532;534;544;545;546
534|521;522;523;533;535;545;546;547
535|522;523;524;534;536;546;547;548
536|523;524;525;535;537;547;548;549
537|524;525;526;536;538;548;549;550
538|525;526;527;537;539;549;550;551
539|526;527;528;538;540;550;551;552
540|527;528;529;539;541;551;552;553
541|528;529;530;540;542;552;553;554
542|529;530;531;541;543;553;554;555
543|530;531;542;554;555;3270;3294
544|532;533;545;556;557
545|532;533;534;544;546;556;557;558
546|533;534;535;545;547;557;558;559
547|534;535;536;546;548;558;559;560
548|535;536;537;547;549;559;560;561
549|536;537;538;548;550;560;561;562
550|537;538;539;549;551;561;562;563
551|538;539;540;550;552;562;563;564
552|539;540;541;551;553;563;564;565
553|540;541;542;552;554;564;565;566
554|541;542;543;553;555;565;566
555|542;543;554;566
556|544;545;557;568;569
557|544;545;546;556;558;568;569;570
558|545;546;547;557;559;569;570;571
559|546;547;548;558;560;570;571;572
560|547;548;549;559;561;571;572;573
561|548;549;550;560;562;572;573;574
562|549;550;551;561;563;573;574;575
563|550;551;552;562;564;574;575;576
564|551;552;553;563;565;575;576;577
565|552;553;554;564;566;576;577;578
566|553;554;555;565;577;578;579
568|556;557;569;580;581
569|556;557;558;568;570;580;581;582
570|557;558;559;569;571;581;582;583
571|558;559;560;570;572;582;583;584
572|559;560;561;571;573;583;584;585
573|560;561;562;572;574;584;585;586
574|561;562;563;573;575;585;586;587
575|562;563;564;574;576;586;587;588
576|563;564;565;575;577;587;588;589
577|564;565;566;576;578;588;589;590
578|565;566;577;579;589;590;591
579|566;578;590;591
580|568;569;581;592;593
581|568;569;570;580;582;592;593;594
582|569;570;571;581;583;593;594;595
583|570;571;572;582;584;594;595;596
584|571;572;573;583;585;595;596;597
585|572;573;574;584;586;596;597;598
586|573;574;575;585;587;597;598;599
587|574;575;576;586;588;598;599;600
588|575;576;577;587;589;599;600;601
589|576;577;578;588;590;600;601;602
590|577;578;579;589;591;601;602;603
591|578;579;590;602;603
592|580;581;593;604;605
593|580;581;582;592;594;604;605;606
594|581;582;583;593;595;605;606;607
595|582;583;584;594;596;606;607;608
596|583;584;585;595;597;607;608;609
597|584;585;586;596;598;608;609;610
598|585;586;587;597;599;609;610;611
599|586;587;588;598;600;610;611;612
600|587;588;589;599;601;611;612;613
601|588;589;590;600;602;612;613;614
602|589;590;591;601;603;613;614;615
603|590;591;602;614;615
604|592;593;605;616;617
605|592;593;594;604;606;616;617;618
606|593;594;595;605;607;617;618;619
607|594;595;596;606;608;618;619;620
608|595;596;597;607;609;619;620;621
609|596;597;598;608;610;620;621;622
610|597;598;599;609;611;621;622;623
611|598;599;600;610;612;622;623;624
612|599;600;601;611;613;623;624;625
613|600;601;602;612;614;624;625;626
614|601;602;603;613;615;625;626;627
615|602;603;614;626;627
616|604;605;617;628;629
617|604;605;606;616;618;628;629;630
618|605;606;607;617;619;629;630;631
619|606;607;608;618;620;630;631;632
620|607;608;609;619;621;631;632;633
621|608;609;610;620;622;632;633;634
622|609;610;611;621;623;633;634;635
623|610;611;612;622;624;634;635
624|611;612;613;623;625;635;637
625|612;613;614;624;626;637;638
626|613;614;615;625;627;637;638
627|614;615;626;638
628|616;617;629
629|616;617;618;628;630
630|617;618;619;629;631
631|618;619;620;630;632
632|619;620;621;631;633
633|620;621;622;632;634
634|621;622;623;633;635
635|622;623;624;634
637|624;625;626;638
638|625;626;627;637
640|308;313;318;641;650;651
641|640;642;650;651;652
642|641;643;651;652;653;2381;2856
643|642;644;652;653;654;2381;2382;2855
644|643;645;653;654;655;2382;2383;2855
645|644;646;654;655;656;2383;2384
646|645;647;655;656;657;2384;2385
647|646;648;656;657;658;2385;2386
648|647;649;657;658;659;2386
649|648;658;659
650|313;318;323;640;641;651;660;661
651|640;641;642;650;652;660;661;662
652|641;642;643;651;653;661;662;663
653|642;643;644;652;654;662;663;664;2855
654|643;644;645;653;655;663;664;665;2855
655|644;645;646;654;656;664;665;666
656|645;646;647;655;657;665;666;667
657|646;647;648;656;658;666;667;668
658|647;648;649;657;659;667;668;669
659|648;649;658;668;669
660|318;323;328;650;651;661;670;671
661|650;651;652;660;662;670;671;672
662|651;652;653;661;663;671;672;673
663|652;653;654;662;664;672;673;674
664|653;654;655;663;665;673;674;675
665|654;655;656;664;666;674;675;676
666|655;656;657;665;667;675;676;677
667|656;657;658;666;668;676;677;678
668|657;658;659;667;669;677;678;679
669|658;659;668;678;679
670|323;328;333;660;661;671;680;681
671|660;661;662;670;672;680;681;682
672|661;662;663;671;673;681;682;683
673|662;663;664;672;674;682;683;684
674|663;664;665;673;675;683;684;685
675|664;665;666;674;676;684;685;686
676|665;666;667;675;677;685;686;687
677|666;667;668;676;678;686;687;688
678|667;668;669;677;679;687;688;689
679|668;669;678;688;689
680|328;333;338;670;671;681;690;691
681|670;671;672;680;682;690;691;692
682|671;672;673;681;683;691;692;693
683|672;673;674;682;684;692;693;694
684|673;674;675;683;685;693;694;695
685|674;675;676;684;686;694;695;696
686|675;676;677;685;687;695;696;697
687|676;677;678;686;688;696;697;698
688|677;678;679;687;689;697;698;699
689|678;679;688;698;699
690|333;338;343;680;681;691;700;701
691|680;681;682;690;692;700;701;702
692|681;682;683;691;693;701;702;703
693|682;683;684;692;694;702;703;704
694|683;684;685;693;695;703;704;705
695|684;685;686;694;696;704;705;706
696|685;686;687;695;697;705;706;707
697|686;687;688;696;698;706;707;708
698|687;688;689;697;699;707;708;709
699|688;689;698;708;709
700|338;343;348;690;691;701;710;711
701|690;691;692;700;702;710;711;712
702|691;692;693;701;703;711;712;713
703|692;693;694;702;704;712;713;714
704|693;694;695;703;705;713;714;715
705|694;695;696;704;706;714;715;716
706|695;696;697;705;707;715;716;717
707|696;697;698;706;708;716;717;718
708|697;698;699;707;709;717;718;719
709|698;699;708;718;719
710|700;701;711;720;721
711|700;701;702;710;712;720;721;722
712|701;702;703;711;713;721;722;723
713|702;703;704;712;714;722;723;724
714|703;704;705;713;715;723;724;725
715|704;705;706;714;716;724;725;726
716|705;706;707;715;717;725;726;727
717|706;707;708;716;718;726;727;728
718|707;708;709;717;719;727;728;729
719|708;709;718;728;729
720|710;711;721;730;731
721|710;711;712;720;722;730;731;732
722|711;712;713;721;723;731;732;733
723|712;713;714;722;724;732;733;734
724|713;714;715;723;725;733;734;735
725|714;715;716;724;726;734;735;736
726|715;716;717;725;727;735;736;737
727|716;717;718;726;728;736;737;738
728|717;718;719;727;729;737;738
729|718;719;728;738
730|720;721;731;740;741;2874
731|720;721;722;730;732;740;741;742
732|721;722;723;731;733;741;742;743
733|722;723;724;732;734;742;743;744
734|723;724;725;733;735;743;744;745
735|724;725;726;734;736;744;745;746
736|725;726;727;735;737;745;746;747
737|726;727;728;736;738;746;747;748
738|727;728;729;737;747;748
740|352;357;363;730;731;741;750;751;2874
741|730;731;732;740;742;750;751
742|731;732;733;741;743;752;753
743|732;733;734;742;744;752;753;754
744|733;734;735;743;745;753;754;755
745|734;735;736;744;746;754;755;756
746|735;736;737;745;747;755;756;757
747|736;737;738;746;748;756;757;758
748|737;738;747;757;758
750|363;740;741;751;2874
751|740;741;750;752;760;2857
752|742;743;751;753;760;761;2857
753|742;743;744;752;754;761;2858
754|743;744;745;753;755;2858
755|744;745;746;754;756
756|745;746;747;755;757
757|746;747;748;756;758
758|747;748;757
760|751;752;761;762;763;2857
761|752;753;760;762;763;2857;2858;2859
762|760;761;763;764;765
763|760;761;762;764;765;2859
764|762;763;765;766;767
765|762;763;764;766;767
766|764;765;767;768;769
767|764;765;766;768;769
768|766;767;769;770;771
769|766;767;768;770;771
770|768;769;771;772;773
771|768;769;770;772;773
772|770;771;773;774;775
773|770;771;772;774;775
774|772;773;775
775|772;773;774
776|761;763;765;777;778;779;2858
777|776;778;779;2858;2869;2873
778|765;767;776;777;779;780;781
779|776;777;778;780;781;2873
780|767;769;778;779;781;782;783
781|778;779;780;782;783
782|769;771;780;781;783
783|780;781;782
786|777;779;781;787;788;789
787|786;788;789
788|779;781;783;786;787;789;790;791
789|786;787;788;790;791
790|781;783;788;789;791;792;793
791|788;789;790;792;793
792|783;790;791;793
793|790;791;792
794|786;787;788;789;791;795;797;798
795|787;789;794;796;797;798;799
796|795;798;799
797|787;788;789;790;791;793;794;795;798;800
798|794;795;796;797;799;800;802
799|795;796;798;802
800|789;790;791;792;793;797;798;803;804
802|798;799;805
803|791;792;793;800;804
804|793;800;803;805
805|802;804
806|807;813;814;2176,2;3615,1;3616,1
807|806;808;813;814;815;2176,2;2177,2
808|807;809;814;815;816;2177,2;2178,2
809|808;810;815;816;817;2178,2
810|809;811;816;817;818
811|810;812;817;818;819
812|811;818;819
813|806;807;814;820;821;3615,1;3616,1
814|806;807;808;813;815;820;821;822
815|807;808;809;814;816;821;822;823
816|808;809;810;815;817;822;823;824
817|809;810;811;816;818;823;824;825
818|810;811;812;817;819;824;825;826
819|811;812;818;825;826
820|813;814;821;827;828;3616,1
821|813;814;815;820;822;827;828;829
822|814;815;816;821;823;828;829;830
823|815;816;817;822;824;829;830;831
824|816;817;818;823;825;830;831;832
825|817;818;819;824;826;831;832;833
826|818;819;825;832;833
827|820;821;828;834;835;2840;2843
828|820;821;822;827;829;834;835;836
829|821;822;823;828;830;835;836;837
830|822;823;824;829;831;836;837;838
831|823;824;825;830;832;837;838;839
832|824;825;826;831;833;838;839;840
833|825;826;832;839;840
834|827;828;835;841;842;2840;2843
835|827;828;829;834;836;841;842;843
836|828;829;830;835;837;842;843;844
837|829;830;831;836;838;843;844;845
838|830;831;832;837;839;844;845;846
839|831;832;833;838;840;845;846;847
840|832;833;839;846;847
841|834;835;842;848;849;2840;2843;3614
842|834;835;836;841;843;848;849;850
843|835;836;837;842;844;849;850;851
844|836;837;838;843;845;850;851;852
845|837;838;839;844;846;851;852;853
846|838;839;840;845;847;852;853;854
847|839;840;846;853;854
848|841;842;849;855;856;2840;2843;3614
849|841;842;843;848;850;855;856;857
850|842;843;844;849;851;856;857;858
851|843;844;845;850;852;857;858;859
852|844;845;846;851;853;858;859;860
853|845;846;847;852;854;859;860;861
854|846;847;853;860;861
855|848;849;856;862;863;3614
856|848;849;850;855;857;862;863;864
857|849;850;851;856;858;863;864;865
858|850;851;852;857;859;864;865;866
859|851;852;853;858;860;865;866;867
860|852;853;854;859;861;866;867;868
861|853;854;860;867;868
862|855;856;863;3614
863|855;856;857;862;864
864|856;857;858;863;865
865|857;858;859;864;866;3596
866|858;859;860;865;867;3596;3597
867|859;860;861;866;868;3596;3597
868|860;861;867;3596;3597
869|870;873;874;1234;1245;1256;2811
870|869;871;873;874;875;2810;2811
871|870;872;874;875;876;2810;2811
872|871;875;876;2238;2245;2252;2809;2810
873|869;870;874;877;878;1245;1256;1267
874|869;870;871;873;875;877;878;879
875|870;871;872;874;876;878;879;880
876|871;872;875;879;880;2245;2252
877|873;874;878;881;882;1256;1267;1278
878|873;874;875;877;879;881;882;883
879|874;875;876;878;880;882;883;884
880|875;876;879;883;884
881|877;878;882;885;886;1267;1278;1289
882|877;878;879;881;883;885;886;887
883|878;879;880;882;884;886;887;888
884|879;880;883;887;888
885|881;882;886;889;890;1278;1289;1300
886|881;882;883;885;887;889;890;891
887|882;883;884;886;888;890;891;892
888|883;884;887;891;892
889|885;886;890;893;894;1289;1300;1311
890|885;886;887;889;891;893;894;895
891|886;887;888;890;892;894;895;896
892|887;888;891;895;896;2273;2280;2287
893|889;890;894;897;898;1300;1311;1322
894|889;890;891;893;895;897;898;899
895|890;891;892;894;896;898;899;900
896|891;892;895;899;900;2280;2287;2294
897|893;894;898;901;902;1311;1322;2182
898|893;894;895;897;899;901;902;903
899|894;895;896;898;900;902;903;904
900|895;896;899;903;904;2287;2294
901|897;898;902;905;906;1322;2182;2186
902|897;898;899;901;903;905;906;907
903|898;899;900;902;904;906;907;908
904|899;900;903;907;908
905|901;902;906;909;910;2182;2186;2190
906|901;902;903;905;907;909;910;911
907|902;903;904;906;908;910;911;912
908|903;904;907;911;912
909|905;906;910;913;914;2186;2190;2194
910|905;906;907;909;911;913;914;915
911|906;907;908;910;912;914;915;916
912|907;908;911;915;916
913|909;910;914;917;918;2190;2194;2198
914|909;910;911;913;915;917;918;919
915|910;911;912;914;916;918;919;920
916|911;912;915;919;920
917|913;914;918;921;922;2194;2198;2202
918|913;914;915;917;919;921;922;923
919|914;915;916;918;920;922;923;924
920|915;916;919;923;924
921|917;918;922;2198;2202;2854
922|917;918;919;921;923;2854
923|918;919;920;922;924
924|919;920;923
925|936;937;3412,1;3452;3453
929|930;939;940;941;3391;3393
930|929;931;940;941;942;3391
931|930;932;941;942;943
932|931;933;942;943;944
933|932;934;943;944;945
934|933;935;944;945;946
935|934;945;946;3390
936|925;937;947;948;3452;3453
937|925;936;938;947;948;949
938|937;939;948;949;950;3413,1
939|929;938;940;949;950;951;3413,1
940|929;930;939;941;950;951;952
941|929;930;931;940;942;951;952;953
942|930;931;932;941;943;952;953;954
943|931;932;933;942;944;953;954;955
944|932;933;934;943;945;954;955;956
945|933;934;935;944;946;955;956;957
946|934;935;945;956;957
947|936;937;948;958;959;3425;3452;3453
948|936;937;938;947;949;958;959;960
949|937;938;939;948;950;959;960;961
950|938;939;940;949;951;960;961;962
951|939;940;941;950;952;961;962;963
952|940;941;942;951;953;962;963;964
953|941;942;943;952;954;963;964;965
954|942;943;944;953;955;964;965;966
955|943;944;945;954;956;965;966;967
956|944;945;946;955;957;966;967;968
957|945;946;956;967;968
958|947;948;959;969;970
959|947;948;949;958;960;969;970;971
960|948;949;950;959;961;970;971;972
961|949;950;951;960;962;971;972;973
962|950;951;952;961;963;972;973;974
963|951;952;953;962;964;973;974;975
964|952;953;954;963;965;974;975;976
965|953;954;955;964;966;975;976;977
966|954;955;956;965;967;976;977;978
967|955;956;957;966;968;977;978;979
968|956;957;967;978;979
969|958;959;970;980;981
970|958;959;960;969;971;980;981;982
971|959;960;961;970;972;981;982;983
972|960;961;962;971;973;982;983;984
973|961;962;963;972;974;983;984;985
974|962;963;964;973;975;984;985;986
975|963;964;965;974;976;985;986;987
976|964;965;966;975;977;986;987;988
977|965;966;967;976;978;987;988;989
978|966;967;968;977;979;988;989;990
979|967;968;978;989;990
980|969;970;981;991;992
981|969;970;971;980;982;991;992;993
982|970;971;972;981;983;992;993;994
983|971;972;973;982;984;993;994;995
984|972;973;974;983;985;994;995;996
985|973;974;975;984;986;995;996;997
986|974;975;976;985;987;996;997;998
987|975;976;977;986;988;997;998;999
988|976;977;978;987;989;998;999;1000
989|977;978;979;988;990;999;1000;1001
990|978;979;989;1000;1001;3173;3174
991|980;981;992;1003
992|980;981;982;991;993;1003;1004
993|981;982;983;992;994;1003;1004;1005
994|982;983;984;993;995;1004;1005;1006
995|983;984;985;994;996;1005;1006;1007
996|984;985;986;995;997;1006;1007;1008
997|985;986;987;996;998;1007;1008;1009
998|986;987;988;997;999;1008;1009;1010
999|987;988;989;998;1000;1009;1010;1011
1000|988;989;990;999;1001;1010;1011;1012
1001|989;990;1000;1011;1012;3173;3174
1003|991;992;993;1004;1015
1004|992;993;994;1003;1005;1015;1016
1005|993;994;995;1004;1006;1015;1016;1017
1006|994;995;996;1005;1007;1016;1017;1018
1007|995;996;997;1006;1008;1017;1018;1019
1008|996;997;998;1007;1009;1018;1019;1020
1009|997;998;999;1008;1010;1019;1020;1021
1010|998;999;1000;1009;1011;1020;1021;1022
1011|999;1000;1001;1010;1012;1021;1022;1023
1012|1000;1001;1011;1022;1023;3173;3174
1015|1003;1004;1005;1016;3414,1
1016|1004;1005;1006;1015;1017;3419
1017|1005;1006;1007;1016;1018;3418;3419
1018|1006;1007;1008;1017;1019;3417;3419
1019|1007;1008;1009;1018;1020;3424
1020|1008;1009;1010;1019;1021;3421;3424
1021|1009;1010;1011;1020;1022
1022|1010;1011;1012;1021;1023
1023|1011;1012;1022
1027|1028;1032;1033;1034
1028|1027;1029;1033;1034;1035
1029|1028;1034;1035
1030|1031;1036;1037
1031|1030;1032;1036;1037;1038
1032|1027;1031;1033;1037;1038;1039
1033|1027;1028;1032;1034;1038;1039;1040
1034|1027;1028;1029;1033;1035;1039;1040;1041
1035|1028;1029;1034;1040;1041
1036|1030;1031;1037;3391
1037|1030;1031;1032;1036;1038
1038|1031;1032;1033;1037;1039
1039|1032;1033;1034;1038;1040
1040|1033;1034;1035;1039;1041
1041|1034;1035;1040
1048|1049;1059;1060
1049|1048;1050;1059;1060;1061
1050|1049;1051;1060;1061;1062
1051|1050;1052;1061;1062;1063
1052|1051;1053;1062;1063;1064
1053|1052;1054;1063;1064;1065
1054|1053;1055;1064;1065;1066
1055|1054;1056;1065;1066;1067
1056|1055;1057;1066;1067;1068
1057|1056;1058;1067;1068;1069
1058|1057;1068;1069
1059|1048;1049;1060;1070;1071
1060|1048;1049;1050;1059;1061;1070;1071;1072
1061|1049;1050;1051;1060;1062;1071;1072;1073
1062|1050;1051;1052;1061;1063;1072;1073;1074
1063|1051;1052;1053;1062;1064;1073;1074;1075
1064|1052;1053;1054;1063;1065;1074;1075;1076
1065|1053;1054;1055;1064;1066;1075;1076;1077
1066|1054;1055;1056;1065;1067;1076;1077;1078
1067|1055;1056;1057;1066;1068;1077;1078;1079
1068|1056;1057;1058;1067;1069;1078;1079;1080
1069|1057;1058;1068;1079;1080
1070|1059;1060;1071;1081;1082
1071|1059;1060;1061;1070;1072;1081;1082;1083
1072|1060;1061;1062;1071;1073;1082;1083;1084
1073|1061;1062;1063;1072;1074;1083;1084;1085
1074|1062;1063;1064;1073;1075;1084;1085;1086
1075|1063;1064;1065;1074;1076;1085;1086;1087
1076|1064;1065;1066;1075;1077;1086;1087;1088
1077|1065;1066;1067;1076;1078;1087;1088;1089
1078|1066;1067;1068;1077;1079;1088;1089;1090
1079|1067;1068;1069;1078;1080;1089;1090;1091
1080|1068;1069;1079;1090;1091
1081|1070;1071;1082;1092;1093
1082|1070;1071;1072;1081;1083;1092;1093;1094
1083|1071;1072;1073;1082;1084;1093;1094;1095
1084|1072;1073;1074;1083;1085;1094;1095;1096
1085|1073;1074;1075;1084;1086;1095;1096;1097
1086|1074;1075;1076;1085;1087;1096;1097;1098
1087|1075;1076;1077;1086;1088;1097;1098;1099
1088|1076;1077;1078;1087;1089;1098;1099;1100
1089|1077;1078;1079;1088;1090;1099;1100;1101
1090|1078;1079;1080;1089;1091;1100;1101;1102
1091|1079;1080;1090;1101;1102
1092|1081;1082;1093
1093|1081;1082;1083;1092;1094
1094|1082;1083;1084;1093;1095
1095|1083;1084;1085;1094;1096
1096|1084;1085;1086;1095;1097
1097|1085;1086;1087;1096;1098
1098|1086;1087;1088;1097;1099;1110
1099|1087;1088;1089;1098;1100;1110;1111
1100|1088;1089;1090;1099;1101;1110;1111;1112
1101|1089;1090;1091;1100;1102;1111;1112;1113
1102|1090;1091;1101;1112;1113;3428
1110|1098;1099;1100;1111;1121;1122;3459,1
1111|1099;1100;1101;1110;1112;1121;1122;1123
1112|1100;1101;1102;1111;1113;1122;1123;1124
1113|1101;1102;1112;1123;1124;3426;3428
1121|1110;1111;1122;1132;1133;3459,1
1122|1110;1111;1112;1121;1123;1132;1133;1134
1123|1111;1112;1113;1122;1124;1133;1134;1135
1124|1112;1113;1123;1134;1135;3426;3428
1132|1121;1122;1133;1143;1144;3459,1
1133|1121;1122;1123;1132;1134;1143;1144;1145
1134|1122;1123;1124;1133;1135;1144;1145;1146
1135|1123;1124;1134;1145;1146;3426;3428
1143|1132;1133;1144;1153;1154;1155;3459,1
1144|1132;1133;1134;1143;1145;1154;1155;1156
1145|1133;1134;1135;1144;1146;1155;1156;1157
1146|1134;1135;1145;1156;1157;3426
1147|1148;1158;1159
1148|1147;1149;1158;1159;1160
1149|1148;1150;1159;1160;1161
1150|1149;1151;1160;1161;1162
1151|1150;1152;1161;1162;1163
1152|1151;1153;1162;1163;1164
1153|1143;1152;1154;1163;1164;1165
1154|1143;1144;1153;1155;1164;1165;1166
1155|1143;1144;1145;1154;1156;1165;1166;1167
1156|1144;1145;1146;1155;1157;1166;1167;1168
1157|1145;1146;1156;1167;1168;3426
1158|1147;1148;1159;1169;1170
1159|1147;1148;1149;1158;1160;1169;1170;1171
1160|1148;1149;1150;1159;1161;1170;1171;1172
1161|1149;1150;1151;1160;1162;1171;1172;1173
1162|1150;1151;1152;1161;1163;1172;1173;1174
1163|1151;1152;1153;1162;1164;1173;1174;1175
1164|1152;1153;1154;1163;1165;1174;1175;1176
1165|1153;1154;1155;1164;1166;1175;1176;1177
1166|1154;1155;1156;1165;1167;1176;1177;1178
1167|1155;1156;1157;1166;1168;1177;1178;1179
1168|1156;1157;1167;1178;1179
1169|1158;1159;1170;1180;1181
1170|1158;1159;1160;1169;1171;1180;1181;1182
1171|1159;1160;1161;1170;1172;1181;1182;1183
1172|1160;1161;1162;1171;1173;1182;1183;1184
1173|1161;1162;1163;1172;1174;1183;1184;1185
1174|1162;1163;1164;1173;1175;1184;1185;1186
1175|1163;1164;1165;1174;1176;1185;1186;1187
1176|1164;1165;1166;1175;1177;1186;1187;1188
1177|1165;1166;1167;1176;1178;1187;1188;1189
1178|1166;1167;1168;1177;1179;1188;1189;1190
1179|1167;1168;1178;1189;1190
1180|1169;1170;1181;1191;1192
1181|1169;1170;1171;1180;1182;1191;1192;1193
1182|1170;1171;1172;1181;1183;1192;1193;1194
1183|1171;1172;1173;1182;1184;1193;1194;1195
1184|1172;1173;1174;1183;1185;1194;1195;1196
1185|1173;1174;1175;1184;1186;1195;1196;1197
1186|1174;1175;1176;1185;1187;1196;1197;1198
1187|1175;1176;1177;1186;1188;1197;1198;1199
1188|1176;1177;1178;1187;1189;1198;1199;1200
1189|1177;1178;1179;1188;1190;1199;1200;1201
1190|1178;1179;1189;1200;1201
1191|1180;1181;1192
1192|1180;1181;1182;1191;1193
1193|1181;1182;1183;1192;1194
1194|1182;1183;1184;1193;1195
1195|1183;1184;1185;1194;1196
1196|1184;1185;1186;1195;1197
1197|1185;1186;1187;1196;1198
1198|1186;1187;1188;1197;1199
1199|1187;1188;1189;1198;1200
1200|1188;1189;1190;1199;1201
1201|1189;1190;1200;3430
1202|1203;1213;1214
1203|1202;1204;1213;1214;1215
1204|1203;1205;1214;1215;1216
1205|1204;1206;1215;1216;1217
1206|1205;1207;1216;1217;1218
1207|1206;1208;1217;1218;1219
1208|1207;1209;1218;1219;1220;2716;2717
1209|1208;1210;1219;1220;1221;2716;2717;2718
1210|1209;1211;1220;1221;1222;2717;2718
1211|1210;1221;1222;1223
1213|1202;1203;1214;1224;1225;152,2
1214|1202;1203;1204;1213;1215;1224;1225;1226
1215|1203;1204;1205;1214;1216;1225;1226;1227
1216|1204;1205;1206;1215;1217;1226;1227;1228
1217|1205;1206;1207;1216;1218;1227;1228
1218|1206;1207;1208;1217;1219;1228
1219|1207;1208;1209;1218;1220;1231
1220|1208;1209;1210;1219;1221;1231;1232
1221|1209;1210;1211;1220;1222;1231;1232;1233
1222|1210;1211;1221;1223;1232;1233;1234
1223|1211;1222;1233;1234
1224|1213;1214;1225;1235;1236;152,2;157,2
1225|1213;1214;1215;1224;1226;1235;1236;1237
1226|1214;1215;1216;1225;1227;1236;1237;1238
1227|1215;1216;1217;1226;1228;1237;1238;1239
1228|1216;1217;1218;1227;1238;1239;1240
1231|1219;1220;1221;1232;1241;1242;1243
1232|1220;1221;1222;1231;1233;1242;1243;1244
1233|1221;1222;1223;1232;1234;1243;1244;1245
1234|869;1222;1223;1233;1244;1245
1235|1224;1225;1236;1246;1247;152,2;157,2;162,2
1236|1224;1225;1226;1235;1237;1246;1247;1248
1237|1225;1226;1227;1236;1238;1247;1248;1249
1238|1226;1227;1228;1237;1239;1248;1249;1250
1239|1227;1228;1238;1240;1249;1250;1251
1240|1228;1239;1241;1250;1251;1252
1241|1231;1240;1242;1251;1252;1253
1242|1231;1232;1241;1243;1252;1253;1254
1243|1231;1232;1233;1242;1244;1253;1254;1255
1244|1232;1233;1234;1243;1245;1254;1255;1256
1245|869;873;1233;1234;1244;1255;1256
1246|1235;1236;1247;1257;1258;157,2;162,2;2898,2
1247|1235;1236;1237;1246;1248;1257;1258;1259
1248|1236;1237;1238;1247;1249;1258;1259;1260
1249|1237;1238;1239;1248;1250;1259;1260;1261
1250|1238;1239;1240;1249;1251;1260;1261;1262
1251|1239;1240;1241;1250;1252;1261;1262;1263
1252|1240;1241;1242;1251;1253;1262;1263;1264
1253|1241;1242;1243;1252;1254;1263;1264;1265
1254|1242;1243;1244;1253;1255;1264;1265;1266
1255|1243;1244;1245;1254;1256;1265;1266;1267
1256|869;873;877;1244;1245;1255;1266;1267
1257|1246;1247;1258;1268;1269;162,2;2897,2;2898,2
1258|1246;1247;1248;1257;1259;1268;1269;1270
1259|1247;1248;1249;1258;1260;1269;1270;1271
1260|1248;1249;1250;1259;1261;1270;1271;1272
1261|1249;1250;1251;1260;1262;1271;1272;1273
1262|1250;1251;1252;1261;1263;1272;1273;1274
1263|1251;1252;1253;1262;1264;1273;1274;1275
1264|1252;1253;1254;1263;1265;1274;1275;1276
1265|1253;1254;1255;1264;1266;1275;1276;1277
1266|1254;1255;1256;1265;1267;1276;1277;1278
1267|873;877;881;1255;1256;1266;1277;1278
1268|1257;1258;1269;1279;1280;2897,2;2898,2
1269|1257;1258;1259;1268;1270;1279;1280;1281
1270|1258;1259;1260;1269;1271;1280;1281;1282
1271|1259;1260;1261;1270;1272;1281;1282;1283
1272|1260;1261;1262;1271;1273;1282;1283;1284
1273|1261;1262;1263;1272;1274;1283;1284;1285
1274|1262;1263;1264;1273;1275;1284;1285;1286
1275|1263;1264;1265;1274;1276;1285;1286;1287
1276|1264;1265;1266;1275;1277;1286;1287;1288
1277|1265;1266;1267;1276;1278;1287;1288;1289
1278|877;881;885;1266;1267;1277;1288;1289
1279|1268;1269;1280;1290;1291;2897,2
1280|1268;1269;1270;1279;1281;1290;1291;1292
1281|1269;1270;1271;1280;1282;1291;1292
1282|1270;1271;1272;1281;1283;1294
1283|1271;1272;1273;1282;1284;1294;1295
1284|1272;1273;1274;1283;1285;1294;1295;1296
1285|1273;1274;1275;1284;1286;1295;1296;1297
1286|1274;1275;1276;1285;1287;1296;1297;1298
1287|1275;1276;1277;1286;1288;1297;1298;1299
1288|1276;1277;1278;1287;1289;1298;1299;1300
1289|881;885;889;1277;1278;1288;1299;1300
1290|1279;1280;1291;1301;1302;2414,2;2423,2;2432,2
1291|1279;1280;1281;1290;1292;1301;1302;1303
1292|1280;1281;1291;1302;1303;1304
1294|1282;1283;1284;1295;1304;1305;1306
1295|1283;1284;1285;1294;1296;1305;1306;1307
1296|1284;1285;1286;1295;1297;1306;1307;1308
1297|1285;1286;1287;1296;1298;1307;1308;1309
1298|1286;1287;1288;1297;1299;1308;1309;1310
1299|1287;1288;1289;1298;1300;1309;1310;1311
1300|885;889;893;1288;1289;1299;1310;1311
1301|1290;1291;1302;1312;1313;2423,2;2432,2;2441,2
1302|1290;1291;1292;1301;1303;1312;1313;1314
1303|1291;1292;1302;1304;1313;1314;1315
1304|1292;1294;1303;1305;1314;1315;1316
1305|1294;1295;1304;1306;1315;1316;1317
1306|1294;1295;1296;1305;1307;1316;1317;1318
1307|1295;1296;1297;1306;1308;1317;1318;1319
1308|1296;1297;1298;1307;1309;1318;1319;1320
1309|1297;1298;1299;1308;1310;1319;1320;1321
1310|1298;1299;1300;1309;1311;1320;1321;1322
1311|889;893;897;1299;1300;1310;1321;1322
1312|1301;1302;1313
1313|1301;1302;1303;1312;1314
1314|1302;1303;1304;1313;1315
1315|1303;1304;1305;1314;1316
1316|1304;1305;1306;1315;1317
1317|1305;1306;1307;1316;1318
1318|1306;1307;1308;1317;1319
1319|1307;1308;1309;1318;1320;2179;2180;2820
1320|1308;1309;1310;1319;1321;2179;2180;2181
1321|1309;1310;1311;1320;1322;2180;2181;2182
1322|893;897;901;1310;1311;1321;2181;2182
1323|1324;1334;1335;3602;3603;3604
1324|1323;1325;1334;1335;1336
1325|1324;1326;1335;1336;1337
1326|1325;1327;1336;1337;1338
1327|1326;1328;1337;1338;1339
1328|1327;1329;1338;1339;1340
1329|1328;1330;1339;1340;1341
1330|1329;1331;1340;1341;1342
1331|1330;1332;1341;1342;1343
1332|1331;1333;1342;1343;1344
1333|1332;1343;1344
1334|1323;1324;1335;1345;1346;3603;3604;3605;3606
1335|1323;1324;1325;1334;1336;1345;1346;1347
1336|1324;1325;1326;1335;1337;1346;1347;1348
1337|1325;1326;1327;1336;1338;1347;1348;1349
1338|1326;1327;1328;1337;1339;1348;1349;1350
1339|1327;1328;1329;1338;1340;1349;1350;1351
1340|1328;1329;1330;1339;1341;1350;1351;1352
1341|1329;1330;1331;1340;1342;1351;1352;1353
1342|1330;1331;1332;1341;1343;1352;1353;1354
1343|1331;1332;1333;1342;1344;1353;1354;1355
1344|1332;1333;1343;1354;1355
1345|1334;1335;1346;1356;1357;1442,2;3605;3606;3607
1346|1334;1335;1336;1345;1347;1356;1357;1358
1347|1335;1336;1337;1346;1348;1357;1358;1359
1348|1336;1337;1338;1347;1349;1358;1359;1360
1349|1337;1338;1339;1348;1350;1359;1360;1361
1350|1338;1339;1340;1349;1351;1360;1361;1362
1351|1339;1340;1341;1350;1352;1361;1362;1363
1352|1340;1341;1342;1351;1353;1362;1363;1364
1353|1341;1342;1343;1352;1354;1363;1364;1365
1354|1342;1343;1344;1353;1355;1364;1365;1366
1355|1343;1344;1354;1365;1366
1356|1345;1346;1357;1367;1368;1450,2;3606;3607;3608;3609
1357|1345;1346;1347;1356;1358;1367;1368;1369
1358|1346;1347;1348;1357;1359;1368;1369;1370
1359|1347;1348;1349;1358;1360;1369;1370;1371
1360|1348;1349;1350;1359;1361;1370;1371;1372
1361|1349;1350;1351;1360;1362;1371;1372;1373
1362|1350;1351;1352;1361;1363;1372;1373;1374
1363|1351;1352;1353;1362;1364;1373;1374;1375
1364|1352;1353;1354;1363;1365;1374;1375;1376
1365|1353;1354;1355;1364;1366;1375;1376;1377
1366|1354;1355;1365;1376;1377
1367|1356;1357;1368;1378;1379;1450,2;1458,2;3607;3608;3609;3610
1368|1356;1357;1358;1367;1369;1378;1379;1380
1369|1357;1358;1359;1368;1370;1379;1380;1381
1370|1358;1359;1360;1369;1371;1380;1381;1382
1371|1359;1360;1361;1370;1372;1381;1382;1383
1372|1360;1361;1362;1371;1373;1382;1383;1384
1373|1361;1362;1363;1372;1374;1383;1384;1385
1374|1362;1363;1364;1373;1375;1384;1385;1386
1375|1363;1364;1365;1374;1376;1385;1386;1387
1376|1364;1365;1366;1375;1377;1386;1387;1388
1377|1365;1366;1376;1387;1388
1378|1367;1368;1379;1389;1390;1458,2;1466,2;3609;3610;3611;3612
1379|1367;1368;1369;1378;1380;1389;1390;1391
1380|1368;1369;1370;1379;1381;1390;1391;1392
1381|1369;1370;1371;1380;1382;1391;1392;1393
1382|1370;1371;1372;1381;1383;1392;1393;1394
1383|1371;1372;1373;1382;1384;1393;1394;1395
1384|1372;1373;1374;1383;1385;1394;1395;1396
1385|1373;1374;1375;1384;1386;1395;1396;1397
1386|1374;1375;1376;1385;1387;1396;1397;1398
1387|1375;1376;1377;1386;1388;1397;1398;1399
1388|1376;1377;1387;1398;1399
1389|1378;1379;1390;1400;1401;1466,2;1474,2;3610;3611;3612;3613
1390|1378;1379;1380;1389;1391;1400;1401;1402;3546
1391|1379;1380;1381;1390;1392;1401;1402;1403;3545;3546
1392|1380;1381;1382;1391;1393;1402;1403;1404;3544;3545;3546
1393|1381;1382;1383;1392;1394;1403;1404;1405;3542;3543;3544;3545;3546
1394|1382;1383;1384;1393;1395;1404;1405;1406;3541;3542;3543;3544
1395|1383;1384;1385;1394;1396;1405;1406;1407;3540;3541;3542;3543
1396|1384;1385;1386;1395;1397;1406;1407;1408;3539;3540;3541;3542
1397|1385;1386;1387;1396;1398;1407;1408;1409;3537;3538;3539
1398|1386;1387;1388;1397;1399;1408;1409;1410;3536;3537
1399|1387;1388;1398;1409;1410
1400|1389;1390;1401;2152;2153;2158;3528;3529;3530;3612;3613
1401|1389;1390;1391;1400;1402;2152;2153;3528;3529;3530;3531
1402|1390;1391;1392;1401;1403;2153;3526;3531;3532;3558
1403|1391;1392;1393;1402;1404;3519;3556;3557;3558
1404|1392;1393;1394;1403;1405;3555;3556;3557
1405|1393;1394;1395;1404;1406;3554;3555;3556
1406|1394;1395;1396;1405;1407;3553;3554;3555
1407|1395;1396;1397;1406;1408;3553;3554
1408|1396;1397;1398;1407;1409;3551;3553
1409|1397;1398;1399;1408;1410;3552;3561
1410|1398;1399;1409;3549;3550;3560
1411|1412;1419;1420
1412|1411;1413;1419;1420;1421
1413|1412;1414;1420;1421;1422
1414|1413;1415;1421;1422;1423
1415|1414;1416;1422;1423;1424
1416|1415;1417;1423;1424;1425
1417|1416;1418;1424;1425;1426
1418|1323;1417;1425;1426
1419|1411;1412;1420;1427;1428
1420|1411;1412;1413;1419;1421;1427;1428;1429
1421|1412;1413;1414;1420;1422;1428;1429;1430
1422|1413;1414;1415;1421;1423;1429;1430;1431
1423|1414;1415;1416;1422;1424;1430;1431;1432
1424|1415;1416;1417;1423;1425;1431;1432;1433
1425|1416;1417;1418;1424;1426;1432;1433;1434
1426|1323;1334;1417;1418;1425;1433;1434
1427|1419;1420;1428;1435
1428|1419;1420;1421;1427;1429;1435;1437
1429|1420;1421;1422;1428;1430;1437;1438
1430|1421;1422;1423;1429;1431;1437;1438;1439
1431|1422;1423;1424;1430;1432;1438;1439
1432|1423;1424;1425;1431;1433;1439
1433|1424;1425;1426;1432;1434;1442
1434|1323;1334;1345;1425;1426;1433;1442
1435|1427;1428;1443;1444
1437|1428;1429;1430;1438;1444;1445;3601
1438|1429;1430;1431;1437;1439;1445;3601
1439|1430;1431;1432;1438;1448;3601
1442|1334;1345;1356;1433;1434;1449;1450
1443|1435;1444;1451;1452
1444|1435;1437;1443;1445;1451;1452;1453
1445|1437;1438;1444;1452;1453;3601
1448|1439;1449;1456;1457;3601
1449|1442;1448;1450;1456;1457;1458
1450|1345;1356;1367;1442;1449;1457;1458
1451|1443;1444;1452;1459;1460
1452|1443;1444;1445;1451;1453;1459;1460;1461
1453|1444;1445;1452;1460;1461;1462;3601
1456|1448;1449;1457;1463;1464;1465;3601
1457|1448;1449;1450;1456;1458;1464;1465;1466
1458|1356;1367;1378;1449;1450;1457;1465;1466
1459|1451;1452;1460;1467;1468
1460|1451;1452;1453;1459;1461;1467;1468;1469
1461|1452;1453;1460;1462;1468;1469;1470;3601
1462|1453;1461;1463;1469;1470;1471;3601
1463|1456;1462;1464;1470;1471;1472;3601
1464|1456;1457;1463;1465;1471;1472;1473;3601
1465|1456;1457;1458;1464;1466;1472;1473;1474
1466|1367;1378;1389;1457;1458;1465;1473;1474
1467|1459;1460;1468;1475;1476
1468|1459;1460;1461;1467;1469;1475;1476;1477
1469|1460;1461;1462;1468;1470;1476;1477;1478
1470|1461;1462;1463;1469;1471;1477;1478;1479
1471|1462;1463;1464;1470;1472;1478;1479;1480
1472|1463;1464;1465;1471;1473;1479;1480;1481
1473|1464;1465;1466;1472;1474;1480;1481;1482
1474|1378;1389;1400;1465;1466;1473;1481;1482
1475|1467;1468;1476;3467;3626;3627
1476|1467;1468;1469;1475;1477;2103;3467
1477|1468;1469;1470;1476;1478;2103;2105;2106;3463;3467
1478|1469;1470;1471;1477;1479;2103;2105;2106;2107;3463;3467
1479|1470;1471;1472;1478;1480;2103;2105;2106;2107;2148;2149;3463;3467
1480|1471;1472;1473;1479;1481;2106;2148;2149;2153;2158;3463
1481|1472;1473;1474;1480;1482;2107;2152;2153;2154;2156;2158
1482|1389;1400;1473;1474;1481;2107;2153;2154;2155;2156;2158;2159
1483|1484;1486;1487
1484|400;1483;1485;1486;1487;1488
1485|400;401;412;1484;1487;1488
1486|1483;1484;1487;1489;1490
1487|1483;1484;1485;1486;1488;1489;1490;1491
1488|400;412;424;1484;1485;1487;1490;1491
1489|1486;1487;1490;1492;1493
1490|1486;1487;1488;1489;1491;1492;1493;1494
1491|412;424;436;1487;1488;1490;1493;1494
1492|1489;1490;1493;1495;1496
1493|1489;1490;1491;1492;1494;1495;1496;1497
1494|424;436;448;1490;1491;1493;1496;1497
1495|1492;1493;1496;1498;1499
1496|1492;1493;1494;1495;1497;1498;1499;1500
1497|436;448;460;1493;1494;1496;1499;1500
1498|1495;1496;1499;1501;1502
1499|1495;1496;1497;1498;1500;1501;1502;1503
1500|448;460;472;1496;1497;1499;1502;1503
1501|1498;1499;1502;1504;1505
1502|1498;1499;1500;1501;1503;1504;1505;1506
1503|460;472;484;1499;1500;1502;1505;1506
1504|1501;1502;1505;1507;1508
1505|1501;1502;1503;1504;1506;1507;1508;1509
1506|472;484;496;1502;1503;1505;1508;1509
1507|1504;1505;1508;1510;1511
1508|1504;1505;1506;1507;1509;1510;1511;1512
1509|484;496;1505;1506;1508;1511;1512
1510|1507;1508;1511;1513;1514
1511|1507;1508;1509;1510;1512;1513;1514;1515
1512|496;520;1508;1509;1511;1514;1515
1513|1510;1511;1514
1514|520;1510;1511;1512;1513;1515;3162
1515|520;532;1511;1512;1514;3162
1517|1518;1526;1527;1528
1518|1517;1519;1527;1528;1529
1519|1518;1520;1528;1529;1530
1520|1519;1521;1529;1530;1531;3188;3189
1521|1520;1522;1530;1531;1532;3188;3189
1522|1521;1523;1531;1532;1533
1523|1522;1532;1533;1534
1526|1517;1527;1536;1537
1527|1517;1518;1526;1528;1536;1537;1538
1528|1517;1518;1519;1527;1529;1537;1538;1539
1529|1518;1519;1520;1528;1530;1538;1539;1540
1530|1519;1520;1521;1529;1531;1539;1540;1541
1531|1520;1521;1522;1530;1532;1540;1541;1542
1532|1521;1522;1523;1531;1533;1541;1542;1543
1533|1522;1523;1532;1534;1542;1543;1544
1534|1523;1533;1543;1544;1545
1536|1526;1527;1537;1546;1547
1537|1526;1527;1528;1536;1538;1546;1547;1548
1538|1527;1528;1529;1537;1539;1547;1548;1549
1539|1528;1529;1530;1538;1540;1548;1549;1550
1540|1529;1530;1531;1539;1541;1549;1550;1551
1541|1530;1531;1532;1540;1542;1550;1551;1552
1542|1531;1532;1533;1541;1543;1551;1552;1553
1543|1532;1533;1534;1542;1544;1552;1553;1554
1544|1533;1534;1543;1545;1553;1554;1555
1545|1534;1544;1554;1555
1546|1536;1537;1547;1556;1557
1547|1536;1537;1538;1546;1548;1556;1557;1558
1548|1537;1538;1539;1547;1549;1557;1558;1559
1549|1538;1539;1540;1548;1550;1558;1559;1560
1550|1539;1540;1541;1549;1551;1559;1560;1561
1551|1540;1541;1542;1550;1552;1560;1561;1562
1552|1541;1542;1543;1551;1553;1561;1562;1563
1553|1542;1543;1544;1552;1554;1562;1563;1564
1554|1543;1544;1545;1553;1555;1563;1564;1565
1555|1544;1545;1554;1564;1565
1556|410;411;423;1546;1547;1557;3190
1557|411;1546;1547;1548;1556;1558;3190
1558|1547;1548;1549;1557;1559
1559|1548;1549;1550;1558;1560
1560|1549;1550;1551;1559;1561
1561|1550;1551;1552;1560;1562
1562|1551;1552;1553;1561;1563
1563|1552;1553;1554;1562;1564
1564|1553;1554;1555;1563;1565
1565|1554;1555;1564
1566|1567;1569;1570
1567|1566;1568;1569;1570;1571
1568|1567;1570;1571
1569|1566;1567;1570;1573;3140
1570|1566;1567;1568;1569;1571;1573;1574
1571|1567;1568;1570;1573;1574
1573|1569;1570;1571;1574;1576;1577;3140
1574|1570;1571;1573;1576;1577
1576|1573;1574;1577;1580;3140;3141;3144,1
1577|1573;1574;1576;1580
1580|1576;1577;1583;3141
1583|1580;1585;1586;3139;3141;3146,1
1585|1583;1586;1587;1588;1589;3138;3139
1586|410;1583;1585;1588;1589
1587|407;408;409;1585;1588;3138
1588|408;409;410;1585;1586;1587;1589
1589|409;410;411;1585;1586;1588
1590|1591;1592;1593
1591|1566;1590;1592;1593
1592|1590;1591;1593;1594;1595
1593|1569;1590;1591;1592;1594;1595
1594|1592;1593;1595;1596;1597
1595|1592;1593;1594;1596;1597
1596|1594;1595;1597;1598;1599
1597|1594;1595;1596;1598;1599;3145
1598|1596;1597;1599;1600;1601
1599|1596;1597;1598;1600;1601;3144
1600|1598;1599;1601;1602;1603;1614
1601|1598;1599;1600;1602;1603;3143
1602|1600;1601;1603;1604;1605;1613;1614;1623;3142
1603|1600;1601;1602;1604;1605;1614
1604|406;407;1602;1603;1605;1614;1622;1623
1605|407;408;1587;1602;1603;1604;1623
1606|1607;1615;1616;3152;3153
1607|1606;1608;1615;1616;1617;3152;3153
1608|1607;1609;1616;1617;1618;3147;3149;3152;3153
1609|1608;1610;1617;1618;1619;3147;3149;3150;3153
1610|1609;1611;1618;1619;1620
1611|1610;1612;1619;1620;1621
1612|1611;1613;1620;1621;1622
1613|1602;1612;1614;1621;1622;1623
1614|1600;1602;1603;1604;1613;1622;1623
1615|1483;1484;1606;1607;1616
1616|1484;1485;1606;1607;1608;1615;1617
1617|400;1485;1607;1608;1609;1616;1618
1618|400;401;1608;1609;1610;1617;1619
1619|401;402;1609;1610;1611;1618;1620
1620|402;403;1610;1611;1612;1619;1621
1621|403;404;1611;1612;1613;1620;1622
1622|404;405;1604;1612;1613;1614;1621;1623
1623|405;406;1602;1604;1605;1613;1614;1622
1624|1625;1628;1629
1625|1624;1626;1628;1629;1630
1626|1625;1627;1629;1630;1631
1627|1626;1630;1631;1636,1;1641
1628|1624;1625;1629;1632;1633
1629|1624;1625;1626;1628;1630;1632;1633;1634
1630|1625;1626;1627;1629;1631;1633;1634;1635
1631|1626;1627;1630;1634;1635;1636;1641,1;1646
1632|1628;1629;1633;3154;3155;3158
1633|1628;1629;1630;1632;1634;3158
1634|1629;1630;1631;1633;1635;3150;3158;3159
1635|1630;1631;1634;1641;1646,1;1651;3159
1636|1627;1631;1637;1641
1637|1636;1638;1641
1638|1637;1639;1644
1639|1638;1640;1644;1645
1640|1590;1592;1639;1644;1645
1641|1627;1631;1635;1636;1637;1646
1644|1638;1639;1640;1645;1649;1650
1645|1592;1594;1639;1640;1644;1649;1650
1646|1631;1635;1641;1651;1652;3160
1649|1644;1645;1650;1655
1650|1594;1596;1644;1645;1649;1655
1651|1635;1646;1652;1656;1657;3160;3161
1652|1646;1651;1656;1657;1658
1655|1596;1598;1649;1650;1659;1660
1656|1651;1652;1657;1661;1662;3160;3161
1657|1651;1652;1656;1658;1661;1662;1663
1658|1652;1657;1659;1662;1663;1664
1659|1655;1658;1660;1663;1664;1665
1660|1598;1600;1655;1659;1664;1665
1661|1610;1611;1656;1657;1662;3161
1662|1611;1612;1656;1657;1658;1661;1663
1663|1612;1613;1657;1658;1659;1662;1664
1664|1613;1614;1658;1659;1660;1663;1665
1665|1600;1602;1614;1659;1660;1664
1667|1668;1671
1668|1667;1669
1669|1668;1675
1671|1667;1676
1675|1669;1680
1676|1671;1681;1682
1680|1675;1684;1685
1681|1676;1682;1686;1687
1682|1676;1681;1683;1686;1687;1688
1683|1682;1684;1687;1688;1689
1684|1680;1683;1685;1688;1689;1690
1685|1680;1684;1689;1690
1686|1681;1682;1687;1691;1692
1687|1681;1682;1683;1686;1688;1691;1692;1693
1688|1682;1683;1684;1687;1689;1692;1693;1694
1689|1683;1684;1685;1688;1690;1693;1694;1695
1690|1684;1685;1689;1694;1695
1691|1686;1687;1692;3188
1692|1686;1687;1688;1691;1693;3188;3189
1693|1687;1688;1689;1692;1694;3188;3189
1694|1688;1689;1690;1693;1695;3189
1695|1689;1690;1694;3189
1696|1697;1703;1704
1697|1696;1698;1703;1704;1705
1698|1697;1699;1704;1705;1706
1699|1698;1700;1705;1706;1707
1700|1699;1701;1706;1707;1708
1701|1700;1702;1707;1708;1709
1702|1701;1708;1709
1703|1696;1697;1704;1710;1711
1704|1696;1697;1698;1703;1705;1710;1711;1712
1705|1697;1698;1699;1704;1706;1711;1712;1713
1706|1698;1699;1700;1705;1707;1712;1713;1714
1707|1699;1700;1701;1706;1708;1713;1714;1715
1708|1700;1701;1702;1707;1709;1714;1715;1716
1709|1701;1702;1708;1715;1716;2993
1710|1703;1704;1711;1717;1718
1711|1703;1704;1705;1710;1712;1717;1718;1719
1712|1704;1705;1706;1711;1713;1718;1719;1720
1713|1705;1706;1707;1712;1714;1719;1720;1721
1714|1706;1707;1708;1713;1715;1720;1721;1722
1715|1707;1708;1709;1714;1716;1721;1722;1723
1716|1708;1709;1715;1722;1723;2993;2994
1717|1710;1711;1718;1724;1725
1718|1710;1711;1712;1717;1719;1724;1725;1726
1719|1711;1712;1713;1718;1720;1725;1726;1727
1720|1712;1713;1714;1719;1721;1726;1727;1728
1721|1713;1714;1715;1720;1722;1727;1728;1729
1722|1714;1715;1716;1721;1723;1728;1729;1730
1723|1715;1716;1722;1729;1730;2993;2994;2995
1724|1717;1718;1725;1731;1732
1725|1717;1718;1719;1724;1726;1731;1732;1733
1726|1718;1719;1720;1725;1727;1732;1733;1734
1727|1719;1720;1721;1726;1728;1733;1734;1735
1728|1720;1721;1722;1727;1729;1734;1735;1736
1729|1721;1722;1723;1728;1730;1735;1736;1737
1730|1722;1723;1729;1736;1737;2994;2995;2996
1731|1724;1725;1732;1738;1739
1732|1724;1725;1726;1731;1733;1738;1739;1740
1733|1725;1726;1727;1732;1734;1739;1740;1741
1734|1726;1727;1728;1733;1735;1740;1741;1742
1735|1727;1728;1729;1734;1736;1741;1742;1743
1736|1728;1729;1730;1735;1737;1742;1743;1744
1737|1729;1730;1736;1743;1744;2995;2996;2997
1738|1731;1732;1739;1745;1746
1739|1731;1732;1733;1738;1740;1745;1746;1747
1740|1732;1733;1734;1739;1741;1746;1747;1748
1741|1733;1734;1735;1740;1742;1747;1748;1749
1742|1734;1735;1736;1741;1743;1748;1749;1750
1743|1735;1736;1737;1742;1744;1749;1750;1751
1744|1736;1737;1743;1750;1751;2996;2997;2998
1745|1738;1739;1746;1752;1753
1746|1738;1739;1740;1745;1747;1752;1753;1754
1747|1739;1740;1741;1746;1748;1753;1754;1755
1748|1740;1741;1742;1747;1749;1754;1755;1756
1749|1741;1742;1743;1748;1750;1755;1756;1757
1750|1742;1743;1744;1749;1751;1756;1757;1758
1751|1743;1744;1750;1757;1758;2997;2998;2999
1752|1745;1746;1753;1759;1760
1753|1745;1746;1747;1752;1754;1759;1760;1761
1754|1746;1747;1748;1753;1755;1760;1761;1762
1755|1747;1748;1749;1754;1756;1761;1762;1763
1756|1748;1749;1750;1755;1757;1762;1763;1764
1757|1749;1750;1751;1756;1758;1763;1764;1765
1758|1750;1751;1757;1764;1765;2998;2999;3000
1759|1752;1753;1760
1760|1752;1753;1754;1759;1761
1761|1753;1754;1755;1760;1762
1762|1754;1755;1756;1761;1763;3076
1763|1755;1756;1757;1762;1764;3075;3076
1764|1756;1757;1758;1763;1765;3075
1765|1757;1758;1764;2999;3000
1766|1767;1771;1772
1767|1766;1768;1771;1772;1773
1768|1767;1769;1772;1773;1774
1769|1768;1770;1773;1774;1775
1770|1769;1774;1775;2992
1771|1766;1767;1772;1776;1777
1772|1766;1767;1768;1771;1773;1776;1777;1778
1773|1767;1768;1769;1772;1774;1777;1778;1779
1774|1768;1769;1770;1773;1775;1778;1779;1780
1775|1769;1770;1774;1779;1780;2991;2992
1776|1771;1772;1777;1781;1782
1777|1771;1772;1773;1776;1778;1781;1782;1783
1778|1772;1773;1774;1777;1779;1782;1783;1784
1779|1773;1774;1775;1778;1780;1783;1784;1785
1780|1774;1775;1779;1784;1785;2991;2992
1781|1776;1777;1782;1786;1787;2990
1782|1776;1777;1778;1781;1783;1786;1787;1788
1783|1777;1778;1779;1782;1784;1787;1788;1789
1784|1778;1779;1780;1783;1785;1788;1789;1790
1785|1779;1780;1784;1789;1790;2991;2992
1786|1781;1782;1787
1787|1781;1782;1783;1786;1788;1792;1793
1788|1782;1783;1784;1787;1789;1792;1793;1794
1789|1783;1784;1785;1788;1790;1793;1794;1795
1790|1784;1785;1789;1794;1795;2991;2992
1792|1787;1788;1793;1797;1798
1793|1787;1788;1789;1792;1794;1797;1798;1799
1794|1788;1789;1790;1793;1795;1798;1799;1800
1795|1789;1790;1794;1799;1800;2991
1797|1792;1793;1798;1801;1802;1803
1798|1792;1793;1794;1797;1799;1802;1803;1804
1799|1793;1794;1795;1798;1800;1803;1804;1805
1800|1794;1795;1799;1804;1805;2916
1801|1797;1802;1806;1807;2993;2994
1802|1797;1798;1801;1803;1806;1807;1808
1803|1797;1798;1799;1802;1804;1807;1808;1809
1804|1798;1799;1800;1803;1805;1808;1809;1810
1805|1799;1800;1804;1809;1810;2915;2916
1806|1801;1802;1807;1811;1812;2993;2994;2995
1807|1801;1802;1803;1806;1808;1811;1812;1813
1808|1802;1803;1804;1807;1809;1812;1813;1814
1809|1803;1804;1805;1808;1810;1813;1814;1815
1810|1804;1805;1809;1814;1815;2910;2915;2916
1811|1806;1807;1812;1816;1817;2994;2995;2996
1812|1806;1807;1808;1811;1813;1816;1817;1818
1813|1807;1808;1809;1812;1814;1817;1818;1819
1814|1808;1809;1810;1813;1815;1818;1819;1820
1815|1809;1810;1814;1819;1820;2910;2915
1816|1811;1812;1817;1821;1822;2995;2996;2997
1817|1811;1812;1813;1816;1818;1821;1822;1823
1818|1812;1813;1814;1817;1819;1822;1823;1824
1819|1813;1814;1815;1818;1820;1823;1824;1825
1820|1814;1815;1819;1824;1825;3012;3018
1821|1816;1817;1822;1826;1827;2996;2997;2998
1822|1816;1817;1818;1821;1823;1826;1827;1828
1823|1817;1818;1819;1822;1824;1827;1828;1829
1824|1818;1819;1820;1823;1825;1828;1829;1830
1825|1819;1820;1824;1829;1830;3012;3018
1826|1821;1822;1827;2997;2998;2999;3003;3006
1827|1821;1822;1823;1826;1828;3006;3007
1828|1822;1823;1824;1827;1829;3007;3008
1829|1823;1824;1825;1828;1830;3008;3009
1830|1824;1825;1829;2985;3009;3010;3012
1831|1832;1838;1839;3207
1832|1831;1833;1838;1839;1840;3206;3207
1833|1832;1839;1840;1841;3206;3232,2;3288,1
1838|1831;1832;1839;1845;1846;3207
1839|1831;1832;1833;1838;1840;1845;1846;1847;3206;3207
1840|1832;1833;1839;1841;1846;1847;1848;3206
1841|1833;1840;1842;1847;1848;1849
1842|1841;1843;1848;1849;1850
1843|1842;1844;1849;1850;1851
1844|1843;1850;1851
1845|1838;1839;1846;1852;1853;3204
1846|1838;1839;1840;1845;1847;1852;1853;1854
1847|1839;1840;1841;1846;1848;1853;1854;1855
1848|1840;1841;1842;1847;1849;1854;1855;1856
1849|1841;1842;1843;1848;1850;1855;1856;1857
1850|1842;1843;1844;1849;1851;1856;1857;1858
1851|1843;1844;1850;1857;1858
1852|1845;1846;1853;1859;1860;3201;3204
1853|1845;1846;1847;1852;1854;1859;1860;1861
1854|1846;1847;1848;1853;1855;1860;1861;1862
1855|1847;1848;1849;1854;1856;1861;1862;1863
1856|1848;1849;1850;1855;1857;1862;1863;1864
1857|1849;1850;1851;1856;1858;1863;1864;1865
1858|1850;1851;1857;1864;1865
1859|1852;1853;1860;1866;1867;3201;3204
1860|1852;1853;1854;1859;1861;1866;1867;1868
1861|1853;1854;1855;1860;1862;1867;1868;1869
1862|1854;1855;1856;1861;1863;1868;1869;1870
1863|1855;1856;1857;1862;1864;1869;1870;1871
1864|1856;1857;1858;1863;1865;1870;1871;1872
1865|1857;1858;1864;1871;1872
1866|1859;1860;1867;1873;1874;3201
1867|1859;1860;1861;1866;1868;1873;1874;1875
1868|1860;1861;1862;1867;1869;1874;1875;1876
1869|1861;1862;1863;1868;1870;1875;1876;1877
1870|1862;1863;1864;1869;1871;1876;1877;1878
1871|1863;1864;1865;1870;1872;1877;1878;1879
1872|1864;1865;1871;1878;1879
1873|1866;1867;1874;1880;1881
1874|1866;1867;1868;1873;1875;1880;1881;1882
1875|1867;1868;1869;1874;1876;1881;1882;1883
1876|1868;1869;1870;1875;1877;1882;1883;1884
1877|1869;1870;1871;1876;1878;1883;1884;1885
1878|1870;1871;1872;1877;1879;1884;1885;1886
1879|1871;1872;1878;1885;1886
1880|1873;1874;1881;1887;1888
1881|1873;1874;1875;1880;1882;1887;1888;1889
1882|1874;1875;1876;1881;1883;1888;1889;1890
1883|1875;1876;1877;1882;1884;1889;1890;1891
1884|1876;1877;1878;1883;1885;1890;1891;1892
1885|1877;1878;1879;1884;1886;1891;1892;1893
1886|1878;1879;1885;1892;1893
1887|1880;1881;1888;1894;1895
1888|1880;1881;1882;1887;1889;1894;1895;1896
1889|1881;1882;1883;1888;1890;1895;1896;1897
1890|1882;1883;1884;1889;1891;1896;1897;1898
1891|1883;1884;1885;1890;1892;1897;1898;1899
1892|1884;1885;1886;1891;1893;1898;1899;1900
1893|1885;1886;1892;1899;1900;3238;3247
1894|1887;1888;1895
1895|1887;1888;1889;1894;1896
1896|1888;1889;1890;1895;1897
1897|1889;1890;1891;1896;1898
1898|1890;1891;1892;1897;1899
1899|1891;1892;1893;1898;1900;3236
1900|1892;1893;1899;3236;3237;3238
1906|1907;1911;1912
1907|1906;1908;1911;1912;1913
1908|1907;1909;1912;1913;1914
1909|1908;1910;1913;1914;1915
1910|1909;1914;1915
1911|1906;1907;1912;1916;1917
1912|1906;1907;1908;1911;1913;1916;1917;1918
1913|1907;1908;1909;1912;1914;1917;1918;1919
1914|1908;1909;1910;1913;1915;1918;1919;1920
1915|1909;1910;1914;1919;1920;1952
1916|1911;1912;1917;1921;1922
1917|1911;1912;1913;1916;1918;1921;1922;1923
1918|1912;1913;1914;1917;1919;1922;1923;1924
1919|1913;1914;1915;1918;1920;1923;1924;1925
1920|1914;1915;1919;1924;1925
1921|1916;1917;1922;1926;1927
1922|1916;1917;1918;1921;1923;1926;1927;1928
1923|1917;1918;1919;1922;1924;1927;1928;1929
1924|1918;1919;1920;1923;1925;1928;1929;1930
1925|1919;1920;1924;1929;1930
1926|1921;1922;1927;1931;1932
1927|1921;1922;1923;1926;1928;1931;1932;1933
1928|1922;1923;1924;1927;1929;1932;1933;1934
1929|1923;1924;1925;1928;1930;1933;1934;1935
1930|1924;1925;1929;1934;1935
1931|1926;1927;1932
1932|1926;1927;1928;1931;1933;3248;3249
1933|1927;1928;1929;1932;1934;3248;3249
1934|1928;1929;1930;1933;1935;3248;3249
1935|1929;1930;1934
1936|1937;1940
1937|1936;1938
1938|1937;1939;1943
1939|1938;1943
1940|1936;1944;1945
1943|1938;1939;1946;1947
1944|1940;1945;1948;1949
1945|1940;1944;1946;1948;1949;1950
1946|1943;1945;1947;1949;1950;1951
1947|1943;1946;1950;1951
1948|1944;1945;1949;1952;1953
1949|1944;1945;1946;1948;1950;1952;1953;1954
1950|1945;1946;1947;1949;1951;1953;1954;1955
1951|1946;1947;1950;1954;1955
1952|1915;1948;1949;1953;1956;1957
1953|1948;1949;1950;1952;1954;1956;1957;1958
1954|1949;1950;1951;1953;1955;1957;1958;1959
1955|1950;1951;1954;1958;1959;1982;1984
1956|1952;1953;1957;1961;3285;3300
1957|1952;1953;1954;1956;1958;1961;1962
1958|1953;1954;1955;1957;1959;1961;1962;1963
1959|1954;1955;1958;1962;1963;1982;1984;1986
1961|1956;1957;1958;1962;1965;1966;3285;3300
1962|1957;1958;1959;1961;1963;1965;1966;1967
1963|1958;1959;1962;1966;1967;1984;1986;1988
1965|1961;1962;1966;1969;1970;3285;3286;3299
1966|1961;1962;1963;1965;1967;1969;1970;1971
1967|1962;1963;1966;1970;1971;1986;1988;1990
1969|1965;1966;1970;1973;1974;3286
1970|1965;1966;1967;1969;1971;1973;1974;1975
1971|1966;1967;1970;1974;1975;1988;1990;1992
1973|1969;1970;1974;1977;1978;3286
1974|1969;1970;1971;1973;1975;1977;1978;1979
1975|1970;1971;1974;1978;1979;1990;1992;1994
1977|1973;1974;1978;3252;3255
1978|1973;1974;1975;1977;1979;2343;2344
1979|1974;1975;1978;1994;1996;2343;2344
1980|1981;1982
1981|1980;1982
1982|1980;1981;1984;1985
1984|1982;1985;1986;1987
1985|1982;1984;1986;1987
1986|1984;1985;1987;1988;1989
1987|1984;1985;1986;1988;1989
1988|1986;1987;1989;1990;1991
1989|1986;1987;1988;1990;1991
1990|1988;1989;1991;1992;1993
1991|1988;1989;1990;1992;1993
1992|1990;1991;1993;1994;1995
1993|1990;1991;1992;1994;1995;3461
1994|1992;1993;1995;1996;1997
1995|1992;1993;1994;1996;1997;2842;3461
1996|1994;1995;1997;2347;2348;2804
1997|1994;1995;1996;2804;2842
1998|1843;1850;1999;2005;2006
1999|1998;2005;2006
2005|1843;1850;1857;1998;1999;2006;2012;2013
2006|1998;1999;2005;2012;2013
2010|2011;2017;2018
2011|1952;1956;2010;2017;2018
2012|1850;1857;1864;2005;2006;2013;2019;2020
2013|2005;2006;2012;2019;2020
2017|2010;2011;2018;2023;2024;3287
2018|1956;1961;2010;2011;2017;2024;3287
2019|1857;1864;1871;2012;2013;2020;2026;2027
2020|2012;2013;2019;2021;2026;2027;2028
2021|2020;2022;2027;2028;2029;3291,2
2022|2021;2023;2028;2029;2030;3290,2
2023|2017;2022;2024;2029;2030;2031;3289,2
2024|2017;2018;2023;2030;2031;3287
2026|1864;1871;1878;2019;2020;2027;2033;2034
2027|2019;2020;2021;2026;2028;2033;2034;2035
2028|2020;2021;2022;2027;2029;2034;2035;2036
2029|2021;2022;2023;2028;2030;2035;2036;2037
2030|2022;2023;2024;2029;2031;2036;2037;2038
2031|2023;2024;2030;2037;2038;2039;3287
2033|1871;1878;1885;2026;2027;2034;2040;2041
2034|2026;2027;2028;2033;2035;2040;2041;2042
2035|2027;2028;2029;2034;2036;2041;2042;2043
2036|2028;2029;2030;2035;2037;2042;2043;2044
2037|2029;2030;2031;2036;2038;2043;2044;2045
2038|2030;2031;2037;2039;2044;2045;2046;3287
2039|1969;1973;2031;2038;2045;2046;3287
2040|1878;1885;2033;2034;2041
2041|2033;2034;2035;2040;2042
2042|2034;2035;2036;2041;2043
2043|2035;2036;2037;2042;2044
2044|2036;2037;2038;2043;2045
2045|2037;2038;2039;2044;2046
2046|1973;1977;2038;2039;2045
2047|2048;2051;2052
2048|2047;2049;2051;2052;2053;2105
2049|2048;2050;2052;2053;2054;2105;2106
2050|2049;2053;2054;2105;2106;2107
2051|2047;2048;2052;2055;2056
2052|2047;2048;2049;2051;2053;2055;2056;2057;3630
2053|2048;2049;2050;2052;2054;2056;2057
2054|2049;2050;2053;2057
2055|2051;2052;2056;2059;2060
2056|2051;2052;2053;2055;2057;2059;2060;2061
2057|2052;2053;2054;2056;2060;2061;2062
2059|2055;2056;2060;2063;2064;3462;3463
2060|2055;2056;2057;2059;2061;2063;2064;2065
2061|2056;2057;2060;2062;2064;2065;2066
2062|2057;2061;2065;2066
2063|2059;2060;2064;2067;2068
2064|2059;2060;2061;2063;2065;2067;2068;2069
2065|2060;2061;2062;2064;2066;2068;2069;2070
2066|2061;2062;2065;2069;2070
2067|2063;2064;2068;2071;2072
2068|2063;2064;2065;2067;2069;2071;2072;2073
2069|2064;2065;2066;2068;2070;2072;2073;2074
2070|2065;2066;2069;2073;2074
2071|2067;2068;2072
2072|2067;2068;2069;2071;2073
2073|2068;2069;2070;2072;2074
2074|2069;2070;2073
2075|2076;2078;2079
2076|2075;2077;2078;2079;2080
2077|2076;2079;2080
2078|2075;2076;2079;2081;2082
2079|2075;2076;2077;2078;2080;2081;2082;3460
2080|2076;2077;2079;2082;2120;3460
2081|2078;2079;2082;2084;2085
2082|2078;2079;2080;2081;2084;2085;3460
2084|2081;2082;2085;2087;2088
2085|2081;2082;2084;2087;2088;3460
2087|2084;2085;2088;2090;2091
2088|2084;2085;2087;2090;2091;3460
2090|2087;2088;2091;2093;2094
2091|2087;2088;2090;2093;2094
2093|2090;2091;2094;2096;2097
2094|2090;2091;2093;2096;2097;3464
2096|2093;2094;2097;2099;2100
2097|2093;2094;2096;2099;2100;3464
2099|2096;2097;2100;2103;3467
2100|2096;2097;2099;2103;3463;3464;3467
2103|2099;2100;2105;2106;2107;3463;3467
2105|2048;2049;2050;2103;2106;3467
2106|2049;2050;2103;2105;2107;3463;3467
2107|2050;2103;2106;3463
2120|2080;2121;3460
2121|2120;2122
2122|2121;2123
2123|2122;2124
2124|2123;2125
2125|2124;2126
2126|2125;2127
2127|2126;2128
2128|2127;2129
2129|2128;2130
2130|2129;2131
2131|2130
2144|2145;2148;2149
2145|2144;2146;2148;2149;2150
2146|2145;2147;2149;2150;2151
2147|2146;2150;2151
2148|2144;2145;2149;2152;2153;3463;3464;3465;3466
2149|2144;2145;2146;2148;2150;2152;2153;2154
2150|2145;2146;2147;2149;2151;2153;2154;2155
2151|2146;2147;2150;2154;2155
2152|2107;2148;2149;2153;2156;2157;3463
2153|2148;2149;2150;2152;2154;2156;2157;2158
2154|2149;2150;2151;2153;2155;2157;2158;2159
2155|2150;2151;2154;2158;2159
2156|2050;2100;2152;2153;2157
2157|2152;2153;2154;2156;2158;3465;3466
2158|2153;2154;2155;2157;2159;3465;3466
2159|2154;2155;2158;3465;3466
2168|2169;2170;2171;2172;3599;3600;3617,2;3618,2
2169|2168;2171;2172;3599;3600
2170|2168;2171;2173;2174;3618,2;3619,2
2171|2168;2169;2170;2172;2173;2174;2175;3618,2
2172|2168;2169;2171;2174;2175
2173|2170;2171;2174;2176;2177;3615;3618,2;3619,2
2174|2170;2171;2172;2173;2175;2176;2177;2178
2175|2171;2172;2174;2177;2178
2176|806;807;2173;2174;2177;3615;3619,2
2177|807;808;2173;2174;2175;2176;2178
2178|808;809;2174;2175;2177
2179|1319;1320;2180;2183;2184;2819;2820
2180|1319;1320;1321;2179;2181;2183;2184;2185
2181|1320;1321;1322;2180;2182;2184;2185;2186
2182|897;901;905;1321;1322;2181;2185;2186
2183|2179;2180;2184;2187;2188;2818;2819
2184|2179;2180;2181;2183;2185;2187;2188;2189
2185|2180;2181;2182;2184;2186;2188;2189;2190
2186|901;905;909;2181;2182;2185;2189;2190
2187|2183;2184;2188;2191;2192;2362;2818;2819
2188|2183;2184;2185;2187;2189;2191;2192;2193
2189|2184;2185;2186;2188;2190;2192;2193;2194
2190|905;909;913;2185;2186;2189;2193;2194
2191|2187;2188;2192;2195;2196;2362;2364
2192|2187;2188;2189;2191;2193;2195;2196;2197
2193|2188;2189;2190;2192;2194;2196;2197;2198
2194|909;913;917;2189;2190;2193;2197;2198
2195|2191;2192;2196;2199;2200;2362;2364;2366
2196|2191;2192;2193;2195;2197;2199;2200;2201
2197|2192;2193;2194;2196;2198;2200;2201;2202
2198|913;917;921;2193;2194;2197;2201;2202
2199|2195;2196;2200;2364;2366
2200|2195;2196;2197;2199;2201;2367,2;2368,2
2201|2196;2197;2198;2200;2202;2368,2;2369,2
2202|917;921;2197;2198;2201
2203|2204;2210;2211;2358;2808
2204|2203;2205;2210;2211;2212;2358;2359;2808
2205|2204;2206;2211;2212;2213;2355;2358;2359;2360
2206|2205;2207;2212;2213;2214;2358;2359;2360
2207|2206;2208;2213;2214;2215;2357;2359;2360;2796
2208|2207;2214;2215;2360;2846
2210|2203;2204;2211;2217;2218
2211|2203;2204;2205;2210;2212;2217;2218;2219
2212|2204;2205;2206;2211;2213;2218;2219;2220
2213|2205;2206;2207;2212;2214;2219;2220;2221
2214|2206;2207;2208;2213;2215;2220;2221;2222
2215|2207;2208;2214;2221;2222;2846
2217|2210;2211
2218|2210;2211;2212;2219;2224;2225;2226
2219|2211;2212;2213;2218;2220;2225;2226;2227
2220|2212;2213;2214;2219;2221;2226;2227;2228
2221|2213;2214;2215;2220;2222;2227;2228;2229
2222|2214;2215;2221;2228;2229
2224|2218;2225;2231;2232;2812
2225|2218;2219;2224;2226;2231;2232;2233
2226|2218;2219;2220;2225;2227;2232;2233;2234
2227|2219;2220;2221;2226;2228;2233;2234;2235
2228|2220;2221;2222;2227;2229;2234;2235;2236
2229|2221;2222;2228;2235;2236
2231|2224;2225;2232;2238;2239;2812;2814
2232|2224;2225;2226;2231;2233;2238;2239;2240
2233|2225;2226;2227;2232;2234;2239;2240;2241
2234|2226;2227;2228;2233;2235;2240;2241;2242
2235|2227;2228;2229;2234;2236;2241;2242;2243
2236|2228;2229;2235;2242;2243
2238|872;2231;2232;2239;2245;2246;2809;2812
2239|2231;2232;2233;2238;2240;2245;2246;2247
2240|2232;2233;2234;2239;2241;2246;2247;2248
2241|2233;2234;2235;2240;2242;2247;2248;2249
2242|2234;2235;2236;2241;2243;2248;2249;2250
2243|2235;2236;2242;2249;2250
2245|872;876;2238;2239;2246;2252;2253;2809
2246|2238;2239;2240;2245;2247;2252;2253;2254
2247|2239;2240;2241;2246;2248;2253;2254;2255
2248|2240;2241;2242;2247;2249;2254;2255;2256
2249|2241;2242;2243;2248;2250;2255;2256;2257
2250|2242;2243;2249;2256;2257
2252|872;876;2245;2246;2253;2259;2260
2253|2245;2246;2247;2252;2254;2259;2260;2261
2254|2246;2247;2248;2253;2255;2260;2261;2262
2255|2247;2248;2249;2254;2256;2261;2262;2263
2256|2248;2249;2250;2255;2257;2262;2263;2264
2257|2249;2250;2256;2263;2264
2259|2252;2253;2260;2267
2260|2252;2253;2254;2259;2261;2267;2268
2261|2253;2254;2255;2260;2262;2267;2268;2269
2262|2254;2255;2256;2261;2263;2268;2269;2270
2263|2255;2256;2257;2262;2264;2269;2270;2271
2264|2256;2257;2263;2270;2271
2267|2259;2260;2261;2268;2274;2275
2268|2260;2261;2262;2267;2269;2274;2275;2276
2269|2261;2262;2263;2268;2270;2275;2276;2277
2270|2262;2263;2264;2269;2271;2276;2277;2278
2271|2263;2264;2270;2277;2278
2273|892;2274;2280;2848
2274|2267;2268;2273;2275;2280;2282;2848
2275|2267;2268;2269;2274;2276;2282;2283
2276|2268;2269;2270;2275;2277;2282;2283;2284
2277|2269;2270;2271;2276;2278;2283;2284;2285
2278|2270;2271;2277;2284;2285
2280|892;896;2273;2274;2287;2848;2849
2282|2274;2275;2276;2283;2289;2290;2847
2283|2275;2276;2277;2282;2284;2289;2290;2291
2284|2276;2277;2278;2283;2285;2290;2291;2292
2285|2277;2278;2284;2291;2292
2287|892;896;900;2280;2294;2295;2848;2849
2289|2282;2283;2290;2295;2296;2297;2847
2290|2282;2283;2284;2289;2291;2296;2297;2298
2291|2283;2284;2285;2290;2292;2297;2298;2299
2292|2284;2285;2291;2298;2299
2294|896;900;2287;2295;2302;2849
2295|2287;2289;2294;2296;2302;2303;2849
2296|2289;2290;2295;2297;2302;2303;2304
2297|2289;2290;2291;2296;2298;2303;2304;2305
2298|2290;2291;2292;2297;2299;2304;2305;2306
2299|2291;2292;2298;2305;2306
2302|2294;2295;2296;2303;2309;2310
2303|2295;2296;2297;2302;2304;2309;2310;2311
2304|2296;2297;2298;2303;2305;2310;2311;2312
2305|2297;2298;2299;2304;2306;2311;2312;2313
2306|2298;2299;2305;2312;2313
2309|2302;2303;2310;2315;2316;2317
2310|2302;2303;2304;2309;2311;2316;2317;2318
2311|2303;2304;2305;2310;2312;2317;2318;2319
2312|2304;2305;2306;2311;2313;2318;2319;2320
2313|2305;2306;2312;2319;2320;2321
2315|2309;2316;2322;2323
2316|2309;2310;2315;2317;2322;2323;2324
2317|2309;2310;2311;2316;2318;2323;2324;2325
2318|2310;2311;2312;2317;2319;2324;2325;2326
2319|2311;2312;2313;2318;2320;2325;2326
2320|2312;2313;2319;2321;2326
2321|2313;2320;2730,4;2731,4
2322|2315;2316;2323;2329;2330
2323|2315;2316;2317;2322;2324;2329;2330;2331
2324|2316;2317;2318;2323;2325;2330;2331;2332
2325|2317;2318;2319;2324;2326;2331;2332;2333
2326|2318;2319;2320;2325;2332;2333;2729,1
2329|2322;2323;2330;2336;2337
2330|2322;2323;2324;2329;2331;2336;2337;2338
2331|2323;2324;2325;2330;2332;2337;2338;2339
2332|2324;2325;2326;2331;2333;2338;2339;2340
2333|2325;2326;2332;2339;2340;2729,1
2336|2329;2330;2337
2337|2329;2330;2331;2336;2338
2338|2330;2331;2332;2337;2339;2795
2339|2331;2332;2333;2338;2340
2340|2332;2333;2339
2343|2344;2346;2347
2344|2343;2346;2347;2348
2346|2343;2344;2347;2349;2350
2347|2343;2344;2346;2348;2349;2350;2351
2348|2344;2347;2350;2351
2349|2346;2347;2350;2352;2353;2805
2350|2346;2347;2348;2349;2351;2352;2353;2354
2351|2347;2348;2350;2353;2354
2352|2349;2350;2353;2355;2356;2805
2353|2349;2350;2351;2352;2354;2355;2356;2357
2354|2350;2351;2353;2356;2357;2851
2355|2205;2352;2353;2356;2358;2359;2805;2807;2808
2356|2352;2353;2354;2355;2357;2358;2359;2360
2357|2207;2353;2354;2356;2359;2360;2796;2851
2358|2203;2204;2205;2206;2355;2356;2359;2807;2808
2359|2204;2205;2206;2207;2355;2356;2357;2358;2360
2360|2205;2206;2207;2208;2356;2357;2359;2796;2850;2851
2361|283;288;2362;2363;2364
2362|2187;2191;2195;2361;2363;2364
2363|283;288;293;2361;2362;2364;2365;2366
2364|2191;2195;2199;2361;2362;2363;2365;2366
2365|283;288;293;298;2363;2364;2366
2366|2195;2199;2363;2364;2365
2367|2199;2200;2368;2374;2375;2856,1
2368|2200;2201;2367;2369;2374;2375;2376
2369|2201;2202;2368;2370;2375;2376;2377
2370|921;2202;2369;2371;2376;2377;2378
2371|921;922;2370;2372;2375;2377;2378;2379;2382;2854
2372|922;923;2371;2373;2378;2379;2380
2373|923;924;2372;2379;2380
2374|2367;2368;2375;2381;2382;2856,1
2375|2367;2368;2369;2371;2374;2376;2381;2382;2383
2376|2368;2369;2370;2375;2377;2382;2383;2384
2377|2369;2370;2371;2376;2378;2383;2384;2385
2378|2370;2371;2372;2377;2379;2384;2385;2386
2379|2371;2372;2373;2378;2380;2385;2386
2380|2372;2373;2379;2386
2381|2374;2375;2382;2856,1;2870;642,2;643,2
2382|2371;2374;2375;2376;2381;2383;2855
2383|2375;2376;2377;2382;2384;2871;644,2;645,2
2384|2376;2377;2378;2383;2385
2385|2377;2378;2379;2384;2386
2386|2378;2379;2380;2385
2388|2389;2397;2398
2389|2388;2390;2397;2398;2399
2390|2389;2391;2398;2399;2400
2391|2390;2392;2399;2400;2401
2392|158;2391;2393;2400;2401;2402;2975
2393|153;158;159;2392;2394;2401;2402;2403;2975
2394|158;159;160;2393;2395;2402;2403;2404
2395|159;160;161;2394;2396;2403;2404;2405
2396|160;161;162;2395;2404;2405;2897;2898
2397|2388;2389;2398;2406;2407
2398|2388;2389;2390;2397;2399;2406;2407;2408
2399|2389;2390;2391;2398;2400;2407;2408;2409
2400|2390;2391;2392;2399;2401;2408;2409;2410
2401|2391;2392;2393;2400;2402;2409;2410;2411
2402|2392;2393;2394;2401;2403;2410;2411;2412
2403|2393;2394;2395;2402;2404;2411;2412;2413
2404|2394;2395;2396;2403;2405;2412;2413;2414
2405|161;2395;2396;2404;2413;2414;2897;2898
2406|2397;2398;2407;2415;2416
2407|2397;2398;2399;2406;2408;2415;2416;2417
2408|2398;2399;2400;2407;2409;2416;2417;2418
2409|2399;2400;2401;2408;2410;2417;2418;2419
2410|2400;2401;2402;2409;2411;2418;2419;2420
2411|2401;2402;2403;2410;2412;2419;2420;2421
2412|2402;2403;2404;2411;2413;2420;2421;2422
2413|2403;2404;2405;2412;2414;2421;2422;2423
2414|2404;2405;2413;2422;2423;2897
2415|2406;2407;2416;2424;2425
2416|2406;2407;2408;2415;2417;2424;2425;2426
2417|2407;2408;2409;2416;2418;2425;2426;2427
2418|2408;2409;2410;2417;2419;2426;2427;2428
2419|2409;2410;2411;2418;2420;2427;2428;2429
2420|2410;2411;2412;2419;2421;2428;2429;2430
2421|2411;2412;2413;2420;2422;2429;2430;2431
2422|2412;2413;2414;2421;2423;2430;2431;2432
2423|2413;2414;2422;2431;2432;2897
2424|2415;2416;2425;2433;2434
2425|2415;2416;2417;2424;2426;2433;2434;2435
2426|2416;2417;2418;2425;2427;2434;2435;2436
2427|2417;2418;2419;2426;2428;2435;2436;2437
2428|2418;2419;2420;2427;2429;2436;2437;2438
2429|2419;2420;2421;2428;2430;2437;2438;2439
2430|2420;2421;2422;2429;2431;2438;2439;2440
2431|2421;2422;2423;2430;2432;2439;2440;2441
2432|2422;2423;2431;2440;2441;2897
2433|2424;2425;2434;2442;2443
2434|2424;2425;2426;2433;2435;2442;2443;2444
2435|2425;2426;2427;2434;2436;2443;2444;2445
2436|2426;2427;2428;2435;2437;2444;2445;2446
2437|2427;2428;2429;2436;2438;2445;2446;2447
2438|2428;2429;2430;2437;2439;2446;2447;2448
2439|2429;2430;2431;2438;2440;2447;2448;2449
2440|2430;2431;2432;2439;2441;2448;2449;2450
2441|2431;2432;2440;2449;2450
2442|2433;2434;2443;2451;2452
2443|2433;2434;2435;2442;2444;2451;2452;2453
2444|2434;2435;2436;2443;2445;2452;2453;2454
2445|2435;2436;2437;2444;2446;2453;2454;2455
2446|2436;2437;2438;2445;2447;2454;2455;2456
2447|2437;2438;2439;2446;2448;2455;2456;2457
2448|2438;2439;2440;2447;2449;2456;2457;2458
2449|2439;2440;2441;2448;2450;2457;2458;2459
2450|2440;2441;2449;2458;2459;2837;2839
2451|2442;2443;2452;2460;2461
2452|2442;2443;2444;2451;2453;2460;2461;2462
2453|2443;2444;2445;2452;2454;2461;2462;2463
2454|2444;2445;2446;2453;2455;2462;2463;2464
2455|2445;2446;2447;2454;2456;2463;2464;2465
2456|2446;2447;2448;2455;2457;2464;2465;2466
2457|2447;2448;2449;2456;2458;2465;2466;2467
2458|2448;2449;2450;2457;2459;2466;2467;2468
2459|2449;2450;2458;2467;2468;2836;2837;2839
2460|103;2451;2452;2461
2461|103;104;2451;2452;2453;2460;2462
2462|103;104;105;2452;2453;2454;2461;2463
2463|104;105;106;2453;2454;2455;2462;2464
2464|105;106;107;2454;2455;2456;2463;2465
2465|106;107;108;2455;2456;2457;2464;2466
2466|107;108;109;2456;2457;2458;2465;2467
2467|108;109;110;2457;2458;2459;2466;2468
2468|109;110;2458;2459;2467;2836;2837
2470|2329;2330;2331;2471;2475;2476;2477
2471|2329;2330;2331;2332;2470;2476;2477;2478
2473|2331;2332;2333;2474;2479;2480
2474|2332;2333;2473;2479;2480;2734
2475|923;2372;2373;2379;2470;2476;2481;2482
2476|2470;2471;2475;2477;2481;2482;2483
2477|2470;2471;2476;2478;2482;2483;2484
2478|2471;2477;2479;2483;2484;2485
2479|2473;2474;2478;2480;2484;2485;2486
2480|2473;2474;2479;2485;2486;2734;2740
2481|2372;2373;2379;2475;2476;2482;2487;2488
2482|2475;2476;2477;2481;2483;2487;2488;2489
2483|2476;2477;2478;2482;2484;2488;2489;2490
2484|2477;2478;2479;2483;2485;2489;2490;2491
2485|2478;2479;2480;2484;2486;2490;2491
2486|2479;2480;2485;2491;2733;2740
2487|648;658;2379;2385;2481;2482;2488;3632;3636
2488|2481;2482;2483;2487;2489;3632;3634;3635;3636;3658
2489|2482;2483;2484;2488;2490;3632;3634;3635;3636
2490|2483;2484;2485;2489;2491;3634
2491|2484;2485;2486;2490;3634
2493|2494;2502;2503
2494|2493;2495;2502;2503;2504
2495|2494;2496;2503;2504;2505
2496|2495;2497;2504;2505;2506
2497|2496;2498;2505;2506;2507
2498|2497;2499;2506;2507;2508
2499|2498;2500;2507;2508;2509
2500|2499;2501;2508;2509;2510
2501|2500;2509;2510
2502|2493;2494;2503;2511;2512
2503|2493;2494;2495;2502;2504;2511;2512;2513
2504|2494;2495;2496;2503;2505;2512;2513;2514
2505|2495;2496;2497;2504;2506;2513;2514;2515
2506|2496;2497;2498;2505;2507;2514;2515;2516
2507|2497;2498;2499;2506;2508;2515;2516;2517
2508|2498;2499;2500;2507;2509;2516;2517;2518
2509|2499;2500;2501;2508;2510;2517;2518;2519
2510|2500;2501;2509;2518;2519
2511|2502;2503;2512;2520;2521
2512|2502;2503;2504;2511;2513;2520;2521;2522
2513|2503;2504;2505;2512;2514;2521;2522;2523
2514|2504;2505;2506;2513;2515;2522;2523;2524
2515|2505;2506;2507;2514;2516;2523;2524;2525
2516|2506;2507;2508;2515;2517;2524;2525;2526
2517|2507;2508;2509;2516;2518;2525;2526;2527
2518|2508;2509;2510;2517;2519;2526;2527;2528
2519|2509;2510;2518;2527;2528
2520|2511;2512;2521;2529;2530
2521|2511;2512;2513;2520;2522;2529;2530;2531
2522|2512;2513;2514;2521;2523;2530;2531;2532
2523|2513;2514;2515;2522;2524;2531;2532;2533
2524|2514;2515;2516;2523;2525;2532;2533;2534
2525|2515;2516;2517;2524;2526;2533;2534;2535
2526|2516;2517;2518;2525;2527;2534;2535;2536
2527|2517;2518;2519;2526;2528;2535;2536;2537
2528|2518;2519;2527;2536;2537;3292,1
2529|2520;2521;2530;2538;2539
2530|2520;2521;2522;2529;2531;2538;2539;2540
2531|2521;2522;2523;2530;2532;2539;2540;2541
2532|2522;2523;2524;2531;2533;2540;2541;2542
2533|2523;2524;2525;2532;2534;2541;2542;2543
2534|2524;2525;2526;2533;2535;2542;2543;2544
2535|2525;2526;2527;2534;2536;2543;2544;2545
2536|2526;2527;2528;2535;2537;2544;2545;2546
2537|2527;2528;2536;2545;2546;3292,1
2538|2529;2530;2539;2547;2548
2539|2529;2530;2531;2538;2540;2547;2548;2549
2540|2530;2531;2532;2539;2541;2548;2549;2550
2541|2531;2532;2533;2540;2542;2549;2550;2551
2542|2532;2533;2534;2541;2543;2550;2551;2552
2543|2533;2534;2535;2542;2544;2551;2552;2553
2544|2534;2535;2536;2543;2545;2552;2553;2554
2545|2535;2536;2537;2544;2546;2553;2554;2555
2546|151;152;2536;2537;2545;2554;2555
2547|2538;2539;2548
2548|2538;2539;2540;2547;2549
2549|2539;2540;2541;2548;2550
2550|2540;2541;2542;2549;2551
2551|148;153;2541;2542;2543;2550;2552;2972,1
2552|148;149;153;2542;2543;2544;2551;2553
2553|148;149;153;2543;2544;2545;2552;2554
2554|149;2544;2545;2546;2553;2555
2555|151;152;157;2545;2546;2554
2556|2557;2564;2565;3077;3085
2557|2556;2558;2564;2565;2566;3075;3077
2558|2557;2559;2565;2566;2567;3075;3076;3077
2559|2558;2560;2566;2567;2568;3002;3075;3076
2560|2559;2561;2567;2568;2569;3002;3075
2561|2560;2562;2568;2569;2570;3005
2562|2561;2563;2569;2570;2571;3005;3024
2563|2562;2570;2571;3005;3024
2564|2556;2557;2565;2572;2573;3085
2565|2556;2557;2558;2564;2566;2572;2573;2574
2566|2557;2558;2559;2565;2567;2573;2574;2575
2567|2558;2559;2560;2566;2568;2574;2575;2576
2568|2559;2560;2561;2567;2569;2575;2576;2577
2569|2560;2561;2562;2568;2570;2576;2577;2578
2570|2561;2562;2563;2569;2571;2577;2578;2579
2571|2562;2563;2570;2578;2579
2572|2564;2565;2573;2580;2581;3085;3086
2573|2564;2565;2566;2572;2574;2580;2581;2582
2574|2565;2566;2567;2573;2575;2581;2582;2583
2575|2566;2567;2568;2574;2576;2582;2583;2584
2576|2567;2568;2569;2575;2577;2583;2584;2585
2577|2568;2569;2570;2576;2578;2584;2585;2586
2578|2569;2570;2571;2577;2579;2585;2586;2587
2579|2570;2571;2578;2586;2587
2580|2572;2573;2581;2588;2589;3086;3087
2581|2572;2573;2574;2580;2582;2588;2589;2590
2582|2573;2574;2575;2581;2583;2589;2590;2591
2583|2574;2575;2576;2582;2584;2590;2591;2592
2584|2575;2576;2577;2583;2585;2591;2592;2593
2585|2576;2577;2578;2584;2586;2592;2593;2594
2586|2577;2578;2579;2585;2587;2593;2594;2595
2587|2578;2579;2586;2594;2595
2588|2580;2581;2589;2596;2597;3086;3087
2589|2580;2581;2582;2588;2590;2596;2597;2598
2590|2581;2582;2583;2589;2591;2597;2598;2599
2591|2582;2583;2584;2590;2592;2598;2599;2600
2592|2583;2584;2585;2591;2593;2599;2600;2601
2593|2584;2585;2586;2592;2594;2600;2601;2602
2594|2585;2586;2587;2593;2595;2601;2602;2603
2595|2586;2587;2594;2602;2603
2596|2588;2589;2597;2604;2605;3087
2597|2588;2589;2590;2596;2598;2604;2605;2606
2598|2589;2590;2591;2597;2599;2605;2606;2607
2599|2590;2591;2592;2598;2600;2606;2607;2608
2600|2591;2592;2593;2599;2601;2607;2608;2609
2601|2592;2593;2594;2600;2602;2608;2609;2610
2602|2593;2594;2595;2601;2603;2609;2610;2611
2603|2594;2595;2602;2610;2611
2604|2596;2597;2605;2612;2613;3088
2605|2596;2597;2598;2604;2606;2612;2613;2614
2606|2597;2598;2599;2605;2607;2613;2614;2615
2607|2598;2599;2600;2606;2608;2614;2615;2616
2608|2599;2600;2601;2607;2609;2615;2616;2617
2609|2600;2601;2602;2608;2610;2616;2617;2618
2610|2601;2602;2603;2609;2611;2617;2618;2619
2611|2602;2603;2610;2618;2619
2612|2604;2605;2613;3088;3089
2613|2604;2605;2606;2612;2614
2614|2605;2606;2607;2613;2615
2615|2606;2607;2608;2614;2616
2616|2607;2608;2609;2615;2617
2617|2608;2609;2610;2616;2618
2618|2609;2610;2611;2617;2619
2619|2610;2611;2618
2620|2621;2635;2636
2621|2620;2622;2635;2636;2637
2622|2621;2623;2636;2637;2638
2623|2622;2624;2637;2638;2639
2624|2623;2625;2638;2639;2640
2625|2624;2626;2639;2640;2641
2626|2625;2627;2640;2641;2642
2627|2626;2628;2641;2642;2643
2628|2627;2629;2642;2643;2644;3237,1
2629|2628;2630;2643;2644;2645;3239,1
2630|2629;2631;2644;2645;2646;3239,1;3241,1
2631|2630;2632;2645;2646;2647;3241,1;3243,1
2632|2631;2633;2646;2647;2648;3243,1;3245,1
2633|2632;2647;2648;2649;3238,1;3245,1
2635|2620;2621;2636;2650;2651
2636|2620;2621;2622;2635;2637;2650;2651;2652
2637|2621;2622;2623;2636;2638;2651;2652;2653
2638|2622;2623;2624;2637;2639;2652;2653;2654
2639|2623;2624;2625;2638;2640;2653;2654;2655
2640|2624;2625;2626;2639;2641;2654;2655;2656
2641|2625;2626;2627;2640;2642;2655;2656;2657
2642|2626;2627;2628;2641;2643;2656;2657;2658
2643|2627;2628;2629;2642;2644;2657;2658;2659
2644|2628;2629;2630;2643;2645;2658;2659;2660
2645|2629;2630;2631;2644;2646;2659;2660;2661
2646|2630;2631;2632;2645;2647;2660;2661;2662
2647|2631;2632;2633;2646;2648;2661;2662;2663
2648|2632;2633;2647;2649;2662;2663;2664
2649|2633;2648;2663;2664;2806;2807
2650|2635;2636;2651;2665;2666
2651|2635;2636;2637;2650;2652;2665;2666;2667
2652|2636;2637;2638;2651;2653;2666;2667;2668
2653|2637;2638;2639;2652;2654;2667;2668;2669
2654|2638;2639;2640;2653;2655;2668;2669;2670
2655|2639;2640;2641;2654;2656;2669;2670;2671
2656|2640;2641;2642;2655;2657;2670;2671;2672
2657|2641;2642;2643;2656;2658;2671;2672;2673
2658|2642;2643;2644;2657;2659;2672;2673;2674
2659|2643;2644;2645;2658;2660;2673;2674;2675
2660|2644;2645;2646;2659;2661;2674;2675;2676
2661|2645;2646;2647;2660;2662;2675;2676;2677
2662|2646;2647;2648;2661;2663;2676;2677;2678
2663|2647;2648;2649;2662;2664;2677;2678;2679
2664|2648;2649;2663;2678;2679;2806;2807;2808
2665|2650;2651;2666;2680;2681
2666|2650;2651;2652;2665;2667;2680;2681;2682
2667|2651;2652;2653;2666;2668;2681;2682;2683
2668|2652;2653;2654;2667;2669;2682;2683;2684
2669|2653;2654;2655;2668;2670;2683;2684;2685
2670|2654;2655;2656;2669;2671;2684;2685;2686
2671|2655;2656;2657;2670;2672;2685;2686;2687
2672|2656;2657;2658;2671;2673;2686;2687;2688
2673|2657;2658;2659;2672;2674;2687;2688;2689
2674|2658;2659;2660;2673;2675;2688;2689;2690
2675|2659;2660;2661;2674;2676;2689;2690;2691
2676|2660;2661;2662;2675;2677;2690;2691;2692
2677|2661;2662;2663;2676;2678;2691;2692;2693
2678|2662;2663;2664;2677;2679;2692;2693;2694
2679|2663;2664;2678;2693;2694;2807;2808
2680|2665;2666;2681;2695;2696
2681|2665;2666;2667;2680;2682;2695;2696;2697
2682|2666;2667;2668;2681;2683;2696;2697;2698
2683|2667;2668;2669;2682;2684;2697;2698;2699
2684|2668;2669;2670;2683;2685;2698;2699;2700
2685|2669;2670;2671;2684;2686;2699;2700;2701
2686|2670;2671;2672;2685;2687;2700;2701;2702
2687|2671;2672;2673;2686;2688;2701;2702;2703
2688|2672;2673;2674;2687;2689;2702;2703;2704
2689|2673;2674;2675;2688;2690;2703;2704;2705
2690|2674;2675;2676;2689;2691;2704;2705;2706
2691|2675;2676;2677;2690;2692;2705;2706;2707
2692|2676;2677;2678;2691;2693;2706;2707;2708
2693|2677;2678;2679;2692;2694;2707;2708;2709
2694|2678;2679;2693;2708;2709
2695|2680;2681;2696;2710;2711
2696|2680;2681;2682;2695;2697;2710;2711;2712
2697|2681;2682;2683;2696;2698;2711;2712;2713
2698|2682;2683;2684;2697;2699;2712;2713;2714
2699|2683;2684;2685;2698;2700;2713;2714;2715
2700|2684;2685;2686;2699;2701;2714;2715;2716
2701|2685;2686;2687;2700;2702;2715;2716;2717
2702|2686;2687;2688;2701;2703;2716;2717;2718
2703|2687;2688;2689;2702;2704;2717;2718;2719
2704|2688;2689;2690;2703;2705;2718;2719;2720
2705|2689;2690;2691;2704;2706;2719;2720;2721
2706|2690;2691;2692;2705;2707;2720;2721;2722
2707|2691;2692;2693;2706;2708;2721;2722;2723
2708|2692;2693;2694;2707;2709;2722;2723;2724
2709|2693;2694;2708;2723;2724
2710|2695;2696;2711
2711|2695;2696;2697;2710;2712
2712|2696;2697;2698;2711;2713
2713|2697;2698;2699;2712;2714
2714|2698;2699;2700;2713;2715
2715|2699;2700;2701;2714;2716
2716|1208;1209;2700;2701;2702;2715;2717
2717|1208;1209;1210;2701;2702;2703;2716;2718
2718|1209;1210;2702;2703;2704;2717;2719
2719|2703;2704;2705;2718;2720
2720|2704;2705;2706;2719;2721
2721|2705;2706;2707;2720;2722
2722|2706;2707;2708;2721;2723
2723|2707;2708;2709;2722;2724
2724|2708;2709;2723
2725|2804;2840;2843
2726|3071;3072;3073;3074
2727|255;256;263;264
2728|199;207;318,1
2729|2319;2326;2333;2730,1
2730|2321;2729;2731;2734;2736;2738;2739
2731|2321;2730;2738;2739;2793;2794
2732|2733
2733|2732;2734;2735
2734|2729;2730;2733;2735;2739
2735|2729;2733;2734;2736
2736|2730;2735;2737;2739
2737|2736;2738;2739;2792,2
2738|2730;2731;2737;2739;2744
2739|2730;2731;2734;2736;2737;2738
2740|2732;2734;2735
2741|2735;2736;2740;2742
2742|2735;2736;2741
2743|2737;2744;2745;2746
2744|2738;2743;2745;2746
2745|1;8;15;2737;2743;2744;2746;2768
2746|2743;2744;2745;2746;2767;2768
2747|2748;2752
2748|2747;2749;2751;2752
2749|2748;2751
2750|2751;2754;2755
2751|2748;2749;2750;2752;2753;2754;2755
2752|2747;2748;2751;2753;2754
2753|2751;2752;2754;2769;2770
2754|2750;2751;2752;2753;2755
2755|2750;2751;2754;2766
2756|2757;2759
2757|2756;2758
2758|2757;2759;2760;2761
2759|2756;2758;2760;2761
2760|2758;2759;2761;2767
2761|2758;2759;2760;2762;2767
2762|22;2761;2763;2767;2768
2763|22;23;31;38;2762;2764;2766
2764|38;2763;2765;2790;2791
2765|38;39;40;2764;2783;2790;2791
2766|38;2755;2762;2763;2764
2767|2746;2760;2761;2762;2768
2768|8;15;22;2745;2746;2762;2767
2769|2770;2783
2770|2769;2771;2785
2771|2770;2772;2785
2772|2771;2773
2773|2772;2774
2774|2773;2775
2775|2774;2776
2776|4;5;6;2775;2777
2777|4;5;6;2776;2778,2
2778|2;3;4;5;2777;2779;2782
2779|2778;2780;2781;2782
2780|2737;2744;2779;2781;2782
2781|2744;2779,1
2782|8;9;10;11;2778;2779;2780
2783|2765;2769;2784;2789;2791
2784|2783;2785;2789;2791
2785|2770;2771;2784;2786
2786|2785;2787;2789
2787|41;42;2786;2788
2788|40;41;42;2787;2789;2790
2789|2783;2784;2786;2788;2790
2790|38;39;40;41;2764;2765;2788;2789;2791
2791|38;39;2764;2765;2783;2784;2790
2792|2743,1
2793|2320;2321;2333;2731,1
2794|2321;2731,1
2795|2338
2796|2207;2357;2360;2797;2850;3614
2797|2796;2798;2802;2845;2850;3614
2798|2797;2799;2800;2801;2844;2845;2846;3614
2799|2798;2800;2801
2800|2798;2799;2801;2844
2801|2798;2799;2800;2802;2843;2844;2845
2802|2797;2801;2803;2843;2845;3614
2803|2802
2804|1996;1997;2347;2350;2351;2353;2354;2725;2842;2844;2852;2853
2805|2349;2352;2355;2806;2807
2806|2649;2664;2805;2807
2807|2355;2358;2649;2664;2679;2805;2806;2808
2808|2203;2204;2355;2358;2664;2679;2807
2809|872;2238;2245;2810;2812;2813
2810|870;871;872;2809;2811;2812;2813;2817
2811|869;870;871;2810;2813;2817
2812|2224;2231;2238;2809;2810;2813;2814;2815
2813|2809;2810;2811;2812;2814;2815
2814|2231;2812;2813;2815
2815|2812;2813;2814;2816
2816|2815;2817
2817|2810;2811;2816
2818|2183;2187;2191;2361;2819;2821;2822
2819|2179;2183;2187;2818;2820;2821;2822;2823
2820|1318;1319;2179;2819;2822;2823
2821|283;2362;2818;2819;2822;2824;2825
2822|2818;2819;2820;2821;2823;2824;2825;2826
2823|1305;1307;2819;2820;2822;2825;2826
2824|282;283;2362;2821;2822;2825;2827;2828
2825|2821;2822;2823;2824;2826;2827;2828;2829
2826|1305;1306;2822;2823;2825;2828;2829
2827|282;283;2361;2824;2825;2828;2830;2831
2828|2824;2825;2826;2827;2829;2830;2831;2832
2829|1304;1305;2825;2826;2828;2831;2832
2830|281;283;2827;2828;2831;2833;2834
2831|2827;2828;2829;2830;2832;2833;2834;2835
2832|1303;1304;2828;2829;2831;2834;2835
2833|280;281;2830;2831;2834;2836;2837
2834|2830;2831;2832;2833;2835;2836;2837;2839
2835|2831;2832;2834;2837;2838
2836|2459;2468;2833;2834;2837
2837|2450;2459;2468;2833;2834;2835;2836;2839
2838|1302;2835;2839
2839|2450;2459;2834;2837;2838
2840|2725;2841;2842;2843;2844
2841|2840;2842;3461
2842|1995;1997;2804;2840;2841;2843;2844;2845;3461
2843|2725;2801;2802;2840;2842;2844;2845
2844|2798;2800;2801;2804;2840;2842;2843;2853
2845|2797;2798;2801;2802;2842;2843;3614
2846|2208;2215;2798,1
2847|2282;2289;2848;2849
2848|2273;2274;2280;2287;2847;2849
2849|2280;2287;2294;2295;2847;2848
2850|2360;2796;2797
2851|2354;2357;2360
2852|2804;2853
2853|2804;2844;2852
2854|921;922;2371
2855|643;644;653;654;2382
2856|2367;2374;2381
2857|751;752;760;761
2858|753;754;761;2859;2864;2867;2868
2859|761;763;2858;2864;2867;2868
2860|758;2861;2865;2866
2861|757;758;2860;2862;2865;2866;2867
2862|756;757;758;2861;2863;2866;2867;2868
2863|755;756;757;2862;2864;2867;2868
2864|754;755;756;2858;2859;2863;2868
2865|2860;2861;2866
2866|2860;2861;2862;2865;2867
2867|2858;2859;2861;2862;2863;2866;2868;2869,2
2868|2858;2859;2862;2863;2864;2867;2873,2
2869|777;2866;2867;2868
2870|2381
2871|2383
2872|2854,7
2873|777;779;2868
2874|361;362;363;2875;2876
2875|360;361;362;2874;2876
2876|364;365;366;2874;2875;2877
2877|365;366;2876
2878|367;371;2879
2879|371;375;2878;2880
2880|373;375;379;2879
2881|384;2882;2883
2882|380;384;2881
2883|381;382;2881;2884
2884|2883;2885
2885|2884;2886
2886|2885;2887;2889
2887|390;2886;2889;2891
2888|2885
2889|390;2885;2886;2887;2890,2;2891
2890|390;393;396;2885;2889
2891|390;2887;2889
2892|355;356;360
2893|355;356;357
2894|356;357;358
2895|362;363;741;750;751
2896|355;356;357
2897|1257;1268;1279;2396;2405;2414;2423;2432;2898
2898|161;162;1246;1257;1268;2396;2405;2897
2899|165;166;169;197
2900|95;96;100;171;2901
2901|90;169;2900;2902
2902|167;340;345;350;355;360;2899;2901;2903;2904
2903|2902;2904;2906;2911
2904|345;350;355;360;2902;2903;2905
2905|350;355;360;2904;2911
2906|2903;2907;2911;2912
2907|2906;2908;2912;2913
2908|2907;2909;2912;2913;2914
2909|2908;2910;2913;2914;2915
2910|1810;1815;2909;2914;2915;2916;2917
2911|2903;2905;2906;2912
2912|2906;2907;2908;2911;2913
2913|2907;2908;2909;2912;2914;2917
2914|2908;2909;2910;2913;2915;2917
2915|1805;1810;1815;2909;2910;2914;2916;2917
2916|1800;1805;1810;2910;2915;2917
2917|2910;2913;2914;2915;2916;2918
2918|2912;2913;2914;2917;2919
2919|2912;2913;2918;2920,1
2920|2903;2905;2906;2907;2912;2913;2919;2921
2921|2903;2905;2906;2907;2920;2922;2923
2922|2921;2923;2924
2923|354;360;2905;2911;2921;2922
2924|2922;2925;2932;2933
2925|2924;2926;2931;2932;2933
2926|2925;2927;2930;2931;2932
2927|2926;2928;2929;2930;2931
2928|2927;2929;2930
2929|2927;2928;2930;2936;2937
2930|2926;2927;2928;2929;2931;2935;2936;2937
2931|2925;2926;2927;2930;2932;2934;2935;2936
2932|2924;2925;2926;2931;2933;2934;2935
2933|2924;2925;2932;2934
2934|2931;2932;2933;2935;2940;2941
2935|2930;2931;2932;2934;2936;2939;2940;2941
2936|2929;2930;2931;2935;2937;2938;2939;2940
2937|2929;2930;2936;2938;2939
2938|2936;2937;2939;2940;2945;2946
2939|2935;2936;2937;2938;2940;2944;2945;2946
2940|2934;2935;2936;2938;2939;2941;2943;2944;2945
2941|2934;2935;2940;2942;2943;2944
2942|2941;2943;2944;2950
2943|2940;2941;2942;2944;2949;2950
2944|2939;2940;2941;2942;2943;2945;2947;2948;2949;2950
2945|2938;2939;2940;2944;2946;2947;2948;2949
2946|2938;2939;2945;2947;2948
2947|2944;2945;2946;2948
2948|2944;2945;2946;2947;2949
2949|2943;2944;2945;2948;2950
2950|2942;2943;2944;2949
2951|359;360;2952
2952|2951;2953
2953|2952;2954,1
2954|2952;2953;2955;2956
2955|2954;2956;2957;2958
2956|2954;2955;2957;2958
2957|2955;2956;2958
2958|2955;2956;2957
2959|2957;2958;2960;2961;2962
2960|2957;2958;2959;2961;2962
2961|2959;2960;2962
2962|2959;2960;2961
2963|149;154;155
2964|2390;2391;2392;2965;2970;2971
2965|2964;2966;2969;2970;2971;2973;2974
2966|2965;2967;2968;2969;2970;2972;2973
2967|2549;2550;2551;2966;2968;2969;2972
2968|2549;2550;2966;2967;2969
2969|2965;2966;2967;2968;2971
2970|2964;2965;2966;2971
2971|2390;2391;2964;2965;2969;2970
2972|148;153;2551;2552;2966,1;2967,1;2973
2973|2965,1;2966,1;2972;2974;2975
2974|2973;2975
2975|148;153;158;2392;2393;2973,1;2974,1
2976|2899,7
2977|49
2978|146;147;2982
2979|2980;2981
2980|295;300;2979;2981
2981|2979;2980
2982|146;147;290;295;300;305;2978
2983|2984
2984|110;2983
2985|1830;2986;3011;3012
2986|2985;2987,6
2987|2988,5
2988|2989
2989|2988
2990|1781
2991|69;74;75;80;81;86;87;93;1775;1780;1785;1790;1795;2992
2992|63;68;69;74;75;80;81;87;1770;1775;1780;1785;1790;2991
2993|1709;1716;1723;1801;1806;2994
2994|1716;1723;1730;1801;1806;1811;2993;2995
2995|1723;1730;1737;1806;1811;1816;2994;2996
2996|1730;1737;1744;1811;1816;1821;2995;2997
2997|1737;1744;1751;1816;1821;1826;2996;2998
2998|1744;1751;1758;1821;1826;2997;2999
2999|1751;1758;1765;1826;2998;3000;3003
3000|1758;1765;2999;3001;3003;3004
3001|3000;3002;3003;3004;3005
3002|2559,4;2560,4;3001;3004;3005
3003|1826;2999;3000;3001;3004;3006;3031
3004|3000;3001;3002;3003;3005;3032
3005|3001;3002;3004;3022;3024
3006|1826;1827;3003;3007
3007|1827;1828;3006;3008
3008|1828;1829;3007;3009
3009|1829;1830;3008;3010
3010|1830;3009;3011
3011|2985;3010;3019
3012|1820;1825;1830;2985;3013;3018
3013|3012;3014;3018
3014|3013
3015|3016;3019
3016|3015;3017
3017|3016;3018
3018|1820;1825;3012;3013;3017
3019|3011;3015
3020|3019
3021|1820;3013
3022|3005;3023;3024;3025
3023|3022;3024;3025
3024|3005;3022;3023;3025;3026
3025|3022;3023;3024;3026
3026|3024;3025;3027;3028;3029;3030
3027|3026;3028
3028|3026;3027;3029
3029|3026;3028;3030
3030|3026;3029
3031|3003;3006;3007;3008;3032;3033;3034
3032|3002;3004;3005;3031;3033;3034
3033|3002;3005;3031;3032;3034;3035;3036
3034|3007;3008;3009;3031;3032;3033;3035;3036
3035|3008;3009;3033;3034;3036;3037;3038
3036|3033;3034;3035;3037;3038;3046,1
3037|3035;3036;3038;3039;3040;3045,1
3038|3009;3010;3035;3036;3037;3039;3040
3039|3010;3011;3037;3038;3040;3041;3042
3040|3037;3038;3039;3041;3042
3041|3039;3040;3042;3043;3044
3042|3039;3040;3041;3043;3044
3043|3041;3042;3044;3051;3052;3055;3056;3057
3044|3041;3042;3043;3051;3052
3045|3037;3046;3047
3046|3036;3045;3047;3050
3047|3045;3046;3048;3049;3050
3048|3047;3049
3049|3023;3025;3047;3048;3050
3050|3022;3023;3025;3046;3047;3049
3051|3043;3044;3052;3053;3054
3052|3043;3044;3051;3053;3054;3055;3056;3057
3053|3051;3052;3054;3056;3057
3054|3051;3052;3053
3055|3043;3052;3056;3067,1
3056|3043;3052;3053;3055;3057;3066,1;3067,1
3057|3043;3052;3053;3056;3058;3060;3061;3066,1
3058|3057;3059;3060;3061;3062;3066,1;3069,1
3059|2912,1;3058;3061;3062;3069,1
3060|3057;3058;3061;3063
3061|3057;3058;3059;3060;3062;3063;3064;3065
3062|2911,1;2912,1;3058;3059;3061;3064;3065
3063|3060;3061;3064
3064|3061;3062;3063;3065
3065|2905,1;2911,1;2912,1;2922,1;3061;3062;3064
3066|3056;3057;3058;3067;3068;3069;3070
3067|3021;3055;3056;3066;3068;3069;3070
3068|3021;3066;3067;3070
3069|3058;3059;3066;3067;3070
3070|3066;3067;3068;3069
3071|2726;3052;3056;3057
3072|2726;2926,1;2927,1;2928,1;3074
3073|3043;3056;3057;3061;3071;3074
3074|2925,1;2926,1;2927,1;3073
3075|1763;1764;2557,4;2558,4;2559,4;2560,4;3076
3076|1762;1763;2558,4;2559,4;3075;3077
3077|2556;2557;2558;3076,4;3078
3078|3077;3079,1
3079|3078;3080;3085
3080|3079;3081;3085
3081|3080;3082;3085;3086
3082|3081;3083;3085;3086;3087
3083|3082;3084;3086;3087
3084|3083;3087;3088;3090,4
3085|2556,1;2564,1;2572,1;3077;3078;3079;3080;3081;3082;3086
3086|2572,1;2580,1;2588,1;3081;3082;3083;3085;3087
3087|2580,1;2588,1;2596,1;3082;3083;3084;3086;3088
3088|2604,1;2612,1;3084;3087;3089
3089|2612,1;3088
3090|3084;3091;3094
3091|3082;3083;3090;3092;3094
3092|3081;3082;3091;3093;3094;3095
3093|3080;3081;3092;3094;3095
3094|3090;3091;3092;3093;3095
3095|3092;3093;3094;3098,4
3096|3094;3097
3097|3096;3098
3098|3095;3097;3099
3099|3098;3100
3100|3099;3101
3101|3100;3102
3102|3101;3103,1
3103|3102;3104,1
3104|3103;3105;3109;3113
3105|3104;3109;3113;3114
3106|3092;3093;3096;3107;3110;3111
3107|3098;3099;3100;3106;3108;3111
3108|3099;3100;3101;3107;3109
3109|3100;3101;3102;3104;3105;3108
3110|3091;3092;3093;3106;3111;3112;3116;3117
3111|3106;3107;3110;3112;3116
3112|3091;3092;3110;3111;3115;3116;3118;3119
3113|3104;3105
3114|3105;3116
3115|3086;3087;3091;3112;3118;3119;3124;3126
3116|3110;3111;3112;3114;3117
3117|3110;3116;3118,1
3118|3111;3112;3115;3117;3119;3120;3121;3124
3119|3111;3112;3115;3118;3120;3121;3126
3120|3118;3119;3121;3122;3124;3125
3121|3118;3119;3120;3123;3124
3122|3120;3123;3124;3125
3123|3121;3122;3124
3124|3115;3118;3120;3121;3122;3123
3125|3120;3122
3126|3086;3087;3115,1;3119,1;3127
3127|3086;3087;3126;3128
3128|3127;3129
3129|3128;3130
3130|3129;3131
3131|3130,1;3132
3132|3131,1;3133
3133|3132,1;3134
3134|3133;3135;3136
3135|3134;3136
3136|3134;3135
3137|471;483;495;3198;3281;3284
3138|1585;1587;3139;3142,1
3139|1583;1585;3138;3142,1;3146,1
3140|1569;1573;1576;3145,1
3141|1576;1580;1583;3146,1
3142|1602,1;3138;3139;3143;3146
3143|1601,1;3142;3144;3146
3144|1576;1599,1;3143;3145;3146
3145|1597,1;3140;3144;3146
3146|1583;3139;3141;3142;3143;3144;3145
3147|1608;1609;3148;3149;3150
3148|3147;3149;3150;3151
3149|1608;1609;3147;3148;3150;3151;3152;3153
3150|1609;3147;3148;3149;3151;3152
3151|3148;3149;3150;3155,1;3156,1
3152|1606;1607;1608;3149;3150;3153;3155,1
3153|1606;1607;1608;1609;3149;3152;3154,1
3154|3153;3155;3156;3157
3155|3151;3152;3154;3156;3157
3156|3151;3154;3155;3157;3158,1
3157|3154;3155;3156;3158,1
3158|1632;1633;1634;3156;3157;3159
3159|1634;1635;3148;3150;3158;3160,1
3160|1646;1651;1656;3159;3161
3161|1609;1610;1651;1656;1661;3160
3162|1514;1515;3163
3163|3162;3164
3164|3163;3165;3167
3165|3164;3166;3167
3166|3165;3167
3167|3164;3165;3166;3168
3168|3167;3170;3180
3169|3170;3171;3180;3181,2;3187
3170|3168;3169;3171;3172;3177;3180;3187
3171|3169;3170;3177;3185;3186;3187
3172|3170;3173;3175;3176;3177
3173|990;1001;1012;3172;3174;3175
3174|46;52;58;141;990;1001;1012;3173;3175
3175|105;114;123;132;3172;3173;3174;3176
3176|3172;3175;3177;3178
3177|2417;2426;2435;2444;3170;3171;3172;3176;3187
3178|3176;3179,5
3180|3168;3169;3170;3182,2
3181|3169;3182;3183
3182|3180;3181;3183
3183|3181;3182;3184
3184|611;612;623;624;3183
3185|612,1;613,1;614,1;615,1;3171;3186;3187
3186|148,1;2392,1;2400,1;2401,1;2540,1;2551,1;2552,1;3171;3185;3187
3187|2392,1;2400,1;2401,1;3169;3170;3171;3177;3185;3186
3188|1520;1521;1691;1692;1693;3189
3189|1520;1521;1692;1693;1694;1695;3188
3190|411;423;1556;1557;3191
3191|423;3190;3192
3192|1859;1866;3191;3193;3194
3193|1838;1839;1853;1861;1866;1867;3192;3194;3195
3194|3192;3193;3195
3195|3205,1
3196|447;459;3197;3198;3199;3202
3197|423;435;3196;3199;3202
3198|459;471;3137;3196;3281;3284
3199|3196;3197;3200
3200|3199;3201;3204
3201|1852;1859;1866;3200;3203;3204
3202|3196;3197;3203
3203|3201;3202;3204
3204|1845;1852;1859;3200;3201;3203
3205|3208;3211;3213;3225;3226;3227;3228;3232
3206|1832;1833;1839;1840;3207;3208,2;3232,2
3207|1831;1832;1838;1839;3206;3208,2;3231,2
3208|3205,4;3206;3207;3225,1;3231;3232
3209|3210,2;3212,4
3210|3209;3211,4;3232;3288
3211|3205;3206;3207;3210;3212;3213;3216;3232
3212|3209;3210;3211,2;3216,2;3218
3213|3205;3211;3214,2;3216;3219
3214|3213;3215;3217;3305;3306
3215|3205;3208;3211;3214;3305
3216|3211;3212;3213;3218;3219
3217|3214;3216;3220;3304;3305
3218|3212;3216,2;3219;3221;3224
3219|3213,2;3216,2;3218;3220;3222;3224
3220|3217,2;3219;3222;3223
3221|3218,2;3222;3224
3222|3219,2;3221;3224
3223|3220,2
3224|3218,2;3219,2;3221;3222
3225|3205,4;3208;3226,2;3230;3231
3226|3205,2;3225;3227;3230;3233
3227|3205,2;3226;3228;3233;3234
3228|3205,2;3227;3229;3235
3229|3228
3230|3225;3226,2;3231;3233
3231|1831;3207;3208;3225,2;3230,2;3232
3232|1833;3206;3208;3210;3231;3288
3233|3226,2;3227,2;3230
3234|3227,2;3235
3235|3228,2;3234
3236|1899;1900;2628;2641;2642;3237;3256
3237|1900;2628;2629;2643;2644;3236;3238;3239;3240
3238|1893;1900;3237;3239;3240;3247
3239|2628;2629;2630;2643;2644;2645;3237;3238;3240;3241;3242
3240|3237;3238;3239;3241;3242;3247;3248
3241|2629;2630;2631;2644;2645;2646;3239;3240;3242;3243;3244
3242|3239;3240;3241;3243;3244;3247;3248;3249
3243|2630;2631;2632;2645;2646;2647;3241;3242;3244;3245;3246
3244|3241;3242;3243;3245;3246;3248;3249
3245|2632;2633;2647;2648;2649;3243;3244;3246;3250;3251
3246|3243;3244;3245;3249;3250;3255
3247|1893;3238;3240;3242;3248
3248|1932;1933;1934;3240;3242;3244;3247;3249
3249|1932;1933;1934;3242;3244;3246;3248
3250|3245;3246;3251;3252,2;3255
3251|3245;3250;3252,2;3254,2
3252|3250;3251;3253;3254;3255
3253|2349;2352;2649;2805;2806;3252;3254
3254|2648;2649;2806;3251;3252;3253
3255|3246;3250;3252,2
3256|3236;3257
3257|1888;2638;3256;3258;3261;3276
3258|2623;2638;2653;3259;3270;3275;3292;3293
3259|2653;2668;2683;3258;3260;3275;3293
3260|3259,1;3292
3261|3257;3262;3276;3277
3262|3261;3263;3277
3263|3262;3264;3278;3279;3280;3297
3264|3263;3265;3278;3279;3280;3297
3265|3264;3266;3267;3283,1
3266|3199;3201;3204;3265;3267;3281;3284
3267|3265;3266;3281;3282,1;3283,1;3284
3268|3269;3282;3283
3269|3268;3270,1
3270|519;531;543;3258;3271;3274;3275;3293
3271|2505;2506;2507;2508;3270;3293;3294
3272|3273
3273|3272;3274
3274|3270,1;3273;3275
3275|3258;3259;3270,1;3274
3276|3257;3258;3261;3277;3278;3279
3277|3261;3262;3276;3278;3279
3278|3263;3264;3276;3277;3279
3279|1874;1881;1888;3263;3264;3276;3277;3278;3280
3280|1867;1874;1881;3263;3264;3279
3281|3137;3198;3266;3267;3282,1
3282|3267;3268;3281;3283
3283|3265;3267;3268;3282
3284|3137;3198;3200;3203;3266;3267
3285|1956;1961;1965;3286;3287
3286|1965;1969;1973;3285;3299
3287|2017;2018;2024;2031;2038;2039;3285
3288|1833;3210;3232
3289|2023;3290
3290|2022;3289;3291
3291|2021;3290
3292|152;2528;2537;3258;3260;3293
3293|3258;3259;3270;3271;3292
3294|531;543;2504;3271
3295|3296
3296|3295;3297
3297|3263;3264;3296
3298|3299;3300
3299|1965;3286;3298
3300|1956;1961;3298
3301|3213;3306
3302|3301,7
3303|3302,7;3304
3304|3217;3303;3305
3305|3214;3215;3217;3304
3306|3214;3301
3307|3140;3308;3315;3316
3308|1576;3140;3141;3307;3309;3315;3316;3317
3309|1576;1583;3140;3141;3308;3310;3316;3317;3318
3310|1576;1583;1585;1586;3141;3309;3311;3317;3318;3319
3311|1585;1586;3139;3141;3310;3312;3318;3319;3320
3312|408;421;422;423;3139;3311;3319;3320;3321
3315|3307;3308;3316;3323;3324
3316|3307;3308;3309;3315;3317;3323;3324;3325
3317|3308;3309;3310;3316;3318;3324;3325;3326
3318|3309;3310;3311;3317;3319;3325;3326;3327
3319|3310;3311;3312;3318;3320;3326;3327;3328
3320|3311;3312;3319;3321;3327;3328;3329
3321|409;421;422;423;434;3312;3320;3328;3329;3330
3323|3315;3316;3324;3331;3332
3324|3315;3316;3317;3323;3325;3331;3332;3333
3325|3316;3317;3318;3324;3326;3332;3333;3334
3326|3317;3318;3319;3325;3327;3333;3334;3335
3327|3318;3319;3320;3326;3328;3334;3335;3336
3328|3319;3320;3321;3327;3329;3335;3336;3337
3329|3320;3321;3328;3330;3336;3337;3338
3330|422;434;447;459;3321;3329;3337;3338
3331|3323;3324;3332;3339;3340
3332|3323;3324;3325;3331;3333;3339;3340;3341
3333|3324;3325;3326;3332;3334;3340;3341;3342
3334|3325;3326;3327;3333;3335;3341;3342;3343
3335|3326;3327;3328;3334;3336;3342;3343;3344
3336|3327;3328;3329;3335;3337;3343;3344;3345
3337|3328;3329;3330;3336;3338;3344;3345;3346
3338|435;447;459;3200;3202;3203;3329;3330;3337;3345;3346
3339|3331;3332;3340;3347;3348
3340|3331;3332;3333;3339;3341;3347;3348;3349
3341|3332;3333;3334;3340;3342;3348;3349;3350
3342|3333;3334;3335;3341;3343;3349;3350;3351
3343|3334;3335;3336;3342;3344;3350;3351;3352
3344|3335;3336;3337;3343;3345;3351;3352;3353
3345|3336;3337;3338;3344;3346;3352;3353;3354
3346|435;447;459;3200;3201;3203;3337;3338;3345;3353;3354
3347|3339;3340;3348;3355;3356
3348|3339;3340;3341;3347;3349;3355;3356;3357
3349|3340;3341;3342;3348;3350;3356;3357;3358
3350|3341;3342;3343;3349;3351;3357;3358;3359
3351|3342;3343;3344;3350;3352;3358;3359;3360
3352|3343;3344;3345;3351;3353;3359;3360;3361
3353|3344;3345;3346;3352;3354;3360;3361;3362
3354|447;459;3201;3345;3346;3353;3361;3362
3355|3347;3348;3356;3363;3387
3356|3347;3348;3349;3355;3357;3363;3365;3387;3388
3357|3348;3349;3350;3356;3358;3365;3366;3388
3358|3349;3350;3351;3357;3359;3365;3366;3367
3359|3350;3351;3352;3358;3360;3366;3367;3368
3360|3351;3352;3353;3359;3361;3367;3368;3369
3361|3352;3353;3354;3360;3362;3368;3369;3370
3362|3201;3353;3354;3361;3369;3370
3363|3355;3356;3371;3372;3387;3388
3365|3356;3357;3358;3366;3372;3373;3374;3388
3366|3357;3358;3359;3365;3367;3373;3374;3375
3367|3358;3359;3360;3366;3368;3374;3375;3376
3368|3359;3360;3361;3367;3369;3375;3376;3377
3369|3360;3361;3362;3368;3370;3376;3377;3378
3370|1866;3193;3201;3361;3362;3369;3377;3378
3371|3363;3372;3379;3380;3387
3372|3363;3365;3371;3373;3379;3380;3381;3387
3373|3365;3366;3372;3374;3380;3381;3382
3374|3365;3366;3367;3373;3375;3381;3382;3383
3375|3366;3367;3368;3374;3376;3382;3383;3384
3376|3367;3368;3369;3375;3377;3383;3384;3385
3377|3368;3369;3370;3376;3378;3384;3385
3378|1866;3193;3206;3369;3370;3377;3385
3379|3371;3372;3380
3380|3371;3372;3373;3379;3381
3381|3372;3373;3374;3380;3382
3382|3373;3374;3375;3381;3383
3383|1846;1853;3374;3375;3376;3382;3384
3384|1846;1852;1853;3195;3375;3376;3377;3383;3385
3385|1853;1866;3193;3195;3376;3377;3378;3384
3387|3355;3356;3363;3371;3372;3389
3388|3356;3357;3363;3365;3389
3389|3387;3388
3390|3172,5
3391|929;930;1036;3392;3393;3410
3392|3391;3410;3411
3393|929;3391;3410
3394|3164;3165;3166;3168;3395;3398
3395|3394;3396;3397;3398;3399;3411
3396|3395;3397;3398;3413
3397|937;938;939;3395;3396;3398;3399;3412
3398|3394;3395;3396;3397;3399;3400,1
3399|3395;3397;3398;3412
3400|3394;3395;3396;3398;3401,1
3401|3400;3402
3402|3401;3403,9
3403|424;436;448;460;472;1503;1506;3404
3404|3403;3405,10
3405|3404,15;3406
3406|3405;3407,11
3407|3406,14;3408
3408|3407;3409,12
3409|3408,13
3410|3391;3392;3393;3411
3411|3392;3395,1;3410
3412|925;3397,1;3413
3413|938;939;3396,1;3412
3414|1015;3415;3416;3418;3421;3422
3415|1003;1004;3414
3416|3420;3421;3422;3423;3424
3417|1018,1;3418;3419
3418|1017,1;3417
3419|3417;3420
3420|3416;3419,1;3421;3422;3423
3421|1777;1782;1787;3416;3420;3422;3424
3422|1806;2994;3416;3420;3421;3423;3424
3423|1734;1736;1737;2995;3416;3420;3422;3424
3424|3416;3421;3422;3423
3425|947;3426,1;3427;3429;3452;3453
3426|1113;1124;1135;1146;1157;3425;3427;3428
3427|3425;3428,1;3452;3453
3428|1102;1113;1124;1135;3425;3426;3427
3429|3425;3430
3430|1201,1;3429;3431,8
3431|3430,8;3432
3432|3431;3433,8
3433|3432,8;3434
3434|3433;3435,8
3435|3434,8;3436
3436|3435;3437,8
3437|3436,8;3438
3438|3437;3439,8
3439|3438,8;3440
3440|3439;3441,8
3441|3440,8;3442
3442|3441;3443,8
3443|3442,8;3444
3444|3443;3445,8
3445|3444,8;3446
3446|3445;3447,8
3447|3446,8;3448
3448|3447;3449;3451
3449|3448;3450
3450|3448;3449
3451|3452
3452|925;936;947;3425;3427;3453
3453|925;936;947;3425;3427;3452;3454,2
3454|3453;3455
3455|3454;3456;3457;3458
3456|3457;3458
3457|3456;3458
3458|3455,1;3456;3457
3459|1097;1098;1110;1121;1132;1143;1152;1153
3460|2079;2080;2082;2085;2088;2120
3461|1993;1995;2841;2842;3462,2
3462|2059,2;3461
3463|2059;2100;2103;2106;2107;2148,3
3464|2094;2097;2100;2148,3
3465|2148;2157;2158;2159;3466;3599,2;3600,2
3466|2148;2157;2158;2159;3465;3599,2;3600,2
3467|2099;2100;2103;2105;2106
3468|814;815;816;817;2173;2176;3469;3473;3474
3469|816;817;818;3468;3470;3473;3474;3475
3470|817;818;3469;3471;3474;3475;3476
3471|817;818;819;3470;3472;3475;3476;3477
3472|818;819;3471;3476;3477;3478
3473|2171;2173;2174;2176;2177;3468;3469;3474;3479;3480
3474|3468;3469;3470;3473;3475;3479;3480;3481
3475|3469;3470;3471;3474;3476;3480;3481;3482
3476|3470;3471;3472;3475;3477;3481;3482;3483
3477|3471;3472;3476;3478;3482;3483;3484
3478|3472;3477;3483;3484;3535
3479|2171;2174;2177;3473;3474;3480;3485;3486
3480|3473;3474;3475;3479;3481;3485;3486;3487
3481|3474;3475;3476;3480;3482;3486;3487;3488
3482|3475;3476;3477;3481;3483;3487;3488;3489
3483|3476;3477;3478;3482;3484;3488;3489;3490
3484|3477;3478;3483;3489;3490;3535
3485|2168;2171;2173;2174;3479;3480;3486;3491;3492
3486|3479;3480;3481;3485;3487;3491;3492;3493
3487|3480;3481;3482;3486;3488;3492;3493;3494
3488|3481;3482;3483;3487;3489;3493;3494;3495
3489|3482;3483;3484;3488;3490;3494;3495;3496
3490|3483;3484;3489;3495;3496;3535
3491|2171;2173;3485;3486;3492;3497;3498;3599
3492|3485;3486;3487;3491;3493;3497;3498;3499
3493|3486;3487;3488;3492;3494;3498;3499;3500
3494|3487;3488;3489;3493;3495;3499;3500;3501
3495|3488;3489;3490;3494;3496;3500;3501;3502
3496|3489;3490;3495;3501;3502;3535
3497|2168;2171;3491;3492;3498;3503;3504
3498|3491;3492;3493;3497;3499;3503;3504;3505
3499|3492;3493;3494;3498;3500;3504;3505;3506
3500|3493;3494;3495;3499;3501;3505;3506;3507
3501|3494;3495;3496;3500;3502;3506;3507
3502|3495;3496;3501;3507;3512;3535;3590,2
3503|2168;3497;3498;3504;3508;3509;3599
3504|3497;3498;3499;3503;3505;3508;3509;3510
3505|3498;3499;3500;3504;3506;3509;3510;3511
3506|3499;3500;3501;3505;3507;3510;3511;3512
3507|3500;3501;3502;3506;3511;3512
3508|2157;3503;3504;3509;3513;3514;3599
3509|3503;3504;3505;3508;3510;3513;3514;3515
3510|3504;3505;3506;3509;3511;3514;3515;3516
3511|3505;3506;3507;3510;3512;3515;3516
3512|3502;3506;3507;3511;3516;3520;3524;3581,2;3587,2
3513|2158;3508;3509;3514;3517;3518
3514|3508;3509;3510;3513;3515;3517;3518;3519;3599
3515|3509;3510;3511;3514;3516;3518;3519;3520
3516|3510;3511;3512;3515;3519;3520
3517|2154;2158;3513;3514;3518;3521;3522
3518|3513;3514;3515;3517;3519;3521;3522;3523
3519|3514;3515;3516;3518;3520;3522;3523;3524
3520|3512;3515;3516;3519;3523;3524
3521|2154;2158;3517;3518;3522;3525;3526
3522|3517;3518;3519;3521;3523;3525;3526;3527
3523|3518;3519;3520;3522;3524;3526;3527
3524|3512;3519;3520;3523;3527;3530;3567,2
3525|2150;2154;2158;3521;3522;3526;3528;3529
3526|3521;3522;3523;3525;3527;3528;3529;3530
3527|3522;3523;3524;3526;3529;3530
3528|2146;2150;2154;3525;3526;3529;3531;3532
3529|3525;3526;3527;3528;3530;3531;3532
3530|3524;3526;3527;3529;3532;3534;3558,2
3531|2146;2150;2154;3528;3529;3532;3533;3534
3532|3528;3529;3530;3531;3533;3534
3533|2146;2150;3531;3532;3534
3534|3530;3531;3532;3533
3535|3478;3484;3490;3496;3502
3536|1398,2;3537;3548;3549
3537|1397,2;1398,2;3536;3538;3548;3549;3550
3538|1397,2;3537;3539;3549;3550;3551
3539|1396,2;1397,2;3538;3540;3550;3551;3552
3540|1395,2;1396,2;3539;3541;3551;3552;3553
3541|1394,2;1395,2;1396,2;3540;3542;3552;3553;3554
3542|1393,2;1394,2;1395,2;1396,2;3541;3543;3553;3554;3555
3543|1393,2;1394,2;1395,2;3542;3544;3554;3555;3556
3544|1392,2;1393,2;1394,2;3543;3545;3555;3556;3557
3545|1391,2;1392,2;1393,2;3544;3546;3556;3557;3558
3546|1390,2;1391,2;1392,2;1393,2;3545;3547;3557;3558
3547|3529;3532;3534;3546;3558
3548|3536;3537;3549;3559
3549|3536;3537;3538;3548;3550;3559;3560
3550|3537;3538;3539;3549;3551;3559;3560;3561
3551|3538;3539;3540;3550;3552;3560;3561
3552|3539;3540;3541;3551;3553;3561;3563
3553|3540;3541;3542;3552;3554;3563;3564
3554|3541;3542;3543;3553;3555;3563;3564;3565
3555|3542;3543;3544;3554;3556;3564;3565;3566
3556|3543;3544;3545;3555;3557;3565;3566;3567
3557|3544;3545;3546;3556;3558;3566;3567;3595
3558|3530;3545;3546;3547;3557;3595
3559|3548;3549;3550;3560;3568
3560|3549;3550;3551;3559;3561;3568;3569
3561|3550;3551;3552;3560;3568;3569
3563|3552;3553;3554;3564;3571;3572
3564|3553;3554;3555;3563;3565;3571;3572;3573
3565|3554;3555;3556;3564;3566;3572;3573;3574
3566|3555;3556;3557;3565;3567;3573;3574;3575
3567|3524;3556;3557;3566;3574;3575;3595
3568|3559;3560;3561;3569;3576
3569|3560;3561;3568;3576
3571|3563;3564;3572;3578;3579
3572|3563;3564;3565;3571;3573;3578;3579;3580
3573|3564;3565;3566;3572;3574;3579;3580;3581
3574|3565;3566;3567;3573;3575;3580;3581;3582
3575|3566;3567;3574;3581;3582;3595
3576|3568;3569;3583
3578|3571;3572;3579;3583;3584;3585
3579|3571;3572;3573;3578;3580;3584;3585;3586
3580|3572;3573;3574;3579;3581;3585;3586;3587
3581|3512;3573;3574;3575;3580;3582;3586;3587
3582|3511;3515;3516;3519;3574;3575;3581
3583|3576;3578;3584;3588
3584|3578;3579;3583;3585;3588;3589
3585|3578;3579;3580;3584;3586;3588;3589;3590
3586|3579;3580;3581;3585;3587;3589;3590;3591
3587|3512;3580;3581;3586;3590;3591
3588|3583;3584;3585;3589;3592
3589|3584;3585;3586;3588;3590;3592;3593
3590|3502;3585;3586;3587;3589;3591;3593
3591|3495;3496;3501;3506;3511;3586;3587;3590
3592|3588;3589;3593;3594
3593|3589;3590;3592;3594
3594|3478;3483;3484;3489;3495;3501;3592;3593
3595|3518;3519;3522;3523;3526;3527;3529;3530;3532;3557;3558;3567;3575
3596|865;866;867;868;3597;3598
3597|866;867;868;3596;3598
3598|3596;3597
3599|2168;2169;3465;3466;3503,2;3508,2;3514,2;3600
3600|2168;2169;3465;3466;3599;3617,2
3601|1437;1438;1439;1445;1448;1453;1456;1461;1462;1463;1464
3602|1323;3603
3603|1323;1334;3602;3604
3604|1323;1334;3603;3605
3605|1334;1345;3604;3606
3606|1334;1345;1356;3605;3607
3607|1345;1356;1367;3606;3608
3608|1356;1367;3607;3609
3609|1356;1367;1378;3608;3610
3610|1367;1378;1389;3609;3611
3611|1378;1389;3610;3612
3612|1378;1389;1400;3611;3613
3613|1389;1400;3612
3614|2796;2797;2798;2802;2845
3615|806;813;2061;2065;2069;2073;2173;2176;2843;3616
3616|806;813;820;2066;2070;2840;2843;3615
3617|2168;3600;3618;3620;3621;3622
3618|2168;2170;2171;2173;3617;3619;3620;3621;3622
3619|2170;2173;2176;3615;3618;3620;3622
3620|2057;2061;2065;2069;3617;3618;3619;3621
3621|2061;2062;2065;3617;3618;3620;3622
3622|3617;3618;3619;3621;3623
3623|2056;2100;3622,2;3624
3624|3623;3625
3625|2051;2052;2055;3624;3626,2
3626|2051;2052;2096;2097;3463;3625;3627,2;3628
3627|1987;2047;2096;2097;2100;2103;3626;3629
3628|1987;3626;3629
3629|1946;1950;1954;1955;3628
3630|2052,2
3631|3626;3627
3632|2487;2488;2489;3633;3634;3636;3637;3638;3658
3633|3632;3635;3636
3634|2488;2489;2490;2491;3632;3637;3638;3658
3635|668;678;688;698;708;2488;2489;3633;3636
3636|648;658;668;678;688;2386;2487;2488;2489;3632;3633;3635
3637|3632;3634;3638;3639;3640;3641;3642;3658
3638|3632;3634;3637;3639;3640;3641;3642;3658
3639|3637;3638;3640;3641;3642
3640|3637;3638;3639;3641;3642
3641|3637;3638;3639;3640;3642;3644,2
3642|3637;3638;3639;3640;3641;3643,2
3643|3642;3644;3645;3646
3644|3641;3643;3645;3646
3645|3643;3644;3646;3647,2
3646|3643;3644;3645;3648,2
3647|3645;3648;3649;3650
3648|3646;3647;3649;3650
3649|3647;3648;3650;3652,2
3650|3647;3648;3649;3651,2
3651|3650;3652;3653;3654
3652|3649;3651;3653;3654
3653|3651;3652;3654;3655,2
3654|3651;3652;3653;3656,2
3655|3653;3656;3657
3656|3654;3655;3657
3657|3655;3656;3658
3658|2488;3632;3634;3637;3638
]==]
local ATLAS_CANNON_DATA = [==[
2725|382,42
2726|1916,39
2798|70,25;326,31;361,28;411,30;438,34;570,24;577,19;685,20;777,26;973,21;1617,33;1737,22;1792,17;1876,23;2426,36;2489,27;2524,29;2584,37;2743,18;3171,35;3362,32
2799|70,25;326,31;361,28;411,30;438,34;570,24;577,19;685,20;777,26;973,21;1617,33;1737,22;1792,17;1876,23;2426,36;2489,27;2524,29;2584,37;2743,18;3171,35;3362,32
2800|70,25;326,31;361,28;411,30;438,34;570,24;577,19;685,20;777,26;973,21;1617,33;1737,22;1792,17;1876,23;2426,36;2489,27;2524,29;2584,37;2743,18;3171,35;3362,32
2801|70,25;326,31;361,28;411,30;438,34;570,24;577,19;685,20;777,26;973,21;1617,33;1737,22;1792,17;1876,23;2426,36;2489,27;2524,29;2584,37;2743,18;3171,35;3362,32
2856|1782,38
3070|2252,41
3283|714,40
]==]
return { labels = ATLAS_LABELS, nodeData = ATLAS_NODE_DATA, walkData = ATLAS_WALK_DATA, cannonData = ATLAS_CANNON_DATA }
end)()
    local graphLabels = AtlasGraphData.labels or {}
    local graphNodes, graphLinks = {}, {}

    for record in tostring(AtlasGraphData.nodeData or ""):gmatch("[^;]+") do
        local clean = record:gsub("%s+", "")
        local id, x, y, z = clean:match("^(%d+)|([^,]+),([^,]+),([^,]+)$")
        if id then
            graphNodes[tonumber(id)] = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
        end
    end

    local function addGraphLinks(text, kind)
        for line in tostring(text or ""):gmatch("[^\r\n]+") do
            local from, rest = line:match("^(%d+)|(.+)$")
            if from then
                from = tonumber(from)
                local list = graphLinks[from]
                if not list then
                    list = {}
                    graphLinks[from] = list
                end
                for spec in rest:gmatch("[^;]+") do
                    local to, code = spec:match("^(%d+),?(%d*)$")
                    if to then
                        local label = ""
                        if code and code ~= "" then label = graphLabels[tonumber(code)] or "" end
                        local edgeKind = kind
                        if kind == 0 and (label == "Jump" or label == "Jump1") then
                            edgeKind = 1
                        end
                        list[#list + 1] = { to = tonumber(to), label = label, kind = edgeKind }
                    end
                end
            end
        end
    end

    addGraphLinks(AtlasGraphData.walkData, 0)
    addGraphLinks(AtlasGraphData.cannonData, 2)

    local EMPTY_LINKS = {}
    local WALK_LABELS = {
        Jump = true, Jump1 = true, MultiJump = true, CoconutJump = true,
        Drop = true, Wait = true, Night = true,
    }

    local function nearestNode(pos)
        local bestId, bestDistance = nil, math.huge
        for id, node in pairs(graphNodes) do
            local dx, dy, dz = node.X - pos.X, node.Y - pos.Y, node.Z - pos.Z
            local distance = dx * dx + dy * dy + dz * dz
            if distance < bestDistance then
                bestDistance, bestId = distance, id
            end
        end
        if not bestId then return nil, math.huge end
        return bestId, math.sqrt(bestDistance)
    end

    local function linkAllowed(link)
        if link.kind == 2 then return false end
        if link.kind == 1 then return true end
        if link.label == "" then return true end
        return WALK_LABELS[link.label] == true
    end

     
    local function findNodePath(from, to)
        if not from or not to then return nil end
        local startId = nearestNode(from)
        local goalId = nearestNode(to)
        if not startId or not goalId then return nil end
        if startId == goalId then
            return { { Position = to, Label = "", Final = true } }
        end

        local totalDistance = (to - from).Magnitude
        local goalPosition = graphNodes[goalId]
        local openSet = { [startId] = { 0, totalDistance, totalDistance } }
        local closedSet = {}
        local cameFrom = {}

        while true do
            local currentNode, currentG, currentF = nil, nil, math.huge
            for id, entry in pairs(openSet) do
                if entry[3] < currentF then
                    currentNode, currentG, currentF = id, entry[1], entry[3]
                end
            end
            if not currentNode then return nil end

            openSet[currentNode] = nil
            closedSet[currentNode] = true
            if currentNode == goalId then break end

            local currentPosition = graphNodes[currentNode]
            local links = graphLinks[currentNode] or EMPTY_LINKS
            for index = 1, #links do
                local link = links[index]
                if linkAllowed(link) then
                    local neighbor = graphNodes[link.to]
                    if neighbor and not closedSet[link.to] then
                        local newCost = currentG + (neighbor - currentPosition).Magnitude
                        local existing = openSet[link.to]
                        if not existing then
                            local h = (neighbor - goalPosition).Magnitude
                            openSet[link.to] = { newCost, h, newCost + h }
                            cameFrom[link.to] = { parent = currentNode, connection = link }
                        elseif newCost < existing[1] then
                            existing[1] = newCost
                            existing[3] = newCost + existing[2]
                            cameFrom[link.to] = { parent = currentNode, connection = link }
                        end
                    end
                end
            end
        end

        local path = {}
        local node = goalId
        while true do
            local entry = cameFrom[node]
            if not entry then break end
            table.insert(path, 1, {
                Position = graphNodes[node],
                Label = entry.connection.label,
            })
            node = entry.parent
        end
        path[#path + 1] = { Position = to, Label = "", Final = true }
        return path
    end

     
     
    local function expandNodePath(path, fromPos)
        local out = {}
        if not path then return out end
        local last = fromPos
        for index = 1, #path do
            local entry = path[index]
            local point = entry.Position
            if point and last then
                local dx, dz = point.X - last.X, point.Z - last.Z
                local distance = math.sqrt(dx * dx + dz * dz)
                local steps = 1
                if distance > 12 then
                    steps = math.min(7, math.ceil(distance / 9))
                end
                for step = 1, steps - 1 do
                    local t = step / steps
                    out[#out + 1] = {
                        Position = Vector3.new(
                            last.X + dx * t,
                            last.Y + (point.Y - last.Y) * t,
                            last.Z + dz * t
                        ),
                        Label = "",
                        Sub = true,
                    }
                end
                out[#out + 1] = entry
                last = point
            elseif point then
                out[#out + 1] = entry
                last = point
            end
        end
        return out
    end

    Nav.graph = { nodes = graphNodes, links = graphLinks, labels = graphLabels }
    Nav.nodeNearest = nearestNode
    Nav.nodePath = findNodePath
    Nav.nodeExpand = expandNodePath
    Nav.graphStats = function()
        local nodes, links = 0, 0
        for _ in pairs(graphNodes) do nodes = nodes + 1 end
        for _, list in pairs(graphLinks) do links = links + #list end
        return nodes, links
    end
    end)()
     

     
    ;(function()  
    local driveInst, driveAttach = nil, nil

     
     
     
     
     
     
     
    local savedCollide = nil     
    local noclipList = nil       
    local noclipChar = nil
    local noclipScanAt = 0

    local function restoreCollide()
        if savedCollide then
            for part, value in pairs(savedCollide) do
                if part and part.Parent then
                    pcall(function() part.CanCollide = value end)
                end
            end
        end
        savedCollide = nil
        noclipList = nil
        noclipChar = nil
        noclipScanAt = 0
    end

    local function noclipCharacter()
        local character = lp and lp.Character
        if not character then return end
        if noclipChar ~= character then
             
            restoreCollide()
            noclipChar = character
        end
        if savedCollide == nil then savedCollide = {} end
        if noclipList == nil then noclipList = {} end
        local now = tick()
        if now >= noclipScanAt then
            noclipScanAt = now + 0.25
            local list = try(function() return character:GetDescendants() end)
            if list then
                for _, part in ipairs(list) do
                    if isPart(part) and savedCollide[part] == nil then
                        savedCollide[part] = (try(function() return part.CanCollide end) ~= false)
                        noclipList[#noclipList + 1] = part
                    end
                end
            end
        end
         
         
         
        pcall(function()
            for i = 1, #noclipList do
                local part = noclipList[i]
                if part and part.Parent and part.CanCollide ~= false then
                    part.CanCollide = false
                end
            end
        end)
    end

    Nav.noclipTravel = function(on)
        if not on then
            restoreCollide()
            return
        end
         
         
        if S.travel_mode ~= "Tween" then return end
        noclipCharacter()
    end

     
     
     
    Nav.noclipProbe = function(origin, dx, dz, reach)
        if not origin or savedCollide == nil then return false end
        local len = math.sqrt(dx * dx + dz * dz)
        if len < 0.001 then return false end
        dx, dz = dx / len, dz / len
        reach = reach or 8
        local opened = false
        for i = 1, 2 do
            local lift = (i == 1) and 2 or 4.5
            local hit = Nav.ray(
                Vector3.new(origin.X, origin.Y + lift, origin.Z),
                Vector3.new(dx * reach, 0, dz * reach)
            )
            if hit then
                local normal = hit.Normal
                local ny = (normal and normal.Y) or 0
                if math.abs(ny) < 0.35 then
                    local inst = hit.Instance
                    if inst and savedCollide[inst] == nil then
                        local can = try(function() return inst.CanCollide end)
                        if can ~= nil then
                            savedCollide[inst] = (can ~= false)
                            pcall(function() inst.CanCollide = false end)
                            opened = true
                        end
                    end
                end
            end
        end
        return opened
    end

     
     
    Engine.noclipStep = function()
        if savedCollide == nil then return end
        noclipCharacter()
    end
    Engine.noclipTravel = Nav.noclipTravel
    Engine.noclipProbe = Nav.noclipProbe

    local function killDrive()
        if driveInst then pcall(function() driveInst:Destroy() end) end
        if driveAttach then pcall(function() driveAttach:Destroy() end) end
        driveInst, driveAttach = nil, nil
    end
    Nav.stopDrive = killDrive

     
     
     
    local function ensureDrive(hrp)
        if driveInst and driveInst.Parent and driveAttach and driveAttach.Parent then return true end
        killDrive()
        local ok = pcall(function()
            local attach = Instance.new("Attachment")
            attach.Name = "AtlasGlideAttachment"
            attach.Parent = hrp
            local vel = Instance.new("LinearVelocity")
            vel.Name = "AtlasGlide"
            vel.Attachment0 = attach
            vel.RelativeTo = Enum.ActuatorRelativeTo.World
            vel.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            vel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            vel.VectorVelocity = Vector3.new(0, 0, 0)
            vel.Parent = hrp
            driveAttach, driveInst = attach, vel
        end)
        if not ok or not driveInst then
            killDrive()
            return false
        end
        return true
    end

    local function driveVelocity(velocity)
        if driveInst then
            local ok = pcall(function() driveInst.VectorVelocity = velocity end)
            if ok then return end
            killDrive()
        end
         
        local hrp = getHRP()
        if hrp then
            pcall(function()
                hrp.AssemblyLinearVelocity = Vector3.new(velocity.X, velocity.Y + 3.2, velocity.Z)
            end)
        end
    end

     
     
     
     
     
    local runTrack = nil
    local function stopRunAnim(fade)
         
         
         
        pcall(function() Engine.walkAnimDrive(false) end)
        if runTrack == nil then return end
        pcall(function() runTrack:Stop(fade or 0.15) end)
        runTrack = nil
    end
    local function startRunAnim(speed)
        stopRunAnim()
        local hum = getHum()
        if not hum then return end
        local playSpeed = clamp((tonumber(speed) or 110) / 110, 0.8, 2.2)

         
         
         
         
        local played = false
        pcall(function()
             
             
             
            local char = lp and lp.Character
            local animate = (char and char:FindFirstChild("Animate"))
                or hum:FindFirstChild("Animate")
            local branch = animate and (animate:FindFirstChild("run")
                or animate:FindFirstChild("RunAnim"))
            local runAnim = branch and (branch:IsA("Animation") and branch
                or branch:FindFirstChildWhichIsA("Animation", true)) or nil
            local animator = hum:FindFirstChildOfClass("Animator")
            if runAnim and animator then
                local track = animator:LoadAnimation(runAnim)
                track.Priority = Enum.AnimationPriority.Action
                track.Looped = true
                track:Play(0.15, 1, playSpeed)
                runTrack = track
                if runTrack ~= nil then played = true end
            end
        end)
        if played then return end

         
        pcall(function()
            local animator = hum:FindFirstChildOfClass("Animator")
            if not animator or not animator.Parent then
                animator = Instance.new("Animator")
                animator.Parent = hum
            end
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://180426354"
            local track = animator:LoadAnimation(anim)
            track.Priority = Enum.AnimationPriority.Action
            track.Looped = true
            track:Play(0.15, 1, playSpeed)
            runTrack = track
        end)
    end
     
     
     
     
    pcall(function()
        local hAnim = getHum()
        if hAnim then hAnim:ChangeState(Enum.HumanoidStateType.Running) end
    end)

    Nav.stopRunAnim = stopRunAnim

     
     
     
     
     
     
     
     
     
    Nav.flyTo = function(targetPos, speed, thr, label, keepGoing)
        if not targetPos then return false end
        thr = thr or 4
        speed = tonumber(speed) or tonumber(S.glide_speed) or 110
        if speed <= 0 then speed = 110 end
        local hrp = getHRP()
        if not hrp then return false end

         
         
        pcall(killDrive)
        lastMoveMode, lastMoveAt = label or "Tween", tick()
        startRunAnim(speed)
        flightNoclip(true)

         
         
         
         
        pcall(function()
            local down = Nav.ray(
                Vector3.new(targetPos.X, targetPos.Y + 400, targetPos.Z),
                Vector3.new(0, -900, 0)
            )
            local inst = down and down.Instance
            if not inst or not down.Position then return end
            local ny = (down.Normal and down.Normal.Y) or 0
            if ny <= 0.45 then return end
            local name = string.lower(tostring(inst.Name or ""))
            local floorish = inst.ClassName == "Terrain"
                or string.find(name, "baseplate", 1, true) ~= nil
                or string.find(name, "ground", 1, true) ~= nil
                or string.find(name, "floor", 1, true) ~= nil
                or string.find(name, "terrain", 1, true) ~= nil
            if floorish and targetPos.Y < down.Position.Y - 6 then
                targetPos = Vector3.new(targetPos.X, down.Position.Y + 2, targetPos.Z)
            end
        end)

        local start = tick()
        local budget = math.min(120, ((targetPos - hrp.Position).Magnitude / speed) * 3 + 6)
        local bestDistance, bestAt = math.huge, start
        local wrotePos, wroteStep = nil, 0
        local stuckFrames = 0
        local lastStep = start
        local yaw = glideYaw or currentYaw(hrp.CFrame)
         
         
         
         
         
         
         
         
        local useVel = true
        local velFrom, velAt = hrp.Position, start
        local startY = hrp.Position.Y
         
         
         
         
         
        local climbMax = math.min(38, math.max(16, speed * 0.5))

         
         
         
         
        local driveX, driveZ = 0, 0
        local firstDelta = targetPos - hrp.Position
        if firstDelta.Magnitude > 0.1 then
            driveX, driveZ = firstDelta.Unit.X, firstDelta.Unit.Z
        end
        Engine.walkAnimDrive(true, driveX, driveZ)

        while tick() - start < budget do
            if not isOn() then break end
            hrp = getHRP()
            if not hrp or not isAlive() then break end

            local now = tick()
            local dt = clamp(now - lastStep, 0.001, 0.1)
            lastStep = now

             
             
             
            Engine.noclipStep()
            if wrotePos then
                local moved = (hrp.Position - wrotePos).Magnitude
                if moved < math.min(wroteStep, 1.5) * 0.4 then
                    stuckFrames = stuckFrames + 1
                    if stuckFrames >= 2 then
                         
                         
                        stuckFrames = 0
                        local probeDir = targetPos - hrp.Position
                        if probeDir.Magnitude > 0.1 and Engine.noclipProbe then
                            Engine.noclipProbe(hrp.Position, probeDir.Unit.X, probeDir.Unit.Z, 10)
                        end
                    end
                else
                    stuckFrames = 0
                end
            end

            local delta = targetPos - hrp.Position
            local distance = delta.Magnitude
            local flatDist = Vector3.new(delta.X, 0, delta.Z).Magnitude
             
             
            if flatDist <= thr and math.abs(delta.Y) <= 1.5 then break end
             
             
             
             
            if useVel and flatDist <= 7 and math.abs(delta.Y) <= 14 then
                useVel, wrotePos = false, nil
            end

             
             
             
            if useVel and hrp.Position.Y < math.min(startY, targetPos.Y) - 45 then
                useVel, wrotePos = false, nil
            end

            local want = speed
            if not keepGoing and distance < 12 then want = math.max(24, distance * 4) end
            local accel = math.max(30, speed * 2.6)
            if glideSpeed < want then
                glideSpeed = math.min(want, glideSpeed + accel * dt)
            else
                glideSpeed = math.max(want, glideSpeed - accel * 1.4 * dt)
            end

            local dir = delta.Unit
            driveX, driveZ = dir.X, dir.Z
            Engine.walkAnimDrive(true, driveX, driveZ)

            if useVel then
                 
                 
                 
                 
                local vy = 0
                if math.abs(delta.Y) > 1.0 then
                    vy = clamp(delta.Y * 2.4, -climbMax, climbMax)
                end
                local vel = Vector3.new(dir.X * glideSpeed, vy, dir.Z * glideSpeed)
                pcall(function()
                    hrp.AssemblyLinearVelocity = vel
                    hrp.Velocity = vel
                end)
                if now - velAt > 0.6 then
                    if distance > 8 and (hrp.Position - velFrom).Magnitude
                        < math.max(0.8, glideSpeed * (now - velAt) * 0.25) then
                         
                         
                        useVel, wrotePos = false, nil
                    end
                    velFrom, velAt = hrp.Position, now
                end
            else
                local step = math.min(want * dt, distance)
                local newPos = hrp.Position + dir * step
                local goalYaw = flatYaw(newPos, Vector3.new(targetPos.X, newPos.Y, targetPos.Z))
                if goalYaw then
                    yaw = yaw + clampYawDelta(goalYaw - yaw, math.max(0.5, dt * 22))
                end
                glideYaw = yaw
                pcall(function()
                    hrp.CFrame = CFrame.new(newPos.X, newPos.Y, newPos.Z) * CFrame.Angles(0, glideYaw or 0, 0)
                     
                     
                     
                     
                     
                    local vmag = math.min(want, 14)
                    hrp.AssemblyLinearVelocity = Vector3.new(driveX * vmag, 0, driveZ * vmag)
                    hrp.Velocity = Vector3.new(driveX * vmag, 0, driveZ * vmag)
                end)
                wrotePos, wroteStep = newPos, step
            end

            if distance < bestDistance - 0.4 then
                bestDistance, bestAt = distance, now
            elseif now - bestAt > 7 then
                status = "Tween stalled: " .. tostring(label or "")
                break
            end
             
             
             
             
             
            task.wait(0.03)
        end

        glideYaw = nil
        local current = getHRP()
        if not keepGoing then
            if current then
                pcall(function()
                    current.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    current.Velocity = Vector3.new(0, 0, 0)
                end)
            end
             
            stopRunAnim()
            flightNoclip(false)
             
             
             
            pcall(function()
                local h = getHum()
                if h then h:ChangeState(Enum.HumanoidStateType.Landed) end
            end)
        end
        return current ~= nil and (targetPos - current.Position).Magnitude <= thr + 2
    end
     
     
     
     
    Engine.flyTo = Nav.flyTo

     
     
    Nav.tweenTravel = function(targetPos, speed, thr, label)
        if not targetPos then return false end
        if not isOn() then return false end
        local ok = false
        local pinned = false
        pcall(function() Nav.traceTarget(targetPos) end)
        pcall(function()
            Nav.noclipTravel(true)
            pinned = true
        end)
        glideActive = true
        glideActiveSince = tick()
         
         
         
        local distance = (getHRP() and (getHRP().Position - targetPos).Magnitude) or 400
        S.face.pauseUntil = tick() + math.clamp(distance / math.max(speed or 80, 20) + 6, 4, 45)
        ok = Nav.flyTo(targetPos, speed, thr or 4, label or "Tween")
        S.face.pauseUntil = 0
        glideActive = false
        pcall(function() Nav.traceClear() end)
        if pinned then pcall(function() Nav.noclipTravel(false) end) end
        pcall(killDrive)
        return ok
    end

     
     
     
    local Trace = {
        points = {}, target = nil, ok = nil,
        core = {}, glow = {}, dots = {}, ring = nil,
    }
    local TRACE_MAX = 44

    local function traceReady()
        if Trace.ok ~= nil then return Trace.ok end
        Trace.ok = false
        if Drawing ~= nil then
            pcall(function()
                local probe = Drawing.new("Line")
                probe.Thickness = 1
                probe.Transparency = 1
                probe.Visible = false
                Trace.probe = probe
                Trace.ok = true
            end)
        end
        return Trace.ok
    end

    local function tracePool(n)
        while #Trace.core < n do
            local core = Drawing.new("Line")
            core.Color = Color3.fromRGB(255, 255, 255)
            core.Thickness = 2.6
            core.Transparency = 0.04
            core.Visible = false
            Trace.core[#Trace.core + 1] = core

            local glow = Drawing.new("Line")
            glow.Color = Color3.fromRGB(215, 232, 255)
            glow.Thickness = 9
            glow.Transparency = 0.8
            glow.Visible = false
            Trace.glow[#Trace.glow + 1] = glow
        end
        while #Trace.dots < n + 1 do
            local dot = Drawing.new("Circle")
            dot.Color = Color3.fromRGB(255, 255, 255)
            dot.Thickness = 1
            dot.Radius = 2.4
            dot.Filled = true
            dot.Transparency = 0.3
            dot.Visible = false
            Trace.dots[#Trace.dots + 1] = dot
        end
        if not Trace.ring then
            local ring = Drawing.new("Circle")
            ring.Color = Color3.fromRGB(255, 255, 255)
            ring.Thickness = 2
            ring.Radius = 9
            ring.Filled = false
            ring.Transparency = 0.12
            ring.Visible = false
            Trace.ring = ring
        end
    end

    local function traceHideAll()
        for index = 1, #Trace.core do
            Trace.core[index].Visible = false
            Trace.glow[index].Visible = false
        end
        for index = 1, #Trace.dots do Trace.dots[index].Visible = false end
        if Trace.ring then Trace.ring.Visible = false end
    end

     
     
     
    local function traceScreen(camera, point)
        if not camera or not point then return nil end
        local ok, screen, onScreen = pcall(function() return camera:WorldToScreenPoint(point) end)
        if not ok or not screen or onScreen == false then return nil end
        if screen.Z and screen.Z < 0 then return nil end
        return Vector2.new(screen.X, screen.Y)
    end

    local function traceDraw()
         
        if S.path_trace ~= true then return end
        if not traceReady() then return end
        local camera = Workspace.CurrentCamera
        if not camera then return end

        local pts = Trace.points
        if Trace.target then
            local hrp = getHRP()
            if hrp then pts = { hrp.Position, Trace.target } end
        end
        local count = #pts - 1
        if count < 1 then return end

        for index = 1, count do
            local core, glow = Trace.core[index], Trace.glow[index]
            local from = traceScreen(camera, pts[index])
            local to = traceScreen(camera, pts[index + 1])
            local show = from ~= nil and to ~= nil
            if core and glow then
                core.Visible = show
                glow.Visible = show
                if show then
                    core.From, core.To = from, to
                    glow.From, glow.To = from, to
                    local along = (index - 1) / count
                    core.Transparency = 0.02 + 0.14 * along
                    glow.Transparency = 0.68 + 0.18 * along
                end
            end
            local dot = Trace.dots[index]
            if dot then
                dot.Visible = from ~= nil
                if from then dot.Position = from end
            end
        end

        local tail = Trace.dots[count + 1]
        local lastScreen = traceScreen(camera, pts[#pts])
        if tail then
            tail.Visible = lastScreen ~= nil
            if lastScreen then tail.Position = lastScreen end
        end
        if Trace.ring then
            Trace.ring.Visible = lastScreen ~= nil
            if lastScreen then
                Trace.ring.Position = lastScreen
                Trace.ring.Radius = 7 + 2.2 * math.sin(tick() * 4.2)
                Trace.ring.Transparency = 0.1 + 0.08 * (0.5 + 0.5 * math.sin(tick() * 4.2))
            end
        end

        for index = count + 1, #Trace.core do
            Trace.core[index].Visible = false
            Trace.glow[index].Visible = false
        end
        for index = count + 2, #Trace.dots do Trace.dots[index].Visible = false end
    end

    Nav.traceClear = function()
        Trace.points = {}
        Trace.target = nil
        pcall(traceHideAll)
    end

    Nav.tracePath = function(points)
        if not traceReady() then return end
        Nav.traceClear()
        if S.path_trace == false or not points or #points < 2 then return end

        local raw = {}
        local last = nil
        for index = 1, #points do
            local point = points[index] and points[index].Position
            if point and (not last or (point - last).Magnitude > 4) then
                raw[#raw + 1] = point
                last = point
            end
        end
        if #raw < 2 then return end

        local stride = math.max(1, math.ceil((#raw - 1) / TRACE_MAX))
        local list = {}
        for index = 1, #raw, stride do
            list[#list + 1] = raw[index]
        end
        if list[#list] ~= raw[#raw] then list[#list + 1] = raw[#raw] end
        if #list < 2 then return end

        Trace.points = list
        tracePool(#list - 1)
    end

     
     
     
    Nav.traceTarget = function(target)
        if S.path_trace ~= true then return end
        if not traceReady() then return end
        Nav.traceClear()
        if not target then return end
        Trace.target = target
        tracePool(1)
    end

    Nav.traceDraw = function() pcall(traceDraw) end

    pcall(function()
        local RunService = game:GetService("RunService")
        RunService.RenderStepped:Connect(function()
            if S.path_trace ~= true then return end
            if not Trace.target and #Trace.points < 2 then return end
            if not isOn() then
                Nav.traceClear()
                return
            end
            pcall(traceDraw)
        end)
    end)

     
     
    Nav.nodeTravel = function(targetPos, label, tolerance)
        if not targetPos then return false end
        local hrp = getHRP()
        if not hrp then return false end
        label = label or "Travel"
        tolerance = tolerance or 5

        if (Vector3.new(hrp.Position.X, targetPos.Y, hrp.Position.Z) - targetPos).Magnitude <= tolerance then
            return true
        end

        status = label .. ": planning"
        local path = Nav.nodePath(hrp.Position, targetPos)
        local points = path and Nav.nodeExpand(path, hrp.Position) or nil

        if points and #points > 0 then
            status = label .. ": " .. tostring(#points) .. " nodes"
            pcall(function() Nav.tracePath(points) end)

             
             
             
            if S.walk_method ~= "Keyboard" and type(Nav.walkRoute) == "function"
                and type(Nav.memAvailable) == "function" and Nav.memAvailable() then
                Nav.walkRoute(points, { arrive = 3.5, label = label })
            else
                local index = 1
                while index <= #points do
                    if not isOn() then break end
                    local current = getHRP()
                    if not current then break end
                    local point = points[index] and points[index].Position
                    if not point or (point - current.Position).Magnitude <= 3 then
                        index = index + 1
                    else
                        local distance = (point - current.Position).Magnitude
                        if point.Y - current.Position.Y > 2.5 and distance < 30 and type(Nav.jumpNow) == "function" then Nav.jumpNow() end
                        Nav.walk(point, {
                            arrive = 3.5,
                            timeout = math.max(6, math.min(40, distance / 4 + 6)),
                            label = label,
                        })
                        index = index + 1
                    end
                end
            end
        end

        pcall(function() Nav.traceClear() end)
        local current = getHRP()
        if not current then return false end
        if (Vector3.new(current.Position.X, targetPos.Y, current.Position.Z) - targetPos).Magnitude <= tolerance then
            return true
        end

        local distance = (targetPos - current.Position).Magnitude
        return Nav.walk(targetPos, {
            arrive = tolerance,
            timeout = math.max(8, math.min(60, distance / 4 + 8)),
            label = label,
        })
    end
    end)()
     

     
     
     
     
     
    Nav.pineReturn = {
        Vector3.new(-291.8, 68.0, -134.1),
        Vector3.new(-238.6, 68.0, -71.2),
        Vector3.new(-226.8, 34.3, 72.3),
        Vector3.new(-155.3, 4.0, 172.3),
        Vector3.new(-113.1, 4.7, 215.7),
        Vector3.new(-113.7, 4.9, 272.7),
    }

     
     
     
     
     
     
     
     
    Nav.walkLegs = function(list, label, arrive, opts)
        if type(list) ~= "table" or #list < 1 then return false end
        arrive = tonumber(arrive) or 3.5
        label = label or "Route"
        local first = 1
        if opts and opts.from then
            first = math.max(1, math.min(#list, math.floor(opts.from)))
        end
        if opts and opts.viaHive then
            local startPoint = list[1]
            local hrp0 = getHRP()
            if hrp0 and (startPoint - hrp0.Position).Magnitude > 45 then
                status = label .. ": pathfinding to hive"
                if S.travel_mode == "Tween" then
                    Nav.tweenTravel(startPoint, S.glide_speed, 4, label)
                else
                    Nav.nodeTravel(startPoint, label, 4)
                end
                if not isOn() then return false end
            end
            first = 2
        end
        for index = first, #list do
            if not isOn() then return false end
            local point = list[index]
            local hrp = getHRP()
            if not hrp then return false end
            local gap = (point - hrp.Position).Magnitude
            if gap > arrive then
                status = label .. " " .. index .. "/" .. #list
                local prev = list[index - 1]
                local climb = prev ~= nil and (point.Y - prev.Y) > 6
                local jumper = nil
                if climb and type(Nav.jumpNow) == "function" then
                     
                     
                     
                     
                     
                     
                     
                     
                    jumper = task.spawn(function()
                        local hops = 0
                        local baseAt, baseX, baseY, baseZ = tick(), nil, nil, nil
                        while isOn() and hops < 4 do
                            local current = getHRP()
                            if not current then break end
                            local pos = current.Position
                            if (point - pos).Magnitude <= arrive then break end
                            if pos.Y >= point.Y - 2 then break end
                            local now = tick()
                            local moved = baseX ~= nil
                                and (math.abs(pos.X - baseX) > 1.5
                                    or math.abs(pos.Z - baseZ) > 1.5
                                    or math.abs(pos.Y - baseY) > 1.5)
                            if baseX == nil or moved or (point - pos).Magnitude > 30 then
                                baseX, baseY, baseZ, baseAt = pos.X, pos.Y, pos.Z, now
                            elseif now - baseAt > 1.2 then
                                Nav.jumpNow()
                                hops = hops + 1
                                baseX, baseY, baseZ, baseAt = pos.X, pos.Y, pos.Z, now
                            end
                            task.wait(0.15)
                        end
                    end)
                end
                if S.travel_mode == "Tween" then
                    Nav.tweenTravel(point, S.glide_speed, arrive, label)
                else
                    Nav.walk(point, {
                        arrive = arrive,
                        timeout = math.max(6, math.min(45, gap / 4 + 6)),
                        label = label,
                    })
                end
                if jumper then pcall(task.cancel, jumper) end
            end
        end
        return true
    end

    Nav.firePromptOn = function(obj)
        if not obj or type(fireproximityprompt) ~= "function" then return false end
        local ok, desc = pcall(function() return obj:GetDescendants() end)
        if not ok or not desc then return false end
        for _, o in ipairs(desc) do
            if o.ClassName == "ProximityPrompt" then
                local enabled = try(function() return o.Enabled end)
                if enabled ~= false then
                    local fired = pcall(function() fireproximityprompt(o) end)
                    if fired then return true end
                end
            end
        end
        return false
    end

    Nav.firePromptNear = function(pos, radius)
        if not pos or type(fireproximityprompt) ~= "function" then return false end
        local ok, list = pcall(function() return Workspace:GetDescendants() end)
        if not ok or not list then return false end
        local best, bestD = nil, radius or 18
        for _, o in ipairs(list) do
            if o.ClassName == "ProximityPrompt" then
                local enabled = try(function() return o.Enabled end)
                local pp = enabled ~= false and getPartPos(o.Parent) or nil
                if pp then
                    local d = (pp - pos).Magnitude
                    if d < bestD then bestD = d; best = o end
                end
            end
        end
        if best then
            pcall(function() fireproximityprompt(best) end)
            return true
        end
        return false
    end

    Nav.touchToken = function(tok)
        if not tok or type(firetouchinterest) ~= "function" then return false end
        local part = tok
        if not getPartPos(part) then
            part = try(function() return tok:FindFirstChildWhichIsA("BasePart", true) end)
        end
        local hrp = getHRP()
        if not hrp or not part or not getPartPos(part) then return false end
        local ok = pcall(function()
            firetouchinterest(hrp, part, 0)
            firetouchinterest(hrp, part, 1)
        end)
        return ok
    end

    Nav.hiveKeyAt = function(pos)
        if not pos then return nil, math.huge end
        local best, bestD = nil, math.huge
        for i = 1, 6 do
            local key = "Hive" .. i
            local pts = Nav.routes[key]
            if pts then
                local p = pts[#pts]
                local d = (Vector3.new(p[1], p[2], p[3]) - pos).Magnitude
                if d < bestD then bestD = d; best = key end
            end
        end
        return best, bestD
    end

    Nav.hivePos = function(key)
        local pts = key and Nav.routes[key]
        if not pts then return nil end
        local p = pts[#pts]
        return Vector3.new(p[1], p[2], p[3])
    end

    Nav.keyFor = function(pos)
        if not pos then return nil end
        local bestKey, bestDist = nil, 78
        for key, pts in pairs(Nav.routes) do
            local p = pts[#pts]
            local dx, dz = p[1] - pos.X, p[3] - pos.Z
            local d = math.sqrt(dx * dx + dz * dz)
            if d < bestDist then bestDist = d; bestKey = key end
        end
        return bestKey
    end

    Nav.inFieldName = function(name, pos, margin)
        local zones = Workspace:FindFirstChild("FlowerZones")
            or Workspace:FindFirstChild("Fields")
            or Workspace:FindFirstChild("FieldZones")
        local f = zones and zones:FindFirstChild(name)
        if not f or not pos then return false end
        local p = try(function() return f.Position end)
        local s = try(function() return f.Size end)
        if not p or not s then return false end
        local m = margin or 4
        return math.abs(pos.X - p.X) <= s.X / 2 + m
           and math.abs(pos.Z - p.Z) <= s.Z / 2 + m
    end

    Nav.walkKeys = {}
    Nav.onFoot = false

    Nav.setKey = function(code, want)
        local held = Nav.walkKeys[code]
        if want and not held then
            Nav.walkKeys[code] = true
            pcall(function() keypress(code) end)
        elseif not want and held then
            Nav.walkKeys[code] = nil
            pcall(function() keyrelease(code) end)
        end
    end

    Nav.release = function()
        local held = {}
        for code in pairs(Nav.walkKeys) do held[#held + 1] = code end
        Nav.walkKeys = {}
        for i = 1, #held do
            local code = held[i]
            pcall(function() keyrelease(code) end)
        end
    end

    ;(function()  
    local RAY_CELL = 8
    local RAY_RADIUS = 6
    local RAY_STEP_UP = 4.5
    local RAY_STEP_DOWN = 8
    local RAY_CACHE_LIFE = 3
    local RAY_CLEAR_HEIGHTS = { -1.4, 0.7 }
    local RAY_STEER_OFFSETS = { 0, 30, -30, 60, -60, 90, -90, 120, -120 }
    local RAY_DIRS = {
        { 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 },
        { 1, 1 }, { 1, -1 }, { -1, 1 }, { -1, -1 },
    }

    Nav.rayAvailable = false
    Nav.rayParams = nil
    Nav.rayCharacter = nil
    Nav.steerSide = 0
    Nav.groundCache = {}
    Nav.groundCacheOrigin = nil
    Nav.edgeCache = {}

    pcall(function()
        local params = RaycastParams.new()
        local filterOk = pcall(function()
            params.FilterType = Enum.RaycastFilterType.Exclude
        end)
        if not filterOk then
            filterOk = pcall(function()
                params.FilterType = Enum.RaycastFilterType.Blacklist
            end)
        end
        local listOk = false
        if lp.Character then
            listOk = pcall(function()
                params.FilterDescendantsInstances = { lp.Character }
            end)
        end
        pcall(function() params.IgnoreWater = true end)
        pcall(function() params.RespectCanCollide = true end)
        if filterOk and listOk then Nav.rayParams = params end
    end)

    local function ownCharacterPart(inst)
        local c = lp and lp.Character
        if not c or not inst then return false end
        local node = inst
        for _ = 1, 16 do
            if node == c then return true end
            node = node.Parent
            if not node then break end
        end
        return false
    end

    local function refreshRayFilter()
        if not Nav.rayParams then return end
        local c = lp and lp.Character
        if c == Nav.rayCharacter then return end
        Nav.rayCharacter = c
        pcall(function()
            Nav.rayParams.FilterDescendantsInstances = c and { c } or {}
        end)
    end

    Nav.ray = function(origin, direction)
        if not origin or not direction then return nil end
        local len = direction.Magnitude
        if len < 0.01 then return nil end
        local ux, uy, uz = direction.X / len, direction.Y / len, direction.Z / len
        local ox, oy, oz = origin.X, origin.Y, origin.Z
        local left = len
        refreshRayFilter()
        for _ = 1, 16 do
            local originNow = Vector3.new(ox, oy, oz)
            local directionNow = Vector3.new(ux * left, uy * left, uz * left)
            local result = nil
            local usedParams = false
            if Nav.rayParams then
                local ok, hit = pcall(function()
                    return Workspace:Raycast(originNow, directionNow, Nav.rayParams)
                end)
                if ok then
                    Nav.rayAvailable = true
                    usedParams = true
                    result = hit
                else
                    Nav.rayParams = nil
                end
            end
            if not usedParams then
                local ok, hit = pcall(function()
                    return Workspace:Raycast(originNow, directionNow)
                end)
                if ok then
                    Nav.rayAvailable = true
                    result = hit
                end
            end
            if not result then return nil end
            local inst = result.Instance
            local hitPos = result.Position
            if not hitPos then return nil end
            local own = ownCharacterPart(inst)
            local ignore = own
            if not ignore and inst then
                local collide = try(function() return inst.CanCollide end)
                if collide == false then ignore = true end
            end
            if not ignore then return result end
            local hitDist = tonumber(result.Distance) or (hitPos - originNow).Magnitude
            if hitDist >= left then return nil end
            local stepPast = own and 0.4 or 0.12
            ox = hitPos.X + ux * stepPast
            oy = hitPos.Y + uy * stepPast
            oz = hitPos.Z + uz * stepPast
            left = left - math.max(hitDist, 0) - stepPast
            if left <= 0.05 then return nil end
        end
        return nil
    end

    Nav.groundAt = function(x, z, refY)
        local hit = Nav.ray(Vector3.new(x, (refY or 0) + 6, z), Vector3.new(0, -50, 0))
        if not hit then return nil end
        local normal = hit.Normal
        if normal and normal.Y and normal.Y < 0.45 then return nil end
        return hit.Position.Y, hit
    end

    Nav.clearDist = function(pos, dx, dz, maxDist)
        local len = math.sqrt(dx * dx + dz * dz)
        if len < 0.001 then return 0 end
        dx, dz = dx / len, dz / len
        maxDist = maxDist or 9
        local best = maxDist
        for i = 1, #RAY_CLEAR_HEIGHTS do
            local origin = Vector3.new(pos.X, pos.Y + RAY_CLEAR_HEIGHTS[i], pos.Z)
            local hit = Nav.ray(origin, Vector3.new(dx * maxDist, 0, dz * maxDist))
            if hit then
                local normal = hit.Normal
                if not normal or not normal.Y or normal.Y < 0.55 then
                    local d = (hit.Position - origin).Magnitude
                    if d < best then best = d end
                end
            end
        end
        return best
    end

    Nav.stepAhead = function(pos, dx, dz, probe)
        local len = math.sqrt(dx * dx + dz * dz)
        if len < 0.001 then return false end
        dx, dz = dx / len, dz / len
        probe = probe or 4.5
        local y0 = Nav.groundAt(pos.X, pos.Z, pos.Y)
        local y1 = Nav.groundAt(pos.X + dx * probe, pos.Z + dz * probe, pos.Y)
        if not y0 or not y1 then return false end
        local rise = y1 - y0
        return rise > 1.1 and rise <= 5.0
    end

    Nav.steer = function(pos, dx, dz, maxProbe)
        local len = math.sqrt(dx * dx + dz * dz)
        if len < 0.001 then return dx, dz, 0 end
        dx, dz = dx / len, dz / len
        maxProbe = maxProbe or 9
        local direct = Nav.clearDist(pos, dx, dz, maxProbe)
        if direct >= maxProbe * 0.78 then
            Nav.steerSide = 0
            return dx, dz, direct
        end
        local base = math.atan2(dz, dx)
        local y0 = Nav.groundAt(pos.X, pos.Z, pos.Y)
        local bestX, bestZ, bestScore, bestClear = dx, dz, -math.huge, direct
        for i = 1, #RAY_STEER_OFFSETS do
            local off = RAY_STEER_OFFSETS[i]
            local a = base + math.rad(off)
            local cx, cz = math.cos(a), math.sin(a)
            local clear = Nav.clearDist(pos, cx, cz, maxProbe)
            local y1 = Nav.groundAt(pos.X + cx * 5.5, pos.Z + cz * 5.5, pos.Y)
            local walkable = y0 ~= nil and y1 ~= nil and (y1 - y0) <= 5 and (y1 - y0) >= -8
            local score = clear - math.abs(off) * 0.045
            if not walkable then score = score - 10 end
            if (Nav.steerSide or 0) ~= 0 and (off * Nav.steerSide) > 0 then score = score + 1.0 end
            if score > bestScore then
                bestScore = score
                bestX, bestZ, bestClear = cx, cz, clear
            end
        end
        if bestScore < 1.0 then return dx, dz, direct end
        Nav.steerSide = 0
        local bestAngle = math.atan2(bestZ, bestX)
        local delta = ((bestAngle - base + math.pi) % (2 * math.pi)) - math.pi
        if delta > 0.12 then Nav.steerSide = 1 elseif delta < -0.12 then Nav.steerSide = -1 end
        return bestX, bestZ, bestClear
    end

    Nav.segmentClear = function(fromPos, toPos)
        if not fromPos or not toPos then return false end
        local dx, dz = toPos.X - fromPos.X, toPos.Z - fromPos.Z
        local flat = math.sqrt(dx * dx + dz * dz)
        if flat < 0.5 then return true end
        local lowY = math.min(fromPos.Y, toPos.Y) + 0.6
        local heights = { lowY, lowY + 1.5 }
        for i = 1, #heights do
            local origin = Vector3.new(fromPos.X, heights[i], fromPos.Z)
            local hit = Nav.ray(origin, Vector3.new(dx, 0, dz))
            if hit then
                local normal = hit.Normal
                local d = (hit.Position - origin).Magnitude
                if d < flat - 1.0 and (not normal or not normal.Y or normal.Y < 0.55) then
                    return false
                end
            end
        end
        local lastY = nil
        local steps = math.max(2, math.ceil(flat / 6))
        local refY = math.max(fromPos.Y, toPos.Y)
        for i = 0, steps do
            local t = i / steps
            local gy = Nav.groundAt(fromPos.X + dx * t, fromPos.Z + dz * t, refY)
            if not gy then return false end
            if lastY and math.abs(gy - lastY) > 5.5 then return false end
            lastY = gy
        end
        return true
    end

    Nav.chooseSubgoal = function(startPos, goalPos, maxDist)
        local dx, dz = goalPos.X - startPos.X, goalPos.Z - startPos.Z
        local dist = math.sqrt(dx * dx + dz * dz)
        local y0 = Nav.groundAt(startPos.X, startPos.Z, startPos.Y)
        local function heightAt(px, pz)
            return Nav.groundAt(px, pz, startPos.Y)
        end
        local function lineWalkable(px, pz)
            if not y0 then return false end
            local lx, lz = px - startPos.X, pz - startPos.Z
            local flat = math.sqrt(lx * lx + lz * lz)
            local steps = math.max(1, math.ceil(flat / 6))
            local lastY = y0
            for i = 1, steps do
                local t = i / steps
                local gy = Nav.groundAt(startPos.X + lx * t, startPos.Z + lz * t, startPos.Y)
                if not gy then return false end
                if math.abs(gy - lastY) > 5.5 then return false end
                lastY = gy
            end
            return true
        end
        if dist <= maxDist * 0.85 then
            local gy = heightAt(goalPos.X, goalPos.Z)
            if gy and lineWalkable(goalPos.X, goalPos.Z) then
                return Vector3.new(goalPos.X, gy + 2.6, goalPos.Z)
            end
            return goalPos
        end
        if dist > 0.1 then
            local nx, nz = dx / dist, dz / dist
            local px, pz = startPos.X + nx * maxDist, startPos.Z + nz * maxDist
            local gy = heightAt(px, pz)
            if gy and lineWalkable(px, pz) then
                return Vector3.new(px, gy + 2.6, pz)
            end
        end
        local base = math.atan2(dz, dx)
        local best, bestScore = nil, -math.huge
        for i = 1, #RAY_STEER_OFFSETS do
            local off = RAY_STEER_OFFSETS[i]
            local a = base + math.rad(off)
            local cx, cz = math.cos(a), math.sin(a)
            local px, pz = startPos.X + cx * maxDist, startPos.Z + cz * maxDist
            local gy = heightAt(px, pz)
            if gy and lineWalkable(px, pz) then
                local clear = Nav.clearDist(startPos, cx, cz, maxDist)
                local score = clear - math.abs(off) * 0.1
                if score > bestScore then
                    bestScore = score
                    best = Vector3.new(px, gy + 2.6, pz)
                end
            end
        end
        return best
    end

    local function cachedGround(gx, gz, refY)
        local key = tostring(gx) .. ":" .. tostring(gz)
        local now = tick()
        local entry = Nav.groundCache[key]
        if entry and now - entry.t < RAY_CACHE_LIFE then return entry.y end
        local x = (gx + 0.5) * RAY_CELL
        local z = (gz + 0.5) * RAY_CELL
        local y = Nav.groundAt(x, z, refY)
        Nav.groundCache[key] = { y = y, t = now }
        return y
    end

    local function cachedEdgeClear(a, bx, bz, by)
        local key = tostring(a.gx) .. ":" .. tostring(a.gz) .. ">" .. tostring(bx) .. ":" .. tostring(bz)
        local now = tick()
        local entry = Nav.edgeCache[key]
        if entry and now - entry.t < RAY_CACHE_LIFE then return entry.ok end
        local ax = (a.gx + 0.5) * RAY_CELL
        local az = (a.gz + 0.5) * RAY_CELL
        local tx = (bx + 0.5) * RAY_CELL
        local tz = (bz + 0.5) * RAY_CELL
        local dx, dy, dz = tx - ax, by - a.y, tz - az
        local flat = math.sqrt(dx * dx + dz * dz)
        local ok = true
        if flat > 0.01 then
            local origin = Vector3.new(ax, a.y + 2.2, az)
            local hit = Nav.ray(origin, Vector3.new(dx, dy, dz))
            if hit then
                local normal = hit.Normal
                local d = (hit.Position - origin).Magnitude
                local rise = by - a.y
                local stepUp = rise > 0.5 and rise <= RAY_STEP_UP
                if d < flat - 0.8 and (not normal or not normal.Y or normal.Y < 0.55) and not stepUp then
                    ok = false
                end
            end
        end
        Nav.edgeCache[key] = { ok = ok, t = now }
        return ok
    end

    Nav.planRayPath = function(startPos, goalPos)
        if not startPos or not goalPos then return nil end
        if not Nav.rayAvailable then
            Nav.groundAt(startPos.X, startPos.Z, startPos.Y)
            if not Nav.rayAvailable then return nil end
        end

        local maxDist = RAY_CELL * RAY_RADIUS * 0.8
        local sub = Nav.chooseSubgoal(startPos, goalPos, maxDist)
        if not sub then return nil end

        local sx = math.floor(startPos.X / RAY_CELL)
        local sz = math.floor(startPos.Z / RAY_CELL)
        local gx = math.floor(sub.X / RAY_CELL)
        local gz = math.floor(sub.Z / RAY_CELL)
        local minX = math.min(sx - RAY_RADIUS, gx - 2)
        local maxX = math.max(sx + RAY_RADIUS, gx + 2)
        local minZ = math.min(sz - RAY_RADIUS, gz - 2)
        local maxZ = math.max(sz + RAY_RADIUS, gz + 2)

        if not Nav.groundCacheOrigin or (startPos - Nav.groundCacheOrigin).Magnitude > 80 then
            Nav.groundCache = {}
            Nav.edgeCache = {}
            Nav.groundCacheOrigin = startPos
        end

        local startY = cachedGround(sx, sz, startPos.Y) or (startPos.Y - 2.6)
        local goalY = cachedGround(gx, gz, startPos.Y)
        if not goalY then
            local found = false
            for r = 1, 2 do
                for ox = -r, r do
                    for oz = -r, r do
                        if math.abs(ox) == r or math.abs(oz) == r then
                            local tx, tz = gx + ox, gz + oz
                            if tx >= minX and tx <= maxX and tz >= minZ and tz <= maxZ then
                                local ty = cachedGround(tx, tz, startPos.Y)
                                if ty then
                                    gx, gz, goalY = tx, tz, ty
                                    found = true
                                    break
                                end
                            end
                        end
                    end
                    if found then break end
                end
                if found then break end
            end
        end
        if not goalY then return nil end

        local startKey = tostring(sx) .. ":" .. tostring(sz)
        local startNode = { gx = sx, gz = sz, y = startY, g = 0, f = 0, parent = nil, key = startKey }
        startNode.f = math.sqrt((sx - gx) * (sx - gx) + (sz - gz) * (sz - gz)) * RAY_CELL
        local open = { startNode }
        local openSet = { [startKey] = true }
        local closed = {}
        local gScore = { [startKey] = 0 }
        local goalNode = nil
        local iterations = 0

        while #open > 0 and iterations < 600 do
            iterations = iterations + 1
            local bestIndex = 1
            for i = 2, #open do
                if open[i].f < open[bestIndex].f then bestIndex = i end
            end
            local node = table.remove(open, bestIndex)
            openSet[node.key] = nil
            closed[node.key] = true
            if node.gx == gx and node.gz == gz then
                goalNode = node
                break
            end
            for d = 1, #RAY_DIRS do
                local dir = RAY_DIRS[d]
                local nx, nz = node.gx + dir[1], node.gz + dir[2]
                if nx >= minX and nx <= maxX and nz >= minZ and nz <= maxZ then
                    local nk = tostring(nx) .. ":" .. tostring(nz)
                    if not closed[nk] then
                        local ny = cachedGround(nx, nz, startPos.Y)
                        if ny then
                            local rise = ny - node.y
                            if rise <= RAY_STEP_UP and rise >= -RAY_STEP_DOWN then
                                local diagonalOk = true
                                if dir[1] ~= 0 and dir[2] ~= 0 then
                                    local y1 = cachedGround(node.gx + dir[1], node.gz, startPos.Y)
                                    local y2 = cachedGround(node.gx, node.gz + dir[2], startPos.Y)
                                    if not y1 or not y2 then
                                        diagonalOk = false
                                    elseif (y1 - node.y) > RAY_STEP_UP or (y1 - node.y) < -RAY_STEP_DOWN then
                                        diagonalOk = false
                                    elseif (y2 - node.y) > RAY_STEP_UP or (y2 - node.y) < -RAY_STEP_DOWN then
                                        diagonalOk = false
                                    end
                                end
                                if diagonalOk and cachedEdgeClear(node, nx, nz, ny) then
                                    local step = math.sqrt(dir[1] * dir[1] + dir[2] * dir[2]) * RAY_CELL
                                    local cost = step + math.max(0, rise) * 1.5 + math.max(0, -rise) * 0.35
                                    local tentative = node.g + cost
                                    if not gScore[nk] or tentative < gScore[nk] then
                                        gScore[nk] = tentative
                                        local h = math.sqrt((nx - gx) * (nx - gx) + (nz - gz) * (nz - gz)) * RAY_CELL
                                        local newNode = { gx = nx, gz = nz, y = ny, g = tentative, f = tentative + h, parent = node, key = nk }
                                        if openSet[nk] then
                                            for i = 1, #open do
                                                if open[i].key == nk then
                                                    open[i] = newNode
                                                    break
                                                end
                                            end
                                        else
                                            open[#open + 1] = newNode
                                            openSet[nk] = true
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if not goalNode then return nil end

        local cells = {}
        local node = goalNode
        while node do
            cells[#cells + 1] = node
            node = node.parent
        end
        local raw = {}
        for i = #cells, 1, -1 do
            local c = cells[i]
            if #raw > 0 or c.gx ~= sx or c.gz ~= sz then
                raw[#raw + 1] = Vector3.new((c.gx + 0.5) * RAY_CELL, c.y + 2.6, (c.gz + 0.5) * RAY_CELL)
            end
        end
        if #raw == 0 then
            raw[1] = Vector3.new((gx + 0.5) * RAY_CELL, goalY + 2.6, (gz + 0.5) * RAY_CELL)
        end
        local lastRaw = raw[#raw]
        if lastRaw and (lastRaw - sub).Magnitude > 1.0 and Nav.segmentClear(lastRaw, sub) then
            raw[#raw + 1] = sub
        end

        local out = {}
        local cur = Vector3.new(startPos.X, startY + 2.6, startPos.Z)
        local i = 1
        while i <= #raw do
            local pick = i
            for j = #raw, i, -1 do
                if Nav.segmentClear(cur, raw[j]) then
                    pick = j
                    break
                end
            end
            out[#out + 1] = raw[pick]
            cur = raw[pick]
            i = pick + 1
        end
        if #out < 1 then return nil end
        return out
    end
    end)()

    Nav.walkTo = function(x, z, gy, label, tol, keep)
        local hrp = getHRP()
        if not hrp then return false end
        tol = tol or 3.2
        local expectY = (gy or (hrp.Position.Y - 2.6)) + 2.6
        pcall(function() setrobloxinput(true) end)
        Nav.onFoot = true
        walkingWithKeys = true
        lastMoveMode, lastMoveAt = label or "WASD walk", tick()
        local deadline = tick() + 55
        local lastProbe = 0
        local lastJump = 0
        local lastPos = hrp.Position
        local movingAt = tick()
        local climbBackUntil = 0
        local climbBackCool = 0
        local climbJumps = 0
        local rayStepUp = false
        local nextSteerAt = 0
        local ok = false

        while tick() < deadline do
            if not isOn() then break end
            if not rbxActive() then
                Nav.release()
                deadline = tick() + 55
                task.wait(0.25)
                continue
            end
            local cur = getHRP()
            if not cur or not isAlive() then break end
            local p = cur.Position
            lastMoveMode, lastMoveAt = label or "WASD walk", tick()
            local dx, dz = x - p.X, z - p.Z
            local hd = math.sqrt(dx * dx + dz * dz)
            if hd <= tol and math.abs(p.Y - expectY) <= 6 then
                ok = true
                break
            end

            local cam = Workspace.CurrentCamera
            local look = cam and cam.CFrame.LookVector or Vector3.new(0, 0, -1)
            local fx, fz = look.X, look.Z
            local fl = math.sqrt(fx * fx + fz * fz)
            if fl < 0.05 then fx, fz, fl = 0, -1, 1 end
            fx, fz = fx / fl, fz / fl
            local rx, rz = -fz, fx
            local ux, uz = 0, 0
            if hd > 0.05 then ux, uz = dx / hd, dz / hd end
            if tick() < climbBackUntil then ux, uz = -ux, -uz end

            local nowSteer = tick()
            if nowSteer >= nextSteerAt and hd > 0.05 then
                nextSteerAt = nowSteer + 0.18
                rayStepUp = Nav.stepAhead(p, ux, uz, 4.5)
                if not rayStepUp then
                    local sx, sz = Nav.steer(p, ux, uz, 12)
                    if sx and sz then ux, uz = sx, sz end
                    rayStepUp = Nav.stepAhead(p, ux, uz, 4.5)
                end
            end

            local fwdDot = ux * fx + uz * fz
            local rightDot = ux * rx + uz * rz
            local holdW, holdS = Nav.walkKeys[0x57] == true, Nav.walkKeys[0x53] == true
            local holdD, holdA = Nav.walkKeys[0x44] == true, Nav.walkKeys[0x41] == true
            local wantW = fwdDot > 0.4 or (holdW and fwdDot > 0.1)
            local wantS = fwdDot < -0.4 or (holdS and fwdDot < -0.1)
            local wantD = rightDot > 0.4 or (holdD and rightDot > 0.1)
            local wantA = rightDot < -0.4 or (holdA and rightDot < -0.1)
            if wantW and wantS then
                if fwdDot >= 0 then wantS = false else wantW = false end
            end
            if wantD and wantA then
                if rightDot >= 0 then wantA = false else wantD = false end
            end
            Nav.setKey(0x57, wantW)
            Nav.setKey(0x53, wantS)
            Nav.setKey(0x44, wantD)
            Nav.setKey(0x41, wantA)

            local now = tick()
            if now - lastProbe > 0.3 then
                lastProbe = now
                local moved = (p - lastPos).Magnitude > 1.0
                if moved then
                    lastPos = p
                    movingAt = now
                    climbJumps = 0
                end
                local stuck = (now - movingAt) > 0.85 and hd > tol + 1.5
                local vy, vx, vz = 0, 0, 0
                pcall(function()
                    local v = cur.AssemblyLinearVelocity
                    if v then vy, vx, vz = v.Y, v.X, v.Z end
                end)
                local grounded = math.abs(vy) < 12
                local hspd = math.sqrt(vx * vx + vz * vz)
                local rise = expectY - p.Y
                local needUp = rise > 3.5 and hd < 20

                if now >= climbBackUntil and grounded then
                    local wantJump = ((needUp or rayStepUp) and hspd < 5) or (stuck and rise <= 3.5)
                    if wantJump then
                        if climbJumps >= 3 and now > climbBackCool then
                            climbBackUntil = now + 0.3
                            climbBackCool = now + 2.6
                            climbJumps = 0
                            movingAt = now
                        elseif (now - lastJump) > ((needUp or rayStepUp) and 0.55 or 0.9) then
                            lastJump = now
                            climbJumps = climbJumps + 1
                            Nav.setKey(0x20, true)
                            task.wait(0.07)
                            Nav.setKey(0x20, false)
                        end
                    end
                end
            end
            task.wait(0.04)
        end

        if not keep then
            Nav.release()
            Nav.onFoot = false
            walkingWithKeys = false
        end
        return ok
    end

    Nav.pathFrom = function(fromKey, toKey)
        local dest = toKey and Nav.routes[toKey]
        if not dest or fromKey == toKey then return nil end
        local pts = {}
        local mergeAt = 0
        if fromKey then
            local frm = Nav.routes[fromKey]
            if not frm then return nil end
            local n = math.min(#frm, #dest)
            for i = 1, n do
                local a, b = frm[i], dest[i]
                if math.abs(a[1] - b[1]) < 2 and math.abs(a[3] - b[3]) < 2 then
                    mergeAt = i
                else
                    break
                end
            end
            for i = #frm, math.max(1, mergeAt), -1 do pts[#pts + 1] = frm[i] end
        else
            pts[#pts + 1] = dest[1]
            mergeAt = 1
        end
        for i = math.max(1, mergeAt + 1), #dest do
            local p = dest[i]
            local last = pts[#pts]
            if not last or math.abs(last[1] - p[1]) > 0.5 or math.abs(last[3] - p[3]) > 0.5 then
                pts[#pts + 1] = p
            end
        end
        if #pts < 1 or #pts > 90 then return nil end
        return pts
    end

    Nav.walkPath = function(pts, label)
        if not pts or #pts < 1 then return false end
        local readyUntil = tick() + 4
        while tick() < readyUntil and S.farm_on and FeaturesActive and not isOn() do
            task.wait(0.15)
        end
        if not isOn() then Nav.release(); return false end
        local t0 = tick()
        for i = 1, #pts do
            if not isOn() or not FeaturesActive then Nav.release(); return false end
            if tick() - t0 > 420 then Nav.release(); return false end
            local p = pts[i]
            if not Nav.walkTo(p[1], p[3], p[2], label or "Walk", 3.2, true) then
                local cur = getHRP()
                if not cur then Nav.release(); return false end
                local dx, dz = p[1] - cur.Position.X, p[3] - cur.Position.Z
                local hd = math.sqrt(dx * dx + dz * dz)
                local dy = math.abs(cur.Position.Y - (p[2] + 2.6))
                if hd > 20 or dy > 30 then
                    Nav.release()
                    return false
                end
            end
        end
        Nav.release()
        Nav.onFoot = false
        walkingWithKeys = false
        return true
    end

    Nav.respawnAtHive = function()
        Nav.release()
        restoreFacing()
        status = "Walk: waiting for Roblox focus"
        while S.farm_on and FeaturesActive and not rbxActive() do
            task.wait(0.2)
        end
        if not S.farm_on or not FeaturesActive then return nil end

        status = "Walk: resetting at hive"
        local oldChar = lp.Character
        local hum = getHum()
        local sawDead = false
        local healthWorked = false

        if hum then
            local ok = pcall(function() hum.Health = 0 end)
            if ok then healthWorked = true else hum = nil end
        end

        if healthWorked then
            local t0 = tick()
            while S.farm_on and FeaturesActive and tick() - t0 < 1.4 do
                local c = lp.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if (h and h.Health <= 0) or c ~= oldChar then
                    sawDead = true
                    break
                end
                task.wait(0.1)
            end
        end

        if not sawDead and S.farm_on and FeaturesActive then
            while S.farm_on and FeaturesActive and not rbxActive() do
                task.wait(0.2)
            end
            if S.farm_on and FeaturesActive then
                pcall(function()
                    if not rbxActive() then return end
                    setrobloxinput(true)
                    keypress(0x1B); task.wait(0.12); keyrelease(0x1B)
                    task.wait(0.55)
                    if not rbxActive() then return end
                    keypress(0x52); task.wait(0.12); keyrelease(0x52)
                    task.wait(0.55)
                    if not rbxActive() then return end
                    keypress(0x0D); task.wait(0.12); keyrelease(0x0D)
                end)
            end
        end

        local deadline = tick() + 16
        while S.farm_on and FeaturesActive and tick() < deadline do
            local c = lp.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if h and h.Health <= 0 then sawDead = true end
            if r and h and h.Health > 0 and (sawDead or c ~= oldChar) then
                task.wait(1.1)
                break
            end
            task.wait(0.2)
        end

        if not sawDead and lp.Character == oldChar then
            status = "Walk: reset failed"
            return nil
        end
        local humNow = getHum()
        if not humNow or humNow.Health <= 0 then
            status = "Walk: reset failed"
            return nil
        end
        local hrp = getHRP()
        if not hrp then return nil end
        local key, hd = Nav.hiveKeyAt(hrp.Position)
        if key and (hd or 999) <= 40 then return key end
        local h = autoDetectHiveInstant()
        if h and Nav.routes[h.Name] then return h.Name end
        return key
    end

    Nav.travelWalk = function(targetPos, toKey, label)
        if not toKey then return false end
        local hiveKey = Nav.respawnAtHive()
        if not hiveKey then
            status = "Walk: hive not found"
            return false
        end
        if not S.farm_on then return false end
        local pts = Nav.pathFrom(hiveKey, toKey)
        if not pts then
            status = "Walk: no route"
            return false
        end
        status = "Walk: " .. hiveKey .. " to " .. toKey
        local done = Nav.walkPath(pts, label or "Walk")
        if not done and isOn() then status = "Walk failed: " .. toKey end
        return done
    end

    Nav.rayFollow = function(pts, label)
        if not pts or #pts < 1 then return false end
        local deadline = tick() + 60
        for i = 1, #pts do
            if not isOn() or tick() > deadline then
                Nav.release()
                return false
            end
            local p = pts[i]
            local hrp = getHRP()
            if not hrp then
                Nav.release()
                return false
            end
            local dx, dz = p.X - hrp.Position.X, p.Z - hrp.Position.Z
            local hd = math.sqrt(dx * dx + dz * dz)
            if hd > 2.2 then
                local ok = Nav.walkTo(p.X, p.Z, p.Y - 2.6, label or "Ray path", 2.8, true)
                if not ok then
                    local cur = getHRP()
                    if not cur then
                        Nav.release()
                        return false
                    end
                    local ddx, ddz = p.X - cur.Position.X, p.Z - cur.Position.Z
                    if math.sqrt(ddx * ddx + ddz * ddz) > 7 then
                        Nav.release()
                        return false
                    end
                end
            end
        end
        return true
    end

    Nav.rayTravel = function(targetPos, label)
        if not targetPos or not isOn() then return false end
        Nav.release()
        Nav.onFoot = true
        walkingWithKeys = true
        lastMoveMode, lastMoveAt = label or "Ray path", tick()
        local deadline = tick() + 240
        local failures = 0
        local bestDist = nil
        local bestAt = tick()

        while isOn() and tick() < deadline do
            if not rbxActive() then
                Nav.release()
                task.wait(0.25)
                continue
            end
            local hrp = getHRP()
            if not hrp then break end
            local dx, dz = targetPos.X - hrp.Position.X, targetPos.Z - hrp.Position.Z
            local hd = math.sqrt(dx * dx + dz * dz)
            if hd <= 3.5 and math.abs(hrp.Position.Y - targetPos.Y) <= 10 then
                Nav.release()
                Nav.onFoot = false
                walkingWithKeys = false
                return true
            end
            if not bestDist or hd < bestDist - 1.0 then
                bestDist = hd
                bestAt = tick()
            elseif tick() - bestAt > 15 then
                status = "Ray path: no progress"
                break
            end
            local path = Nav.planRayPath(hrp.Position, targetPos)
            local ok = false
            if path and #path > 0 then
                status = "Ray path: " .. tostring(#path) .. " pts"
                ok = Nav.rayFollow(path, label)
            end
            if not ok then
                ok = Nav.walkTo(targetPos.X, targetPos.Z, targetPos.Y - 2.6, label or "Ray path", 3.2)
                if not ok then
                    failures = failures + 1
                    if failures >= 3 then break end
                    task.wait(0.2)
                else
                    failures = 0
                end
            else
                failures = 0
            end
            task.wait(0.05)
        end

        Nav.release()
        Nav.onFoot = false
        walkingWithKeys = false
        local hrp = getHRP()
        if hrp then
            local dx, dz = targetPos.X - hrp.Position.X, targetPos.Z - hrp.Position.Z
            if math.sqrt(dx * dx + dz * dz) <= 6 then return true end
        end
        return false
    end

    Nav.travelPath = function(targetPos, toKey, label)
        if not targetPos or not toKey then return false end
        local hiveKey = Nav.respawnAtHive()
        if not hiveKey then
            status = "Path: hive not found"
            return false
        end
        if not S.farm_on then return false end
        local pts = Nav.pathFrom(hiveKey, toKey)
        if not pts or #pts < 1 then
            status = "Path: no route"
            return Nav.rayTravel(targetPos, label or "Ray path")
        end
        local deadline = tick() + 420
        status = "Path: " .. hiveKey .. " to " .. toKey
        for i = 1, #pts do
            if not isOn() or tick() > deadline then
                Nav.release()
                return false
            end
            local p = pts[i]
            local dest = Vector3.new(p[1], p[2] + 2.6, p[3])
            if not Nav.rayTravel(dest, label or "Ray path") then
                local cur = getHRP()
                if not cur then
                    Nav.release()
                    return false
                end
                local dx, dz = dest.X - cur.Position.X, dest.Z - cur.Position.Z
                if math.sqrt(dx * dx + dz * dz) > 15 then
                    status = "Path failed: " .. toKey
                    Nav.release()
                    return false
                end
            end
        end
        Nav.release()
        Nav.onFoot = false
        walkingWithKeys = false
        return true
    end

    Nav.travel = function(targetPos, speed, thr, label)
        local hrp = getHRP()
        if not hrp or not targetPos then return false end
        local toKey = Nav.keyFor(targetPos)
        if not toKey then return false end
        local fromKey = nil
        for key in pairs(Nav.routes) do
            if Nav.inFieldName(key, hrp.Position, 8) then fromKey = key; break end
        end
        if not fromKey then
            local hk, hd = Nav.hiveKeyAt(hrp.Position)
            if hk and (hd or 999) < 40 then fromKey = hk end
        end
        if not fromKey and fromKey ~= toKey then
            local start = Nav.routes[toKey][1]
            local sp = Vector3.new(start[1], start[2], start[3])
            if (sp - hrp.Position).Magnitude >= 150 then
                fromKey = Nav.keyFor(hrp.Position)
            end
        end
        if fromKey == toKey then return false end
        local pts = Nav.pathFrom(fromKey, toKey)
        if not pts then return false end
        return Nav.walkPath(pts, label or "Walk")
    end

     
     
     
     
     
    Nav.go = function(targetPos, speed, thr, label)
        if not targetPos then return false end
        if not isOn() then return false end
        if S.travel_mode == "Tween" then
            return Nav.tweenTravel(targetPos, speed, thr, label or "Travel")
        end
        return Nav.nodeTravel(targetPos, label or "Travel", thr or 5)
    end

    local zoneNames = {
        "Dandelion Field", "Sunflower Field", "Mushroom Field", "Blue Flower Field",
        "Clover Field", "Spider Field", "Bamboo Field", "Strawberry Field",
        "Pineapple Patch", "Pumpkin Patch", "Cactus Field", "Pine Tree Forest",
        "Rose Field", "Stump Field", "Mountain Top Field", "Pepper Patch", "Coconut Field",
    }

    local FIELD_DATA = {
        ["Dandelion Field"]    = { Vector3.new(-31, 1, 220),    Vector3.new(143, 2, 72) },
        ["Sunflower Field"]    = { Vector3.new(-209, 1, 176),   Vector3.new(80, 2, 131) },
        ["Mushroom Field"]     = { Vector3.new(-90, 1, 111),    Vector3.new(128, 2, 91) },
        ["Blue Flower Field"]  = { Vector3.new(146, 2, 99),     Vector3.new(171, 2, 67) },
        ["Clover Field"]       = { Vector3.new(157, 31, 196),   Vector3.new(106, 2, 118) },
        ["Spider Field"]       = { Vector3.new(-44, 18, -14),   Vector3.new(112, 2, 106) },
        ["Bamboo Field"]       = { Vector3.new(132, 18, -26),   Vector3.new(156, 2, 74) },
        ["Strawberry Field"]   = { Vector3.new(-179, 18, -10),  Vector3.new(89, 2, 106) },
        ["Pineapple Patch"]    = { Vector3.new(256, 66, -208),  Vector3.new(130, 2, 91) },
        ["Pumpkin Patch"]      = { Vector3.new(-189, 65, -184), Vector3.new(135, 2, 68) },
        ["Cactus Field"]       = { Vector3.new(-189, 65, -102), Vector3.new(135, 2, 68) },
        ["Pine Tree Forest"]   = { Vector3.new(-329, 65, -188), Vector3.new(90, 2, 121) },
        ["Rose Field"]         = { Vector3.new(-328, 17, 129),  Vector3.new(123, 2, 82) },
        ["Stump Field"]        = { Vector3.new(424, 94, -175),  Vector3.new(110, 2, 113) },
        ["Mountain Top Field"] = { Vector3.new(77, 173, -166),  Vector3.new(97, 2, 110) },
        ["Pepper Patch"]       = { Vector3.new(-489, 120, 535), Vector3.new(82, 2, 110) },
        ["Coconut Field"]      = { Vector3.new(-255, 68, 469),  Vector3.new(120, 2, 84) },
    }

    local function fallbackField(name)
        local d = FIELD_DATA[name]
        if not d then return nil end
        return { Position = d[1], Size = d[2], Name = name, fallback = true }
    end

    local function getFieldFolder()
        return Workspace:FindFirstChild("FlowerZones")
            or Workspace:FindFirstChild("Fields")
            or Workspace:FindFirstChild("FieldZones")
    end
    pcall(function()
        local zones = getFieldFolder()
        if zones then
            local known = {}
            for _, n in ipairs(zoneNames) do known[n] = true end
            for _, z in ipairs(zones:GetChildren()) do
                if not known[z.Name] then insert(zoneNames, z.Name) end
            end
        end
    end)

    
    
    
    
    
    local function getField(name)
        local z = getFieldFolder()
        if not z or not name then return fallbackField(name) end
        local f = z:FindFirstChild(name)
        if not f then
            local want = string.lower(tostring(name))
            for _, c in ipairs(z:GetChildren()) do
                if string.lower(c.Name) == want then f = c; break end
            end
        end
        if not f then return fallbackField(name) end

        local cl = f.ClassName
        local base = nil
        if cl == "Part" or cl == "MeshPart" or cl == "UnionOperation"
            or cl == "WedgePart" or cl == "CornerWedgePart" then
            base = f
        end
        if base then
            local p = try(function() return base.Position end)
            local s = try(function() return base.Size end)
            if p and s and s.X > 1 and s.Z > 1 then return base end
            return fallbackField(name) or base
        end

        local cf, size = nil, nil
        pcall(function() cf, size = f:GetBoundingBox() end)
        if cf and size and size.X > 1 and size.Z > 1 then
            return { Position = cf.Position, Size = size, Name = f.Name, raw = f }
        end
        local bp = f.PrimaryPart or f:FindFirstChildWhichIsA("BasePart", true)
        if bp then
            local p = try(function() return bp.Position end)
            local s = try(function() return bp.Size end)
            if p and s and s.X > 1 and s.Z > 1 then
                return { Position = p, Size = s, Name = f.Name, raw = f }
            end
        end
        return fallbackField(name)
    end

    local function groundY(f) return f.Position.Y + f.Size.Y / 2 end

    local function inField(pos, f, m)
        local c, s = f.Position, f.Size
        return math.abs(pos.X - c.X) <= s.X / 2 + m
           and math.abs(pos.Z - c.Z) <= s.Z / 2 + m
           and math.abs(pos.Y - c.Y) <= 35
    end

    local function distToCenter(pos, f)
        return Vector3.new(pos.X - f.Position.X, 0, pos.Z - f.Position.Z).Magnitude
    end

     
     
     
     
     
    Nav.fieldStandPoint = function(f)
        if not f then return nil end

        local c, s = f.Position, f.Size
        local inset = math.max(6, math.min(s.X, s.Z) * 0.16)
        local loX, hiX = c.X - s.X / 2 + inset, c.X + s.X / 2 - inset
        local loZ, hiZ = c.Z - s.Z / 2 + inset, c.Z + s.Z / 2 - inset
        if loX > hiX then loX, hiX = c.X, c.X end
        if loZ > hiZ then loZ, hiZ = c.Z, c.Z end

        local hx, hz = c.X, c.Z
        local hrp = getHRP()
        if hrp then hx, hz = hrp.Position.X, hrp.Position.Z end

        return Vector3.new(math.clamp(hx, loX, hiX), groundY(f) + 2, math.clamp(hz, loZ, hiZ))
    end

    local function clampTarget(tgt, f, fm, cr)
        if fm == 1 then
            local c = f.Position
            local d = Vector3.new(tgt.X - c.X, 0, tgt.Z - c.Z)
            if d.Magnitude > cr then
                local dir = d.Unit
                return Vector3.new(c.X + dir.X * cr, tgt.Y, c.Z + dir.Z * cr)
            end
        elseif fm == 2 then
            local c, s = f.Position, f.Size
            local inset = cr or 6
            local hx = math.max(s.X / 2 - inset, 1)
            local hz = math.max(s.Z / 2 - inset, 1)
            return Vector3.new(
                clamp(tgt.X, c.X - hx, c.X + hx),
                tgt.Y,
                clamp(tgt.Z, c.Z - hz, c.Z + hz))
        end
        return tgt
    end

    
    
    
     
     
     
     
     
     
     
    Nav._wsKids, Nav._wsKidsAt = nil, 0
    Nav.workspaceKids = function()
        local now = tick()
        local cached = Nav._wsKids
        if cached and now - (Nav._wsKidsAt or 0) < 0.25 then return cached end
        local ok, list = pcall(function() return Workspace:GetChildren() end)
        if ok and type(list) == "table" then
            Nav._wsKids, Nav._wsKidsAt = list, now
            return list
        end
        return cached or {}
    end

    local _cBalloon, _dBalloon, _tBalloon = nil, nil, 0
    local function findClosestBalloon(field)
        local now = tick()
        if now - _tBalloon < 0.35 and (not _cBalloon or _cBalloon.Parent) then return _cBalloon, _dBalloon end
        _tBalloon = now

        local hrp = getHRP()
        if not hrp then return nil end
        local best, bestDist = nil, math.huge

        local function checkPart(part)
            if not part then return end
            local pos = getPartPos(part)
            if not pos then return end
            if not field or inField(pos, field, 35) or (pos - hrp.Position).Magnitude <= 85 then
                local d = (pos - hrp.Position).Magnitude
                if d < bestDist then bestDist = d; best = part end
            end
        end

        local function checkModel(mod)
            if not mod then return end
            local body = mod:FindFirstChild("BalloonBody")
                or mod:FindFirstChild("Balloon")
                or mod:FindFirstChild("Root")
                or mod.PrimaryPart
                or mod:FindFirstChildWhichIsA("BasePart")
            if body then checkPart(body) end
        end

        local balloons = Workspace:FindFirstChild("Balloons")
        if balloons then
            for _, b in ipairs(balloons:GetChildren()) do
                checkModel(b)
                local bp = partOf(b)
                if bp then checkPart(bp) end
                for _, child in ipairs(b:GetChildren()) do
                    checkModel(child)
                    local cp = partOf(child)
                    if cp then checkPart(cp) end
                end
            end
        end

        for _, b in ipairs(Nav.workspaceKids()) do
            if string.find(string.lower(b.Name), "balloon", 1, true) then
                checkModel(b)
                local bp = partOf(b)
                if bp then checkPart(bp) end
            end
        end

        _cBalloon, _dBalloon = best, bestDist
        return best, bestDist
    end

     
     
     
     
     
     
    Nav.hiveBalloons = function(center, radius)
        local hrp = getHRP()
        local root = Workspace:FindFirstChild("Balloons")
        local hive = root and root:FindFirstChild("HiveBalloons")
        if not hive then return 0, 0 end

         
         
         
        local pos = center or (hrp and hrp.Position)
        if not pos then return 0, 0 end
        radius = radius or 60
        local count, pollen = 0, 0
        for _, obj in ipairs(hive:GetChildren()) do
             
             
            local body = obj:FindFirstChild("BalloonBody")
                or obj:FindFirstChildWhichIsA("BasePart", true)
            local p = body and try(function() return body.Position end)
            if p and (p - pos).Magnitude <= radius then
                count = count + 1
                 
                 
                local best = 0
                for _, d in ipairs(obj:GetDescendants()) do
                    if d.ClassName == "TextLabel" then
                         
                         
                        local n = tonumber((string.gsub(tostring(d.Text), "[^%d]", "")))
                        if n and n > best then best = n end
                    end
                end
                pollen = pollen + best
            end
        end
        return count, pollen
    end

    local _cBubble, _dBubble, _tBubble = nil, nil, 0
    local function findNearestBubble(field, pos)
        local now = tick()
        if now - _tBubble < 0.35 and (not _cBubble or _cBubble.Parent) then return _cBubble, _dBubble end
        _tBubble = now

        local best, bestDist = nil, math.huge
        local function checkObj(obj)
            if not obj then return end
            local part = partOf(obj)
            if part then
                local p = getPartPos(part)
                if not p then return end
                if not field or inField(p, field, 25) or (p - pos).Magnitude <= 65 then
                    local d = (p - pos).Magnitude
                    if d < bestDist then bestDist = d; best = part end
                end
            end
        end

        local containers = {
            Workspace:FindFirstChild("Particles"),
            Workspace:FindFirstChild("Effects"),
            Workspace:FindFirstChild("Collectibles"),
            Workspace:FindFirstChild("Debris"),
            Workspace,
        }

        pcall(function()
            for _, cont in ipairs(containers) do
                if cont then
                    for _, obj in ipairs(cont:GetChildren()) do
                        local nm = string.lower(obj.Name)
                        if string.find(nm, "bubble", 1, true) or string.find(nm, "water", 1, true) then
                            checkObj(obj)
                        end
                    end
                end
            end
        end)

        _cBubble, _dBubble = best, bestDist
        return best, bestDist
    end

    local _cCloud, _tCloud = nil, 0
    local function findNearestCloud(field)
        local now = tick()
        if now - _tCloud < 0.5 and (not _cCloud or _cCloud.Parent) then return _cCloud end
        _tCloud = now

        local best, bestDist = nil, math.huge
        local hrp = getHRP()
        if not hrp then return nil end
        pcall(function()
            for _, obj in ipairs(Nav.workspaceKids()) do
                if string.find(string.lower(obj.Name), "cloud", 1, true) then
                    local part = partOf(obj)
                    local p = part and getPartPos(part)
                    if p and inField(p, field, 10) then
                        local d = (p - hrp.Position).Magnitude
                        if d < bestDist then bestDist = d; best = part end
                    end
                end
            end
        end)
        _cCloud = best
        return best
    end

    local _cFlame, _tFlame = nil, 0
    local function findNearestFlame(field)
        local now = tick()
        if now - _tFlame < 0.5 and (not _cFlame or _cFlame.Parent) then return _cFlame end
        _tFlame = now

        local best, bestDist = nil, math.huge
        local hrp = getHRP()
        if not hrp then return nil end
        pcall(function()
            for _, obj in ipairs(Nav.workspaceKids()) do
                if string.find(string.lower(obj.Name), "flame", 1, true) then
                    local part = partOf(obj)
                    local p = part and getPartPos(part)
                    if p and inField(p, field, 6) then
                        local d = (p - hrp.Position).Magnitude
                        if d < bestDist then bestDist = d; best = part end
                    end
                end
            end
        end)
        _cFlame = best
        return best
    end

    
    
    
    
    
    
    local function findNearestSpecial()
        local tokens = {}
        if S.catch_coconuts then tokens[#tokens + 1] = "coconut" end
        if S.catch_stars    then tokens[#tokens + 1] = "star" end
        if S.farm_sprouts   then tokens[#tokens + 1] = "sprout" end
        if #tokens == 0 then return nil end

        local hrp = getHRP()
        if not hrp then return nil end
        local best, bestDist = nil, 260

        local function consider(obj)
            if not obj then return end
            local nm = string.lower(obj.Name or "")
            local hit = false
            for _, t in ipairs(tokens) do
                if string.find(nm, t, 1, true) then hit = true; break end
            end
            if not hit then return end

            local part = partOf(obj)
            local p = part and getPartPos(part)
            if p then
                local d = (p - hrp.Position).Magnitude
                if d < bestDist then bestDist = d; best = part end
            end
        end

        pcall(function()
            for _, obj in ipairs(Nav.workspaceKids()) do consider(obj) end
            for _, fname in ipairs({ "Collectibles", "Effects", "Particles", "Debris" }) do
                local f = Workspace:FindFirstChild(fname)
                if f then
                    for _, obj in ipairs(f:GetChildren()) do consider(obj) end
                end
            end
        end)
        return best
    end

    
    local function findNearestToken(maxDist)
        local hrp = getHRP()
        local folder = Workspace:FindFirstChild("Collectibles")
        if not hrp or not folder then return nil end
        local best, bestDist = nil, maxDist or 60
        for _, tok in ipairs(folder:GetChildren()) do
            local p = getPartPos(tok)
            if p then
                local d = (p - hrp.Position).Magnitude
                if d < bestDist then bestDist = d; best = p end
            end
        end
        return best
    end

    
    
    
    local function findNearestTokenCluster(maxDist, maxN, field)
        local hrp = getHRP()
        local folder = Workspace:FindFirstChild("Collectibles")
        if not hrp or not folder then return nil end
        local hrpPos = hrp.Position
        local near = {}
        for _, tok in ipairs(folder:GetChildren()) do
            local p = getPartPos(tok)
            if p and (not field or inField(p, field, 12)) then
                local d = (p - hrpPos).Magnitude
                if d <= (maxDist or 120) then
                    near[#near + 1] = { p = p, d = d }
                end
            end
        end
        if #near == 0 then return nil end
        table.sort(near, function(a, b) return a.d < b.d end)
        
        
        
        local anchor = near[1].p
        local cap = maxN or 10
        local sx, sy, sz, n = 0, 0, 0, 0
        for i = 1, #near do
            local p = near[i].p
            local dx, dz = p.X - anchor.X, p.Z - anchor.Z
            if dx * dx + dz * dz <= 256 then
                sx = sx + p.X; sy = sy + p.Y; sz = sz + p.Z
                n = n + 1
                if n >= cap then break end
            end
        end
        return Vector3.new(sx / n, sy / n, sz / n)
    end

    
    
    
     
     
    local _capP, _capC, _capT = 0, 0, 0
    local _capLabel = nil
    local function parseCapText(t)
        if type(t) ~= "string" then return nil, nil end
        local a, b = t:match("([%d,]+%s*[KkMmBbTt]?)%s*/%s*([%d,]+%s*[KkMmBbTt]?)")
        if not a or not b then return nil, nil end
        local function parseNum(s)
            s = s:gsub(",", ""):gsub("%s+", "")
            local mults = { K = 1e3, M = 1e6, B = 1e9, T = 1e12 }
            local suf = s:match("([KkMmBbTt])$")
            local mult = suf and (mults[suf:upper()] or 1) or 1
            if suf then s = s:sub(1, #s - 1) end
            local n = tonumber(s)
            return n and (n * mult) or nil
        end
        return parseNum(a), parseNum(b)
    end

    
    
    
    
    local function getPollenAndCap()
        local now = tick()
        if now - _capT < 0.5 then return _capP, _capC end
        _capT = now

        local p, c = _capP, _capC

        
        if _capLabel then
            if _capLabel.Parent then
                local pp, cc = parseCapText(safeText(_capLabel))
                
                
                if pp and cc and cc > 0 and pp <= cc then
                    _capP, _capC = pp, cc
                    return pp, cc
                end
            else
                _capLabel = nil
            end
        end

        
        local done = false
        pcall(function()
            local core = lp:FindFirstChild("CoreStats")
            if core then
                local po = core:FindFirstChild("Pollen")
                local ca = core:FindFirstChild("Capacity")
                local pv = po and tonumber(po.Value)
                local cv = ca and tonumber(ca.Value)
                 
                 
                if pv and cv and cv > 0 and pv >= 0 then
                    p, c, done = pv, cv, true
                end
            end
        end)

        
        
        
        
        
        if not done then
            pcall(function()
                local pg = lp:FindFirstChildOfClass("PlayerGui")
                if not pg then return end
                local best, bestScore = nil, 0
                for _, o in ipairs(pg:GetDescendants()) do
                    if o.ClassName == "TextLabel" then
                        local t = safeText(o)
                        if #t > 0 and #t <= 80 then
                            local pp, cc = parseCapText(t)
                            if pp and cc and cc > 0 and pp <= cc then
                                local sc = 0
                                
                                if string.find(t, ",", 1, true) then sc = sc + 2 end
                                local cur, depth = o, 0
                                while cur and depth < 6 do
                                    if string.find(string.lower(tostring(cur.Name or "")), "pollen", 1, true) then
                                        sc = sc + 5
                                        break
                                    end
                                    cur = cur.Parent
                                    depth = depth + 1
                                end
                                if sc > bestScore then best, bestScore = o, sc end
                            end
                        end
                    end
                end
                if best and bestScore >= 2 then
                    local pp, cc = parseCapText(safeText(best))
                    if pp and cc then
                        p, c = pp, cc
                        _capLabel = best
                    end
                end
            end)
        end

        _capP, _capC = p, c
        return p, c
    end

    
    
    
    local lastHybridCollect = 0

     
     
    S.dig.clickPoint = function()
        local cam = try(function() return Workspace.CurrentCamera end)
        local vp  = (cam and cam.ViewportSize) or Vector2.new(1280, 720)
        local center = Vector2.new(floor(vp.X * 0.5), floor(vp.Y * 0.55))
        local hrp = getHRP()
        if cam and hrp then
            local look = try(function() return hrp.CFrame.LookVector end)
            if look then
                local flat = Vector3.new(look.X, 0, look.Z)
                if flat.Magnitude > 0.01 then
                    local ahead = hrp.Position + flat.Unit * 9 - Vector3.new(0, 1.5, 0)
                    local ok, sp, onScreen = pcall(function() return cam:WorldToScreenPoint(ahead) end)
                    if ok and sp and onScreen ~= false and sp.Z and sp.Z > 0 then
                         
                         
                         
                        if sp.X > vp.X * 0.15 and sp.X < vp.X * 0.85
                            and sp.Y > vp.Y * 0.2 and sp.Y < vp.Y * 0.8 then
                            return Vector2.new(floor(sp.X), floor(sp.Y))
                        end
                    end
                end
            end
        end
        return center
    end

     
     
     
    S.dig.click = function(pt)
        local cx, cy = floor(pt.X), floor(pt.Y)
        pcall(function() if type(mousemoveabs) == "function" then mousemoveabs(cx, cy) end end)

        local done = false
        pcall(function()
            if type(mouse1press) == "function" and type(mouse1release) == "function" then
                mouse1press()
                task.wait(0.02)
                mouse1release()
                done = true
            end
        end)
        if not done then
            pcall(function()
                if type(mouse1click) == "function" then
                    mouse1click(cx, cy)
                    done = true
                end
            end)
        end
        if not done then
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                if vim then
                    vim:SendMouseButtonEvent(cx, cy, 0, true, game, 0)
                    vim:SendMouseButtonEvent(cx, cy, 0, false, game, 0)
                end
            end)
        end
        S.dig.clicks = (S.dig.clicks or 0) + 1
    end

    local function autoDigCursorFree()
        if not S.dig_tool then return end
         
         
        if S.dig.converting then return end

        if S.hybrid then
             
             
            local now = tick()
            if now - lastHybridCollect < 0.18 then return end
            lastHybridCollect = now
            fireEvent("ToolCollect")
            return
        end

         
         
         
        if S.dig.uiOpen or not rbxActive() then return end

        local char = lp and lp.Character
        if not char then return end

        local tool = char:FindFirstChildOfClass("Tool")
        local hum  = getHum()
        local bp   = lp:FindFirstChild("Backpack")

         
         
         
         
        local equippedIsScoop = tool ~= nil
            and string.find(string.lower(tostring(tool.Name)), "scoop", 1, true) ~= nil
        if (not equippedIsScoop) and bp and hum then
            local scoop = nil
            for _, obj in ipairs(bp:GetChildren()) do
                if obj.ClassName == "Tool" and string.find(string.lower(tostring(obj.Name)), "scoop", 1, true) then
                    scoop = obj
                    break
                end
            end
            if scoop then
                pcall(function() hum:EquipTool(scoop) end)
                tool = scoop
            elseif not tool then
                local any = bp:FindFirstChildOfClass("Tool")
                if any then pcall(function() hum:EquipTool(any) end) end
            end
        end

        local now = tick()
        if now - S.dig.last < S.dig.interval then return end
        S.dig.last = now

         
         
        if tool then pcall(function() tool:Activate() end) end
        S.dig.click(S.dig.clickPoint())
    end

    
    
    
    
    
    
    
    local lastCombatHit = 0
    local function combatHit()
        if not isOn() then return end
        if S.hybrid then
            local now = tick()
            if now - lastCombatHit < 0.16 then return end
            lastCombatHit = now
            fireEvent("ToolCollect")
            return
        end

        local char = lp and lp.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        local hum  = getHum()
        if not tool then
            local bp = lp:FindFirstChild("Backpack")
            if bp and hum then
                local bpTool = bp:FindFirstChildOfClass("Tool")
                if bpTool then pcall(function() hum:EquipTool(bpTool) end) end
            end
            return
        end
        pcall(function() tool:Activate() end)
    end

    
    
    
    
    
    
    
    local function catchSpecialForceTween()
        local sp = findNearestSpecial()
        if not sp then return false end
        local spPos = getPartPos(sp)
        if not spPos then return false end

        status = "Force tween: " .. tostring(sp.Name)
        local fspeed = math.max(900, tonumber(S.force_tween) or 1400)
        moveToVelocity(spPos, fspeed, 2.5, "Force tween", true)

        local dl = tick() + 12
        while isOn() and tick() < dl do
            local alive = false
            pcall(function() alive = sp.Parent ~= nil end)
            if not alive then break end
            local cur = getPartPos(sp)
            local hrp = getHRP()
            if cur and hrp and (cur - hrp.Position).Magnitude > 10 then
                moveToVelocity(cur, fspeed, 2.5, "Force tween", true)
            end
            combatHit()
            task.wait(0.08)
        end

        local f = getField(S.field)
        if f then
            local c = f.Position
            Nav.go(Vector3.new(c.X, groundY(f) + 2, c.Z), S.glide_speed, 3, "Return to field")
        end
        return true
    end

    
    
    
    local walkWithKeys

    local NECTAR_TYPES = { "Comforting", "Motivating", "Satisfying", "Refreshing", "Invigorating" }

    local NECTAR_FIELDS = {
        ["Comforting"]   = { "Dandelion Field", "Bamboo Field", "Pine Tree Forest" },
        ["Motivating"]   = { "Mushroom Field", "Spider Field", "Stump Field", "Rose Field" },
        ["Satisfying"]   = { "Sunflower Field", "Pineapple Patch", "Pumpkin Patch" },
        ["Refreshing"]   = { "Blue Flower Field", "Strawberry Field", "Coconut Field" },
        ["Invigorating"] = { "Clover Field", "Cactus Field", "Mountain Top Field", "Pepper Patch" },
    }

     
     
     
     
    local PLANTER_NAMES = {
        "Plastic Planter", "Candy Planter", "Red Clay Planter", "Blue Clay Planter",
        "Tacky Planter", "Pesticide Planter", "Heat-Treated Planter",
        "Hydroponic Planter", "Petal Planter", "Plenty Planter",
        "Paper Planter", "Sticker Planter",
    }

    local PLANTER_BONUS = {
        ["Plastic Planter"]      = {},
        ["Candy Planter"]        = { Motivating = 1.2 },
        ["Red Clay Planter"]     = { Satisfying = 1.2, Invigorating = 1.2 },
        ["Blue Clay Planter"]    = { Comforting = 1.2, Refreshing = 1.2 },
        ["Tacky Planter"]        = { Comforting = 1.25, Satisfying = 1.25 },
        ["Pesticide Planter"]    = { Motivating = 1.3, Satisfying = 1.3 },
        ["Heat-Treated Planter"] = { Motivating = 1.4, Invigorating = 1.4 },
        ["Hydroponic Planter"]   = { Comforting = 1.4, Refreshing = 1.4 },
        ["Petal Planter"]        = { Comforting = 1.5, Satisfying = 1.5 },
        ["Plenty Planter"]       = {
            Comforting = 1.5, Motivating = 1.5, Satisfying = 1.5, Refreshing = 1.5, Invigorating = 1.5,
        },
        ["Paper Planter"]        = {},
        ["Sticker Planter"]      = {},
    }

    local N = {
        status = "Off",
        activeLabel = "0/3",
        harvested = {},
        blacklist = {},
        placeCooldown = {},
        lastPlace = 0,
        cycle = 0,
        signature = "",
        harvestCooldown = {},
        placed = {},
        planterGrace = 60,
        owned = nil,
    }

    local function refreshOwnedPlanters()
        local found = {}
        local containers = {}
        local bp = lp:FindFirstChildOfClass("Backpack")
        if bp then containers[#containers + 1] = bp end
        local char = lp.Character
        if char then containers[#containers + 1] = char end
        for _, cont in ipairs(containers) do
            for _, t in ipairs(cont:GetChildren()) do
                if t.ClassName == "Tool" then
                    local tn = string.lower(t.Name)
                    for _, p in ipairs(PLANTER_NAMES) do
                        if string.find(tn, string.lower(p), 1, true) then
                            found[p] = true
                            break
                        end
                    end
                end
            end
        end
        N.owned = found
        return found
    end

    local function planterOwned(name)
         
         
         
         
        if N.owned == nil then return true end
        local any = false
        for _ in pairs(N.owned) do any = true; break end
        if not any then return true end
        return N.owned[name] == true
    end

    local planterRemote = nil

    local function planterNameFromText(t)
        if type(t) ~= "string" then return nil end
        for i = 1, #PLANTER_NAMES do
            local n = PLANTER_NAMES[i]
            if t:sub(1, #n) == n then return n end
        end
        return nil
    end

    local function readPlanterGrowth(part, text)
        local gv = part:FindFirstChild("GrowthPercent")
        local v = nil
        if gv then
            local ok, x = pcall(function() return gv.Value end)
            if ok then v = tonumber(x) end
        end
        if not v and type(text) == "string" then
            local pct = text:match("%(([%d%.]+)%%%)")
            pct = tonumber(pct)
            if pct then v = pct / 100 end
        end
        if v and v > 1.5 then v = v / 100 end
        return v or 0
    end

    local function firstBasePart(m)
        for _, ch in ipairs(m:GetChildren()) do
            local cl = ch.ClassName
            if cl == "Part" or cl == "MeshPart" then return ch end
        end
        return nil
    end         
     
     
     
    Nav._planterCache, Nav._planterCacheAt = nil, 0
    local function scanPlanters(force)
            local nowScan = tick()
            local cache = Nav._planterCache
            if not force and cache and nowScan - (Nav._planterCacheAt or 0) < 0.35 then
                return cache
            end
            local out = {}
            local folder = Workspace:FindFirstChild("Planters")
            local kids = {}
            if folder then
                local okf, fkids = pcall(function() return folder:GetChildren() end)
                if okf and type(fkids) == "table" then
                    for _, c in ipairs(fkids) do kids[#kids + 1] = c end
                end
            end
            for _, c in ipairs(Nav.workspaceKids()) do kids[#kids + 1] = c end

            local bulbs = {}
            for _, c in ipairs(kids) do
             
             
             
             
            if c.ClassName == "MeshPart" and c.Name == "PlanterBulb" then
                local gv = c:FindFirstChild("GrowthPercent")
                local gui = nil
                for _, ch in ipairs(c:GetChildren()) do
                    if ch.ClassName == "BillboardGui" then gui = ch; break end
                end
                local tl = gui and gui:FindFirstChild("TextLabel")
                if gv or tl then
                    local text = ""
                    if tl then
                        local ok, tx = pcall(function() return tl.Text end)
                        if ok and type(tx) == "string" then text = tx end
                    end
                    local okp, pos = pcall(function() return c.Position end)
                     
                     
                     
                     
                     
                     
                    local mine = c:FindFirstChild("Gui Attach") ~= nil
                    bulbs[#bulbs + 1] = {
                        part = c,
                        name = planterNameFromText(text),
                        text = text,
                        growth = readPlanterGrowth(c, text),
                        pos = okp and pos or nil,
                        mine = mine,
                    }
                end
            end
        end

        for _, m in ipairs(kids) do
            if m.ClassName == "Model" and PLANTER_BONUS[m.Name] ~= nil then
                local soil = m:FindFirstChild("Soil") or firstBasePart(m)
                local pos = nil
                if soil then
                    local ok, p = pcall(function() return soil.Position end)
                    if ok then pos = p end
                end
                local best, bd = nil, 30
                if pos then
                    for _, b in ipairs(bulbs) do
                        if b.pos then
                            local dx, dz = b.pos.X - pos.X, b.pos.Z - pos.Z
                            local d = math.sqrt(dx * dx + dz * dz)
                            if d < bd and (not b.name or b.name == m.Name) then
                                bd, best = d, b
                            end
                        end
                    end
                end
                local fieldName = nil
                if pos then
                    for _, fn in ipairs(zoneNames) do
                        local f = getField(fn)
                        if f and inField(pos, f, 12) then fieldName = fn; break end
                    end
                end
                out[#out + 1] = {
                    key = m.Name .. "|" .. tostring(fieldName),
                    model = m,
                    name = m.Name,
                    pos = pos,
                    field = fieldName,
                    growth = best and best.growth or 0,
                    bulb = best and best.part or nil,
                    bulbPos = best and best.pos or nil,
                    mine = best and best.mine == true or false,
                }
            end
        end
        Nav._planterCache, Nav._planterCacheAt = out, nowScan
        return out
    end

    local function nectarForField(fieldName)
        for _, n in ipairs(NECTAR_TYPES) do
            for _, f in ipairs(NECTAR_FIELDS[n]) do
                if f == fieldName then return n end
            end
        end
        return nil
    end

    local function selectedNectars()
        local out, seen = {}, {}
        for i = 1, 5 do
            local n = S.nectar_slots and S.nectar_slots[i]
            if n and n ~= "None" and NECTAR_FIELDS[n] and not seen[n] then
                seen[n] = true
                out[#out + 1] = n
            end
        end
        return out
    end

    local function planterBonus(planter, nectar)
        local b = PLANTER_BONUS[planter]
        return (b and b[nectar]) or 1
    end

    local function choosePlanterFor(nectar, used)
        local best, bestScore = nil, 0
        for _, p in ipairs(PLANTER_NAMES) do
            local cooling = N.placeCooldown and N.placeCooldown[p] and tick() < N.placeCooldown[p]
            if S.nectar_planters[p] and not N.blacklist[p] and not cooling and not used[p] and planterOwned(p) then
                local s = planterBonus(p, nectar)
                if s > bestScore then
                    best, bestScore = p, s
                elseif s == bestScore and best and p ~= "Plenty Planter" and best == "Plenty Planter" then
                    best = p
                end
            end
        end
        return best, bestScore
    end

    local function chooseNectarField(nectar, usedFields)
         
         
         
         
        local hrp = getHRP()
        local here = hrp and hrp.Position or nil
        local best, bestDist = nil, math.huge

        for _, fn in ipairs(NECTAR_FIELDS[nectar] or {}) do
            if not usedFields[fn] then
                local f = getField(fn)
                if f then
                    local d = 0
                    if here and f.Position then
                        local dx, dz = f.Position.X - here.X, f.Position.Z - here.Z
                        d = math.sqrt(dx * dx + dz * dz)
                    end
                    if d < bestDist then best, bestDist = fn, d end
                end
            end
        end

        return best
    end

    local function fireRemote(ev, arg)
        if not ev then return false end
        local ok
        if ev.ClassName == "RemoteFunction" then
            ok = pcall(function() ev:InvokeServer(arg) end)
        elseif arg ~= nil then
            ok = pcall(function() ev:FireServer(arg) end)
        else
            ok = pcall(function() ev:FireServer() end)
        end
        return ok
    end

    local function fireRemoteConfirm(ev, arg)
        if not ev then return false end
        local ok
        if ev.ClassName == "RemoteFunction" then
            ok = pcall(function() ev:InvokeServer(arg, true) end)
        else
            ok = pcall(function() ev:FireServer(arg, true) end)
        end
        return ok
    end

     
     
     
    Nav.planterPotCount = function(name)
        local n = 0
        for _, p in ipairs(scanPlanters(true)) do
            if p.name == name then n = n + 1 end
        end
        return n
    end

    local function attemptPlanterRemote(remoteName, planter, beforeCount)
        local ev = getRemote(remoteName)
        if not ev then return false end
         
         
         
         
        local args = { { Name = planter }, planter }
        for _, arg in ipairs(args) do
            fireRemote(ev, arg)
            local dl = tick() + 1.8
            while tick() < dl do
                task.wait(0.15)
                if Nav.planterPotCount(planter) > beforeCount then return true end
            end
        end
        return false
    end

    local function tryPlacePlanter(planter)
        local beforeCount = Nav.planterPotCount(planter)
        local order
        if planterRemote then
            order = { planterRemote }
        else
            order = { "PlayerActivesCommand", "ItemUseCommand" }
        end
        for _, r in ipairs(order) do
            if attemptPlanterRemote(r, planter, beforeCount) then
                planterRemote = r
                return true
            end
        end
        return false
    end

     
     
     
     
     
    local function myPlanters(force)
        local out = {}
        for _, p in ipairs(scanPlanters(force)) do
            if p.mine then out[#out + 1] = p end
        end
        return out
    end

    local function placePlanterFor(nectar)
        local active = myPlanters()
        local usedFields, usedPlanters = {}, {}
        for _, p in ipairs(active) do
            if p.field then usedFields[p.field] = true end
            usedPlanters[p.name] = true
        end

        local planter = choosePlanterFor(nectar, usedPlanters)
        if not planter then
            N.status = "No selected planter left for " .. nectar
            return nil
        end

        local fieldName = chooseNectarField(nectar, usedFields)
        if not fieldName then
            N.status = "No free field for " .. nectar
            return nil
        end

        local f = getField(fieldName)
        if not f then return nil end

        local target = Nav.fieldStandPoint(f)
            or Vector3.new(f.Position.X, groundY(f) + 2, f.Position.Z)

        local start = getHRP()
        local inside = start ~= nil and inField(start.Position, f, 0)

        if not inside then
            N.status = "Placing " .. planter .. " in " .. fieldName
            Nav.go(target, S.glide_speed, 4, "Planter travel")

            local t0 = tick()
            while tick() - t0 < 4 do
                local hrp = getHRP()
                if hrp and inField(hrp.Position, f, 0) then break end
                task.wait(0.1)
            end

             
             
             
            local here0 = getHRP()
            if not here0 or not inField(here0.Position, f, 0) then
                Nav.walk(target, { arrive = 5, timeout = 14 })
            end
        else
             
             
            N.status = "Placing " .. planter .. " in " .. fieldName
        end

        local here = getHRP()
        if not here or not inField(here.Position, f, 10) then
            N.status = "Could not reach " .. fieldName
            N.placeCooldown[planter] = tick() + 15
            return nil
        end

        if tryPlacePlanter(planter) then
            N.lastPlace = tick()
            N.placed[planter .. "|" .. tostring(fieldName)] = tick()
            N.status = "Planted " .. planter .. " in " .. fieldName
            return { planter = planter, field = fieldName, nectar = nectar }
        end

         
         
         
        if getRemote("ItemUseCommand") or getRemote("PlayerActivesCommand") then
            N.placeCooldown[planter] = tick() + 30
            N.status = "Place failed: " .. planter
        else
            N.status = "Game remotes missing - rejoin"
        end
        return nil
    end

     
     
     
     
     
    Nav.ensureInput = function()
        if Nav._inputReady then return end
        Nav._inputReady = true
        if type(setrobloxinput) == "function" then pcall(setrobloxinput, true) end
    end

     
    Nav.questionBoxOpen = function()
        local okPg, pg = pcall(function() return lp:FindFirstChildOfClass("PlayerGui") end)
        if not okPg or not pg then return false end
        local sg = pg:FindFirstChild("ScreenGui")
        local qbox = sg and sg:FindFirstChild("QuestionBox")
        local box = qbox and qbox:FindFirstChild("Box")
        local tx = box and box:FindFirstChild("TextBox")
        return string.find(tx and safeText(tx) or "", "lanter", 1, true) ~= nil
    end

    local function answerHarvestPrompt()
        local okPg, pg = pcall(function() return lp:FindFirstChildOfClass("PlayerGui") end)
        if not okPg or not pg then return false end
        local sg = pg:FindFirstChild("ScreenGui")
        local qbox = sg and sg:FindFirstChild("QuestionBox")
        if not qbox then return false end
        local box = qbox:FindFirstChild("Box")
        local tx = box and box:FindFirstChild("TextBox")
        local txt = tx and safeText(tx) or ""
        if not string.find(txt, "lanter", 1, true) then return false end
        local yes = box and box:FindFirstChild("YesButton")
        if not yes then return false end
        Nav.ensureInput()
        local clicked = false
        for _ = 1, 2 do
            local okp, ap = pcall(function() return yes.AbsolutePosition end)
            local oks, asz = pcall(function() return yes.AbsoluteSize end)
            if not okp or not ap then break end
            local w = (oks and asz and asz.X) or 120
            local h = (oks and asz and asz.Y) or 40
            pcall(function()
                mousemoveabs(math.floor(ap.X + w * 0.5), math.floor(ap.Y + h * 0.5))
                task.wait(0.03)
                mouse1press()
                task.wait(0.06)
                mouse1release()
                clicked = true
            end)
            task.wait(0.15)
             
             
            if safeText(tx) == "" then break end
        end
        return clicked
    end

     
     
     
     
     
     
     
     
     
     
     
     
    N.pressActivate = function()
         
         
         
        if type(setrobloxinput) == "function" then pcall(setrobloxinput, true) end
        for _ = 1, 2 do
            pcall(function()
                keypress(0x45)
                task.wait(0.05)
                keyrelease(0x45)
            end)
            task.wait(0.35)
        end
    end

    local function findActivateButton()
        local pg = lp:FindFirstChildOfClass("PlayerGui")
        if not pg then return nil end
        for _, sg in ipairs(pg:GetChildren()) do
            local ab = sg:FindFirstChild("ActivateButton")
            if ab then return ab end
            local ok, list = pcall(function() return sg:GetDescendants() end)
            if ok and type(list) == "table" then
                for _, d in ipairs(list) do
                    if d.Name == "ActivateButton" then return d end
                end
            end
        end
        return nil
    end

     
     
     
    local function clickGui(btn)
        if not btn then return false end
        Nav.ensureInput()
        local ok, ap = pcall(function() return btn.AbsolutePosition end)
        if not ok or not ap then return false end
        local oks, asz = pcall(function() return btn.AbsoluteSize end)
        local w = (oks and asz and asz.X) or 60
        local h = (oks and asz and asz.Y) or 24
        local clicked = false
        pcall(function()
            mousemoveabs(math.floor(ap.X + w * 0.5), math.floor(ap.Y + h * 0.5))
            task.wait(0.03)
            mouse1press()
            task.wait(0.06)
            mouse1release()
            clicked = true
        end)
        return clicked
    end

    local function planterGone(p, before)
        if not p then return true end
         
         
         
         
         
         
        if p.model then
            local ok, par = pcall(function() return p.model.Parent end)
            if ok then
                if par == nil then return true end
                return false
            end
        end
         
         
        if p.pos then
            local okList, list = pcall(function() return scanPlanters(true) end)
            if okList and type(list) == "table" then
                for _, q in ipairs(list) do
                    if q.mine ~= false and q.pos and (q.pos - p.pos).Magnitude < 7 then
                        return false
                    end
                end
                return true
            end
        end
        return false
    end

    local function waitPlanterGone(p, before, seconds)
         
         
         
        local deadline = tick() + (seconds or 3)
        while tick() < deadline do
            if planterGone(p, before) then return true end
            answerHarvestPrompt()
            if p.model then Nav.firePromptOn(p.model) end
            task.wait(0.12)
        end
        answerHarvestPrompt()
        if p.model then Nav.firePromptOn(p.model) end
        return planterGone(p, before)
    end

    local function touchCollectibles(field)
        local folder = Workspace:FindFirstChild("Collectibles")
        local hrp = getHRP()
        if not folder or not hrp then return 0 end
        local n = 0
        for _, tok in ipairs(folder:GetChildren()) do
            local tp = getPartPos(tok)
            if tp and (tp - hrp.Position).Magnitude <= 120 and (not field or inField(tp, field, 20)) then
                if Nav.touchToken(tok) then n = n + 1 end
            end
        end
        return n
    end

    local function collectPlanterTokens(field, seconds)
        local deadline = tick() + (seconds or 7)
        while isOn() and tick() < deadline do
            touchCollectibles(field)
            local target = findNearestTokenCluster(180, 12, field)
            if not target then target = findNearestToken(140) end
            if target then
                if field then target = clampTarget(target, field, 2, 6) end
                local hrp = getHRP()
                local y = field and (groundY(field) + 2) or (hrp and hrp.Position.Y or target.Y)
                local left = deadline - tick()
                if left > 0 then
                     
                     
                     
                    Nav.walk(Vector3.new(target.X, y, target.Z), {
                        arrive = 2, timeout = math.min(4.5, left),
                    })
                    touchCollectibles(field)
                    autoDigCursorFree()
                end
            else
                task.wait(0.2)
            end
            task.wait(0.1)
        end
        touchCollectibles(field)
    end

    local function placedAt(p)
        if not p or not p.name then return nil end
        if p.key and N.placed[p.key] then return N.placed[p.key] end
        local prefix = p.name .. "|"
        for k, v in pairs(N.placed) do
            if type(k) == "string" and k:sub(1, #prefix) == prefix then return v end
        end
        return nil
    end

    local function clearPlaced(p)
        if not p or not p.name then return end
        local prefix = p.name .. "|"
        for k in pairs(N.placed) do
            if type(k) == "string" and k:sub(1, #prefix) == prefix then N.placed[k] = nil end
        end
    end

    local function finishHarvest(p)
        N.harvestCooldown[p.name] = nil
        clearPlaced(p)
        N.status = "Harvested " .. tostring(p.name)
        local field = p.field and getField(p.field) or nil
        if not field and p.pos then
            for _, fn in ipairs(zoneNames) do
                local f = getField(fn)
                if f and inField(p.pos, f, 12) then field = f; break end
            end
        end
         
         
        collectPlanterTokens(field, 5)
        if isOn() then N.status = "Planter tokens collected" end
        return true
    end

     
     
     
     
     
     
    N.FULL_GROWTH = 0.999

    local function shouldHarvest(p)
        if not p or not p.model then return false end
        local growth = p.growth or 0
        local at = placedAt(p)
        if at and tick() - at < N.planterGrace then
            return growth >= N.FULL_GROWTH
        end
         
         
        if S.nectar_mode == "Every X hours" then
            if not at then return growth >= N.FULL_GROWTH end
            return (tick() - at) >= (tonumber(S.nectar_collect_every) or 1) * 3600
                and growth >= N.FULL_GROWTH
        end
        local pct = (tonumber(S.nectar_collect_pct) or 100) / 100
        if pct < N.FULL_GROWTH then pct = N.FULL_GROWTH end
        return growth >= pct
    end

     
     
     
    local function nearestPlanterIsMine()
        local hrp = getHRP()
        if not hrp then return false end
        local hx, hz = hrp.Position.X, hrp.Position.Z
        local bestD, bestMine = math.huge, false
        for _, q in ipairs(scanPlanters()) do
            local pos = q.bulbPos or q.pos
            if pos then
                local dx, dz = pos.X - hx, pos.Z - hz
                local d = dx * dx + dz * dz
                if d < bestD then bestD, bestMine = d, (q.mine == true) end
            end
        end
        return bestMine
    end

     
     
     
     
     
    Nav.planterActorIds = function(force)
        local nowIds = tick()
        local cached = Nav._planterIds
        if not force and cached and (nowIds - (Nav._planterIdsAt or 0)) < 180 then return cached end
        if Nav._planterIdsBusy then return cached or {} end
        if type(getgc) ~= "function" or type(readtbl) ~= "function" then return cached or {} end

        Nav._planterIdsBusy = true
        Nav._planterIdsAt = nowIds
        local out = {}
        pcall(function()
            for index, entry in ipairs(getgc("ActorID")) do
                 
                 
                if index % 8 == 0 then task.wait() end
                if entry.type == "number" and (tonumber(entry.value) or -1) > 0 then
                    local info = { id = tonumber(entry.value) }
                    for offset = -640, 640, 32 do
                        local okR, rows = pcall(readtbl, entry.tbl + offset, 1)
                        if okR and type(rows) == "table" and type(rows[1]) == "table" then
                            local item = rows[1]
                            local key = item.key ~= nil and tostring(item.key) or nil
                            if key == "Type" then
                                info.type = tostring(item.value)
                            elseif key == "GrowthPercent" then
                                info.growth = tonumber(item.value)
                            elseif key == "IsMine" then
                                info.mine = item.value == true
                            elseif key == "Gui" then
                                info.gui = item.value ~= nil
                            end
                        end
                    end
                    if info.mine or info.gui then out[#out + 1] = info end
                end
            end
        end)
        Nav._planterIds, Nav._planterIdsAt, Nav._planterIdsBusy = out, nowIds, false
        return out
    end

    local function harvestPlanter(p)
        if not p or not p.model then return false end
         
         
         
        if not p.mine then
             
             
             
             
            local refreshed = nil
            for _, q in ipairs(scanPlanters(true)) do
                if q.mine and p.pos and q.pos and (q.pos - p.pos).Magnitude < 8 then
                    refreshed = q
                    break
                end
            end
            if not refreshed then
                N.status = "Skipped " .. tostring(p.name) .. " (not yours)"
                return false
            end
            p = refreshed
        end
        if N.harvestCooldown[p.name] and tick() < N.harvestCooldown[p.name] then return false end
        local before = #scanPlanters()
        local target = p.pos
        if not target then
            local soil = p.model:FindFirstChild("Soil") or firstBasePart(p.model)
            if soil then
                local ok, sp = pcall(function() return soil.Position end)
                if ok then target = sp end
            end
        end
        N.status = "Collecting " .. tostring(p.name)

         
         
         
        if target then
            Nav.go(Vector3.new(target.X, target.Y + 3, target.Z), S.glide_speed, 3, "Collect travel")
            local arrive = tick() + 4
            while isOn() and tick() < arrive do
                local h = getHRP()
                if h and (Vector3.new(h.Position.X, target.Y, h.Position.Z) - target).Magnitude <= 3 then break end
                task.wait(0.1)
            end
             
             
             
             
            local h = getHRP()
            if h and (Vector3.new(h.Position.X, target.Y, h.Position.Z) - target).Magnitude > 3 then
                Nav.walk(Vector3.new(target.X, target.Y + 1.5, target.Z), { arrive = 3, timeout = 8 })
            end
        end

        if not nearestPlanterIsMine() then
             
             
            local target2 = p.pos
            if target2 then
                Nav.walk(Vector3.new(target2.X, target2.Y + 1.5, target2.Z), { arrive = 1.5, timeout = 4 })
            end
            if not nearestPlanterIsMine() then
                N.status = "Another player's planter is closer - skipped"
                N.harvestCooldown[p.name] = tick() + 5
                return false
            end
        end

         
         
        if (p.growth or 0) < N.FULL_GROWTH then
            N.status = string.format("Growing %s (%d%%)", tostring(p.name), math.floor((p.growth or 0) * 100))
            N.harvestCooldown[p.name] = tick() + 10
            return false
        end

        local deadline = tick() + 8
        local collected = false
        local attempts = 0

        while isOn() and not collected and tick() < deadline and attempts < 4 do
            attempts = attempts + 1
             
             
             
             
            local ids = Nav.planterActorIds(false)
            if #ids > 0 then
                 
                 
                 
                 
                for index = 1, #ids do
                    local countBefore = #(scanPlanters(true))
                    fireEvent("PlanterModelCollect", ids[index].id)
                    task.wait(0.45)
                    if #(scanPlanters(true)) < countBefore then
                        table.remove(ids, index)
                        break
                    end
                end
            else
                 
                 
                 
                N.pressActivate()
                task.wait(0.2)
            end
            if Nav.questionBoxOpen() then
                 
                 
                N.status = "Harvest prompt open - click Yes/No once"
                break
            end
            collected = planterGone(p, before)
        end

         
         
         
        if not collected and (tick() - (Nav._planterIdsAt or 0)) > 150 then
            N.status = "Reading planter ids"
            local ids = Nav.planterActorIds(true)
            if #ids > 0 then
                 
                for index = 1, #ids do
                    local countBefore = #(scanPlanters(true))
                    fireEvent("PlanterModelCollect", ids[index].id)
                    task.wait(0.5)
                    if #(scanPlanters(true)) < countBefore then
                        table.remove(ids, index)
                        break
                    end
                end
                collected = planterGone(p, before)
            end
        end

        if not collected then
            N.harvestCooldown[p.name] = tick() + 8
            N.status = "Collect failed: " .. tostring(p.name)
            return false
        end

         
         
        N.status = "Collected " .. tostring(p.name) .. " - collecting rewards"
        local holdField = p.field and getField(p.field) or nil
        local holdUntil = tick() + 5
        while isOn() and tick() < holdUntil do
            answerHarvestPrompt()
            local h = getHRP()
            if h and p.pos then
                local d = (Vector3.new(h.Position.X, 0, h.Position.Z) - Vector3.new(p.pos.X, 0, p.pos.Z)).Magnitude
                if d > 26 then break end
            end
            if holdField then touchCollectibles(holdField) end
             
             
             
            local tok = findNearestToken(140)
            local tp = tok and getPartPos(tok)
            if tp and h then
                local dx, dz = tp.X - h.Position.X, tp.Z - h.Position.Z
                if math.sqrt(dx * dx + dz * dz) > 3 then
                    Nav.walk(Vector3.new(tp.X, h.Position.Y, tp.Z), { arrive = 2, timeout = 3 })
                    touchCollectibles(holdField)
                end
            end
            autoDigCursorFree()
            task.wait(0.2)
        end
        return finishHarvest(p)
    end

    local function nectarStep()
         
         
         
        if not S.nectar_farm then return nil end
        if not S.hybrid then
            N.status = "Nectar needs Hybrid input"
            return nil
        end
        if not isOn() then N.status = "Auto farm off"; return nil end

         
         
         
         
        if not N.collectedAll then
            local existing = myPlanters()
            if #existing > 0 then
                N.status = "Collecting " .. tostring(#existing) .. " planter(s)"
                 
                 
                 
                 
                 
                local done = 0
                for _, p in ipairs(existing) do
                    if not isOn() or done >= 5 then break end
                    done = done + 1
                    harvestPlanter(p)
                end
            end
            N.collectedAll = true
        end

        local list = selectedNectars()
        if #list == 0 then N.status = "Select a nectar"; return nil end

        local chosenCount = 0
        for _, p in ipairs(PLANTER_NAMES) do
            if S.nectar_planters[p] == true then chosenCount = chosenCount + 1 end
        end
        if chosenCount == 0 then
            N.status = "Select planters first"
            return nil
        end

        refreshOwnedPlanters()
        local ownedCount = 0
        local anyOwned = false
        for _ in pairs(N.owned or {}) do anyOwned = true; break end
        for _, p in ipairs(PLANTER_NAMES) do
            if S.nectar_planters[p] and planterOwned(p) then ownedCount = ownedCount + 1 end
        end
         
         
        if ownedCount == 0 and anyOwned then
            N.status = "Put planters in your backpack"
            return nil
        end

        local sig = table.concat(list, ",")
        if N.signature ~= sig then
            N.signature = sig
            N.harvested = {}
            N.status = "Priorities changed"
        end

        local active = myPlanters()
        local function refreshLabels()
            local labels = {}
            for _, p in ipairs(active) do labels[#labels + 1] = p.name end
            N.activeLabel = tostring(#active) .. "/3 " .. table.concat(labels, ", ")
        end
        refreshLabels()

        for _, p in ipairs(active) do
            if shouldHarvest(p) then
                if harvestPlanter(p) then
                    local n = p.field and nectarForField(p.field)
                    if n then N.harvested[n] = true end
                end
                if not isOn() then return nil end
            end
        end

        active = myPlanters()
        refreshLabels()

        local activeFields, activeNectars = {}, {}
        for _, p in ipairs(active) do
            if p.field then
                activeFields[p.field] = true
                local n = nectarForField(p.field)
                if n and not activeNectars[n] then activeNectars[n] = p end
            end
        end

        local pollen, cap = getPollenAndCap()
        if pollen and cap and cap > 0 and pollen >= cap * (S.full_pct / 100) then
            N.status = "Pollen full - converting first"
            return nil
        end

        if not remotesReady() then
            N.status = "Game remotes missing - rejoin"
            return nil
        end

        local allDone = true
        for _, n in ipairs(list) do
            if not N.harvested[n] then allDone = false; break end
        end
        if allDone and #active == 0 then
            if S.nectar_repeat then
                N.harvested = {}
                N.cycle = N.cycle + 1
                N.status = "Nectar cycle " .. N.cycle
            else
                S.nectar_farm = false
                N.status = "Nectar complete"
                return nil
            end
        end

         
         
         
         
         
        local want = math.min(#list, 3)
        if #active >= want then
        else
            for _, n in ipairs(list) do
                if #active >= want then break end
                if not activeNectars[n] and not N.harvested[n] then
                    local placed = placePlanterFor(n)
                    if placed then
                        local pf = getField(placed.field)
                        if pf then collectPlanterTokens(pf, 7) end
                    end
                    if not isOn() then return nil end
                    active = myPlanters()
                    refreshLabels()
                    activeFields, activeNectars = {}, {}
                    for _, q in ipairs(active) do
                        if q.field then
                            activeFields[q.field] = true
                            local qn = nectarForField(q.field)
                            if qn and not activeNectars[qn] then activeNectars[qn] = q end
                        end
                    end
                end
            end
        end

         
         
         
        if S.nectar_extra == true and #active < 3 then
            local extras = 0
            while #active < 3 and extras < 3 do
                extras = extras + 1
                local usedFields = {}
                for _, q in ipairs(active) do
                    if q.field then usedFields[q.field] = true end
                end
                 
                 
                 
                 
                 
                local pick, repeatNectar = nil, nil
                for _, nn in ipairs(list) do
                    if chooseNectarField(nn, usedFields) then
                        if repeatNectar == nil then repeatNectar = nn end
                        if not activeNectars[nn] and not N.harvested[nn] then
                            pick = nn
                            break
                        end
                    end
                end
                pick = pick or repeatNectar
                if not pick then break end
                if not placePlanterFor(pick) then break end
                task.wait(0.5)
                active = myPlanters()
                refreshLabels()
                activeFields, activeNectars = {}, {}
                for _, q in ipairs(active) do
                    if q.field then
                        activeFields[q.field] = true
                        local qn = nectarForField(q.field)
                        if qn and not activeNectars[qn] then activeNectars[qn] = q end
                    end
                end
            end
        end

         
         
         
        local growing = 0
        for _, _ in pairs(activeNectars) do growing = growing + 1 end
        N.status = "Planters: " .. tostring(growing) .. "/" .. tostring(want) .. " growing; farming " .. tostring(S.field)
        return nil
    end

    local function nectarBestLabel()
        local list = selectedNectars()
        local n = list[1]
        if not n then return "Select a nectar" end
        local p, score = choosePlanterFor(n, {})
        if not p then return "No planter selected" end
        return n .. " -> " .. p .. " (x" .. string.format("%.2f", score) .. ")"
    end

    
    
    
    
    
    
    local SPRINK_GADGET_WORDS = { "sprinkler", "saturator", "drencher", "soaker", "gusher" }
    local function sprinklerModels()
        local out = {}
        local function scan(cont, depth)
            if not cont then return end
            for _, m in ipairs(cont:GetChildren()) do
                local nl = string.lower(m.Name)
                local hit = false
                for _, w in ipairs(SPRINK_GADGET_WORDS) do
                    if string.find(nl, w, 1, true) then hit = true break end
                end
                if hit then
                    out[#out + 1] = m
                elseif depth > 0 then
                    scan(m, depth - 1)
                end
            end
        end
        scan(Workspace:FindFirstChild("Gadgets"), 0)
        scan(Workspace, 0)
        scan(Workspace:FindFirstChild("Honeycombs"), 1)
        return out
    end

    local function sprinklerSnapshot()
        local out = {}
        for _, m in ipairs(sprinklerModels()) do
            local part = try(function() return m:FindFirstChildWhichIsA("BasePart", true) end)
            local p = part and try(function() return part.Position end) or nil
            if p then
                out[#out + 1] = m.Name .. "@" .. math.floor(p.X) .. "," .. math.floor(p.Y) .. "," .. math.floor(p.Z)
            else
                out[#out + 1] = m.Name .. "@?"
            end
        end
        table.sort(out)
        return table.concat(out, "|")
    end

    local sprinkNextTry = 0
    local lastSprinkTier = nil

    local function tierFromName(name)
        local n = string.lower(tostring(name or ""))
        if string.find(n, "supreme", 1, true) or string.find(n, "saturator", 1, true) then return "Supreme" end
        if string.find(n, "diamond", 1, true) or string.find(n, "drencher", 1, true) then return "Diamond" end
        if string.find(n, "gold", 1, true) or string.find(n, "gusher", 1, true) then return "Gold" end
        if string.find(n, "silver", 1, true) or string.find(n, "soaker", 1, true) then return "Silver" end
        if string.find(n, "basic", 1, true) or string.find(n, "sprinkler", 1, true) then return "Basic" end
        return nil
    end

    local function detectSprinklerTier(maxDist)
        local hrp = getHRP()
        local me = hrp and try(function() return hrp.Position end) or nil
        local best, bd = nil, (maxDist or 25)
        for _, m in ipairs(sprinklerModels()) do
            local t = tierFromName(m.Name)
            if t then
                local part = try(function() return m:FindFirstChildWhichIsA("BasePart", true) end)
                local p = part and try(function() return part.Position end) or nil
                if me and p then
                    local d = (p - me).Magnitude
                    if d < bd then bd = d; best = t end
                elseif not me and not best then
                    best = t
                end
            end
        end
        return best
    end

    local function jumpForSprinkler(strength)
        local hrp = getHRP()
        if not hrp then return false end
        local v = try(function() return hrp.AssemblyLinearVelocity end)
            or try(function() return hrp.Velocity end) or Vector3.new(0, 0, 0)
        local y0 = hrp.Position.Y
        local up = strength or 55
        pcall(function()
            hrp.AssemblyLinearVelocity = Vector3.new(v.X, up, v.Z)
            hrp.Velocity = Vector3.new(v.X, up, v.Z)
        end)
        local t0 = tick()
        while tick() - t0 < 0.5 do
            task.wait(0.03)
            local h = getHRP()
            if not h then return false end
            if h.Position.Y - y0 >= 4 then
                
                task.wait(0.12)
                return true
            end
        end
        return false
    end

    local function hybridPlaceSprinklers()
        if tick() < sprinkNextTry then return false end
        if not isOn() then return false end

        local cmd = getRemote("PlayerActivesCommand")
        if not cmd then
            sprinkNextTry = tick() + 4
            return false
        end

        local tier = detectSprinklerTier() or lastSprinkTier
        local planned = tier and (SPRINK_REPS[tier] or 1) or 1
        local placedCount = 0
        sprinklerBusy = true
        task.wait(0.7)

        local function fire()
            local before = sprinklerSnapshot()
            local ok = pcall(function() cmd:FireServer({ Name = "Sprinkler Builder" }) end)
            if not ok then return false end
            local dl = tick() + 1.8
            while tick() < dl do
                task.wait(0.15)
                if sprinklerSnapshot() ~= before then
                    local t = detectSprinklerTier()
                    if t then
                        lastSprinkTier = t
                        tier = t
                        planned = SPRINK_REPS[t] or 1
                    end
                    return true
                end
            end
            if tier and (SPRINK_REPS[tier] or 0) == 1 and detectSprinklerTier() == tier then
                return true
            end
            return false
        end

        local okAll, errAll = pcall(function()
            local i = 0
            while i < planned and placedCount < 8 do
                if not isOn() then break end
                i = i + 1
                local needJump = (i > 1) or (planned > 1 and tier ~= nil)
                if needJump then
                    if not jumpForSprinkler() then
                        task.wait(0.5)
                        jumpForSprinkler()
                    end
                end
                local ok = fire()
                if not ok and i == 1 then
                    
                    
                    local t = detectSprinklerTier(14)
                    if t then
                        lastSprinkTier = t
                        tier = t
                        planned = SPRINK_REPS[t] or 1
                        ok = true
                    else
                        task.wait(0.3)
                        jumpForSprinkler(70)
                        ok = fire()
                    end
                elseif not ok then
                    task.wait(0.3)
                    jumpForSprinkler(75)
                    ok = fire()
                end
                if not ok then break end
                placedCount = placedCount + 1
                if not tier then
                    local t = detectSprinklerTier()
                    if t then
                        lastSprinkTier = t
                        tier = t
                        planned = SPRINK_REPS[t] or 1
                    end
                end
                if i < planned then
                    task.wait(0.85)
                end
            end
        end)

        if placedCount > 0 then task.wait(0.65) end
        sprinklerBusy = false
        if not okAll then warn("[sprink] " .. tostring(errAll)) end

        if placedCount == 0 then
            sprinkNextTry = tick() + 8
            return false
        end
        sprinkNextTry = 0
        return true
    end

    
    
    
    
    
    
    local WALK_KEY = { W = 0x57, A = 0x41, S = 0x53, D = 0x44 }
    local walkKeysHeld = {}

    local function releaseWalkKeys()
        for code in pairs(walkKeysHeld) do
            pcall(function() keyrelease(code) end)
        end
        walkKeysHeld = {}
    end

    local function setWalkKey(code, want)
        if want and not walkKeysHeld[code] then
            walkKeysHeld[code] = true
            pcall(function() keypress(code) end)
        elseif not want and walkKeysHeld[code] then
            walkKeysHeld[code] = nil
            pcall(function() keyrelease(code) end)
        end
    end

     
     
     
     
     
     
     
    local function humanoidAirborne()
        local hum = getHum()
        if not hum then return true end
        if Nav._humProbe == nil then
            local okState = pcall(function() return hum:GetState() end)
            local okFloor, floor = pcall(function() return hum.FloorMaterial end)
            Nav._humProbe = { state = okState, floor = (okFloor and floor ~= nil) }
        end
        if Nav._humProbe.state then
            local ok, state = pcall(function() return hum:GetState() end)
            if ok and state ~= nil then
                local n = tostring(state)
                if string.find(n, "Freefall", 1, true) or string.find(n, "Jumping", 1, true) then
                    return true
                end
            end
        end
        if Nav._humProbe.floor then
            local okf, floor = pcall(function() return hum.FloorMaterial end)
            if okf and floor ~= nil then
                local okm, air = pcall(function() return Enum.Material.Air end)
                if okm and air ~= nil then return floor == air end
            end
        end
        return false
    end

    Nav._walkKeysImpl = function(targetPos, opts)
        if not targetPos or not isAlive() then return false end
        local hrp = getHRP()
        if not hrp then return false end
        opts = opts or {}
        local arrive  = opts.arrive  or 6
        local timeout = opts.timeout or 16

        local hum = getHum()
        if not hum then return false end

        pcall(function() setrobloxinput(true) end)
        walkingWithKeys = true
        lastMoveMode, lastMoveAt = "WASD walk", tick()
        local start      = tick()
        local lastDig    = 0
        local lastPos    = hrp.Position
        local stuckSince = start
        local jumps      = 0
        local lastHop    = 0
        local reached    = false
        local cam        = Workspace.CurrentCamera

        while tick() - start < timeout do
            if not isOn() then break end
            local curHrp = getHRP()
            if not curHrp or not isAlive() then break end
            if not cam or not cam.Parent then cam = Workspace.CurrentCamera end

            local pos  = curHrp.Position
            local flat = Vector3.new(targetPos.X - pos.X, 0, targetPos.Z - pos.Z)
            local dist = flat.Magnitude
            if dist <= arrive then
                reached = true
                break
            end

             
             
             

            local look = cam and cam.CFrame.LookVector or Vector3.new(0, 0, -1)
            local fx, fz = look.X, look.Z
            local fl = math.sqrt(fx * fx + fz * fz)
            if fl < 0.05 then fx, fz, fl = 0, -1, 1 end
            fx, fz = fx / fl, fz / fl
            local rx, rz = -fz, fx
            local ux, uz = 0, 0
            if dist > 0.05 then ux, uz = flat.X / dist, flat.Z / dist end
            local fwdDot = ux * fx + uz * fz
            local rightDot = ux * rx + uz * rz
            setWalkKey(WALK_KEY.W, fwdDot > 0.35)
            setWalkKey(WALK_KEY.S, fwdDot < -0.35)
            setWalkKey(WALK_KEY.D, rightDot > 0.35)
            setWalkKey(WALK_KEY.A, rightDot < -0.35)

            local now = tick()
            lastMoveMode, lastMoveAt = "WASD walk", now

            if now - lastDig > 0.5 then
                lastDig = now
                autoDigCursorFree()
            end

            if (pos - lastPos).Magnitude < 0.25 then
                local stuckFor = now - stuckSince
                if stuckFor > 4.0 then break end
                if stuckFor > 0.6 + jumps * 0.8 and jumps < 4 and not humanoidAirborne() then
                     
                    jumps = jumps + 1
                    pcall(function()
                        keypress(0x20)
                        task.wait(0.06)
                        keyrelease(0x20)
                    end)
                end
            else
                stuckSince = now
                lastPos = pos
                jumps = 0
            end

            task.wait(0.08)
        end

        releaseWalkKeys()
        walkingWithKeys = false
        return reached
    end

     
     
     
     
    walkWithKeys = function(targetPos, opts)
        local ok, res = pcall(Nav._walkKeysImpl, targetPos, opts)
        releaseWalkKeys()
        walkingWithKeys = false
        if not ok then
            status = "Keyboard walk: " .. tostring(res)
            return false
        end
        return res == true
    end
     
    ;(function()  
     
     
     
     
     
    local OFF_MOVE_DIR   = 0x134
    local OFF_MOVE_POINT = 0x158
    local OFF_TARGET_POINT = 0x140
     
     
     
     
     
     
    local OFF_WALK_DIR   = 0x14C
    local OFF_WALKSPEED  = 0x1C4
     
     
     
     
    local OFF_WALKSPEED_CHECK = 0x39C
     
     
     
     
     
    local OFF_JUMP       = 0x1D0

    local MemWalk = { on = false, dirX = 0, dirZ = 0, target = nil, conns = {}, wdAt = 0 }

     
     
     
     
     
     
     
    local ESCAPE_STEPS = { 50, 100, 150, 180, -150, -100, -50 }

    local function memBase()
        local hum = getHum()
        local base = hum and hum.Address
        if type(base) ~= "number" or base <= 0 then return nil end
        return base
    end

     
     
     
    local MEM_WRITE = nil
    local function memWriter()
        if MEM_WRITE ~= nil then return MEM_WRITE or nil end
        MEM_WRITE = false
        if type(memory_write) == "function" then
            MEM_WRITE = function(addr, value) memory_write("float", addr, value) end
        elseif type(write_float) == "function" then
            MEM_WRITE = function(addr, value) write_float(addr, value) end
        elseif type(memory_write_float) == "function" then
            MEM_WRITE = function(addr, value) memory_write_float(addr, value) end
        elseif type(write_f32) == "function" then
            MEM_WRITE = function(addr, value) write_f32(addr, value) end
        elseif type(memory) == "table" and type(memory.write_float) == "function" then
            MEM_WRITE = function(addr, value) memory.write_float(addr, value) end
        elseif type(memory) == "table" and type(memory.write) == "function" then
            MEM_WRITE = function(addr, value) memory.write("float", addr, value) end
        end
        return MEM_WRITE or nil
    end

    local function memReady()
        return memWriter() ~= nil and memBase() ~= nil
    end

     
     
     
     
     
     
     
     
     
    local SpeedWrite = { on = false, value = 0, thread = nil, gen = 0, restore = nil }
    local function readWalkSpeed(addr)
        if type(memory_read) ~= "function" then return nil end
        local ok, v = pcall(function() return memory_read("float", addr) end)
        if ok and type(v) == "number" and v > 0 and v < 500 then return v end
        return nil
    end
    local function writeWalkSpeed(v)
        if type(v) ~= "number" or v < 16 then return end
        local base = memBase()
        local write = memWriter()
        if not base or not write then return end
        pcall(function()
            write(base + OFF_WALKSPEED, v)
            write(base + OFF_WALKSPEED_CHECK, v)
        end)
    end

    local function startSpeedWrite(v)
        local speed = tonumber(v) or 0
        if speed > 0 and speed < 16 then speed = 16 end
        if speed > 100 then speed = 100 end
        SpeedWrite.value = speed
        if SpeedWrite.on then return end
        local base = memBase()
        SpeedWrite.restore = base and {
            readWalkSpeed(base + OFF_WALKSPEED) or 16,
            readWalkSpeed(base + OFF_WALKSPEED_CHECK) or 16,
        } or { 16, 16 }
        SpeedWrite.on = true
        SpeedWrite.gen = SpeedWrite.gen + 1
        local myGen = SpeedWrite.gen
        SpeedWrite.thread = task.spawn(function()
            while SpeedWrite.on and SpeedWrite.gen == myGen do
                writeWalkSpeed(SpeedWrite.value)
                task.wait(0.1)
            end
            if SpeedWrite.gen == myGen then
                SpeedWrite.thread = nil
                 
                 
                local base2 = memBase()
                local write2 = memWriter()
                local restore = SpeedWrite.restore
                if base2 and write2 and restore then
                    pcall(function()
                        write2(base2 + OFF_WALKSPEED, restore[1])
                        write2(base2 + OFF_WALKSPEED_CHECK, restore[2])
                    end)
                end
            end
        end)
    end

    local function stopSpeedWrite()
        SpeedWrite.on = false
    end

     
     
    Nav.stopSpeedWrite = stopSpeedWrite
    Nav.setSpeedValue = function(v)
        local n = tonumber(v) or 0
        if n > 0 and n < 16 then n = 16 end
        if n > 100 then n = 100 end
        SpeedWrite.value = n
    end

     
     
     
     
    local function later(seconds, fn)
        local thread = type(task) == "table" and task.spawn or spawn
        pcall(function()
            thread(function()
                local waitFn = type(task) == "table" and task.wait or wait
                pcall(waitFn, seconds)
                fn()
            end)
        end)
    end

     
     
     
     
    local InputBridge = false
    local function inputBridge()
        if InputBridge then return end
        InputBridge = true
        if type(setrobloxinput) == "function" then pcall(setrobloxinput, true) end
    end

     
     
     
     
     
     
     
    local MEM_WRITE_BYTE = nil
    local function memByteWriter()
        if MEM_WRITE_BYTE ~= nil then return MEM_WRITE_BYTE or nil end
        MEM_WRITE_BYTE = false
        if type(memory_write) == "function" then
            MEM_WRITE_BYTE = function(addr, value) memory_write("byte", addr, value) end
        elseif type(write_byte) == "function" then
            MEM_WRITE_BYTE = function(addr, value) write_byte(addr, value) end
        elseif type(memory_write_byte) == "function" then
            MEM_WRITE_BYTE = function(addr, value) memory_write_byte(addr, value) end
        elseif type(memory) == "table" and type(memory.write_byte) == "function" then
            MEM_WRITE_BYTE = function(addr, value) memory.write_byte(addr, value) end
        end
        return MEM_WRITE_BYTE or nil
    end

     
     
     
     
     
     
    local function jumpTap()
        local base = memBase()
        local wbyte = base and memByteWriter() or nil
        if not wbyte then return end

        pcall(function() wbyte(base + OFF_JUMP, 1) end)
         
         
         
        later(0.06, function()
            local again = memBase()
            if again then pcall(function() wbyte(again + OFF_JUMP, 0) end) end
        end)
    end

    local lastJumpAt = 0
    local function jumpNow()
        local now = tick()
         
         
         
        if now - lastJumpAt < 0.7 then return end
         
         
         
        if humanoidAirborne() then return end
         
         
        local base = memBase()
        if base and type(memory_read) == "function" then
            local ok, flag = pcall(function() return memory_read("byte", base + OFF_JUMP) end)
            if ok and flag == 1 then return end
        end
        lastJumpAt = now
        jumpTap()
    end
    Nav.jumpNow = jumpNow

     
     
     
     
     
     
     
     
     
     
    local function memWritePointNow()
        local base, write = MemWalk.base, MemWalk.write
        write(base + OFF_MOVE_POINT, MemWalk.tx)
        write(base + OFF_MOVE_POINT + 4, MemWalk.ty)
        write(base + OFF_MOVE_POINT + 8, MemWalk.tz)
    end

    local function memWriteDirNow()
        local base, write = MemWalk.base, MemWalk.write
        write(base + OFF_MOVE_DIR, MemWalk.dirX)
        write(base + OFF_MOVE_DIR + 4, 0)
        write(base + OFF_MOVE_DIR + 8, MemWalk.dirZ)
    end

     
     
     
     
    local function memWriteWalkDirNow()
        local base, write = MemWalk.base, MemWalk.write
        write(base + OFF_WALK_DIR, MemWalk.dirX)
        write(base + OFF_WALK_DIR + 4, 0)
        write(base + OFF_WALK_DIR + 8, MemWalk.dirZ)
    end
    local function memGuardWalkDir() pcall(memWriteWalkDirNow) end

    local function memRefreshWalkDir(now)
        if (now - (MemWalk.wdAt or 0)) < 0.09 then return end
        MemWalk.wdAt = now
        memGuardWalkDir()
    end

     
     
    local function memGuardPoint() pcall(memWritePointNow) end
    local function memGuardDir() pcall(memWriteDirNow) end

     
     
     
     
    local function memHook()
        if not MemWalk.on or not MemWalk.base then return end
        memGuardDir()
        memRefreshWalkDir(tick())
    end

    local function memConnect()
        if #MemWalk.conns > 0 then return true end
        local ok = pcall(function()
            local RunService = game:GetService("RunService")
            MemWalk.conns[#MemWalk.conns + 1] = RunService.RenderStepped:Connect(memHook)
            MemWalk.conns[#MemWalk.conns + 1] = RunService.Heartbeat:Connect(memHook)
        end)
        if not ok then
            for index = #MemWalk.conns, 1, -1 do
                pcall(function() MemWalk.conns[index]:Disconnect() end)
                MemWalk.conns[index] = nil
            end
        end
        return #MemWalk.conns > 0
    end

    local function memZeroDirection()
        local base = memBase()
        local write = memWriter()
        if not base or not write then return end
        pcall(function()
            write(base + OFF_MOVE_DIR, 0)
            write(base + OFF_MOVE_DIR + 4, 0)
            write(base + OFF_MOVE_DIR + 8, 0)
             
             
            write(base + OFF_WALK_DIR, 0)
            write(base + OFF_WALK_DIR + 4, 0)
            write(base + OFF_WALK_DIR + 8, 0)
             
             
            local hrp = getHRP()
            if hrp then
                write(base + OFF_MOVE_POINT, hrp.Position.X)
                write(base + OFF_MOVE_POINT + 4, hrp.Position.Y)
                write(base + OFF_MOVE_POINT + 8, hrp.Position.Z)
            end
        end)
    end

    Nav.memWalkStop = function()
        MemWalk.on = false
        MemWalk.dirX, MemWalk.dirZ = 0, 0
        memZeroDirection()
        for index = #MemWalk.conns, 1, -1 do
            pcall(function() MemWalk.conns[index]:Disconnect() end)
            MemWalk.conns[index] = nil
        end
    end

    Nav.memAvailable = function() return memReady() end
    Nav.memBase = memBase
    Nav.memWriter = memWriter

    Nav.memWalkTo = function(targetPos, opts)
        opts = opts or {}
        if not targetPos then return false end
        if not memReady() then return false end
        if not memConnect() then return false end

        local arrive = opts.arrive or 4.5
        local timeout = opts.timeout or 20
        local label = opts.label or "Offsets walk"
         
         
         
        local noHop = opts.noJump == true

        local hrp = getHRP()
        if not hrp then return false end

        MemWalk.base = memBase()
        MemWalk.write = memWriter()
        MemWalk.tx, MemWalk.ty, MemWalk.tz = targetPos.X, targetPos.Y, targetPos.Z
        MemWalk.on = true
         
         
         
        if S.speed_override == true then
            startSpeedWrite(S.walk_speed or 0)
        else
            stopSpeedWrite()
        end
        glideActive = true
        glideActiveSince = tick()
        walkingWithKeys = false
        releaseWalkKeys()
        if type(killDrive) == "function" then pcall(killDrive) end
        lastMoveMode, lastMoveAt = label, tick()

         
         
        memGuardPoint()

        local start = tick()
        local best = (Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z) - hrp.Position).Magnitude
        local bestAt = start
        local jumps = 0
        local escIdx, escFrom = 0, nil
        local reached = false
        local steerStage = 0
        local reboundUntil = 0
        local lastBaseAt = start
        local lastPointAt = start
        local lastStepProbe = 0
        local startFlat = Vector3.new(targetPos.X - hrp.Position.X, 0, targetPos.Z - hrp.Position.Z)
        local startLen = math.max(startFlat.Magnitude, 0.001)
        MemWalk.dirX = startFlat.X / startLen
        MemWalk.dirZ = startFlat.Z / startLen
        MemWalk.lastPos = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
        MemWalk.slowSince = start
        inputBridge()

        while tick() - start < timeout do
            if not isOn() then break end
            local current = getHRP()
            if not current or not isAlive() then break end

            local now = tick()
             
             
            if now - lastBaseAt > 0.25 then
                lastBaseAt = now
                local base = memBase()
                if base and base ~= MemWalk.base then
                    MemWalk.base = base
                    MemWalk.write = memWriter()
                    memGuardPoint()
                end
            end

             
             
             
            if now - lastPointAt > 0.35 then
                lastPointAt = now
                memGuardPoint()
            end

            local pos = current.Position
            local flat = Vector3.new(targetPos.X - pos.X, 0, targetPos.Z - pos.Z)
            local distance = flat.Magnitude
            if distance <= arrive then
                reached = true
                break
            end
            lastMoveMode, lastMoveAt = label, now

             
             
             
             
             
            local here = Vector3.new(pos.X, 0, pos.Z)
             
             
            if (here - MemWalk.lastPos).Magnitude > 0.5 then
                MemWalk.lastPos = here
                MemWalk.slowSince = now
            elseif now - (MemWalk.slowSince or now) > 0.6 and distance > 8 and not noHop then
                MemWalk.slowSince = now
                jumpNow()
            end

             
             
             
             
            if now > reboundUntil then
                local inv = 1 / math.max(distance, 0.001)
                MemWalk.dirX = flat.X * inv
                MemWalk.dirZ = flat.Z * inv
            end
             
             
            memRefreshWalkDir(now)

            local stuckFor = now - bestAt
            local airborne = humanoidAirborne()
             
             
             
            if not noHop and not airborne and distance < 16 then
                if now - lastStepProbe > 0.12 then
                    lastStepProbe = now
                    if Nav.stepAhead(pos, flat.X, flat.Z, 5.5) then jumpNow() end
                end
            end
            if distance < best - 0.5 then
                best, bestAt = distance, now
                jumps, steerStage = 0, 0
                reboundUntil = 0
            elseif airborne then
                 
                 
                task.wait(0.04)
            elseif stuckFor > 4.5 then
                status = "Offsets stalled"
                break
            elseif stuckFor > 0.45 then
                local step = math.floor((stuckFor - 0.45) / 0.5) + 1
                if step > jumps then
                    jumps = step
                    bestAt = now
                    if step <= 2 and not noHop then
                         
                        jumpNow()
                    else
                         
                         
                         
                        local hereNow = Vector3.new(pos.X, 0, pos.Z)
                        local moved = escFrom and (hereNow - escFrom).Magnitude or 0
                        escFrom = hereNow

                        if moved >= 1.2 and escIdx > 0 then
                            reboundUntil = now + 0.6
                        else
                            escIdx = escIdx > 0 and escIdx + 1 or 1
                            if escIdx > #ESCAPE_STEPS then
                                escIdx, escFrom = 0, nil
                                status = "Offsets stalled"
                                break
                            end
                            local ang = math.rad(ESCAPE_STEPS[escIdx])
                            local ca, sa = math.cos(ang), math.sin(ang)
                            local dx = flat.X / math.max(distance, 0.001)
                            local dz = flat.Z / math.max(distance, 0.001)
                            MemWalk.dirX = dx * ca - dz * sa
                            MemWalk.dirZ = dx * sa + dz * ca
                            reboundUntil = now + 0.55
                        end
                    end
                end
            end
            task.wait(0.03)
        end

        MemWalk.on = false
        MemWalk.dirX, MemWalk.dirZ = 0, 0
        memZeroDirection()
        glideActive = false
        return reached
    end

     
     
     
     
     
    Nav.walkRoute = function(points, opts)
        opts = opts or {}
        if type(points) ~= "table" or #points == 0 then return false end
        if not memReady() then return false end
        if not memConnect() then return false end

        local arrive = opts.arrive or 3.5
        local label = opts.label or "Route walk"
        local pool = opts.timeout or 90

        local hrp = getHRP()
        if not hrp then return false end

        MemWalk.base = memBase()
        MemWalk.write = memWriter()
        MemWalk.on = true
        if S.speed_override == true then
            startSpeedWrite(S.walk_speed or 0)
        else
            stopSpeedWrite()
        end
        glideActive = true
        glideActiveSince = tick()
        walkingWithKeys = false
        releaseWalkKeys()
        if type(killDrive) == "function" then pcall(killDrive) end
        lastMoveMode, lastMoveAt = label, tick()
        inputBridge()

        local function getPoint(entry)
            local p = type(entry) == "table" and entry.Position or entry
            if p == nil or p.X == nil then return nil end
            return p
        end

         
        local function setLeg(target)
            local flat = Vector3.new(target.X - hrp.Position.X, 0, target.Z - hrp.Position.Z)
            local len = math.max(flat.Magnitude, 0.001)
            MemWalk.tx, MemWalk.ty, MemWalk.tz = target.X, target.Y, target.Z
            MemWalk.dirX = flat.X / len
            MemWalk.dirZ = flat.Z / len
            memGuardPoint()
        end

        local first = getPoint(points[1])
        if not first then
            Nav.memWalkStop()
            return false
        end
        setLeg(first)
        MemWalk.lastPos = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
        MemWalk.slowSince = tick()

        local index = 1
        local start = tick()
        local best = math.huge
        local bestAt = start
        local jumps, steerStage, skips = 0, 0, 0
        local reboundUntil = 0
        local escIdx, escFrom, escStartDist = 0, nil, nil
        local done = false
        local lastPointAt = start
        local lastStepProbe = 0
        local backedOff = false

         
         
         
         
         
         
         
        local function stallAdvance()
            if skips >= 3 and not backedOff then
                local backPos = (index > 1) and getPoint(points[index - 1])
                if backPos then
                    backedOff = true
                    local bx = backPos.X - hrp.Position.X
                    local bz = backPos.Z - hrp.Position.Z
                    local bl = math.max(math.sqrt(bx * bx + bz * bz), 0.001)
                    MemWalk.tx, MemWalk.ty, MemWalk.tz = backPos.X, backPos.Y, backPos.Z
                    MemWalk.dirX, MemWalk.dirZ = bx / bl, bz / bl
                    memGuardPoint()
                    jumps, steerStage = 0, 0
                    reboundUntil = tick() + 1.1
                    best, bestAt = math.huge, tick()
                    return true
                end
            end

            skips = skips + 1
             
             
             
            if skips > 6 then return false end
            index = index + 1
            if index > #points then return false end
            local nextPos = getPoint(points[index])
            if not nextPos then return false end
            setLeg(nextPos)
            jumps, steerStage = 0, 0
            reboundUntil = 0
            best, bestAt = math.huge, tick()
            return true
        end

        while tick() - start < pool do
            if not isOn() then break end
            local current = getHRP()
            if not current or not isAlive() then break end
            hrp = current
            if tick() - lastPointAt > 0.35 then
                lastPointAt = tick()
                memGuardPoint()
            end

            local target = getPoint(points[index])
            if not target then break end
            local pos = current.Position
            local flat = Vector3.new(target.X - pos.X, 0, target.Z - pos.Z)
            local distance = flat.Magnitude
            local routeNow = tick()
             
             
            memRefreshWalkDir(routeNow)
            local hereRoute = Vector3.new(pos.X, 0, pos.Z)
             
             
             
             
             
             
             
            if (hereRoute - MemWalk.lastPos).Magnitude > 0.5 then
                MemWalk.lastPos = hereRoute
                MemWalk.slowSince = routeNow
            elseif routeNow - (MemWalk.slowSince or routeNow) > 0.6
                and distance > 8 and not humanoidAirborne() then
                MemWalk.slowSince = routeNow
                jumpNow()
            end

            if distance <= arrive then
                index = index + 1
                if index > #points then
                    done = true
                    break
                end
                local nextPos = getPoint(points[index])
                if nextPos then
                     
                     
                    setLeg(nextPos)
                    jumps, steerStage, backedOff = 0, 0, false
                    best, bestAt = math.huge, tick()
                end
            else
                 
                 
                 
                 
                 
                if routeNow > reboundUntil then
                    local inv = 1 / math.max(distance, 0.001)
                    MemWalk.dirX = flat.X * inv
                    MemWalk.dirZ = flat.Z * inv
                end
                local stuckFor = tick() - bestAt
                local airborne = humanoidAirborne()
                if distance < best - 0.5 then
                    best, bestAt = distance, tick()
                    jumps, steerStage, skips = 0, 0, 0
                    reboundUntil = 0
                     
                     
                    backedOff = false
                elseif airborne then
                    task.wait(0.05)
                else
                     
                     
                    if stuckFor > 3.2 then
                         
                         
                         
                        if not stallAdvance() then break end
                    elseif stuckFor > 0.45 then
                        local step = math.floor((stuckFor - 0.45) / 0.5) + 1
                        if step > jumps then
                            jumps = step
                            bestAt = tick()
                             
                             
                             
                             
                             
                            if step == 1 then
                                jumpNow()
                            else
                                local hereNow = Vector3.new(pos.X, 0, pos.Z)
                                local moved = escFrom and (hereNow - escFrom).Magnitude or 0
                                escFrom = hereNow

                                 
                                 
                                 
                                 
                                 
                                local drifted = escStartDist ~= nil and distance > escStartDist + 8

                                if moved >= 1.2 and escIdx > 0 and not drifted then
                                    reboundUntil = routeNow + 0.6
                                else
                                    escIdx = escIdx > 0 and escIdx + 1 or 1
                                    if escIdx == 1 then escStartDist = distance end

                                    if escIdx > #ESCAPE_STEPS then
                                         
                                         
                                         
                                        escIdx, escFrom, escStartDist = 0, nil, nil
                                        if not stallAdvance() then break end
                                    else
                                        local ang = math.rad(ESCAPE_STEPS[escIdx])
                                        local ca, sa = math.cos(ang), math.sin(ang)
                                        local dx = flat.X / math.max(distance, 0.001)
                                        local dz = flat.Z / math.max(distance, 0.001)
                                        MemWalk.dirX = dx * ca - dz * sa
                                        MemWalk.dirZ = dx * sa + dz * ca
                                        reboundUntil = routeNow + 0.55
                                    end
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.03)
        end

        Nav.memWalkStop()
        return done
    end

     
    Nav.walk = function(targetPos, opts)
        if not targetPos then return false end
        opts = opts or {}
        if S.walk_method == "Keyboard" then
            return walkWithKeys(targetPos, opts) == true
        end
        if Nav.memWalkTo(targetPos, opts) then return true end
        if not memReady() then
             
             
            status = "Offsets unavailable, using keyboard"
            S.walk_method = "Keyboard"
            pcall(function()
                local sync = _G and _G.__lolcatWalkMethodSync

                if type(sync) == "function" then sync("Keyboard") end
            end)
            return walkWithKeys(targetPos, opts) == true
        end
        return false
    end
    end)()
     

    
    
    
    local _tokCache, _tokT = nil, 0
    local function scanTokens(field, farmMode, closeR, eyePos)
        
        
        local now = tick()
        if _tokCache and now - _tokT < 0.2 then return _tokCache end
        _tokT = now
        local out = {}
        local folder = Workspace:FindFirstChild("Collectibles")
        if not folder then return out end
        local okk, kids = pcall(function() return folder:GetChildren() end)
        if not okk or not kids then return out end
        for i = 1, #kids do
            local obj = kids[i]
            local pos
            local okp, p = pcall(function() return obj.Position end)
            if okp and p then pos = p else
                local okm, mp = pcall(function() return obj.PrimaryPart.Position end)
                if okm and mp then pos = mp end
            end
            if pos and inField(pos, field, 4) then
                if farmMode ~= 1 or distToCenter(pos, field) <= closeR then
                    local score = Vector3.new(pos.X - eyePos.X, 0, pos.Z - eyePos.Z).Magnitude
                    out[#out + 1] = { part = obj, pos = pos, score = score }
                end
            end
        end
        _tokCache = out
        return out
    end

    local function getFieldTurnWaypoints(field, pattern, closeR)
        local c = field.Position
        local rx = math.max(8, (closeR or (field.Size.X / 2 - 8)))
        local rz = math.max(8, (closeR or (field.Size.Z / 2 - 8)))
        local standY = groundY(field) + 2

        if pattern == "Square / Box Turns" then
            return {
                Vector3.new(c.X - rx, standY, c.Z - rz),
                Vector3.new(c.X + rx, standY, c.Z - rz),
                Vector3.new(c.X + rx, standY, c.Z + rz),
                Vector3.new(c.X - rx, standY, c.Z + rz),
            }
        elseif pattern == "Serpentine / Snake" then
            return {
                Vector3.new(c.X - rx, standY, c.Z - rz),
                Vector3.new(c.X + rx, standY, c.Z - rz),
                Vector3.new(c.X + rx, standY, c.Z),
                Vector3.new(c.X - rx, standY, c.Z),
                Vector3.new(c.X - rx, standY, c.Z + rz),
                Vector3.new(c.X + rx, standY, c.Z + rz),
                Vector3.new(c.X, standY, c.Z),
            }
        end
        
        local pts = {}
        for i = 0, 7 do
            local theta = (i / 8) * math.pi * 2
            pts[#pts + 1] = Vector3.new(c.X + math.cos(theta) * rx, standY, c.Z + math.sin(theta) * rz)
        end
        return pts
    end

    local farmTurnIdx = 1
    local function farmFieldTurnStep(field, closeR)
        local hrp = getHRP()
        if not hrp then return end

        local standY = groundY(field) + 2
        local pattern = S.farm_mode or "Orbit / Circle Turns"
        local waypoints = getFieldTurnWaypoints(field, pattern, closeR)
        if #waypoints == 0 then return end

        local list = scanTokens(field, 2, closeR or 15, hrp.Position)
        
        
        
        local cluster = {}
        if #list > 0 then
            table.sort(list, function(a, b) return a.score < b.score end)
            local anchor = list[1]
            if anchor.score <= 120 then
                for i = 1, #list do
                    local p = list[i].pos
                    local dx, dz = p.X - anchor.pos.X, p.Z - anchor.pos.Z
                    if dx * dx + dz * dz <= 900 then          
                        cluster[#cluster + 1] = list[i]
                        if #cluster >= 8 then break end
                    end
                end
            end
        end

        if #cluster > 0 then
            
            
            
            local tripEnd = tick() + 24
            for i = 1, #cluster do
                if not isOn() then break end
                local leg  = cluster[i]
                local left = tripEnd - tick()
                if left <= 1 then break end
                local alivePart = false
                pcall(function() alivePart = leg.part ~= nil and leg.part.Parent ~= nil end)
                if alivePart then
                    local targetPos = clampTarget(leg.pos, field, 2, closeR or 15)
                    Nav.walk(targetPos, { arrive = 5.5, timeout = math.min(12, left) })
                    autoDigCursorFree()
                    task.wait(0.05)
                end
            end
            task.wait(0.04)
        else
            if farmTurnIdx > #waypoints then farmTurnIdx = 1 end
            local targetWp = waypoints[farmTurnIdx]
             
             
            Nav.walk(targetWp, { arrive = 4, timeout = 16 })
            autoDigCursorFree()

             
             
            farmTurnIdx = (farmTurnIdx % #waypoints) + 1
            task.wait(0.06)
        end
    end

    
    
    
     
     
     
     
     
     
     
     
     
     
     
     
     
Nav.markVisited = {}
Nav.markKey = function(pos)
    return tostring(math.floor(pos.X / 2)) .. ":" .. tostring(math.floor(pos.Z / 2))
end
Nav.markDone = function(pos)
    if not pos then return end
    Nav.markVisited[Nav.markKey(pos)] = tick()
end
Nav.markSeen = {}
 
 
 
 
Nav._particleCache, Nav._particleCacheAt = nil, 0
Nav._particlesFolder = nil
Nav.particleChildren = function()
    local now = tick()
    local folder = Nav._particlesFolder
    if not folder or folder.Parent == nil then
        folder = Workspace:FindFirstChild("Particles")
        Nav._particlesFolder = folder
        Nav._particleCache = nil
    end
    if not folder then return nil end
    local cached = Nav._particleCache
    if cached and now - Nav._particleCacheAt < 0.2 then return cached end
    local ok, list = pcall(function() return folder:GetChildren() end)
    if not ok or type(list) ~= "table" then return cached or {} end
    Nav._particleCache, Nav._particleCacheAt = list, now
    return list
end

Nav.preciseMarkTarget = function(field)
    if not field or S.mark_target ~= true then return nil end
     
     
    local marks = Nav.particleChildren() or {}
    local hrp = getHRP()
    if not hrp then return nil end
    local gY = groundY(field)
    local best, bestD = nil, math.huge
    local now = tick()
    local visited = Nav.markVisited
    local seen = Nav.markSeen

     
     
    if now - (Nav.markSeenPrune or 0) > 4 then
        Nav.markSeenPrune = now
        for key, rec in pairs(seen) do
            if now - rec.t > 3 then seen[key] = nil end
        end
    end

    local hx, hz = hrp.Position.X, hrp.Position.Z
    local fc = field.Position
    local fhx = field.Size.X / 2 + 2
    local fhz = field.Size.Z / 2 + 2
    local function consider(mark)
         
         
        if mark.Name ~= "Crosshair" then return end
        local pos = mark.Position
        if not pos then return end
        local height = pos.Y - gY
         
         
        if height > -4 and height < 6
            and math.abs(pos.X - fc.X) <= fhx and math.abs(pos.Z - fc.Z) <= fhz then
            local key = Nav.markKey(pos)
            local rec = seen[key]
            local still = false
            if not rec then
                seen[key] = { x = pos.X, z = pos.Z, t = now }
            else
                still = math.abs(pos.X - rec.x) + math.abs(pos.Z - rec.z) <= 0.8
                rec.x, rec.z = pos.X, pos.Z
            end
             
             
            if height <= 3.5 or still then
                local seenAt = visited[key]
                if not seenAt or (now - seenAt) > 20 then
                    local dx, dz = pos.X - hx, pos.Z - hz
                    local d = dx * dx + dz * dz
                    if d < bestD then best, bestD = pos, d end
                end
            end
        end
    end

     
     
     
     
     
    pcall(function()
        for i = 1, #marks do consider(marks[i]) end
        local kids = Nav.workspaceKids()
        for i = 1, #kids do
            local m = kids[i]
            if m.Name == "Crosshair" then consider(m) end
        end
    end)
    return best
end

     
     
     
     
Nav.collectDupedToken = function(field, standY)
    if S.collect_duped == false or not field then return false end
    local cam = Workspace:FindFirstChild("Camera")
    local folder = cam and cam:FindFirstChild("DupedTokens")
    if not folder then return false end
    local hrp = getHRP()
    if not hrp then return false end
    local best, bestD = nil, math.huge
    for _, tok in ipairs(folder:GetChildren()) do
        local ok, tp = pcall(function() return tok.Position end)
        if ok and tp then
            local d = Vector3.new(tp.X - hrp.Position.X, 0, tp.Z - hrp.Position.Z).Magnitude
            if d < bestD and (inField(tp, field, 25) or d <= 60) then
                best, bestD = tp, d
            end
        end
    end
    if not best then return false end
    status = "Digital token"
    Nav.walk(Vector3.new(best.X, standY, best.Z), { arrive = 3, timeout = 14 })
    local holdStart = tick()
    while isOn() and tick() - holdStart < 2.0 do
        local h2 = getHRP()
        if not h2 then break end
        if (Vector3.new(h2.Position.X, 0, h2.Position.Z) - Vector3.new(best.X, 0, best.Z)).Magnitude > 5 then break end
        autoDigCursorFree()
        task.wait(0.1)
    end
    autoDigCursorFree()
    task.wait(0.15)
    return true
end

     
     
     
    do
     
     
     
     
     
     
    local PRIO_TOKENS = {
        { rank = 1, name = "Token Link", r = 255, g = 255, b = 255 },
        { rank = 1, name = "Smile Token", r = 255, g = 255, b = 255 },
        { rank = 2, name = "Bear Morph", r = 242, g = 129, b = 255 },
        { rank = 3, name = "Puppy Love", r = 251, g = 220, b = 135 },
    }

     
     
    local function colour255(c)
        if not c then return nil end
        local ok, r, g, b = pcall(function() return c.R, c.G, c.B end)
        if not ok or type(r) ~= "number" then return nil end
        if r <= 1.001 and g <= 1.001 and b <= 1.001 then
            return r * 255, g * 255, b * 255
        end
        return r, g, b
    end

    local function tokenSaysPollen(tok)
        local ok, found = pcall(function()
            for _, d in ipairs(tok:GetDescendants()) do
                local txt = nil
                if d.ClassName == "TextLabel" then
                    txt = d.Text
                elseif d.ClassName == "BillboardGui" then
                    local tl = d:FindFirstChildWhichIsA("TextLabel")
                    txt = tl and tl.Text
                end
                if txt and string.find(string.lower(tostring(txt)), "pollen", 1, true) then
                    return true
                end
            end
            return false
        end)
        return ok and found == true
    end

    Nav.priorityToken = function(field)
        local coll = Workspace:FindFirstChild("Collectibles")
        local hrp = getHRP()
        if not coll or not hrp then return nil end
        local ok, kids = pcall(function() return coll:GetChildren() end)
        if not ok or not kids then return nil end
        local best, bestScore = nil, math.huge
        for _, tok in ipairs(kids) do
            local pos = getPartPos(tok)
            if pos then
                local d = Vector3.new(pos.X - hrp.Position.X, 0, pos.Z - hrp.Position.Z).Magnitude
                 
                 
                if d <= 90 and (not field or inField(pos, field, 40)) then
                    local r, g, b = colour255(tok.Color)
                    if r then
                        local rank, name = nil, nil
                        for _, c in ipairs(PRIO_TOKENS) do
                            if math.abs(r - c.r) <= 26 and math.abs(g - c.g) <= 26 and math.abs(b - c.b) <= 26 then
                                if rank == nil or c.rank < rank then
                                    rank, name = c.rank, c.name
                                end
                            end
                        end
                        if rank and not tokenSaysPollen(tok) then
                            local score = rank * 100000 + d
                            if score < bestScore then
                                bestScore = score
                                best = { pos = pos, part = tok, rank = rank, name = name, dist = d }
                            end
                        end
                    end
                end
            end
        end
        return best
    end
    end

    local MOB_LOCATIONS = {
        ["Rhino Beetle"] = {
            Vector3.new(150, 5, 100), Vector3.new(260, 68, -200),
            Vector3.new(-150, 5, 195), Vector3.new(135, 20, -25),
        },
        ["Ladybug"] = {
            Vector3.new(-180, 20, -5), Vector3.new(-90, 5, 115), Vector3.new(-150, 5, 195),
        },
        ["Mantis"] = { Vector3.new(-320, 68, -180) },
        ["Spider"] = { Vector3.new(-45, 20, -5) },
        ["Scorpion"] = { Vector3.new(-320, 20, 130) },
        ["Werewolf"] = { Vector3.new(-260, 68, -40) },
    }

    local function getPolarBearLocation()
        local npcs = Workspace:FindFirstChild("NPCs")
        local bear = npcs and npcs:FindFirstChild("Polar Bear")
        if bear then
            local p = bear:FindFirstChild("Circle") or bear:FindFirstChild("Platform")
                or bear:FindFirstChild("HumanoidRootPart") or bear:FindFirstChild("Torso")
                or bear:FindFirstChildWhichIsA("BasePart")
            local pos = getPartPos(p)
            if pos then return pos end
        end
        return Vector3.new(-105, 120, -78)
    end

    local _polarCache, _polarT = nil, 0
    local function getPolarBearQuestRaw()
        local pg = lp:FindFirstChildOfClass("PlayerGui")
        if not pg then return nil end

        local quest = { title = nil, questName = nil, tasks = {}, allComplete = true, hasQuest = false }

        local headerLabel = nil
        for _, l in ipairs(pg:GetDescendants()) do
            if l.ClassName == "TextLabel" then
                local txt = safeText(l)
                if #txt > 0 and string.find(txt, "Polar Bear:", 1, true) then
                    headerLabel = l
                    quest.title = txt
                    quest.hasQuest = true
                    local qn = string.match(txt, "Polar Bear:%s*(.+)")
                    quest.questName = qn and string.gsub(qn, "^%s*(.-)%s*$", "%1") or txt
                    break
                end
            end
        end
        if not headerLabel then return nil end

        local containers = { headerLabel.Parent }
        if headerLabel.Parent and headerLabel.Parent.Parent then
            containers[#containers + 1] = headerLabel.Parent.Parent
        end
        local seen = {}
        for _, container in ipairs(containers) do
            for _, obj in ipairs(container:GetDescendants()) do
                if obj.ClassName == "TextLabel" and obj ~= headerLabel then
                    local txt = safeText(obj)
                    if #txt >= 6 and not seen[txt] then
                        local ltxt = string.lower(txt)
                        local isTask = string.find(ltxt, "collect", 1, true)
                            or string.find(ltxt, "catch", 1, true)
                            or string.find(ltxt, "defeat", 1, true)
                            or string.find(ltxt, "pop", 1, true)
                            or string.find(ltxt, "explode", 1, true)
                            or string.find(ltxt, "have", 1, true)
                            or string.find(ltxt, "use", 1, true)
                        local isReward = string.find(ltxt, "reward", 1, true)
                            or string.find(ltxt, "honey", 1, true)
                            or string.find(ltxt, "ticket", 1, true)
                        if isTask and not isReward then
                            seen[txt] = true
                            local isComplete = string.find(ltxt, "complete", 1, true) ~= nil
                            local current, total = string.match(txt, "([%d%,]+)%s*/%s*([%d%,]+)")
                            local cVal, tVal = 0, 0
                            if current and total then
                                cVal = tonumber((string.gsub(current, "%,", ""))) or 0
                                tVal = tonumber((string.gsub(total, "%,", ""))) or 0
                                if tVal > 0 and cVal >= tVal then isComplete = true end
                            end

                            local taskType, targetField, targetMob, targetPetal = "unknown", nil, nil, nil
                            for _, fname in ipairs({
                                "Rose Field", "Pine Tree Forest", "Pineapple Patch", "Pineapple Field",
                                "Dandelion Field", "Strawberry Field", "Blue Flower Field",
                                "Cactus Field", "Clover Field", "Bamboo Field", "Sunflower Field",
                                "Pumpkin Patch", "Pumpkin Field", "Mushroom Field", "Spider Field",
                                "Stump Field", "Mountain Top Field", "Pepper Patch", "Coconut Field",
                            }) do
                                if string.find(ltxt, string.lower(fname), 1, true) then
                                    taskType, targetField = "pollen", fname
                                    break
                                end
                            end
                            if taskType == "unknown" then
                                for _, mname in ipairs({ "Rhino Beetle", "Ladybug", "Mantis", "Spider", "Scorpion", "Werewolf" }) do
                                    if string.find(ltxt, string.lower(mname), 1, true) then
                                        taskType, targetMob = "mob", mname
                                        break
                                    end
                                end
                            end
                            if taskType == "unknown" and (string.find(ltxt, "bloom", 1, true) or string.find(ltxt, "petal", 1, true)) then
                                taskType = "petal"
                                for _, col in ipairs({ "White", "Cyan", "Green", "Pink" }) do
                                    if string.find(ltxt, string.lower(col), 1, true) then targetPetal = col; break end
                                end
                            end

                            if not isComplete then quest.allComplete = false end

                            insert(quest.tasks, {
                                text = txt, complete = isComplete, type = taskType,
                                field = targetField, mob = targetMob, petal = targetPetal,
                                current = cVal, total = tVal,
                                needed = (tVal > cVal) and (tVal - cVal) or 0,
                            })
                        end
                    end
                end
            end
        end
        return quest
    end

    local function getPolarBearQuest()
        local now = tick()
        
        
        
        if _polarT > 0 and now - _polarT < 0.4 then return _polarCache end
        _polarT = now
        _polarCache = getPolarBearQuestRaw()
        return _polarCache
    end

    
    
    
    
    local lastPolarAsk = 0
    local function hybridPolarDialogue()
        local quest = getPolarBearQuest()
        if quest and quest.questName then
            if quest.allComplete then
                status = "Polar: turning in (hybrid)"
                fireEvent("CompleteQuestFromPool", quest.questName)
                task.wait(0.5)
                local q2 = getPolarBearQuest()
                if q2 and q2.allComplete then
                    fireEvent("CompleteQuest", quest.questName)
                    task.wait(0.5)
                end
            end
            return
        end

        
        
        
        
        
        
        local now = tick()
        if now - lastPolarAsk < 15 then return end
        lastPolarAsk = now
        status = "Polar: accepting (hybrid)"
        for _, pool in ipairs({ "Polar Bear", "PolarBear", "Polar Bear Quests", "Beesmas Feast" }) do
            fireEvent("GiveQuestFromPool", pool)
            task.wait(0.35)
            if getPolarBearQuest() then return end
        end
        fireEvent("GiveQuest", "PolarBearXmas25")
        task.wait(0.5)
    end

    local function spamClickDialogue(duration, force)
        if S.hybrid then
            
            hybridPolarDialogue()
            return
        end
        duration = duration or 5.0
        local dl = tick() + duration
        local cam = try(function() return Workspace.CurrentCamera end)
        local vp = Vector2.new(1920, 1080)
        pcall(function()
            if cam and cam.ViewportSize then vp = cam.ViewportSize end
        end)
        local defaultClickPos = Vector2.new(vp.X * 0.50, vp.Y * 0.77)

        while tick() < dl do
            
            
            
            
            if (not FeaturesActive) and not force then return end
            local clickPos = defaultClickPos

            pcall(function()
                local pg = lp:FindFirstChildOfClass("PlayerGui")
                if pg then
                    for _, obj in ipairs(pg:GetDescendants()) do
                        if isGuiObject(obj) and obj.Visible then
                            local txt = safeText(obj)
                            if #txt > 0 and (string.find(txt, "Click to continue", 1, true)
                                or string.find(txt, "Polar Bear", 1, true)
                                or string.find(txt, "Hahaa", 1, true)
                                or string.find(txt, "kidding", 1, true)) then
                                local ap = obj.AbsolutePosition
                                local as = obj.AbsoluteSize
                                if ap and as and as.X > 10 and as.Y > 10 then
                                    clickPos = Vector2.new(ap.X + as.X / 2, ap.Y + as.Y / 2)
                                    pcall(function()
                                        if isGuiButton(obj) then obj.Activated:Fire() end
                                    end)
                                    break
                                end
                            end
                        end
                    end
                end
            end)

            local cx = math.floor(clickPos.X)
            local cy = math.floor(clickPos.Y)

            pcall(function()
                if type(mousemoveabs) == "function" then mousemoveabs(cx, cy) end
            end)
            pcall(function()
                if type(mouse1click) == "function" then mouse1click(cx, cy) end
            end)
            pcall(function()
                if type(mouse1press) == "function" and type(mouse1release) == "function" then
                    mouse1press()
                    task.wait(0.02)
                    mouse1release()
                end
            end)
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                if vim then
                    vim:SendMouseButtonEvent(cx, cy, 0, true, game, 0)
                    task.wait(0.02)
                    vim:SendMouseButtonEvent(cx, cy, 0, false, game, 0)
                end
            end)
            pcall(function()
                local vu = game:GetService("VirtualUser")
                if vu then
                    vu:Button1Down(Vector2.new(cx, cy))
                    task.wait(0.02)
                    vu:Button1Up(Vector2.new(cx, cy))
                end
            end)
            pcall(function()
                keypress(0x20); task.wait(0.02); keyrelease(0x20)
                keypress(0x0D); task.wait(0.02); keyrelease(0x0D)
                keypress(0x45); task.wait(0.02); keyrelease(0x45)
            end)

            task.wait(0.08)
        end
    end

    local function clickAt(x, y)
        pcall(function() mousemoveabs(math.floor(x), math.floor(y)) end)
        pcall(function() mouse1click() end)
        pcall(function()
            mouse1press()
            task.wait(0.02)
            mouse1release()
        end)
    end

    local function clickGuiObject(obj, dx, dy)
        if not obj then return false end
        local ok, ap = pcall(function() return obj.AbsolutePosition end)
        if not ok or not ap then return false end
        clickAt(ap.X + (dx or 18), ap.Y + (dy or 10))
        return true
    end

    local function findPolarText(words)
        local pg = lp and lp:FindFirstChildOfClass("PlayerGui")
        if not pg then return nil end
        for _, obj in ipairs(pg:GetDescendants()) do
            local cl = obj.ClassName
            if cl == "TextButton" or cl == "TextLabel" or cl == "TextBox" then
                local t = safeText(obj)
                local lt = string.lower(t)
                for _, w in ipairs(words) do
                    if string.find(lt, string.lower(w), 1, true) then return obj end
                end
            end
        end
        return nil
    end

    local function clickActivateButton()
        local pg = lp and lp:FindFirstChildOfClass("PlayerGui")
        local sg = pg and pg:FindFirstChild("ScreenGui")
        local ab = sg and sg:FindFirstChild("ActivateButton")
        if not ab then return false end
        local ok, ap = pcall(function() return ab.AbsolutePosition end)
        if not ok or not ap then return false end
        clickAt(ap.X + 40, ap.Y + 8)
        return true
    end

    local function viewportSize()
        local cam = Workspace.CurrentCamera
        local vp = cam and cam.ViewportSize
        if vp and vp.X and vp.X > 0 then return vp end
        return Vector2.new(1920, 1080)
    end

    local function clickPolarDialogue(times)
        times = times or 2
        local vp = viewportSize()
        for _ = 1, times do
            local pg = lp and lp:FindFirstChildOfClass("PlayerGui")
            local sg = pg and pg:FindFirstChild("ScreenGui")
            local npc = sg and sg:FindFirstChild("NPC")
            local cmd = npc and npc:FindFirstChild("CommandTag")
            local txt = npc and npc:FindFirstChild("TextBox")
            local done = false
            if cmd then done = clickGuiObject(cmd, 18, 8) end
            if not done and txt then done = clickGuiObject(txt, 22, 10) end
            if not done then
                local claim = findPolarText({ "claim", "collect reward", "continue", "next" })
                if claim then done = clickGuiObject(claim, 18, 8) end
            end
            if not done then clickAt(vp.X * 0.5, vp.Y * 0.74) end
            task.wait(0.25)
        end
    end

    local function interactPolarBear()
        clickActivateButton()
        task.wait(0.35)
        clickPolarDialogue(3)
        task.wait(0.35)
        clickActivateButton()
        task.wait(0.35)
        clickPolarDialogue(3)
        task.wait(0.35)
    end

    local function polarSignature()
        local q = getPolarBearQuest()
        if not q then return "none" end
        return tostring(q.questName) .. "|" .. tostring(q.allComplete) .. "|" .. tostring(#q.tasks)
    end

    local function talkToPolarBear()
        local before = polarSignature()
        if S.hybrid then
            hybridPolarDialogue()
            task.wait(0.5)
        end
        interactPolarBear()
        if S.hybrid and polarSignature() == before then
            hybridPolarDialogue()
            task.wait(0.4)
            interactPolarBear()
        end
    end

     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
    Engine.questGivers = {
        { name = "Black Bear",   group = "bear",  pool = "Black Bear 2",  pos = Vector3.new(-256.1, 1.8, 296.9) },
        { name = "Mother Bear",  group = "bear",  pos = Vector3.new(-186.4, 2.0, 87.5) },
        { name = "Brown Bear",   group = "bear",  pool = "Brown Bear 2",  pos = Vector3.new(281.6, 42.4, 236.8) },
        { name = "Panda Bear",   group = "bear",  pos = Vector3.new(104.1, 32.2, 48.2) },
        { name = "Science Bear", group = "bear",  pos = Vector3.new(268.9, 99.5, 19.5) },
        { name = "Dapper Bear",  group = "bear",  pos = Vector3.new(554.0, 138.9, -362.3) },
        { name = "Spirit Bear",  group = "bear",  pos = Vector3.new(-365.5, 94.7, 479.4) },
        { name = "Polar Bear",   group = "bear",  pos = Vector3.new(-106.8, 115.9, -77.4) },
        { name = "Bucko Bee",    group = "other", pos = Vector3.new(304.9, 58.2, 105.4) },
        { name = "Riley Bee",    group = "other", pos = Vector3.new(-361.4, 70.1, 212.8) },
        { name = "Honey Bee",    group = "other", pos = Vector3.new(-386.8, 86.5, -219.8) },
        { name = "Onett",        group = "other", pos = Vector3.new(-9.2, 229.1, -520.8) },
        { name = "Stick Bug",    group = "other", pos = Vector3.new(-128.8, 46.4, 147.4) },
        { name = "Robo Bear",    group = "other", pos = Vector3.new(-444.3, 38.3, 111.7) },
        { name = "Gummy Bear",   group = "other", pos = Vector3.new(271.7, 25289.1, -851.9) },
        { name = "Bee Bear",     group = "other" },
    }

    Engine.questNames = function()
        local out = { "All enabled" }
        for _, giver in ipairs(Engine.questGivers) do out[#out + 1] = giver.name end
        return out
    end

    Engine.questsOnly = function()
        return S.quest_mode == "Quests only"
    end

     
     
     
    Engine.questOn = function()
        return S.quests_auto == true or S.auto_polar_quests == true
            or S.polar_only == true or S.quest_mode == "Quests only"
    end

    Nav.questByName = function(name)
        for _, giver in ipairs(Engine.questGivers) do
            if giver.name == name then return giver end
        end
        return nil
    end

    Nav.questList = function()
        local out = {}
         
         
        local pick = S.quest_pick
        if pick and pick ~= "All enabled" then
            local one = Nav.questByName(pick)
            if one then out[1] = one end
            return out
        end
        if S.polar_only and not S.quests_auto then
            local polar = Nav.questByName("Polar Bear")
            if polar then out[1] = polar end
            return out
        end
        for _, giver in ipairs(Engine.questGivers) do
            local on = (giver.group == "bear" and S.quest_bears ~= false)
                or (giver.group == "other" and S.quest_others == true)
            if on then out[#out + 1] = giver end
        end
        return out
    end

    Nav.questPos = function(giver)
        local npcs = Workspace:FindFirstChild("NPCs")
        local model = npcs and npcs:FindFirstChild(giver.name)
        if model then
            local part = model:FindFirstChild("Circle") or model:FindFirstChild("Platform")
                or model:FindFirstChildWhichIsA("BasePart")
            local pos = getPartPos(part)
            if pos then return pos end
        end
        return giver.pos
    end

     
     
     
    Nav.questFire = function(remote, arg)
        if not arg then return false end
        return fireEvent(remote, arg) == true
    end

     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     

    Nav.mobTypes = function()
        if Nav.mobTypeList then return Nav.mobTypeList end
        local out = {}
        local folder = RS:FindFirstChild("MonsterTypes")
        if folder then
            for _, child in ipairs(folder:GetChildren()) do out[#out + 1] = child.Name end
        end
        table.sort(out, function(a, b) return #a > #b end)
        Nav.mobTypeList = out
        return out
    end

     
     
    Nav.stripMarks = function(text)
        local i = 1
        while i <= #text do
            local b = string.byte(text, i)
            if b and b >= 33 and b <= 126 then break end
            i = i + 1
        end
        return (string.gsub(string.sub(text, i), "^%s*(.-)%s*$", "%1"))
    end

    Nav.questLogPanel = function()
        local pg = lp and lp:FindFirstChildOfClass("PlayerGui")
        local screen = pg and pg:FindFirstChild("ScreenGui")
        local menus = screen and screen:FindFirstChild("Menus")
        local kids = menus and menus:FindFirstChild("Children")
        return kids and kids:FindFirstChild("Quests")
    end

     
    Nav.questRead = function(force)
        local now = tick()
        if not force and Nav.qlAt and (now - Nav.qlAt) < 2 then return Nav.qlData end
        Nav.qlAt = now

        local out = {}
        local panel = Nav.questLogPanel()
        if panel then
            local ok, list = pcall(function() return panel:GetDescendants() end)
            local entry = nil
            for _, obj in ipairs((ok and list) or {}) do
                if obj.ClassName == "TextLabel" then
                    local kind = obj.Name
                    if kind == "TitleBar" or kind == "Description" then
                        local text = Nav.stripMarks(safeText(obj))
                        if #text > 0 then
                            if kind == "TitleBar" then
                                local giver, quest = Nav.questTitle(text)
                                entry = { title = text, giver = giver, quest = quest, tasks = {} }
                                out[#out + 1] = entry
                            elseif entry then
                                entry.tasks[#entry.tasks + 1] = Nav.questTask(text)
                            end
                        end
                    end
                end
            end
        end

        for _, e in ipairs(out) do
            local left = 0
            for _, task in ipairs(e.tasks) do
                if not task.done then left = left + 1 end
            end
            e.left = left
        end

        Nav.qlData = out
        return out
    end

     
     
     
    Nav.questTitle = function(title)
        for _, giver in ipairs(Engine.questGivers) do
            local prefix = giver.name .. ":"
            if string.sub(title, 1, #prefix) == prefix then
                return giver.name, (string.gsub(string.sub(title, #prefix + 1), "^%s*(.-)%s*$", "%1"))
            end
        end
        return nil, title
    end

    Nav.questNumber = function(text)
        if not text then return nil end
        return tonumber((string.gsub(text, ",", "")))
    end

    Nav.fieldIn = function(text)
        local best, bestLen = nil, 0
        for _, name in ipairs(zoneNames) do
            if #name > bestLen and string.find(text, name, 1, true) then
                best, bestLen = name, #name
            end
        end
        return best
    end

     
     
     
     
    Nav.questMob = function(text)
        local lower = string.lower(text)
        local best, bestLen = nil, 0
        for _, name in ipairs(Nav.mobTypes()) do
            local needle = string.lower(name)
            local from = 1
            while true do
                local at = string.find(lower, needle, from, true)
                if not at then break end
                local before = (at == 1) and " " or string.sub(lower, at - 1, at - 1)
                local after = string.sub(lower, at + #needle, at + #needle)
                local okBefore = (before == " " or before == ":" or before == ",")
                local okAfter = (after == "" or after == " " or after == "." or after == "," or after == "s")
                if okBefore and okAfter then
                    if #name > bestLen then best, bestLen = name, #name end
                    break
                end
                from = at + 1
            end
        end
        return best
    end

     
    local QUEST_COLOR_FIELDS = {
        ["White Pollen"] = "Dandelion Field",
        ["Red Pollen"]   = "Rose Field",
        ["Blue Pollen"]  = "Blue Flower Field",
    }

     
    Nav.questTask = function(text)
        local body = (string.gsub(text, "\n", " "))
        local task = { text = body, kind = "manual", done = false }

        local have, need = string.match(body, "(%d[%d,]*)/(%d[%d,]*)")
        if have and need then
            task.have = Nav.questNumber(have)
            task.need = Nav.questNumber(need)
        end
        if string.find(body, "Complete!", 1, true) then task.done = true end
        if not task.done and task.have and task.need and task.have >= task.need then task.done = true end
        if task.done then return task end

        local lower = string.lower(body)
        local field = Nav.fieldIn(body)
        local mob = Nav.questMob(body)
        local push = string.find(lower, "puffshroom", 1, true) ~= nil

        if push then
            task.kind, task.field = "puff", field
        elseif string.find(lower, "defeat", 1, true) and mob then
            task.kind, task.mob, task.field = "mobs", mob, field
        elseif string.find(lower, "pollen from the", 1, true) and field then
            task.kind, task.field = "pollen", field
        elseif string.find(lower, "token", 1, true) then
             
             
            task.kind, task.field = "tokens", field
        elseif string.find(lower, "tickets from", 1, true) then
            if mob then
                task.kind, task.mob, task.field = "mobs", mob, field
            end
        elseif string.find(lower, "planter", 1, true) then
            task.kind = "planters"
        elseif string.find(lower, "nectar", 1, true) then
            task.kind = "nectar"
        elseif string.find(lower, "pollen", 1, true) then
            for colour, fname in pairs(QUEST_COLOR_FIELDS) do
                if string.find(body, colour, 1, true) then
                    task.kind, task.field = "pollen", fname
                    break
                end
            end
        end
        return task
    end

    Nav.questEnabled = function(task)
        if task.kind == "pollen" then return S.qk_pollen ~= false end
        if task.kind == "mobs" then return S.qk_mobs ~= false end
        if task.kind == "puff" then return S.qk_puff ~= false end
        if task.kind == "tokens" then return S.qk_tokens ~= false end
         
         
         
        if task.kind == "planters" or task.kind == "nectar" then
            return S.nectar_farm == true and S.hybrid == true
        end
        return false
    end

     
     
     
    Nav.questStall = {}
    Nav.questFails = {}

    Nav.questStalled = function(task)
        if not task or not task.text then return false end
        local untilAt = Nav.questStall[task.text]
        if not untilAt then return false end
        if tick() < untilAt then return true end
        Nav.questStall[task.text] = nil
        Nav.questFails[task.text] = nil
        return false
    end

    Nav.questFail = function(task)
        if not task or not task.text then return end
        local key = task.text
        local n = (Nav.questFails[key] or 0) + 1
        if n >= 3 then
            Nav.questFails[key] = 0
            Nav.questStall[key] = tick() + 180
        else
            Nav.questFails[key] = n
        end
    end

     
     
    Nav.questTarget = function(list)
        local pick = S.quest_target
        if pick and pick ~= "Auto" and pick ~= "All active" then
            for _, entry in ipairs(list) do
                if entry.title == pick then return entry end
            end
        end
        local giverPick = S.quest_pick
        if giverPick and giverPick ~= "All enabled" then
            for _, entry in ipairs(list) do
                if entry.giver == giverPick then return entry end
            end
        end
        for _, entry in ipairs(list) do
            for _, task in ipairs(entry.tasks) do
                if not task.done and Nav.questEnabled(task) and not Nav.questStalled(task) then
                    return entry
                end
            end
        end
        return list[1]
    end

     
     
     
    Nav.mobSpawner = function(mob)
        local folder = Workspace:FindFirstChild("MonsterSpawners")
        if not folder then return nil end
        local needle = string.lower(mob)
        for _, spawner in ipairs(folder:GetChildren()) do
            local value = spawner:FindFirstChild("MonsterType")
            local kind = nil
            pcall(function() kind = value and value.Value end)
            local name = string.lower(tostring(kind or spawner.Name or ""))
            if string.find(name, needle, 1, true) then
                local pos = getPartPos(spawner:FindFirstChildOfClass("Part")) or getPartPos(spawner)
                if pos then return { pos = pos, name = spawner.Name } end
            end
        end
        return nil
    end

     
     
    Nav.findQuestMob = function(mob, radius)
        local hrp = getHRP()
        if not hrp then return nil end
        local needle = string.lower(mob)
        local roots = {}
        local mon = Workspace:FindFirstChild("Monsters")
        if mon then
            roots[#roots + 1] = mon
            for _, child in ipairs(mon:GetChildren()) do
                if child.ClassName == "Folder" or child.ClassName == "Model" then roots[#roots + 1] = child end
            end
        end
        local best, bestDist = nil, radius or 400
        for _, root in ipairs(roots) do
            for _, model in ipairs(root:GetChildren()) do
                local name = string.lower(tostring(model.Name or ""))
                if string.find(name, needle, 1, true) then
                    local pos = getPartPos(model)
                    local humanoid = model:FindFirstChildOfClass("Humanoid")
                    local hp = nil
                    pcall(function() hp = humanoid and humanoid.Health end)
                    if pos and (hp == nil or hp > 0) then
                        local dist = (pos - hrp.Position).Magnitude
                        if dist < bestDist then best, bestDist = model, dist end
                    end
                end
            end
        end
        return best, bestDist
    end

     
     
     
    Nav.mobHunt = function(mob, field, seconds)
        if not mob or mob == "" then return false end
        local stop = { running = true }
        local deadline = tick() + (tonumber(seconds) or 30)
        local spawn = Nav.mobSpawner(mob)
        local fieldInfo = field and getField(field) or nil
        local killed = false

        status = "Quest: hunting " .. mob
        Nav.spawnHits(stop)
        while isOn() and tick() < deadline do
            local target, dist = Nav.findQuestMob(mob, 500)
            if target then
                local pos = getPartPos(target)
                if pos and dist and dist > 16 then
                    status = "Quest: closing on " .. mob
                    Nav.go(pos, S.glide_speed, 5, "Mob")
                end
                status = "Quest: fighting " .. mob
                local alive = true
                pcall(function() alive = target.Parent ~= nil end)
                if not alive then killed = true end
                task.wait(0.25)
            else
                local hrp = getHRP()
                local dest = spawn and spawn.pos or (fieldInfo and fieldInfo.Position)
                if dest and hrp then
                    local reach = (dest - hrp.Position).Magnitude
                    if reach > 45 then
                        status = "Quest: to " .. tostring(spawn and spawn.name or field)
                        Nav.go(dest, S.glide_speed, 7, "Mob spawn")
                    else
                         
                         
                        status = "Quest: waiting for " .. mob
                        task.wait(0.5)
                    end
                else
                    status = "Quest: no " .. mob .. " spawner found"
                    task.wait(0.5)
                end
            end
        end
        stop.running = false
        return killed
    end

     
     
    Nav.popPuffs = function(field, seconds)
        local stop = { running = true }
        local deadline = tick() + (tonumber(seconds) or 30)
        local popped = false
        status = "Quest: popping puffshrooms"
        Nav.spawnHits(stop)
        while isOn() and tick() < deadline do
            local hrp = getHRP()
             
             
             
            local now = tick()
            if not Nav._puffCache or (now - (Nav._puffAt or 0)) > 2 then
                Nav._puffAt = now
                Nav._puffCache = {}
                local ok, list = pcall(function() return Workspace:GetChildren() end)
                for _, model in ipairs((ok and list) or {}) do
                    local name = string.lower(tostring(model.Name or ""))
                    if string.find(name, "puffshroom", 1, true) then
                        local pos = getPartPos(model)
                        if pos then Nav._puffCache[#Nav._puffCache + 1] = pos end
                    end
                end
            end

            local best, bestDist = nil, 260
            for _, pos in ipairs(Nav._puffCache) do
                if hrp and (not field or inField(pos, field, 40)) then
                    local dist = (pos - hrp.Position).Magnitude
                    if dist < bestDist then best, bestDist = pos, dist end
                end
            end
            if best then
                if bestDist > 12 then
                    Nav.go(best, S.glide_speed, 4, "Puffshroom")
                else
                    popped = true
                    task.wait(0.3)
                end
            else
                task.wait(0.4)
            end
        end
        stop.running = false
        return popped
    end

     
     
     
     
     
     
     
     
     
     
    Nav.questJob = function()
        if not isOn() or not Engine.questOn() then return nil end
         
         
        local read = Nav.questRead
        local list = type(read) == "function" and read() or {}
        if type(list) ~= "table" or #list < 1 then return nil end

        if tick() >= (Nav.turnAt or 0) then
            for _, entry in ipairs(list) do
                if entry.left == 0 and entry.giver then
                    local giver = Nav.questByName(entry.giver)
                    if giver then
                        Nav.turnAt = tick() + 8
                        Nav.questBusy = true
                        local ok, err = pcall(Nav.questDo, giver)
                        Nav.questBusy = false
                        if type(Nav.questRead) == "function" then Nav.questRead(true) end
                        if not ok then status = "Quest turn-in error: " .. tostring(err) end
                        return { kind = "turnin", giver = giver.name, entry = entry }
                    end
                end
            end
        end

        local entry = Nav.questTarget(list)
        if not entry then return nil end
        Nav.questTrack = entry.title

        local worked = nil
        for _, task in ipairs(entry.tasks) do
            if not task.done and Nav.questEnabled(task) and not Nav.questStalled(task) then
                worked = task
                break
            end
        end
        if not worked then
            Nav.questTaskLine = entry.title .. ": unhandled task"
            return { kind = "manual", entry = entry }
        end
        return {
            kind = worked.kind,
            task = worked,
            field = worked.field,
            mob = worked.mob,
            entry = entry,
            giver = entry.giver,
        }
    end

     
     
     
     
    Nav.questWork = function(job)
        if not job then job = Nav.questJob() end
        if not job then return false end
        local passKind = job.kind == "mobs" or job.kind == "puff"
            or job.kind == "tokens" or job.kind == "planters" or job.kind == "nectar"
        if not passKind then return false end

        local now = tick()
        local waitFor = tonumber(S.quest_pass) or 20
        local since = now - (Nav.passAt or 0)
        if since < waitFor then
            Nav.questTaskLine = tostring(job.entry and job.entry.quest or "Quest") .. ": "
                .. tostring(job.kind) .. " in " .. math.floor(waitFor - since) .. "s"
            return false
        end
        Nav.passAt = now

        local quest = tostring(job.entry and job.entry.quest or "Quest")
        if job.kind == "mobs" then
            Nav.questTaskLine = quest .. ": hunting " .. tostring(job.mob)
            if not Nav.mobHunt(job.mob, job.field, S.quest_hunt) then
                Nav.questFail(job.task)
            end
        elseif job.kind == "puff" then
            Nav.questTaskLine = quest .. ": puffshrooms"
            if not Nav.popPuffs(job.field, S.quest_hunt) then
                Nav.questFail(job.task)
            end
        elseif job.kind == "tokens" then
            Nav.questTaskLine = quest .. ": tokens"
            Nav.questTokens(job.field, S.quest_hunt)
        else
            Nav.questTaskLine = quest .. ": planters"
            pcall(nectarStep)
        end
        if type(Nav.questRead) == "function" then Nav.questRead(true) end
        return true
    end

     
     
     
    Nav.questTokens = function(name, seconds)
        local field = name and getField(name) or nil
        local deadline = tick() + (tonumber(seconds) or 20)
        status = "Quest: collecting tokens"
        while isOn() and tick() < deadline do
            touchCollectibles(field)
            if field then
                farmFieldTurnStep(field, nil)
            else
                task.wait(0.3)
            end
        end
        return true
    end

     
     
     
     
    Nav.questFarm = function(name, seconds)
        local field = getField(name)
        if not field or not isOn() then return false end
        local hrp = getHRP()
        if not hrp then return false end
        local c = field.Position
        local standY = groundY(field) + 2

        if not inField(hrp.Position, field, 30) then
            status = "Quest: to " .. tostring(name)
            Nav.goField(name, Vector3.new(c.X, standY + 1, c.Z), S.glide_speed, "Quest field")
            hrp = getHRP()
            if not hrp or not inField(hrp.Position, field, 34) then
                status = "Quest: could not reach " .. tostring(name)
                return false
            end
        end

        status = "Quest: farming " .. tostring(name)
        collecting = true
        local deadline = tick() + (tonumber(seconds) or 10)
        while isOn() and tick() < deadline do
            autoDigCursorFree()
            farmFieldTurnStep(field, nil)
        end
        Nav.questTaskLine = "Farming " .. tostring(name)
        return true
    end

    Nav.taskProgressText = function(task)
        if task.have and task.need then
            return " (" .. tostring(task.have) .. "/" .. tostring(task.need) .. ")"
        end
        return ""
    end

    Nav.questTravel = function(pos, label)
        if not pos then return false end
        local hrp = getHRP()
        if hrp and (Vector3.new(pos.X, 0, pos.Z) - Vector3.new(hrp.Position.X, 0, hrp.Position.Z)).Magnitude <= 14 then
            return true
        end
        if S.travel_mode == "Tween" then
            return Nav.tweenTravel(pos, S.glide_speed, 9, label)
        end
        local ok = Nav.nodeTravel(pos, label, 9)
        if not ok and isOn() then
             
             
             
            ok = Nav.tweenTravel(pos, S.glide_speed, 9, label)
        end
        return ok
    end

    Nav.questDo = function(giver)
        if not giver then return false end
        local label = "Quest: " .. giver.name
        Nav.questLast = giver.name
        Nav.questAt = tick() + math.max(10, tonumber(S.quest_check) or 25)

         
         
        local bypass = (S.quest_bypass ~= false) and S.hybrid == true
        if not bypass then
            status = "Quest: to " .. giver.name
            if not Nav.questTravel(Nav.questPos(giver), label) then
                status = "Quest: could not reach " .. giver.name
                return false
            end
            if not isOn() then return false end
        end

        if S.hybrid then
            local key = giver.pool or giver.name
            status = "Quest: " .. giver.name .. (bypass and " (bypass)" or " at the giver")
            Nav.questFire("CompleteQuestFromPool", key)
            if key ~= giver.name then Nav.questFire("CompleteQuestFromPool", giver.name) end
            task.wait(0.4)
            Nav.questFire("GiveQuestFromPool", giver.name)
            if key ~= giver.name then Nav.questFire("GiveQuestFromPool", key) end
            task.wait(0.3)
        else
             
             
             
             
            status = "Quest: talking to " .. giver.name
            local npcPos = Nav.questPos(giver)
            Nav.usePromptAt(npcPos, 32)
            task.wait(0.5)
            Nav.usePromptAt(npcPos, 32)
        end

        return true
    end

     
     
    Nav.questStep = function(force)
        if not isOn() then return end
        if not Engine.questOn() then return end
        local now = tick()
        if not force and now < (Nav.questAt or 0) then return end
        local list = Nav.questList()
        if #list < 1 then
            status = "Quests: no giver enabled"
            return
        end
        local index = (Nav.questIndex or 0) + 1
        if index > #list then index = 1 end
        Nav.questIndex = index
        Nav.questDo(list[index])
    end

    local tunnelBearCooldown, kingBeetleCooldown, crabCooldown = 0, 0, 0

     
     
     
     
 
 
 
Nav.findStinger = function()
    local roots = {}
    local coll = Workspace:FindFirstChild("Collectibles")
    if coll then roots[#roots + 1] = coll end
    roots[#roots + 1] = Workspace
    local hrp = getHRP()
    local me = hrp and hrp.Position
    local best, bestD = nil, math.huge
    for _, root in ipairs(roots) do
        local ok, kids = pcall(function() return root:GetChildren() end)
        if ok and kids then
            for _, tok in ipairs(kids) do
                local tn = string.lower(tostring(tok.Name or ""))
                 
                local decor = string.find(tn, "sign", 1, true) or string.find(tn, "icon", 1, true)
                    or string.find(tn, "sound", 1, true)
                if not decor and string.find(tn, "sting", 1, true) then
                    local p = getPartPos(tok)
                    if p then
                        local d = 0
                        if me then d = Vector3.new(p.X - me.X, 0, p.Z - me.Z).Magnitude end
                        if d < bestD then
                            bestD = d
                            best = { part = tok, pos = p }
                        end
                    end
                end
            end
        end
    end
    return best
end

Nav.findMonster = function(pattern)
    local pat = string.lower(tostring(pattern or ""))
    if pat == "" then return nil end
    local roots = {}
    local mon = Workspace:FindFirstChild("Monsters")
    if mon then roots[#roots + 1] = mon end
    local bees = Workspace:FindFirstChild("Bees")
    if bees then roots[#roots + 1] = bees end
     
     
     
    for _, root in ipairs(roots) do
        local ok, kids = pcall(function() return root:GetChildren() end)
        if ok and kids then
            for _, m in ipairs(kids) do
                local n = string.lower(tostring(m.Name or ""))
                local decor = string.find(n, "lair", 1, true) or string.find(n, "door", 1, true)
                    or string.find(n, "sign", 1, true) or string.find(n, "gate", 1, true)
                if not decor and string.find(n, pat, 1, true) and getPartPos(m) then
                     
                    local live = false
                    pcall(function()
                        live = m:FindFirstChild("HumanoidRootPart") ~= nil
                            or m:FindFirstChildOfClass("Humanoid") ~= nil
                    end)
                    if live then return m end
                end
            end
        end
    end
    return nil
end

     
     
     
     
     
     
     
     
     
     
     
     
    Nav.bossRespawn = function(bossName)
        local pat = string.lower(tostring(bossName or ""))
        if pat == "" then return nil end
        local cache = Nav._bossTimerCache
        if not cache then cache = {}; Nav._bossTimerCache = cache end
        local now = tick()
        local hit = cache[pat]
        if hit and now - hit.at < 1 then return hit.secs, hit.txt end

        local secs, txt = nil, nil
        local spawners = Workspace:FindFirstChild("MonsterSpawners")
        if spawners then
            local ok, kids = pcall(function() return spawners:GetChildren() end)
            for _, s in ipairs((ok and kids) or {}) do
                 
                 
                local typeName = ""
                pcall(function()
                    local mt = s:FindFirstChild("MonsterType")
                    if mt and type(mt.Value) == "string" then typeName = mt.Value end
                end)
                local typeLower = string.lower(typeName)
                local partLower = string.lower(tostring(s.Name or ""))
                local isMine = (typeLower ~= "" and string.find(typeLower, pat, 1, true) ~= nil)
                    or string.find(partLower, pat, 1, true) ~= nil
                if isMine then
                    local okDesc, descs = pcall(function() return s:GetDescendants() end)
                    for _, desc in ipairs((okDesc and descs) or {}) do
                        if desc.ClassName == "TextLabel" then
                            local t = safeText(desc)
                            local head = nil
                            if typeLower ~= "" then
                                local _, he = string.find(string.lower(t), typeLower .. ":", 1, true)
                                head = he
                            end
                            if head then
                                local clock = string.sub(t, head + 1)
                                local total = nil
                                 
                                for num, unit in string.gmatch(clock, "(%d+)%s*([hms])") do
                                    local n = tonumber(num) or 0
                                    total = (total or 0)
                                    if unit == "h" then total = total + n * 3600
                                    elseif unit == "m" then total = total + n * 60
                                    else total = total + n end
                                end
                                 
                                 
                                 
                                 
                                if not total then
                                    local parts = string.match(clock, "([%d:]+)%s*$")
                                    if parts then
                                        local groups, count = {}, 0
                                        for g in string.gmatch(parts, "%d+") do
                                            count = count + 1
                                            groups[count] = tonumber(g) or 0
                                        end
                                        if count >= 1 and count <= 4 then
                                            local mult = { 1, 60, 3600, 86400 }
                                            total = 0
                                            for i = 1, count do
                                                total = total + groups[count - i + 1] * mult[i]
                                            end
                                        end
                                    end
                                end
                                if total then
                                    secs = total
                                    txt = (string.gsub(clock, "^%s+", ""))
                                end
                            else
                                 
                                 
                                 
                                secs, txt = 0, nil
                            end
                            break
                        end
                    end
                end
                if secs ~= nil then break end
            end
        end
        cache[pat] = { at = now, secs = secs, txt = txt }
        return secs, txt
    end

     
     
    Nav.bossStatus = function(pattern)
        local pat = string.lower(tostring(pattern or ""))
        if pat == "" then return "-" end
        local cache = Nav._bossTimerCache
        if not cache then cache = {}; Nav._bossTimerCache = cache end
        local now = tick()
        local key = "s:" .. pat
        local hit = cache[key]
        if hit and now - hit.at < 1 then return hit.txt end
        local txt
        if Nav.findMonster(pat) then
            txt = "up"
        else
            local secs, raw = Nav.bossRespawn(pat)
            if secs and secs > 0 then
                txt = raw and tostring(raw) or "cooling"
            elseif secs then
                txt = "ready"
            else
                txt = "-"
            end
        end
        cache[key] = { at = now, txt = txt }
        return txt
    end

     
     
     
    local function checkBossOnCooldown(bossName)
        local secs, txt = Nav.bossRespawn(bossName)
        if secs and secs > 0 then return true, txt, secs end
        return false, txt, 0
    end

     
     
     
     
     
    Nav.bossRetry = function(secs)
        return math.min(math.max(tonumber(secs) or 60, 5), 120)
    end

     
     
     
     
     
     
     
     
    Nav.miscToys = {
        { key = "honeystorm", label = "Summon Honeystorm", cd = 4 * 3600,
          at = Vector3.new(234.2, 35.2, 163.3), toy = "Honeystorm" },
        { key = "sprout", label = "Summon Special Sprout", cd = 16 * 3600,
          at = Vector3.new(-269.1, 28.5, 265.8), toy = "Sprout Summoner" },
        { key = "coconut", label = "Use Coconut Dispenser", cd = 4 * 3600,
          at = Vector3.new(-177.8, 74.4, 531.2), toy = "Coconut Dispenser",
          needsCrab = true },
        { key = "blueberry", label = "Use Blueberry Dispenser", cd = 4 * 3600,
          at = Vector3.new(309.2, 6.0, 135.9), toy = "Blueberry Dispenser" },
        { key = "strawberry", label = "Use Strawberry Dispenser", cd = 4 * 3600,
          at = Vector3.new(-319.9, 47.9, 272.2), toy = "Strawberry Dispenser" },
        { key = "redbooster", label = "Use Red Field Booster", cd = 45 * 60,
          at = Vector3.new(-317.0, 22.0, 241.9), toy = "Red Field Booster" },
        { key = "bluebooster", label = "Use Blue Field Booster", cd = 45 * 60,
          at = Vector3.new(271.2, 59.5, 84.3), toy = "Blue Field Booster" },
        { key = "treat", label = "Use Treat Dispenser", cd = 60 * 60,
          at = Vector3.new(192.6, 69.7, -122.7), toy = "Treat Dispenser" },
        { key = "fieldbooster", label = "Use Field Booster", cd = 45 * 60,
          at = Vector3.new(-35.0, 177.8, -188.6), toy = "Field Booster" },
         
         
        { key = "meteor", label = "Use Mythic Meteor Shower", cd = 22 * 3600,
          at = Vector3.new(-449.4, 118.6, 49.7), toy = "Mythic Meteor Shower",
          travel = "tween" },
        { key = "honeydispenser", label = "Use Honey Dispenser", cd = 60 * 60,
          at = Vector3.new(46.0, 6.9, 321.1), toy = "Honey Dispenser" },
         
         
         
         
         
         
         
         
         
        { key = "glue", label = "Use Glue Dispenser", cd = 22 * 3600,
          resetAfter = true,
          steps = {
            standard = {
              { at = Vector3.new(271.9, 25258.3, -722.2), teleport = true, pressE = true },
            },
            hybrid = {
              { at = Vector3.new(14.6, 94.0, 485.8), tween = true },
              { active = "Gumdrops" },
              { awaitRide = true, at = Vector3.new(271.3, 25258.3, -722.9), tween = true },
              { toy = "Glue Dispenser" },
            },
          } },
    }

     
     
    Nav.miscState = {}
    Nav.crabKilled = false

    Nav.hmsText = function(secs)
        secs = math.max(0, math.floor(tonumber(secs) or 0))
        local h = math.floor(secs / 3600)
        local m = math.floor((secs % 3600) / 60)
        local s = secs % 60
        if h > 0 then return string.format("%dh %dm", h, m) end
        if m > 0 then return string.format("%dm %ds", m, s) end
        return tostring(s) .. "s"
    end

     
     
    Nav.crabUp = function()
        local mon = Workspace:FindFirstChild("Monsters")
        if not mon then return false end
        local ok, kids = pcall(function() return mon:GetChildren() end)
        for _, m in ipairs((ok and kids) or {}) do
            local n = string.lower(tostring(m.Name or ""))
            if (string.find(n, "coconut", 1, true) or string.find(n, "crab", 1, true)) and getPartPos(m) then
                return true
            end
        end
        return false
    end

     
     
    Nav.usePromptAt = function(pos, radius)
        pcall(function() Nav.firePromptNear(pos, radius or 30) end)
        pcall(function() keypress(0x45) end)
        task.wait(0.06)
        pcall(function() keyrelease(0x45) end)
        task.wait(0.25)
    end

     
     
     
    Nav.hardTeleport = function(pos)
        local hrp = getHRP()
        if not hrp then return false end
        pcall(function() Nav.noclipTravel(true) end)
        for _ = 1, 2 do
            pcall(function()
                local h = getHRP()
                if h then
                    h.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
                    h.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    h.Velocity = Vector3.new(0, 0, 0)
                end
            end)
            task.wait(0.2)
        end
        pcall(function() Nav.noclipTravel(false) end)
        local after = getHRP()
        return after ~= nil and (after.Position - pos).Magnitude <= 14
    end

     
     
     
     
    Nav.awaitRide = function(before, timeout)
        timeout = tonumber(timeout) or 20
        local deadline = tick() + timeout
        while tick() < deadline do
            if not isOn() then return false end
            local hrp = getHRP()
            if not hrp then return false end
            local moved = (hrp.Position - before).Magnitude > 400
            if moved or hrp.Position.Y > 1000 then
                task.wait(0.4)
                return true
            end
            task.wait(0.25)
        end
        return false
    end

     
     
     
     
    Nav.miscTravel = function(step, label)
        if step.teleport then
            return Nav.hardTeleport(step.at)
        end
        local here = getHRP()
        if step.awaitRide and here then
            if Nav.awaitRide(here.Position, 20) then
                here = getHRP()
                 
                 
                if here and (here.Position - step.at).Magnitude <= 8 then return true end
            end
        elseif not step.tween then
            if Nav.nodeTravel(step.at, label, 5) then return true end
             
             
        end
        local dist = here and (here.Position - step.at).Magnitude or 200
         
         
        local speed = math.max(tonumber(S.glide_speed) or 120, math.min(900, dist / 20))
        return Nav.tweenTravel(step.at, speed, 5, label)
    end

    Nav.miscRun = function(entry)
        local steps = entry.steps and (S.hybrid and entry.steps.hybrid or entry.steps.standard)
        if not steps then
            local glide = entry.travel == "tween"
            if S.hybrid then
                steps = { { at = entry.at, tween = glide }, { toy = entry.toy } }
            else
                steps = { { at = entry.at, pressE = true, tween = glide } }
            end
        end
        for _, step in ipairs(steps) do
            if not isOn() then return false end
            if step.at then
                local label = entry.label .. " travel"
                local ok = Nav.miscTravel(step, label)
                if not ok and not getHRP() then return false end
                task.wait(0.25)
            end
            if step.toy then
                fireEvent("ToyEvent", step.toy)
                task.wait(0.4)
            end
            if step.active then
                fireEvent("PlayerActivesCommand", { Name = step.active })
                task.wait(0.4)
            end
            if step.pressE and step.at then
                Nav.usePromptAt(step.at)
            end
        end
         
         
         
         
         
        if entry.resetAfter and type(Nav.resetCharacter) == "function" then
            for _ = 1, 12 do
                if Nav.resetCharacter(entry.label) then break end
                if not isOn() then break end
                task.wait(2)
            end
        end
        return true
    end

     
     
     
     
    Nav.miscStep = function()
        if not isOn() then return end
        local now = tick()
        if now < (Nav.miscNext or 0) then return end
        for _, entry in ipairs(Nav.miscToys) do
            if S.misc and S.misc[entry.key] and now >= (tonumber(Nav.miscState[entry.key]) or 0) then
                 
                 
                if entry.needsCrab and not Nav.crabKilled and Nav.crabUp() then
                    S.misc_status = entry.label .. ": kill the Coconut Crab first"
                    return
                end
                status = "Misc: " .. entry.label
                Nav.miscNext = tick() + math.max(5, tonumber(S.misc_gap) or 12)
                if Nav.miscRun(entry) then
                    Nav.miscState[entry.key] = tick() + entry.cd
                    S.misc_status = entry.label .. " done, ready again in " .. Nav.hmsText(entry.cd)
                else
                     
                     
                    Nav.miscState[entry.key] = tick() + 30
                    S.misc_status = entry.label .. ": retrying"
                end
                 
                 
                return true
            end
        end
    end

     
     
     
     
    Nav.bossTravel = function(pos, arrive, label)
        if not pos then return false end
        if S.travel_mode == "Tween" then
            return Nav.tweenTravel(pos, S.glide_speed, arrive or 6, label or "Boss travel")
        end
        return Nav.go(pos, S.glide_speed, arrive or 6, label or "Boss travel")
    end

     
     
     
     
    Nav.goField = function(name, point, speed, label)
        local legs = name and Nav.legRoutes and Nav.legRoutes[name]
        if legs and S.travel_mode ~= "Tween" then
            local done = Nav.walkLegs(legs, label or ("To " .. tostring(name)), 3.5, { viaHive = true })
            if not done and not isOn() then return false end
            if point then
                return Nav.walk(point, { arrive = 4, timeout = 25, label = label or "Field centre" })
            end
            return done
        end
        return Nav.go(point, speed, 3, label or "Travel")
    end

     
     
    Nav.spawnHits = function(stopFlag)
        return task.spawn(function()
            while stopFlag.running and isOn() do
                combatHit()
                task.wait(0.2)
            end
        end)
    end

     
     
     
     
     
     
     
     
     
     
     
     
     
    local Watch = {
        fails = 0, resets = 0, lastReset = 0,
        lastPos = nil, stillSince = nil, onReset = nil,
        offsets = nil, offsetTried = false, busy = false,
    }

    Watch.humanoidOffsets = function()
        if Watch.offsetTried then return Watch.offsets end
        Watch.offsetTried = true
        pcall(function()
            local get = game.HttpGet
            if type(get) ~= "function" then get = HttpGet end
            if type(get) ~= "function" then return end
            local version = getrbxversion and getrbxversion() or nil
            if type(version) ~= "string" or version == "" then return end
            local body = get(game, "https://offsets.imtheo.lol/" .. version .. "/offsets.json")
            if type(body) ~= "string" or body == "" then return end
            local decoded = HttpService and HttpService:JSONDecode(body) or nil
             
             
            local classes = decoded and (decoded.Offsets or decoded)
            local hum = classes and classes.Humanoid
            if type(hum) == "table" and tonumber(hum.Health) then
                Watch.offsets = hum
            end
        end)
        return Watch.offsets
    end

    Watch.fail = function(what)
        Watch.fails = Watch.fails + 1
        status = "Watchdog: " .. tostring(what) .. " failed " .. Watch.fails .. "/2"
        if Watch.fails < 2 then return false end
        return Watch.reset(what)
    end

     
     
     
    Watch.reset = function(what, force)
        if Watch.busy then return false end
        if not force and tick() - Watch.lastReset < 25 then return false end
        Watch.busy = true
        Watch.lastReset = tick()
        Watch.fails = 0
        Watch.resets = Watch.resets + 1
        status = "Watchdog: reset after " .. tostring(what)
        pcall(function() Nav.release() end)
        pcall(function() if Nav.stopSpeedWrite then Nav.stopSpeedWrite() end end)

        local oldChar = lp.Character
        local killed = false
        pcall(function()
            local hum = getHum()
            local base = hum and hum.Address
            local offsets = base and Watch.humanoidOffsets() or nil
            local write = Nav.memWriter and Nav.memWriter() or nil
            local healthOffset = offsets and tonumber(offsets.Health) or nil
            if write and base and healthOffset and healthOffset > 0 then
                write(base + healthOffset, 0)
                killed = true
            end
        end)
        if not killed then
            pcall(function()
                local hum = getHum()
                if hum then hum.Health = 0 end
            end)
        end
        task.wait(0.8)
        local died = false
        pcall(function()
            local c = lp.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            died = (h == nil) or (h.Health <= 0) or (c ~= oldChar)
        end)
        if not died then
             
             
            pcall(function()
                if not rbxActive() then return end
                setrobloxinput(true)
                keypress(0x1B); task.wait(0.12); keyrelease(0x1B)
                task.wait(0.55)
                keypress(0x52); task.wait(0.12); keyrelease(0x52)
                task.wait(0.55)
                keypress(0x0D); task.wait(0.12); keyrelease(0x0D)
            end)
        end

        local deadline = tick() + 22
        while isOn() and tick() < deadline do
            local character = lp.Character
            local hum = character and character:FindFirstChildOfClass("Humanoid")
            if character ~= oldChar and hum and hum.Health > 0 then
                task.wait(1.2)
                break
            end
            task.wait(0.25)
        end
        Watch.lastPos = nil
        Watch.stillSince = nil
        if type(Watch.onReset) == "function" then pcall(Watch.onReset) end
        Watch.busy = false
        status = "Watchdog: back at hive, retrying"
        return true
    end

     
     
     
    Watch.tick = function(farming)
        local hrp = getHRP()
        local now = tick()
        if not hrp or not farming then
            Watch.lastPos = nil
            Watch.stillSince = nil
            return
        end
        local pos = hrp.Position
        if not Watch.lastPos or (pos - Watch.lastPos).Magnitude > 3 then
            Watch.lastPos = pos
            Watch.stillSince = now
            return
        end
        if Watch.stillSince == nil then Watch.stillSince = now; return end
        if now - Watch.stillSince > 8 then
            Watch.lastPos = nil
            Watch.stillSince = nil
            Watch.fail("stuck")
        end
    end

    if _G then _G.__lolcatWatch = Watch end

     
     
     
     
     
    Nav.resetCharacter = function(label)
        return Watch.reset(label or "reset", true)
    end

    local function killTunnelBear()
        if not getHRP() then return end
        if tick() < tunnelBearCooldown then return end

        status = "Combat: checking Tunnel Bear"
         
         
         
        local tunnelFloor = Vector3.new(281.4, 6.3, -44.4)
        local activatePos = Vector3.new(380.6, 6.3, -45.7)
        local portalPos   = Vector3.new(548.6, 6.6, -48.9)

        local tb = Nav.findMonster("tunnel")
        if not tb then
            local onCd, txt, secs = checkBossOnCooldown("Tunnel")
            if onCd then
                 
                 
                status = "Tunnel Bear respawns in " .. tostring(txt)
                tunnelBearCooldown = tick() + Nav.bossRetry(secs)
                return
            end
             
             
             
            local tunnelLegs = Nav.legRoutes["Tunnel Bear"]
            local climbLegs = {}
            for index = 1, 11 do climbLegs[index] = tunnelLegs[index] end
            Nav.walkLegs(climbLegs, "Tunnel Bear travel", 3.5, { viaHive = true })
            if not getHRP() then return end
            status = "Tunnel Bear: dropping in"
            Nav.tweenTravel(Vector3.new(281.6, 6.3, -45.0),
                math.max(tonumber(S.glide_speed) or 120, 120), 3, "Tunnel drop")
            if not getHRP() then return end
             
             
            status = "Tunnel Bear: activating"
            Nav.walk(activatePos, { arrive = 3.5, timeout = 30, label = "Tunnel Bear activate" })
            pcall(function() Nav.firePromptNear(activatePos, 22) end)
            task.wait(0.4)
            local tWait = tick()
            while isOn() and tick() - tWait < 6 do
                tb = Nav.findMonster("tunnel")
                if tb then break end
                task.wait(0.2)
            end
        end

        if not tb then
            tunnelBearCooldown = tick() + 45
            Watch.fail("tunnel bear")
            return
        end

        status = "Combat: fighting Tunnel Bear"
         
         
         
         
         
         
         
         
         
         
        local swing = { running = true }
        Nav.spawnHits(swing)
        local dl = tick() + 240
        local lastSeen = tick()
        local laneMinX, laneMaxX = 300, 990
        local dir, dirSet = 1, false
        while isOn() and tick() < dl do
            if not (tb and tb.Parent) then
                tb = Nav.findMonster("tunnel")
                if not tb then break end
            end
            local bp2 = getPartPos(tb)
            local hrp2 = getHRP()
            if bp2 and hrp2 then
                lastSeen = tick()
                local here = hrp2.Position
                local gap = math.abs(bp2.X - here.X) + math.abs(bp2.Z - here.Z)
                if not dirSet then
                     
                    dirSet = true
                    if bp2.X <= here.X then
                        dir = ((laneMaxX - here.X) >= 60) and 1 or -1
                    else
                        dir = ((here.X - laneMinX) >= 60) and -1 or 1
                    end
                elseif (bp2.X - here.X) * dir > 0 then
                     
                     
                    if (dir > 0 and (here.X - laneMinX) > 60) or (dir < 0 and (laneMaxX - here.X) > 60) then
                        dir = -dir
                    end
                end
                local stepLen
                if gap < 22 then
                    stepLen = 18            
                elseif gap > 34 then
                    stepLen = 4             
                else
                    stepLen = 7             
                end
                local stepX = math.clamp(here.X + dir * stepLen, laneMinX, laneMaxX)
                if math.abs(stepX - here.X) < 1.5 then
                     
                     
                    task.wait(0.2)
                else
                    Nav.walk(Vector3.new(stepX, here.Y, here.Z), {
                        arrive = 3, timeout = 4, label = "Tunnel Bear kite",
                    })
                     
                     
                    if gap >= 22 then task.wait(0.18) end
                end
                combatHit()
            end
            if tick() - lastSeen > 8 then break end
            task.wait(0.05)
        end
        swing.running = false

         
         
        if Nav.findMonster("tunnel") then
            status = "Tunnel Bear: still alive"
            tunnelBearCooldown = tick() + 12
            return
        end

        status = "Looting Tunnel Bear"
        tunnelBearCooldown = tick() + 60
         
         
         
         
         
        local lootEnd = tick() + 12
        while isOn() and tick() < lootEnd do
            local coll = Workspace:FindFirstChild("Collectibles")
            local hrp3 = getHRP()
            local best, bestD = nil, 1e9
            if coll and hrp3 then
                local okKids, kids = pcall(function() return coll:GetChildren() end)
                for _, tok in ipairs((okKids and kids) or {}) do
                    local p = getPartPos(tok)
                    if p and p.X >= 290 and p.X <= 1010 and math.abs(p.Z + 48) <= 22 then
                        local d = (p - hrp3.Position).Magnitude
                        if d <= 24 then pcall(function() Nav.touchToken(tok) end) end
                        if d < bestD then bestD = d; best = p end
                    end
                end
            end
            if not best then break end
            if bestD > 7 then
                Nav.walk(Vector3.new(best.X, best.Y + 1, best.Z), {
                    arrive = 6, timeout = 3, label = "Tunnel loot",
                })
            else
                task.wait(0.08)
            end
        end

         
         
         
        status = "Tunnel Bear: leaving"
        if S.hybrid then
            Nav.walk(portalPos, { arrive = 4, timeout = 35, label = "Tunnel portal" })
            pcall(function()
                local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
                local toy = events and events:FindFirstChild("ToyEvent")
                if toy then toy:FireServer("Tunnel Portal") end
            end)
        else
             
             
            local padPos, padPart = portalPos, nil
            pcall(function()
                local toys = Workspace:FindFirstChild("Toys")
                local model = toys and toys:FindFirstChild("Tunnel Portal")
                local platform = model and (model:FindFirstChild("Platform") or model.PrimaryPart)
                local p = platform and platform.Position
                if p then padPos, padPart = p, platform end
            end)
            Nav.walk(Vector3.new(padPos.X, padPos.Y + 3, padPos.Z), {
                arrive = 3, timeout = 40, label = "Tunnel exit pad",
            })
             
             
            local tryEnd = tick() + 8
            while isOn() and tick() < tryEnd do
                local hrp4 = getHRP()
                if not hrp4 then break end
                local near = (Vector3.new(hrp4.Position.X, padPos.Y, hrp4.Position.Z)
                    - Vector3.new(padPos.X, padPos.Y, padPos.Z)).Magnitude <= 4
                if near then
                    pcall(function() Nav.firePromptNear(padPos, 24) end)
                    pcall(function()
                        if padPart and type(firetouchinterest) == "function" then
                            firetouchinterest(hrp4, padPart, 0)
                            firetouchinterest(hrp4, padPart, 1)
                        end
                    end)
                    pcall(function() keypress(0x45) end)
                    task.wait(0.12)
                    pcall(function() keyrelease(0x45) end)
                    task.wait(0.25)
                    local after = getHRP()
                    if not after or (after.Position - padPos).Magnitude > 60 then break end
                else
                    Nav.walk(Vector3.new(padPos.X, padPos.Y + 3, padPos.Z), {
                        arrive = 3, timeout = 6, label = "Tunnel exit pad",
                    })
                end
            end
        end
        task.wait(1.2)
    end

    local function killKingBeetle()
        if not getHRP() then return end
        if tick() < kingBeetleCooldown then return end

        status = "Combat: checking King Beetle"
         
         
        local entrance = Vector3.new(194.3, 4.1, 172.0)

        local kb = Nav.findMonster("king beetle") or Nav.findMonster("king")
        if not kb then
            local onCd, txt, secs = checkBossOnCooldown("King")
            if onCd then
                 
                 
                status = "King Beetle respawns in " .. tostring(txt)
                kingBeetleCooldown = tick() + Nav.bossRetry(secs)
                return
            end
            Nav.walkLegs(Nav.legRoutes["King Beetle"], "King Beetle travel", 3.5, { viaHive = true })
            task.wait(0.4)
            local tWait = tick()
            while isOn() and tick() - tWait < 5 do
                kb = Nav.findMonster("king beetle") or Nav.findMonster("king")
                if kb then break end
                task.wait(0.2)
            end
        end

        if not kb then
            kingBeetleCooldown = tick() + 45
            Watch.fail("king beetle")
            return
        end

        status = "Combat: fighting King Beetle"
         
         
         
        local ring = {
            Vector3.new(132, 5, 160),
            Vector3.new(232, 5, 160),
            Vector3.new(232, 5, 220),
            Vector3.new(132, 5, 220),
            Vector3.new(122, 5, 180),
            Vector3.new(242, 5, 180),
            Vector3.new(182, 5, 240),
            Vector3.new(182, 5, 150),
        }
        local swing = { running = true }
        Nav.spawnHits(swing)
        local dl = tick() + 240
        local lastSeen = tick()
        local ringIndex = 1
        while isOn() and tick() < dl do
            local alive = false
            pcall(function() alive = kb.Parent ~= nil end)
            if not alive then
                kb = Nav.findMonster("king beetle") or Nav.findMonster("king")
                if not kb then break end
            end
            local bp2 = getPartPos(kb)
            if bp2 then
                lastSeen = tick()
                local hrp2 = getHRP()
                if not hrp2 or (bp2 - hrp2.Position).Magnitude > 60 then
                    Nav.bossTravel(ring[ringIndex], 8, "King Beetle ring")
                    ringIndex = (ringIndex % #ring) + 1
                else
                    Nav.bossTravel(ring[ringIndex], 8, "King Beetle ring")
                    ringIndex = (ringIndex % #ring) + 1
                end
                combatHit()
            end
            if tick() - lastSeen > 6 then break end
            task.wait(0.12)
        end
        swing.running = false

        status = "Looting King Beetle"
        kingBeetleCooldown = tick() + 60
         
         
        local lootEnd = tick() + 5
        while isOn() and tick() < lootEnd do
            local coll = Workspace:FindFirstChild("Collectibles")
            local hrp3 = getHRP()
            local best, bestD = nil, 1e9
            if coll and hrp3 then
                for _, tok in ipairs(coll:GetChildren()) do
                    local p = getPartPos(tok)
                    if p and p.X >= 90 and p.X <= 265 and p.Z >= 100 and p.Z <= 265 then
                        local d = (p - hrp3.Position).Magnitude
                        if d < bestD then bestD = d; best = p end
                    end
                end
            end
            if best then
                Nav.walk(Vector3.new(best.X, best.Y + 1, best.Z), {
                    arrive = 2.5, timeout = 6, label = "Beetle loot",
                })
            else
                task.wait(0.15)
            end
        end

        Nav.walkLegs(Nav.legRoutes["King Beetle Return"], "King Beetle return", 3.5)
    end

    
    
    
    local function killCoconutCrab()
        if not getHRP() then return end
        if tick() < crabCooldown then return end

         
         
         
         
         
        local function findCrab()
            local mon = Workspace:FindFirstChild("Monsters")
            if not mon then return nil end
            local ok2, kids = pcall(function() return mon:GetChildren() end)
            for _, m in ipairs((ok2 and kids) or {}) do
                local n = string.lower(tostring(m.Name or ""))
                if string.find(n, "coconut", 1, true) or string.find(n, "crab", 1, true) then
                    if getPartPos(m) then return m end
                end
            end
            return nil
        end

         
         
         
         
         
        local crabCd, crabCdText, crabCdSecs = checkBossOnCooldown("Coconut")
        if crabCd and not findCrab() then
            status = "Coconut Crab respawns in " .. tostring(crabCdText)
            crabCooldown = tick() + Nav.bossRetry(crabCdSecs)
            return
        end

         
         
         
         
         
         
        local prevTravel = S.travel_mode
        S.travel_mode = "Tween"

         
         
         
         
         
        local fieldMid = Vector3.new(-254, 98.8, 469)
        local HOLD_Y = 115

         
         
        status = "Coconut Crab: travelling"
        local hrp = getHRP()
        if hrp and (hrp.Position - fieldMid).Magnitude > 120 then
            Nav.bossTravel(Vector3.new(fieldMid.X, HOLD_Y, fieldMid.Z), 8, "Crab field")
        end
        status = "Coconut Crab: at the field"
        task.wait(2)

         
         
        local crab = findCrab()
        local waitEnd = tick() + 60
        while isOn() and not crab and tick() < waitEnd do
            status = "Coconut Crab: waiting for spawn"
             
            Nav.bossTravel(Vector3.new(fieldMid.X, HOLD_Y, fieldMid.Z), 3, "Crab hold")
            task.wait(0.4)
            crab = findCrab()
        end

        if not crab then
            status = "Coconut Crab: not spawned"
            S.travel_mode = prevTravel
            crabCooldown = tick() + 90
            return
        end

         
        status = "Combat: Coconut Crab"
         
         
         
         
        local hoverRun = true
        task.spawn(function()
            while hoverRun and isOn() do
                local h = getHRP()
                if h then
                    local hp0 = h.Position
                     
                     
                     
                    if math.abs(hp0.Y - HOLD_Y) > 0.12 then
                        pcall(function()
                            h.Position = Vector3.new(hp0.X, HOLD_Y, hp0.Z)
                        end)
                    end
                    pcall(function()
                        local v = h.AssemblyLinearVelocity
                        if v and v.Y < -0.2 then
                            h.AssemblyLinearVelocity = Vector3.new(v.X, 0, v.Z)
                        end
                    end)
                end
                task.wait(0.03)
            end
        end)

         
         
        local dl = tick() + 1200
        local crabPos = getPartPos(crab)
        local goneTicks = 0
        while isOn() and tick() < dl do
             
             
             
             
            local liveCrab = findCrab()
            if liveCrab then
                goneTicks = 0
                crabPos = getPartPos(liveCrab) or crabPos
            else
                goneTicks = goneTicks + 1
                if goneTicks >= 10 then break end
            end
            local me = getHRP()
            if me then
                 
                 
                 
                local hazard = nil
                local hcoll = Workspace:FindFirstChild("Collectibles")
                if hcoll then
                    local okH, hkids = pcall(function() return hcoll:GetChildren() end)
                    for _, ho in ipairs((okH and hkids) or {}) do
                        local hn = string.lower(tostring(ho.Name or ""))
                        if string.find(hn, "coconut", 1, true) or string.find(hn, "rocket", 1, true) then
                            local hpos = getPartPos(ho)
                            if hpos and (Vector3.new(hpos.X, 0, hpos.Z)
                                - Vector3.new(me.Position.X, 0, me.Position.Z)).Magnitude <= 45 then
                                hazard = hpos
                                break
                            end
                        end
                    end
                end
                if hazard then
                    status = "Coconut Crab: dodging"
                    local awayH = Vector3.new(me.Position.X - hazard.X, 0, me.Position.Z - hazard.Z)
                    if awayH.Magnitude < 1 then awayH = Vector3.new(1, 0, 0) end
                    awayH = awayH.Unit
                    Nav.bossTravel(Vector3.new(
                        me.Position.X + awayH.X * 34, HOLD_Y,
                        me.Position.Z + awayH.Z * 34), 2, "Crab dodge")
                else
                    status = "Combat: Coconut Crab"
                     
                    local want = crabPos and Vector3.new(crabPos.X, HOLD_Y, crabPos.Z)
                        or Vector3.new(fieldMid.X, HOLD_Y, fieldMid.Z)
                    if (Vector3.new(me.Position.X, 0, me.Position.Z)
                        - Vector3.new(want.X, 0, want.Z)).Magnitude > 3 then
                        Nav.bossTravel(want, 2, "Crab hover")
                    end
                end
            end
            combatHit()
            task.wait(0.1)
        end
        hoverRun = false
         
         
        Nav.crabKilled = true

         
         
        status = "Coconut Crab: collecting tokens"
        local lootEnd = tick() + 30
        local fieldFloor = Vector3.new(-254, 90, 469)
        while isOn() and tick() < lootEnd do
            local coll = Workspace:FindFirstChild("Collectibles")
            local me2 = getHRP()
            local best, bestD = nil, 1e9
            if coll and me2 then
                local okKids, kids = pcall(function() return coll:GetChildren() end)
                for _, tok in ipairs((okKids and kids) or {}) do
                    local p = getPartPos(tok)
                    if p and (p - fieldFloor).Magnitude <= 90 then
                        local d = (p - me2.Position).Magnitude
                        if d <= 30 then pcall(function() Nav.touchToken(tok) end) end
                        if d < bestD then bestD = d; best = p end
                    end
                end
            end
            if not best or bestD <= 7 then
                task.wait(0.12)
            else
                 
                 
                 
                 
                Nav.walk(Vector3.new(best.X, best.Y + 1, best.Z), {
                    arrive = 5, timeout = 4, label = "Crab loot",
                })
            end
        end
        S.travel_mode = prevTravel
        crabCooldown = tick() + 300
    end

    local function doBossCombat()
        if not getHRP() then return end

        if S.kill_beetle and isOn() then killKingBeetle() end
        if S.kill_bear and isOn() then killTunnelBear() end
        if S.kill_crab and isOn() then killCoconutCrab() end

        if S.kill_vicious and isOn() then
            local vb = Nav.findMonster("vicious")
            if vb then
                status = "Combat: Vicious Bee"
                 
                 
                 
                 
                local coll = Workspace:FindFirstChild("Collectibles")
                local beePos = getPartPos(vb)
                local hrp = getHRP()
                if coll and hrp then
                    for _, tok in ipairs(coll:GetChildren()) do
                        local tn = string.lower(tostring(tok.Name or ""))
                        local tp = getPartPos(tok)
                        if tp and string.find(tn, "sting", 1, true)
                            and (not beePos or (tp - beePos).Magnitude <= 140) then
                            status = "Combat: Vicious stinger"
                            moveToVelocity(tp, S.glide_speed, 3)
                            Nav.touchToken(tok)
                            task.wait(0.6)
                            Nav.touchToken(tok)
                        end
                    end
                end

                local dl = tick() + 90
                local lastSeen = tick()
                local orbitStep = 0
                 
                 
                 
                 
                local function orbitY(x, z, beeY)
                    local base = (beeY or 60) + 4
                    local gy, hit = Nav.groundAt(x, z, base)
                    if gy and hit then
                        local inst = hit.Instance
                        local par = inst and inst.Parent
                         
                         
                        if par and (par.Name == "Monsters" or par.Name == "Bees") then
                            gy = Nav.groundAt(x, z, base + 30)
                        end
                    end
                    if gy then return gy + 2 end
                    return beeY or 60
                end
                while isOn() and tick() < dl do
                    local alive = false
                    pcall(function() alive = vb.Parent ~= nil end)
                    if not alive then
                        vb = Nav.findMonster("vicious")
                        if not vb then break end
                    end
                    local mp = getPartPos(vb)
                    local hrp2 = getHRP()
                    if mp then
                        lastSeen = tick()
                         
                         
                         
                         
                         
                         
                         
                        local ORBIT_R = 16
                        local me = hrp2 and hrp2.Position or mp
                         
                         
                         
                        local underMe = Nav.groundAt(me.X, me.Z, mp.Y + 4)
                        if underMe and me.Y < (underMe - 5) then
                            Nav.walk(Vector3.new(me.X, underMe + 2, me.Z),
                                { arrive = 2.5, timeout = 5, label = "Vicious recover" })
                            hrp2 = getHRP()
                            me = hrp2 and hrp2.Position or me
                        end
                        local away = Vector3.new(me.X - mp.X, 0, me.Z - mp.Z)
                        local gap = away.Magnitude
                        local dir = (gap > 0.1 and away.Unit) or Vector3.new(1, 0, 0)
                        local side = Vector3.new(-dir.Z, 0, dir.X)
                        local targetPos
                        orbitStep = orbitStep + 1
                        if gap > ORBIT_R + 8 then
                            local tx, tz = mp.X + dir.X * ORBIT_R, mp.Z + dir.Z * ORBIT_R
                            targetPos = Vector3.new(tx, orbitY(tx, tz, mp.Y), tz)
                        elseif orbitStep % 2 == 0 then
                            local tx, tz = mp.X + side.X * (ORBIT_R + 2), mp.Z + side.Z * (ORBIT_R + 2)
                            targetPos = Vector3.new(tx, orbitY(tx, tz, mp.Y), tz)
                        else
                            local tx, tz = me.X + side.X * 8 + dir.X * 3, me.Z + side.Z * 8 + dir.Z * 3
                            targetPos = Vector3.new(tx, orbitY(tx, tz, mp.Y), tz)
                        end
                        if S.travel_mode == "Tween" then
                            Nav.tweenTravel(targetPos, S.glide_speed, 2, "Vicious orbit")
                        else
                            Nav.walk(targetPos, { arrive = 3, timeout = 3, label = "Vicious orbit" })
                        end
                        combatHit()
                        pcall(function()
                            local ch = lp.Character
                            local tool = ch and ch:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end)
                    end
                    if tick() - lastSeen > 6 then break end
                    task.wait(0.12)
                end
                status = "Combat: Vicious down"
                 
                 
                local vHold = tick() + 5
                while isOn() and tick() < vHold do
                    local coll5 = Workspace:FindFirstChild("Collectibles")
                    local h5 = getHRP()
                    if coll5 and h5 then
                        for _, tok5 in ipairs(coll5:GetChildren()) do
                            local tp5 = getPartPos(tok5)
                            if tp5 and (tp5 - h5.Position).Magnitude <= 20 then
                                pcall(function() Nav.touchToken(tok5) end)
                            end
                        end
                    end
                    task.wait(0.2)
                end
            else
                 
                 
                 
                 
                local st = Nav.findStinger()
                if st then
                    status = "Vicious stinger: heading to it"
                    local gy = Nav.groundAt(st.pos.X, st.pos.Z, st.pos.Y + 4)
                    local ty = (gy and gy + 2) or st.pos.Y
                    Nav.walk(Vector3.new(st.pos.X, ty, st.pos.Z),
                        { arrive = 2.5, timeout = 12, label = "Vicious stinger" })
                    pcall(function() Nav.touchToken(st.part) end)
                    local hNow = getHRP()
                    if hNow and (Vector3.new(hNow.Position.X, 0, hNow.Position.Z)
                        - Vector3.new(st.pos.X, 0, st.pos.Z)).Magnitude <= 4 then
                         
                         
                        task.wait(0.15)
                        pcall(function() Nav.touchToken(st.part) end)
                    end
                    S.vicious_cd = tick() + 2
                    task.wait(0.4)
                else
                     
                     
                    local vCd, vTxt, vSecs = checkBossOnCooldown("Vicious")
                    if vCd then
                        status = "Vicious Bee respawns in " .. tostring(vTxt)
                        S.vicious_cd = tick() + Nav.bossRetry(vSecs)
                    elseif tick() >= (S.vicious_cd or 0) then
                        status = "Vicious Bee: no stinger on the field"
                        S.vicious_cd = tick() + 30
                    end
                end
            end
        end

        if S.kill_mondo and isOn() and tick() >= (S.mondo_cd or 0) then
             
             
             
             
             
             
            local summoner = Vector3.new(83, 181, -170)
            local chick = Nav.findMonster("mondo")
            local cp = chick and getPartPos(chick)
             
             
             
            if not cp then
                local mCd, mTxt, mSecs = checkBossOnCooldown("Mondo")
                if mCd and (mSecs or 0) > 45 then
                    status = "Mondo Chick respawns in " .. tostring(mTxt)
                    S.mondo_cd = tick() + Nav.bossRetry(mSecs)
                    return
                end
            end
            local hrpM = getHRP()
            if hrpM then
                if (hrpM.Position - (cp or summoner)).Magnitude > 60 then
                    status = "Mondo Chick: to Mountain Top"
                    Nav.bossTravel((cp or summoner) + Vector3.new(0, 8, 0), 12, "Mondo travel")
                end

                 
                 
                if not cp then
                    local waitTop = tick() + 12
                    while isOn() and tick() < waitTop do
                        status = "Mondo Chick: waiting at Mountain Top"
                        task.wait(0.4)
                        chick = Nav.findMonster("mondo")
                        cp = chick and getPartPos(chick)
                        if cp then break end
                    end
                end

                if not cp then
                    status = "Mondo Chick: not spawned"
                    S.mondo_cd = tick() + 60
                else
                    status = "Combat: Mondo Chick"
                     
                     
                     
                    local killEnd = tick() + 900
                    while isOn() and tick() < killEnd do
                        local c2 = Nav.findMonster("mondo")
                        if not c2 then break end
                        local me2 = getHRP()
                        if not me2 then
                            status = "Mondo Chick: waiting for respawn"
                            local wEnd = tick() + 25
                            while isOn() and tick() < wEnd and not getHRP() do
                                task.wait(0.5)
                            end
                            local c3 = Nav.findMonster("mondo")
                            local p3 = c3 and getPartPos(c3)
                            if p3 then
                                Nav.bossTravel(p3 + Vector3.new(0, 10, 0), 16, "Mondo return")
                            end
                            task.wait(0.4)
                        else
                            local p2 = getPartPos(c2)
                            if p2 then
                                local flatMe = Vector3.new(me2.Position.X, 0, me2.Position.Z)
                                local flatC = Vector3.new(p2.X, 0, p2.Z)
                                local away = flatMe - flatC
                                local gap = away.Magnitude
                                local dir = (gap > 0.1 and away.Unit) or Vector3.new(1, 0, 0)
                                 
                                 
                                 
                                 
                                if gap < 40 then
                                     
                                     
                                    local side = Vector3.new(-dir.Z, 0, dir.X)
                                    Nav.walk(Vector3.new(
                                        flatC.X + dir.X * 54 + side.X * 10, me2.Position.Y,
                                        flatC.Z + dir.Z * 54 + side.Z * 10), {
                                        arrive = 6, timeout = 5, label = "Mondo spacing",
                                    })
                                elseif gap > 60 then
                                     
                                     
                                    Nav.walk(Vector3.new(
                                        flatC.X + dir.X * 45, me2.Position.Y,
                                        flatC.Z + dir.Z * 45), {
                                        arrive = 5, timeout = 5, label = "Mondo approach",
                                    })
                                end
                            end
                             
                             
                            local coll2 = Workspace:FindFirstChild("Collectibles")
                            if coll2 then
                                local okKids2, kids2 = pcall(function() return coll2:GetChildren() end)
                                for _, tok2 in ipairs((okKids2 and kids2) or {}) do
                                    local tp2 = getPartPos(tok2)
                                    if tp2 and (tp2 - me2.Position).Magnitude <= 30 then
                                        pcall(function() Nav.touchToken(tok2) end)
                                    end
                                end
                            end
                            combatHit()
                        end
                        task.wait(0.12)
                    end

                     
                     
                     
                     
                     
                     
                    if S.mondo_loot ~= false then
                        status = "Mondo Chick: collecting tokens"
                        local lootEnd = tick() + 30
                        while isOn() and tick() < lootEnd do
                            local me3 = getHRP()
                            if not me3 then break end
                            local coll = Workspace:FindFirstChild("Collectibles")
                            local best, bestD = nil, 1e9
                            if coll then
                                local okKids, kids = pcall(function() return coll:GetChildren() end)
                                for _, tok in ipairs((okKids and kids) or {}) do
                                    local p3 = getPartPos(tok)
                                    if p3 and (p3 - summoner).Magnitude <= 160 then
                                        local d3 = (p3 - me3.Position).Magnitude
                                        if d3 <= 26 then pcall(function() Nav.touchToken(tok) end) end
                                        if d3 < bestD then bestD = d3; best = p3 end
                                    end
                                end
                            end
                            if not best or bestD <= 5 then
                                 
                                 
                                local hold = tick() + 5
                                while isOn() and tick() < hold do
                                    local h2 = getHRP()
                                    local coll2 = Workspace:FindFirstChild("Collectibles")
                                    if h2 and coll2 then
                                        for _, tok in ipairs(coll2:GetChildren()) do
                                            local tp = getPartPos(tok)
                                            if tp and (tp - h2.Position).Magnitude <= 12 then
                                                pcall(function() Nav.touchToken(tok) end)
                                            end
                                        end
                                    end
                                    task.wait(0.2)
                                end
                                break
                            end
                            Nav.walk(Vector3.new(best.X, best.Y + 1, best.Z), {
                                arrive = 2.5, timeout = 6, label = "Mondo loot",
                            })
                            local after = getHRP()
                            local coll3 = Workspace:FindFirstChild("Collectibles")
                            if after and coll3 then
                                for _, tok in ipairs(coll3:GetChildren()) do
                                    local tp = getPartPos(tok)
                                    if tp and (tp - after.Position).Magnitude <= 14 then
                                        pcall(function() Nav.touchToken(tok) end)
                                    end
                                end
                            end
                        end
                    end
                    S.mondo_cd = tick() + 600
                end
            end
        end
    end

    
    
    
    HiveTool.prompt = function()
        local clicked = false
        pcall(function()
            local pg = lp:FindFirstChildOfClass("PlayerGui")
            if not pg then return end
            for _, obj in ipairs(pg:GetDescendants()) do
                if obj.ClassName == "TextButton" then
                    local t = string.lower(safeText(obj))
                    if string.find(t, "claim", 1, true) or t == "yes" or string.find(t, "confirm", 1, true) then
                        local ap = try(function() return obj.AbsolutePosition end)
                        if ap then
                            clickAt(ap.X + 18, ap.Y + 8)
                            clicked = true
                            return
                        end
                    end
                end
            end
            local sg = pg:FindFirstChild("ScreenGui")
            local qbox = sg and sg:FindFirstChild("QuestionBox")
            local box = qbox and qbox:FindFirstChild("Box")
            local yes = box and box:FindFirstChild("YesButton")
            if yes then
                local ap = try(function() return yes.AbsolutePosition end)
                if ap then
                    clickAt(ap.X + 18, ap.Y + 8)
                    clicked = true
                end
            end
        end)
        return clicked
    end

    HiveTool.claim = function()
        if myHive then return true end
        autoDetectHiveInstant()
        if myHive then return true end

        local hive = HiveTool.unclaimed()
        if not hive then
            status = "No unclaimed hive found"
            return false
        end

        local anchor = HiveTool.anchor(hive)
        if not anchor then
            status = "Hive pad not readable"
            return false
        end

        restoreFacing()
        status = "Claiming " .. hive.Name
        Nav.go(anchor, S.glide_speed, 2, "Hive claim")

        for attempt = 1, 4 do
            if myHive then break end
            if S.hybrid then
                pcall(function() fireEvent("ClaimHive", hive) end)
            end
            Nav.firePromptOn(hive)
            Nav.firePromptNear(anchor, 18)
            pcall(function()
                local cd = hive:FindFirstChildWhichIsA("ClickDetector", true)
                if cd then fireclickdetector(cd) end
            end)
            pcall(function()
                keypress(0x45)
                task.wait(0.06)
                keyrelease(0x45)
            end)
            task.wait(0.45)
            HiveTool.prompt()
            task.wait(0.45)
            autoDetectHiveInstant()
            if myHive then break end
            task.wait(0.8)
        end

        if myHive then
            status = "Hive: " .. myHive.Name
            return true
        end
        status = "Claim failed"
        return false
    end

     
     
     
     
     
     
     
     
    Nav.hivePromptText = function()
        local ok, pg = pcall(function() return lp:FindFirstChildOfClass("PlayerGui") end)
        if not ok or not pg then return "" end
        local ok2, list = pcall(function() return pg:GetChildren() end)
        if not ok2 or not list then return "" end
        for _, sg in ipairs(list) do
            local ab = sg:FindFirstChild("ActivateButton")
            local tx = ab and ab:FindFirstChild("TextBox")
            if tx then return safeText(tx) end
        end
        return ""
    end

    Nav.hiveMakeHoney = function(force)
        local making = string.find(Nav.hivePromptText(), "Stop Making Honey", 1, true) ~= nil
        if S.hybrid then
            if making and not force then return true end
            local ev = getRemote("PlayerHiveCommand")
            local fired = false
            if ev then
                fired = pcall(function() ev:FireServer("ToggleHoneyMaking") end)
            end
            if not fired then
                fired = pcall(function()
                    RS.Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
                end)
            end
             
             
            if not fired then
                if type(setrobloxinput) == "function" then pcall(setrobloxinput, true) end
                pcall(function()
                    keypress(0x45)
                    task.wait(0.05)
                    keyrelease(0x45)
                end)
            end
            return fired
        end
         
         
         
         
        if making then return true end
        if type(setrobloxinput) == "function" then pcall(setrobloxinput, true) end
        pcall(function()
            keypress(0x45)
            task.wait(0.05)
            keyrelease(0x45)
        end)
        return true
    end

    local function convertAtHive()
        restoreFacing()
        if not myHive then HiveTool.claim() end
        local pad = myHive and HiveTool.pad(myHive)
        local pp = padPos(pad)
        collecting = false
        status = "Going to hive"

         
         
         
         
         
        do
            local here = getHRP()
            if here and S.travel_mode ~= "Tween" then
                local pine = Nav.keyFor(here.Position) == "Pine Tree Forest"
                    or Nav.inFieldName("Pine Tree Forest", here.Position, 30)
                if pine and Nav.pineReturn then
                    local from, bestD = 1, math.huge
                    for i = 1, #Nav.pineReturn do
                        local d = (Nav.pineReturn[i] - here.Position).Magnitude
                        if d < bestD then bestD, from = d, i end
                    end
                    status = "Pine: back to the hive"
                    Nav.walkLegs(Nav.pineReturn, "Pine to hive", 4, { from = from })
                end
            end
        end

         
         
         
        local target = nil
        for attempt = 1, 3 do
            if not pp then
                autoDetectHiveInstant()
                pad = myHive and HiveTool.pad(myHive)
                pp = padPos(pad)
            end
            if not pp then break end
            target = Vector3.new(pp.X, HiveTool.top(pad) + 1, pp.Z)
            Nav.go(target, S.glide_speed, 3, "Hive travel")
            local hrp = getHRP()
            if hrp and (hrp.Position - target).Magnitude <= 5 then break end
            autoDetectHiveInstant()
            pad = myHive and HiveTool.pad(myHive)
            pp = padPos(pad)
        end
        if not pp or not target then task.wait(1); needSprinkler = true; return end

         
         
         
        local function ask(force)
            if S.hybrid then
                Nav.hiveMakeHoney(force)
                return
            end
            if (not force) and string.find(Nav.hivePromptText(), "Stop Making Honey", 1, true) then
                return
            end
            if type(setrobloxinput) == "function" then pcall(setrobloxinput, true) end
            pcall(function()
                keypress(0x45)
                task.wait(0.05)
                keyrelease(0x45)
            end)
            task.wait(0.6)
            if string.find(Nav.hivePromptText(), "Stop Making Honey", 1, true) then return end
            pcall(clickActivateButton)
        end

        status = S.hybrid and "Converting (hive command)" or "Converting (E)"
         
         
         
         
        S.dig.converting = true
        local convOk, convErr = pcall(function()
            ask(false)
            local dl = tick() + 240
            local last = getPollenAndCap()
            local lastDrop = tick()
            local lastAsk = tick()
            local asked = 1
            local RETRY_AFTER = 40
            while isOn() and tick() < dl do
                local p = getPollenAndCap()
                if p and p <= 0 then break end
                if p and (not last or p < last) then
                    last = p
                    lastDrop = tick()
                end

                 
                 
                 
                if asked < 8 and p and (tick() - lastDrop) >= RETRY_AFTER
                    and (tick() - lastAsk) >= RETRY_AFTER then
                    local making = string.find(Nav.hivePromptText(), "Stop Making Honey", 1, true) ~= nil
                    if not making then
                        asked = asked + 1
                        lastAsk = tick()
                        status = S.hybrid and "Re-sending hive command" or "Re-pressing E"
                         
                         
                        local hrp = getHRP()
                        if hrp and (hrp.Position - target).Magnitude > 6 then
                            Nav.go(target, S.glide_speed, 3, "Back to hive pad")
                        end
                        ask(true)
                    else
                         
                         
                        lastDrop = tick()
                    end
                end
                task.wait(0.5)
            end
        end)
        S.dig.converting = false
        if not convOk then
            status = "Convert error: " .. tostring(convErr)
        end

         
         
        local after = getPollenAndCap()
        if after and after > 0 then
            S.dig.convCooldown = tick() + 45
            status = "Convert failed - retry in 45s"
        else
            S.dig.convCooldown = 0
             
             
             
             
             
             
             
            if S.balloon_convert ~= false then
                pcall(function()
                    status = "Bag empty - converting balloons"
                    local bStart = tick()
                    local bCount, bPollen = Nav.hiveBalloons(target, 35)
                    if bCount > 0 then
                        local lastLeft = bPollen
                        local flat, asks, lastAsk = 0, 0, 0
                        local drained = false
                         
                         
                         
                        while isOn() and (tick() - bStart) < 150 do
                            local c, left = Nav.hiveBalloons(target, 35)
                            if c <= 0 then
                                drained = true
                                break
                            end

                            if lastLeft and left < lastLeft then
                                flat = 0
                                status = string.format("Converting balloon - %.2fB left", left / 1e9)
                            else
                                flat = flat + 1
                            end
                            lastLeft = left

                             
                             
                             
                             
                             
                            if flat >= 20 and asks < 6 then
                                asks = asks + 1
                                lastAsk = tick()
                                local hrp = getHRP()
                                if hrp and (hrp.Position - target).Magnitude > 6 then
                                     
                                     
                                    status = "Back to hive pad for balloon"
                                    Nav.go(target, S.glide_speed, 3, "Back to hive pad")
                                end
                                if not string.find(Nav.hivePromptText(), "Stop Making Honey", 1, true) then
                                    status = "Restarting hive for balloon"
                                    Nav.hiveMakeHoney(true)
                                end
                                flat = 10
                                task.wait(0.6)
                            end

                             
                             
                            if flat >= 40 then break end
                            task.wait(0.5)
                        end

                        if drained then
                            status = "Balloon converted - back to field in 5s"
                        elseif (lastLeft or 0) > 0 then
                            status = string.format("Balloon left %.2fB - back to field in 5s", lastLeft / 1e9)
                        end
                    end
                end)
            end
            if not string.find(tostring(status), "Balloon", 1, true) then
                status = "Bag empty - back to field in 5s"
            end
            task.wait(5)
        end
        needSprinkler = true
    end

    local function doReset()
        restoreFacing()
        status = "Resetting"
        pcall(function()
            keypress(0x1B); task.wait(0.1); keyrelease(0x1B); task.wait(0.3)
            keypress(0x52); task.wait(0.1); keyrelease(0x52); task.wait(0.3)
            keypress(0x0D); task.wait(0.1); keyrelease(0x0D); task.wait(2)
        end)
        local dl = tick() + 15
        while isOn() and tick() < dl do
            if getHRP() then break end
            task.wait(0.3)
        end
        if currentField and isOn() then
            local c = currentField.Position
            Nav.go(Vector3.new(c.X, groundY(currentField) + 5, c.Z), S.glide_speed, 3, "Return to field")
        end
        needSprinkler = true
    end

     
     
     
    Watch.onReset = function()
        needSprinkler = true
        collecting = false
        forceReturn = false
        currentField = nil
    end

     
     
     
    bg(function()
        while true do
            pcall(function()
                Watch.tick(collecting == true and S.dig.converting == false and S.farm_on == true)
            end)
            task.wait(1)
        end
    end)

    
    
    

    bg(function()   
        while true do
            pcall(function()
                if isOn() and collecting then autoDigCursorFree() end
            end)
            task.wait(0.12)
        end
    end)

     
     
     
    bg(function()
        while true do
            pcall(function()
                if not S.hybrid and S.dig_tool and S.farm_on and FeaturesActive
                    and not S.dig.uiOpen and not S.dig.converting and isAlive() then
                    autoDigCursorFree()
                end
            end)
            task.wait(0.05)
        end
    end)

     
     
     
    S.face.field = function()
        if currentField then return currentField end
        local now = tick()
        if S.face.fieldCache and (now - S.face.fieldAt) < 2 then return S.face.fieldCache end
        S.face.fieldAt = now
        local hrp = getHRP()
        local best, bestD = nil, math.huge
        for _, fn in ipairs(zoneNames) do
            local f = getField(fn)
            if f then
                local d = hrp and (f.Position - hrp.Position).Magnitude or 0
                if d < bestD then bestD, best = d, f end
            end
        end
        S.face.fieldCache = best
        return best
    end

     
     
     
     
    S.face.resolve = function()
        if not (S.face_balloons or S.face_bubbles or S.face_center or S.face_flame) then
            S.face.mode = "off"
            return nil
        end
        local hrp = getHRP()
        if not hrp then return nil end
        local field = S.face.field()
        local pos = hrp.Position

        if S.face_balloons then
            local balloon = findClosestBalloon(field)
            local bp = balloon and getPartPos(balloon)
            if bp and (bp - pos).Magnitude <= 250 then
                S.face.mode = "balloon"
                return bp
            end
        end
        if S.face_bubbles then
            local bubble = findNearestBubble(field, pos)
            local pp = bubble and getPartPos(bubble)
            if pp and (pp - pos).Magnitude <= 160 then
                S.face.mode = "bubble"
                return pp
            end
        end
        if S.face_flame then
             
             
             
            local flame = findNearestFlame(field)
            local fp = flame and getPartPos(flame)
            if fp and (fp - pos).Magnitude <= 250 then
                S.face.mode = "flame"
                return fp
            end
        end
        if S.face_center and field then
            S.face.mode = "field middle"
            return field.Position
        end
        S.face.mode = "nothing in range"
        return nil
    end

     
     
     
     
     
    bg(function()
        local FACEERR = 0
        local function faceFrame()
            local okF, errF = pcall(function()
                 
                 
                 
                if not S.farm_on or not currentField then
                    S.face.target, facingTarget = nil, nil
                    return
                end
                local hrpNow = getHRP()
                if not hrpNow or not inField(hrpNow.Position, currentField, 30) then
                    S.face.target, facingTarget = nil, nil
                    return
                end

                local now = tick()
                 
                 
                 
                if now - S.face.resolvedAt >= 0.2 then
                    S.face.resolvedAt = now
                    S.face.target = S.face.resolve()
                end
                local target = S.face.target
                if target then
                    facingTarget = target
                    facePosition(target)
                elseif facingTarget ~= nil or S.face.autoOff then
                    facingTarget = nil
                    restoreFacing()
                end
            end)
            if not okF then
                FACEERR = FACEERR + 1
                if FACEERR <= 5 then warn("[face] " .. tostring(errF)) end
            end
        end

         
         
         
        local rs = try(function() return game:GetService("RunService") end)
        local conn = nil
        if rs and rs.Heartbeat then
            local okC, c = pcall(function() return rs.Heartbeat:Connect(function()
                S.face.lastTick = tick()
                faceFrame()
            end) end)
            if okC and c then conn = c end
        end
        S.face.driver = conn and "heartbeat" or "task"
         
         
         
        while true do
            if not S.face.lastTick or (tick() - S.face.lastTick) > 0.4 then
                S.face.lastTick = tick()
                faceFrame()
            end
            task.wait(0.1)
        end
    end)

    local initialRoutineDone = false
    local farmCycleStart = 0
    local nextCombatCheck = 0
    local FARMERR = 0
    
    
    local lastBeat = 0

    bg(function()
        while true do
            lastBeat = tick()
            pcall(Engine.consoleTick)
            task.wait(0.5)
        end
    end)

    bg(function()   
        while true do
            local okS, errS = pcall(function()
            lastBeat = tick()
            if not Engine.anyFeatureOn() then
                collecting = false
                initialRoutineDone = false
                farmCycleStart = 0
                if Nav.stopSpeedWrite then Nav.stopSpeedWrite() end
                restoreFacing()
                task.wait(0.3)
            elseif not FeaturesActive then
                collecting = false
                if Nav.stopSpeedWrite then Nav.stopSpeedWrite() end
                restoreFacing()
                status = "Paused (menu open)"
                task.wait(0.2)
            elseif not isAlive() then
                collecting = false
                if Nav.stopSpeedWrite then Nav.stopSpeedWrite() end
                restoreFacing()
                status = "Waiting for character"
                task.wait(0.3)
            else
                if not initialRoutineDone then
                    initialRoutineDone = true
                    collecting = false

                    if isOn() and not myHive then
                        status = "Finding hive"
                        HiveTool.claim()
                    end

                    local hasCombat = S.kill_beetle or S.kill_bear or S.kill_vicious or S.kill_mondo or S.kill_crab
                    if hasCombat and isOn() then
                        status = "Routine: bosses"
                        S.combat_now = false
                        doBossCombat()
                    end

                    if S.misc_any and isOn() then
                        status = "Routine: misc"
                        if Nav.miscStep() then needSprinkler = true end
                    end

                    if Engine.questOn() and isOn() then
                        status = "Routine: quests"
                        Nav.questStep()
                    end

                    farmCycleStart = tick()
                    needSprinkler = true
                end

                 
                 
                 
                 
                 
                if (S.polar_only or Engine.questsOnly()) and isOn() then
                    local tag = S.polar_only and "Polar" or "Quests"
                    local pollen, cap = getPollenAndCap()
                    local isFull = forceReturn or (pollen and cap and cap > 0 and pollen >= cap * (S.full_pct / 100) and tick() >= (S.dig.convCooldown or 0))
                    if isFull then
                        forceReturn = false
                        collecting = false
                        if S.reset_mode then doReset() else convertAtHive() end
                    else
                        local hasCombat = S.kill_beetle or S.kill_bear or S.kill_vicious or S.kill_mondo or S.kill_crab
                        if hasCombat and isOn() and tick() >= nextCombatCheck then
                            nextCombatCheck = tick() + 20
                            status = tag .. ": combat"
                            doBossCombat()
                        end

                        if S.nectar_farm and isOn() then
                            status = tag .. ": nectars"
                            nectarStep()
                        end

                         
                         
                        if S.misc_any and isOn() then
                            if Nav.miscStep() then needSprinkler = true end
                        end

                         
                         
                         
                         
                         
                         
                        if Engine.questOn() and isOn() then
                            local job = Nav.questJob()
                            if job then
                                if job.kind == "pollen" then
                                    if job.field and S.quest_follow ~= false then
                                        if S.field ~= job.field then
                                            Engine.onFieldChange(job.field)
                                            if _G.__lolcatFieldSync then pcall(_G.__lolcatFieldSync, job.field) end
                                        end
                                        Nav.questFarm(job.field, 10)
                                    else
                                        Nav.questTaskLine = tostring(job.entry and job.entry.quest or "Quest")
                                            .. ": field farming off"
                                    end
                                elseif job.kind ~= "turnin" and job.kind ~= "manual" then
                                    Nav.questWork(job)
                                end
                            else
                                 
                                 
                                 
                                status = tag .. ": getting a quest"
                                Nav.questStep()
                            end
                        end
                    end
                elseif S.auto_polar_quests and isOn() then
                    local pollen, cap = getPollenAndCap()
                    local isFull = forceReturn or (pollen and cap and cap > 0 and pollen >= cap * (S.full_pct / 100) and tick() >= (S.dig.convCooldown or 0))
                    if isFull then
                        forceReturn = false
                        collecting = false
                        if S.reset_mode then doReset() else convertAtHive() end
                    else
                        Nav.questStep()
                    end
                else
                    if farmCycleStart > 0 and (tick() - farmCycleStart) >= 600 then
                        local hasCombat = S.kill_beetle or S.kill_bear or S.kill_vicious or S.kill_mondo or S.kill_crab
                        if hasCombat and isOn() then
                            status = "10 min cycle: bosses"
                            doBossCombat()
                        end
                        farmCycleStart = tick()
                        needSprinkler = true
                    end

                    
                    
                    
                    
                    local combatWanted = S.kill_beetle or S.kill_bear or S.kill_vicious or S.kill_mondo or S.kill_crab
                    if combatWanted and isOn() and (S.combat_now or tick() >= nextCombatCheck) then
                        S.combat_now = false
                        nextCombatCheck = tick() + 20
                        status = "Combat check"
                        doBossCombat()
                        needSprinkler = true
                    end

                     
                     
                    if S.misc_any and isOn() then
                        if Nav.miscStep() then needSprinkler = true end
                    end

                     
                     
                     
                     
                    if Engine.questOn() and isOn() then
                        local job = Nav.questJob()
                        if job then
                            if job.kind == "pollen" then
                                 
                                 
                                if job.field and S.farm_on and S.quest_follow ~= false and S.field ~= job.field then
                                     
                                     
                                    if not Nav.questFieldBack then Nav.questFieldBack = S.field end
                                    Nav.questSetField = job.field
                                    Engine.onFieldChange(job.field)
                                    if _G.__lolcatFieldSync then pcall(_G.__lolcatFieldSync, job.field) end
                                end
                            elseif job.kind ~= "turnin" and job.kind ~= "manual" then
                                Nav.questWork(job)
                            end
                        else
                             
                             
                             
                            local back = Nav.questFieldBack
                            if back and S.field == (Nav.questSetField or "") then
                                Engine.onFieldChange(back)
                                if _G.__lolcatFieldSync then pcall(_G.__lolcatFieldSync, back) end
                            end
                            Nav.questFieldBack, Nav.questSetField = nil, nil
                            Nav.questStep()
                        end
                    end

                    if S.nectar_farm and isOn() then
                         
                        nectarStep()
                    end

                    local field = S.farm_on and getField(S.field) or nil
                    currentField = field

                    if not S.farm_on then
                         
                         
                         
                        collecting = false
                        task.wait(0.05)
                    elseif not field then
                        status = "Zone not found"
                        task.wait(1)
                    else
                        local pollen, cap = getPollenAndCap()
                        local isFull = forceReturn or (pollen and cap and cap > 0 and pollen >= cap * (S.full_pct / 100) and tick() >= (S.dig.convCooldown or 0))

                        if isFull then
                            forceReturn = false
                            collecting = false
                            if S.reset_mode then doReset() else convertAtHive() end
                        else
                            local hrp = getHRP()
                            if hrp then
                                local c = field.Position
                                local center = Vector3.new(c.X, groundY(field) + 2, c.Z)
                                local farmMode = MODE_INDEX[S.farm_mode] or 2
                                local closeR = S.close_r or 12
                                local standY = groundY(field) + 2
                                 
                                 
                                 
                                 
                                 
                                 
                                local travelPoint = Vector3.new(c.X, groundY(field) + ((S.travel_mode == "Tween") and 3 or 5), c.Z)

                                if not inField(hrp.Position, field, 28) then
                                    status = "Returning to field"
                                    Nav.goField(S.field, travelPoint, S.glide_speed, "Return to field")
                                    local afterWalk = getHRP()
                                    if not afterWalk or not inField(afterWalk.Position, field, 28) then
                                        status = "Travel failed: " .. tostring(S.field)
                                        Watch.fail("field travel")
                                        task.wait(1)
                                        return
                                    end
                                    hrp = afterWalk
                                end

                                local autoSprink = (S.sprinkler == "Auto")
                                local reps = SPRINK_REPS[S.sprinkler] or 0
                                local maySprink = needSprinkler and (autoSprink or reps > 0)
                                if maySprink and lastSprinklerField == S.field
                                    and (tick() - lastSprinklerAt) < 180 then
                                    maySprink = false
                                    needSprinkler = false
                                end
                                if maySprink then
                                     
                                     
                                    status = "Placing sprinklers"
                                    if autoSprink then
                                        local shownTier = detectSprinklerTier() or lastSprinkTier
                                        if shownTier then status = "Placing sprinklers (" .. shownTier .. ")" end
                                    end
                                    local placed = true
                                    if S.hybrid then
                                        placed = hybridPlaceSprinklers()
                                    else
                                        local n = reps
                                        if autoSprink then
                                            local t = detectSprinklerTier() or lastSprinkTier
                                            n = SPRINK_REPS[t or ""] or 1
                                        end
                                        for _ = 1, n do
                                            pcall(function()
                                                keypress(0x20); task.wait(0.05); keyrelease(0x20); task.wait(0.2)
                                                keypress(0x31); task.wait(0.05); keyrelease(0x31); task.wait(0.4)
                                            end)
                                        end
                                    end

                                    if placed then
                                        lastSprinklerField = S.field
                                        lastSprinklerAt = tick()
                                    end
                                    needSprinkler = not placed
                                else
                                    needSprinkler = false
                                end

                                if not inField(hrp.Position, field, 10) then
                                    status = "Going to field"
                                    Nav.goField(S.field, travelPoint, S.glide_speed, "Go to field")
                                    local nearWalk = getHRP()
                                    if not nearWalk or not inField(nearWalk.Position, field, 10) then
                                        status = "Travel failed: " .. tostring(S.field)
                                        Watch.fail("field travel")
                                        task.wait(1)
                                        return
                                    end
                                    hrp = nearWalk
                                end

                                collecting = true
                                status = "Farming " .. S.field
                                autoDigCursorFree()

                                
                                
                                local extraPos = nil
                                local extraToken = false
                                if S.farm_under_balloons then
                                    local b = findClosestBalloon(field)
                                    if b then extraPos = b.Position end
                                elseif S.farm_under_clouds then
                                    local cl = findNearestCloud(field)
                                    if cl then extraPos = cl.Position end
                                elseif S.farm_flames then
                                    local fl = findNearestFlame(field)
                                    if fl then extraPos = fl.Position end
                                elseif S.catch_coconuts or S.catch_stars then
                                    if findNearestSpecial() then
                                        catchSpecialForceTween()
                                    end
                                elseif S.farm_sprouts then
                                    local sp = findNearestSpecial()
                                    if sp then extraPos = sp.Position end
                                elseif S.collect_tokens then
                                    extraPos = findNearestTokenCluster(140, 12, field)
                                    if extraPos then
                                        extraPos = clampTarget(extraPos, field, 2, 6)
                                    end
                                    extraToken = true
                                end

                                
                                
                                if S.convert_balloon then
                                    local b = findClosestBalloon(field)
                                    if b and (b.Position - hrp.Position).Magnitude <= 18 then
                                        local ppollen, pcap = getPollenAndCap()
                                        if pcap > 0 and ppollen >= pcap * 0.5 then forceReturn = true end
                                    end
                                end

                                 
                                 
                                 
                                 
                                 
                                local mpos = nil
                                if S.mark_target == true then
                                    mpos = Nav.preciseMarkTarget(field)
                                end
                                if mpos then
                                     
                                     
                                     
                                     
                                     
                                     
                                     
                                     
                                     
                                     
                                    local fc = field.Position
                                    local fhx = math.max(field.Size.X / 2 - 3, 1)
                                    local fhz = math.max(field.Size.Z / 2 - 3, 1)
                                    local markY = groundY(field) + 1.5
                                    for _ = 1, 3 do
                                        if not isOn() or not mpos then break end
                                        local tgt = Vector3.new(
                                            math.clamp(mpos.X, fc.X - fhx, fc.X + fhx),
                                            markY,
                                            math.clamp(mpos.Z, fc.Z - fhz, fc.Z + fhz)
                                        )
                                        Nav.walk(tgt, { arrive = 2.2, timeout = 4 })
                                        autoDigCursorFree()
                                        local here = getHRP()
                                        if not here then break end
                                         
                                         
                                         
                                        if not inField(here.Position, field, 3) then break end
                                        local done = mpos
                                        Nav.markDone(done)
                                        local dx, dz = done.X - here.Position.X, done.Z - here.Position.Z
                                        if dx * dx + dz * dz > 64 then break end
                                        mpos = Nav.preciseMarkTarget(field)
                                    end
                                elseif S.collect_duped ~= false and Nav.collectDupedToken(field, standY) then
                                     
                                end

                                 
                                 
                                 
                                 
                                 
                                 
                                local prio = Nav.priorityToken(field)
                                if prio then
                                    status = "Priority token: " .. tostring(prio.name)
                                    Nav.walk(Vector3.new(prio.pos.X, standY, prio.pos.Z), { arrive = 2.2, timeout = 9 })
                                    local ph = getHRP()
                                    if ph then
                                        local onIt = (Vector3.new(ph.Position.X, 0, ph.Position.Z)
                                            - Vector3.new(prio.pos.X, 0, prio.pos.Z)).Magnitude <= 4
                                        pcall(function() Nav.touchToken(prio.part) end)
                                        if onIt then
                                             
                                             
                                            task.wait(0.12)
                                            pcall(function() Nav.touchToken(prio.part) end)
                                        end
                                    end
                                    autoDigCursorFree()
                                end

                                if extraPos then
                                    if extraToken then
                                        Nav.walk(Vector3.new(extraPos.X, standY, extraPos.Z), {
                                            arrive = 6,
                                            timeout = 14,
                                        })
                                        autoDigCursorFree()
                                    else
                                        Nav.walk(Vector3.new(extraPos.X, standY, extraPos.Z), {
                                            arrive = 4,
                                            timeout = 14,
                                        })
                                        autoDigCursorFree()
                                    end
                                elseif farmMode == 0 then
                                    if distToCenter(hrp.Position, field) > 4 then
                                        Nav.walk(center, { arrive = 3.5, timeout = 10 })
                                    end
                                    autoDigCursorFree()
                                    task.wait(0.1)
                                else
                                    farmFieldTurnStep(field, farmMode == 1 and closeR or nil)
                                end
                            else
                                
                                
                                status = "Waiting for character"
                                task.wait(0.3)
                            end
                        end
                    end
                end
            end
            end)
            
            
            
            if not okS then
                FARMERR = FARMERR + 1
                if FARMERR <= 5 then warn("[farm] " .. tostring(errS)) end
                status = "Error: " .. tostring(errS)
            end
            task.wait(0.05)
        end
    end)

    
    
    
    Engine.S      = S
    Engine.fields = zoneNames
    Engine.isOn   = isOn
    Engine.nectarTypes    = NECTAR_TYPES
    Engine.nectarPlanters = PLANTER_NAMES

    Engine.nectarStatus = function() return N.status or "Off" end
    Engine.nectarActive = function() return N.activeLabel or "0/3" end
    Engine.nectarBest   = nectarBestLabel

    Engine.setNectarFarm = function(v)
        if v then N.collectedAll = false end
        if v and not S.hybrid then
            S.nectar_farm = false
            N.status = "Nectar needs Hybrid input"
            if _G.__lolcatNectarRow then
                pcall(function() _G.__lolcatNectarRow:Set(false) end)
            end
            pcall(function() Lib:Notify("Nectars", "Restart in Hybrid mode from the loader", 3, "warn") end)
            return
        end
        S.nectar_farm = v and true or false
        if not S.nectar_farm then
            N.status = "Off"
        else
             
             
            N.status = "Starting"
        end
    end

    Engine.setNectarPriority = function(i, name)
        if i >= 1 and i <= 5 then
            S.nectar_slots[i] = name
            N.signature = ""
        end
    end

    Engine.setPlanter = function(name, v)
        if S.nectar_planters[name] ~= nil then
            S.nectar_planters[name] = v and true or false
            N.blacklist[name] = nil
        end
    end

    Engine.ownedPlanters = function()
        return refreshOwnedPlanters()
    end

    Engine.saveConfig = function()
        if CFG_SAVE_NOW then pcall(CFG_SAVE_NOW) end
    end

    Engine.setFeaturesActive = function(v) FeaturesActive = v and true or false end
    Engine.setUiOpen = function(v) S.dig.uiOpen = v and true or false end
    Engine.uiOpen = function() return S.dig.uiOpen end

    Engine.status = function()
        
        
        if lastBeat == 0 or (tick() - lastBeat) > 2 then return "Engine thread NOT running" end
         
         
        if not Engine.anyFeatureOn() then return "Off" end
        if not FeaturesActive then return "Paused (menu open)" end
        if not isAlive() then return "Waiting for character" end
        return status
    end

    Engine.hiveName = function() return myHive and myHive.Name or "None" end

     
     
     
     
     
     
     
     
    Engine.console = { lines = {} }

    Engine.consolePush = function(text)
        if not text or text == "" then return end
        local lines = Engine.console.lines
        local secs = math.floor(tick())
        local line = string.format("%02d:%02d ", math.floor(secs / 60) % 60, secs % 60) .. tostring(text)
        if lines[1] == line then return end
        table.insert(lines, 1, line)
        while #lines > 30 do table.remove(lines) end
    end

    Engine.consoleTick = function()
        local now = tick()
        if now < (Engine.consoleAt or 0) then return end
        Engine.consoleAt = now + 0.4

        local bits = { tostring(status or "-") }
        local moving = tostring(lastMoveMode or "Idle")
        if moving ~= "" and moving ~= "Idle" then bits[#bits + 1] = moving end
        if S.field and S.field ~= "" then bits[#bits + 1] = S.field end
        local questLine = Engine.nav and Engine.nav.questTaskLine or ""
        if questLine ~= "" then bits[#bits + 1] = questLine end

         
         
        local line = table.concat(bits, " | ")
        if line ~= (Engine.consoleSig or "") then
            Engine.consoleSig = line
            Engine.consolePush(line)
        end
    end

    Engine.consoleLine = function(index)
        local lines = Engine.console.lines
        return lines[index] or ""
    end

     
     
     
    Engine.bossTimer = function(pattern) return Nav.bossStatus(pattern) end

    Engine.miscList = function() return Nav.miscToys end
    Engine.miscStatus = function() return S.misc_status or "Off" end

     
     
    Engine.miscReady = function(key)
        Nav._miscReady = Nav._miscReady or {}
        local now = tick()
        local hit = Nav._miscReady[key]
        if hit and now - hit.at < 1 then return hit.txt end
        local left = (tonumber(Nav.miscState[key]) or 0) - now
        local txt = (left > 0) and Nav.hmsText(left) or "ready"
        Nav._miscReady[key] = { at = now, txt = txt }
        return txt
    end

    Engine.setMisc = function(key, v)
        S.misc[key] = v and true or false
        local any = false
        for _, entry in ipairs(Nav.miscToys) do
            if S.misc[entry.key] then any = true; break end
        end
        S.misc_any = any
         
         
    end

    Engine.movement = function()
        
        
        if tick() - lastMoveAt > 1.5 then return "Idle" end
        return lastMoveMode
    end

    Engine.backpack = function()
        local p, c = getPollenAndCap()
        if p and c and c > 0 then
            return string.format("%s / %s (%d%%)", floor(p), floor(c), floor((p / c) * 100))
        end
        return "-"
    end

    Engine.questLine = function()
        local left = math.max(0, math.floor((Nav.questAt or 0) - tick()))
        return tostring(Nav.questLast or "-") .. " / next in " .. left .. "s"
    end

    Engine.questGiverCount = function()
        local pick = S.quest_pick
        if pick and pick ~= "All enabled" then
            return Nav.questByName(pick) and 1 or 0
        end
        local n = 0
        for _, giver in ipairs(Engine.questGivers) do
            if (giver.group == "bear" and S.quest_bears ~= false)
                or (giver.group == "other" and S.quest_others == true) then
                n = n + 1
            end
        end
        return n
    end

    Engine.questMode = function()
        local mode = (S.quest_bypass ~= false) and S.hybrid
            and "Bypass: remotes from here" or "Travel to the giver"
        return mode
            .. " / " .. tostring(S.quest_mode or "Farm + quests")
            .. " / " .. tostring(Engine.travelMode())
            .. " / " .. Engine.questGiverCount() .. " givers"
    end

    Engine.questNow = function()
        bg(function() pcall(Nav.questStep, true) end)
    end

    Engine.setQuests = function(v)
        S.quests_auto = v and true or false
    end

    Engine.execState = function()
        if lastBeat == 0 or (tick() - lastBeat) > 2 then return "Engine thread NOT running" end
        return (Engine.anyFeatureOn() and isAlive()) and "Active" or "Idle"
    end

    Engine.onFarmToggle = function(v)
        S.farm_on = v and true or false
        if S.farm_on then
            needSprinkler = true
        else
            collecting = false
            S.dig.converting = false
            restoreFacing()
        end
    end

    Engine.onCombatToggle = function(v)
        if not v then return end
         
         
         
        S.combat_now = true
    end

    Engine.onFieldChange = function(name)
        if S.field ~= name then needSprinkler = true end
        S.field = name
    end

    Engine.detectHive = function()
        local found = autoDetectHiveInstant()
        if found then
            status = "Detected: " .. found.Name
            return
        end
        bg(function()
            HiveTool.claim()
        end)
    end

    Engine.claimHive = function()
        bg(function() pcall(HiveTool.claim) end)
    end

     
     
     
     
     
    Engine.claimSlots = function()
        if not S.hybrid then return false end
        if autoDetectHiveInstant() then
            status = "Hive: " .. myHive.Name
            return true
        end

        restoreFacing()
        status = "Claiming a hive slot"
        for slot = 1, 6 do
            pcall(function() fireEvent("ClaimHive", slot) end)
            task.wait(0.2)
        end

         
         
        for _ = 1, 10 do
            if autoDetectHiveInstant() then break end
            task.wait(0.4)
        end
        if myHive then
            status = "Hive: " .. myHive.Name
            return true
        end
        status = "ClaimHive: no free hive came back"
        return false
    end

     
     
     
    Engine.travelModes = function()
        return { "Tween", "Pathfinding" }
    end

    Engine.travelMode = function()
        if S.travel_mode == "Tween" then return "Tween" end
        return "Pathfinding"
    end

    Engine.setTravelMode = function(v)
        local name = type(v) == "table" and v[1] or tostring(v)
        if name ~= "Tween" then name = "Pathfinding" end
        S.travel_mode = name
        status = "Travel mode: " .. name
    end

    Engine.walkMethod = function()
        if S.walk_method == "Keyboard" then return "Keyboard" end
        return "Offsets"
    end

    Engine.setWalkMethod = function(v)
        local name = type(v) == "table" and v[1] or tostring(v)
        if name ~= "Keyboard" and name ~= "Offsets" then name = "Offsets" end
        S.walk_method = name
        if name ~= "Offsets" and Nav.stopSpeedWrite then Nav.stopSpeedWrite() end
        status = "Walk method: " .. name
    end

     
     
     
    Engine.setWalkSpeed = function(v)
        local n = tonumber(v) or 0
        if n > 0 and n < 16 then n = 16 end
        if n > 100 then n = 100 end
        S.walk_speed = n
        if Nav.setSpeedValue then Nav.setSpeedValue(n) end
    end

    Engine.stopSpeedWrite = function()
        if Nav.stopSpeedWrite then Nav.stopSpeedWrite() end
    end

    Engine.hidePath = function()
        pcall(function() Nav.traceClear() end)
    end

    Engine.stopTravel = function()
        local nav = type(_G) == "table" and _G.__lolcatNav or nil
        if not nav then return end
        pcall(function() nav.memWalkStop() end)
        pcall(function() nav.noclipTravel(false) end)
        pcall(function() nav.stopDrive() end)
        pcall(function() nav.stopRunAnim() end)
        pcall(function() nav.traceClear() end)
    end

    Engine.fastSweep = function()
        bg(function()
            local honey = Workspace:FindFirstChild("Honeycombs") or Workspace:FindFirstChild("Hives")
            if not honey then return end
            status = "Sweeping pads..."
            for _, hive in ipairs(honey:GetChildren()) do
                local pad = HiveTool.pad(hive)
                local pp = padPos(pad)
                if pp then
                     
                     
                    pcall(function()
                        Nav.nodeTravel(Vector3.new(pp.X, HiveTool.top(pad), pp.Z), "Pad sweep", 5)
                    end)
                    task.wait(0.2)
                    local h = autoDetectHiveInstant()
                    if h then status = "Found: " .. h.Name; break end
                end
            end
        end)
    end

    Engine.setHive = function()
        setHiveManual()
        if myHive then status = "Hive: " .. myHive.Name end
    end

    Engine.forceReturn = function() forceReturn = true end
    Engine.claimQuest  = function() bg(function() pcall(Nav.questStep, true) end) end

    Engine.shutdown = function()
        S.hard_off = true
        S.farm_on = false
        collecting = false
        S.dig.converting = false
        if Nav.stopSpeedWrite then Nav.stopSpeedWrite() end
        restoreFacing()
    end

     
    if type(_G) == "table" then _G.__lolcatEngine = Engine end

    return Engine
end

Engine = initEngine()

local travelModeRow
local walkMethodRow
local walkSpdRow
local win = Lib:CreateWindow({
     
     
     
    title    = "Bee Swarm",
    subtitle = Engine.S.hybrid and "hybrid" or "standard",
    size     = Vector2.new(860, 620),
    menuKey  = "f1",
     
     
    theme    = { accent = Color3.fromRGB(126, 138, 255) },
    accentA  = Color3.fromRGB(126, 138, 255),
    accentB  = Color3.fromRGB(183, 156, 255),
    opacity  = 1,
    configName  = "lolcatbss",
    configFolder = "lolcatbss",
    autoSave = true,
    smartFps = false,
    startOpen = true,
})

 
_G.__lolcatUI = win

win:AddSettingsTab("gear")
task.spawn(function()
    task.wait(0.8)
     
     
     
     
     
    pcall(function() win:LoadConfig("lolcatbss") end)
    pcall(function()
        local saved = travelModeRow and travelModeRow:Get()
        if saved and saved[1] then Engine.setTravelMode(saved[1]) end
         
         
        Engine.setWalkMethod("Offsets")
        if walkMethodRow then
            pcall(function() walkMethodRow:Set({ "Offsets" }) end)
        end
         
         
         
        Engine.S.speed_override = false
        Engine.setWalkSpeed(0)
        if walkSpdRow then pcall(function() walkSpdRow:Set(0) end) end
    end)
end)
task.spawn(function()
    task.wait(1)
    pcall(function() win:SetMenuKey("f1") end)
end)
Lib:Notify("Bee Swarm", "Press F1 to open the menu", 4, "info")

do
     
     
     
     
    if Engine.S.hybrid then
        task.spawn(function()
             
             
             
            for _ = 1, 24 do
                local ch = game:GetService("Players").LocalPlayer.Character
                if ch and ch:FindFirstChild("HumanoidRootPart") then break end
                task.wait(0.5)
            end
            task.wait(0.5)
            local ok = Engine.claimSlots()
            if not ok and Engine.hiveName() == "None" then
                pcall(function()
                    Lib:Notify("Bee Swarm", "No free hive to claim - claim one manually", 4, "warn")
                end)
            end
        end)
    end
end

local PLANTER_UI = {
    "Plastic Planter", "Candy Planter", "Red Clay Planter", "Blue Clay Planter",
    "Tacky Planter", "Pesticide Planter", "Heat-Treated Planter",
    "Hydroponic Planter", "Petal Planter", "Plenty Planter",
    "Paper Planter", "Sticker Planter",
}
local NECTAR_ITEMS = { "None", "Comforting", "Motivating", "Satisfying", "Refreshing", "Invigorating" }

local UIRunService = game:GetService("RunService")
local rippleParts = {}
local rippleConns = {}

local function ripplePulse()
    pcall(function()
        local cam = workspace.CurrentCamera
        local vp = cam and cam.ViewportSize or Vector2.new(1280, 720)
        local cx, cy = vp.X / 2, vp.Y / 2
        local rings = {}
        for i = 1, 3 do
            local ring = Drawing.new("Circle")
            ring.Position = Vector2.new(cx, cy)
            ring.Radius = 70
            ring.Thickness = 2
            ring.NumSides = 64
            ring.Filled = false
            ring.Color = Color3.fromRGB(148, 0, 255)
            ring.ZIndex = 250
            ring.Transparency = 0.4
            ring.Visible = false
            rings[i] = { obj = ring, delay = (i - 1) * 0.09 }
            rippleParts[#rippleParts + 1] = ring
        end
        local started = tick()
        local conn
        conn = UIRunService.RenderStepped:Connect(function()
            local elapsed = tick() - started
            local alive = false
            for i = 1, #rings do
                local r = rings[i]
                local t = elapsed - r.delay
                if t > 0 and t < 0.75 then
                    alive = true
                    local k = t / 0.75
                    r.obj.Radius = 70 + (k ^ 0.7) * 430
                    r.obj.Thickness = 2 + (1 - k) * 2.5
                    r.obj.Transparency = math.max(0, 0.5 * (1 - k))
                    r.obj.Visible = true
                else
                    pcall(function() r.obj.Visible = false end)
                end
            end
            if not alive and elapsed > 1 then
                conn:Disconnect()
                for i = 1, #rings do
                    pcall(function() rings[i].obj:Remove() end)
                end
            end
        end)
        rippleConns[#rippleConns + 1] = conn
    end)
end

 
 
 
 
 
 
 
 
do

local Honey = (function()
    local Plrs = game:GetService("Players")

    local function comma(n)
        n = tonumber(n) or 0
        local neg = n < 0
        local s = tostring(math.floor(math.abs(n) + 0.5))
        local out = ""
        while #s > 3 do
            out = "," .. string.sub(s, -3) .. out
            s = string.sub(s, 1, #s - 3)
        end
        return (neg and "-" or "") .. s .. out
    end

    local function short(n)
        n = tonumber(n) or 0
        local neg = n < 0
        n = math.abs(n)
        local suf = ""
        if n >= 1e12 then n, suf = n / 1e12, "T"
        elseif n >= 1e9 then n, suf = n / 1e9, "B"
        elseif n >= 1e6 then n, suf = n / 1e6, "M"
        elseif n >= 1e3 then n, suf = n / 1e3, "K" end
        local txt
        if suf == "" then
            txt = tostring(math.floor(n + 0.5))
        else
            txt = string.format("%.2f", n)
            txt = string.gsub(txt, "0+$", "")
            txt = string.gsub(txt, "%.$", "")
        end
        return (neg and "-" or "") .. txt .. suf
    end

    local function dur(sec)
        sec = math.max(0, math.floor(tonumber(sec) or 0))
        local h = math.floor(sec / 3600)
        local m = math.floor((sec % 3600) / 60)
        local s = sec % 60
        if h > 0 then return string.format("%dh %02dm %02ds", h, m, s) end
        if m > 0 then return string.format("%dm %02ds", m, s) end
        return tostring(s) .. "s"
    end

    local H = {
        start = tick(), player = nil,
        startValue = nil, current = nil, last = nil,
        gross = 0, net = 0, updated = 0, fallbackAt = 0,
    }

     
     
     
    H.read = function()
        if not H.player or not H.player.Parent then H.player = Plrs.LocalPlayer end
        local v
        pcall(function()
            local core = H.player:FindFirstChild("CoreStats")
            local honey = core and core:FindFirstChild("Honey")
            if honey then v = tonumber(honey.Value) end
        end)
        if v then return v end
        local now = tick()
        if now - H.fallbackAt < 3 then return nil end
        H.fallbackAt = now
        pcall(function()
            local pg = H.player:FindFirstChildOfClass("PlayerGui")
            if not pg then return end
            for _, o in ipairs(pg:GetDescendants()) do
                if o.ClassName == "TextLabel" then
                    local name = string.lower(tostring(o.Name or ""))
                    if string.find(name, "honey", 1, true) then
                        local t = tostring(o.Text or "")
                        t = string.gsub(t, "[^%d,]", "")
                        t = string.gsub(t, ",", "")
                        local n = tonumber(t)
                        if n and n >= 0 then v = n; return end
                    end
                end
            end
        end)
        return v
    end

    H.update = function()
        local now = tick()
        if now - H.updated < 0.5 then return end
        H.updated = now
        local v = H.read()
        if not v then return end
        H.current = v
        if H.startValue == nil then
             
             
            H.startValue = v
            H.last = v
        end
        if H.last then
            local d = v - H.last
             
             
            if d > 0 then H.gross = H.gross + d end
        end
        H.last = v
        H.net = v - H.startValue
    end

    H.nowText   = function() return H.current and comma(H.current) or "reading..." end
    H.baseText  = function() return H.startValue and comma(H.startValue) or "-" end
    H.netText   = function()
        if not H.current then return "reading..." end
        if H.net < 0 then return comma(H.net) .. "  (loss)" end
        return "+" .. comma(H.net)
    end
    H.grossText = function() return H.current and comma(H.gross) or "reading..." end
    H.rateText  = function()
        local elapsed = tick() - H.start
        if not H.current or elapsed < 5 then return "measuring..." end
        local perHour = H.net / (elapsed / 3600)
        return short(perHour) .. " / hour"
    end
    H.uptimeText = function() return dur(tick() - H.start) end
    H.reset = function()
        H.start = tick()
        H.startValue, H.current, H.last = nil, nil, nil
        H.gross, H.net = 0, 0
    end

    task.spawn(function()
        while _G.__lolcatBSS == INSTANCE do
            H.update()
            task.wait(0.5)
        end
    end)

    return H
end)()

 
 
if type(_G) == "table" then _G.__lolcatHoney = Honey end

Lib:Category("HOME")
local homeTab = win:Tab("Home", "home")
local sess = homeTab:Section("Session", "Left", "counted from the moment you executed the script")
sess:Label(function() return "Uptime: " .. Honey.uptimeText() end)
sess:Label(function() return "State: " .. tostring(Engine.status()) end)
sess:Label(function() return "Honey when started: " .. Honey.baseText() end)
sess:Button("Reset session counters", function() Honey.reset() end)

local made = homeTab:Section("Honey", "Right", "estimated from the game's own honey counter")
made:Label(function() return "Honey now: " .. Honey.nowText() end)
made:Label(function() return "Made this session: " .. Honey.netText() end)
made:Label(function() return "Earned (gross): " .. Honey.grossText() end)
made:Label(function() return "Estimated: " .. Honey.rateText() end)
made:Divider("How it is counted")
made:Info("Honey only lands when a conversion finishes, so the hourly figure fills in as the session runs. Net includes anything you spent; gross ignores spending, so a negative net next to a positive gross means you bought something.")

end  

local glideSpd, forceSpd

Lib:Category("AUTO")
local farmTab = win:Tab("Farm", "sun")
local auto = farmTab:Section("Automation", "Left", "farms the target field and converts")
_G.__lolcatAutoFarmRow = auto:Toggle("Enable auto farm", false, function(v) Engine.onFarmToggle(v) end)
auto:Dropdown("Target field", { Engine.fields[1] }, Engine.fields, false, function(v)
    local name = type(v) == "table" and v[1] or v
    if name then Engine.onFieldChange(name) end
end)
auto:Dropdown("Farm pattern", { "Orbit / Circle Turns" },
    { "Orbit / Circle Turns", "Square / Box Turns", "Serpentine / Snake", "Whole Field", "Middle Only" },
    false, function(v)
        local name = type(v) == "table" and v[1] or v
        if name then Engine.S.farm_mode = name end
    end)
auto:Slider("Close radius", 12, 1, 5, 60, "", function(v) Engine.S.close_r = v end)
glideSpd = auto:Slider("Tween speed (travel)", 80, 1, 10, 1200, "", function(v) Engine.S.glide_speed = v end)
auto:Button("Reset travel speed", function() glideSpd:Set(80) end)
auto:Toggle("Auto dig (collect / swing)", false, function(v) Engine.S.dig_tool = v end)
auto:Dropdown("Sprinkler (auto detect)", { "Auto" },
    { "Auto", "Off", "Basic", "Silver", "Gold", "Diamond", "Supreme" },
    false, function(v)
        local name = type(v) == "table" and v[1] or v
        if name then Engine.S.sprinkler = name end
    end)

local hiveRet = farmTab:Section("Hive return", "Right", "backpack fills, then honey time")
hiveRet:Slider("Convert at %", 90, 1, 50, 100, "%", function(v) Engine.S.full_pct = v end)
hiveRet:Toggle("Reset instead of convert", false, function(v) Engine.S.reset_mode = v end)
hiveRet:Toggle("Wait for balloons to convert", true, function(v) Engine.S.balloon_convert = v end, "hold the pad while your hive balloon drains (up to 15 s), then the usual 5 s and back to the field")
hiveRet:Divider("Live")
hiveRet:Label(function() return "Status: " .. tostring(Engine.status()) end)
hiveRet:Label(function()
    return "Input: " .. (Engine.S.hybrid and "Hybrid (remotes)" or "Normal (mouse)")
end)
hiveRet:Label(function() return "Backpack: " .. tostring(Engine.backpack()) end)

local facing = farmTab:Section("Facing", "Left")
facing:Toggle("Face field middle", false, function(v) Engine.S.face_center = v end)
facing:Toggle("Face balloons (yours & others)", false, function(v) Engine.S.face_balloons = v end)
facing:Toggle("Face bubbles (yours & others)", false, function(v) Engine.S.face_bubbles = v end)
facing:Toggle("Face flames", false, function(v) Engine.S.face_flame = v end)
facing:Toggle("Rotate camera to target", false, function(v) Engine.S.face_camera = v end)
facing:Slider("Yaw writes / sec", 10, 1, 2, 30, "/s", function(v) Engine.S.face_hz = v end, "how often the yaw is rewritten while facing: higher turns faster and costs more")
facing:Label(function()
    return "Facing: " .. tostring(Engine.S.face.mode) .. " | yaw writes " .. tostring(Engine.S.face.writes or 0)
end)

local gath = farmTab:Section("Gathering extras", "Right")
gath:Toggle("Farm under balloons", false, function(v) Engine.S.farm_under_balloons = v end)
gath:Toggle("Farm under clouds", false, function(v) Engine.S.farm_under_clouds = v end)
gath:Toggle("Farm flames", false, function(v) Engine.S.farm_flames = v end)
gath:Toggle("Stand on precise marks", true, function(v) Engine.S.mark_target = v end)
gath:Toggle("Collect digital tokens (stand under 2s)", true, function(v) Engine.S.collect_duped = v end)
gath:Label(function() return "Dig clicks sent: " .. tostring(Engine.S.dig and Engine.S.dig.clicks or 0) end)

 
 
local HYBRID_TABS = Engine.S.hybrid == true

if HYBRID_TABS then
Lib:Category("NECTARS")
local nectarTab = win:Tab("Nectars", "plant")
 
nectarTab.Tooltip = function()
    local on = {}

    for _, name in ipairs(PLANTER_UI) do
        if Engine.S.nectar_planters[name] == true then
            on[#on + 1] = string.gsub(name, " Planter", "")
        end
    end

    return "Nectars", next(on) and table.concat(on, ", ") or "no planters allowed yet"
end
local nm = nectarTab:Section("Nectar automation", "Left", "hybrid only: places your planters, then farms your field")
local nectarFarmRow = nm:Toggle("Enable nectar farm", false, function(v) Engine.setNectarFarm(v) end)
if _G then _G.__lolcatNectarRow = nectarFarmRow end
nm:Info("Hybrid input only. Pick planters below; nothing is placed until you do.")
nm:Toggle("Repeat / keep cycling", true, function(v) Engine.S.nectar_repeat = v end)
nm:Dropdown("Harvest when", { Engine.S.nectar_mode or "Growth %" }, { "Growth %", "Every X hours" }, false, function(v)
    local name = type(v) == "table" and v[1] or v
    Engine.S.nectar_mode = (name == "Every X hours") and "Every X hours" or "Growth %"
end)
nm:Slider("Growth % threshold", 100, 5, 5, 100, "%", function(v) Engine.S.nectar_collect_pct = v end)
nm:Slider("Hours between collects", 1, 1, 1, 4, "h", function(v) Engine.S.nectar_collect_every = v end)    nm:Toggle("Fill extra planters (up to 3)", false, function(v) Engine.S.nectar_extra = v end)
nm:Divider("Live")
nm:Label(function() return "Status: " .. tostring(Engine.nectarStatus()) end)
nm:Label(function() return "Active planters: " .. tostring(Engine.nectarActive()) end)
nm:Label(function() return "Best pick: " .. tostring(Engine.nectarBest()) end)

local np = nectarTab:Section("Nectar priorities", "Right", "top fields get planters first")
for i = 1, 5 do
    local cur = Engine.S.nectar_slots and Engine.S.nectar_slots[i] or "None"
    if cur == nil or cur == "" then cur = "None" end
    np:Dropdown("Priority " .. i, { cur }, NECTAR_ITEMS, false, function(v)
        local name = type(v) == "table" and v[1] or v
        if name then Engine.setNectarPriority(i, name) end
    end)
end
 
 
np:Divider("Order")
np:Label(function()
    local parts = {}
    for i = 1, 5 do
        local n = Engine.S.nectar_slots and Engine.S.nectar_slots[i]
        parts[#parts + 1] = i .. "." .. tostring(n or "None")
    end
    return "Placing: " .. table.concat(parts, "  ")
end)

local pw = nectarTab:Section("Planters", "Left", "select the planters the bot may place")
for i = 1, #PLANTER_UI do
    local name = PLANTER_UI[i]
     
     
     
    pw:Toggle("Use " .. name, Engine.S.nectar_planters[name] == true, function(v) Engine.setPlanter(name, v) end)
end

end  

 
 
 
do
Lib:Category("EXTRAS")
local combatTab = win:Tab("Combat", "swords")
local bs = combatTab:Section("Bosses", "Left")
bs:Toggle("Kill Coconut Crab", Engine.S.kill_crab, function(v)
    Engine.S.kill_crab = v
    Engine.onCombatToggle(v)
end)
bs:Toggle("Kill King Beetle", Engine.S.kill_beetle, function(v)
    Engine.S.kill_beetle = v
    Engine.onCombatToggle(v)
end)
bs:Toggle("Kill Tunnel Bear", Engine.S.kill_bear, function(v)
    Engine.S.kill_bear = v
    Engine.onCombatToggle(v)
end)
bs:Toggle("Kill Vicious Bee", Engine.S.kill_vicious, function(v)
    Engine.S.kill_vicious = v
    Engine.onCombatToggle(v)
end)
bs:Toggle("Kill Mondo Chick", Engine.S.kill_mondo, function(v)
    Engine.S.kill_mondo = v
    Engine.onCombatToggle(v)
end)
bs:Toggle("Collect Mondo Chick tokens", Engine.S.mondo_loot, function(v)
    Engine.S.mondo_loot = v
end, "after the kill, walk over the pile on the plateau (never tween) and hold 5 s")
 
bs:Info("Coconut Crab tweens itself (hover fight). No need to change Travel mode.")
 
 
 
bs:Divider("Respawn timers")
bs:Label(function() return "King Beetle: " .. tostring(Engine.bossTimer("King")) end)
bs:Label(function() return "Coconut Crab: " .. tostring(Engine.bossTimer("Coconut")) end)
bs:Label(function() return "Tunnel Bear: " .. tostring(Engine.bossTimer("Tunnel")) end)
bs:Label(function() return "Vicious Bee: " .. tostring(Engine.bossTimer("Vicious")) end)
bs:Label(function() return "Mondo Chick: " .. tostring(Engine.bossTimer("Mondo")) end)

local ex = combatTab:Section("Hazards & items", "Right")
ex:Toggle("Catch falling coconuts", false, function(v) Engine.S.catch_coconuts = v end)
ex:Toggle("Catch star showers", false, function(v) Engine.S.catch_stars = v end)
ex:Toggle("Farm active sprouts", false, function(v) Engine.S.farm_sprouts = v end)
ex:Toggle("Auto-collect loot tokens", false, function(v) Engine.S.collect_tokens = v end)
ex:Toggle("Convert when a balloon is near", false, function(v) Engine.S.convert_balloon = v end)
end  

do  
Lib:Category("MISC")
local miscTab = win:Tab("Misc", "box")
local mt = miscTab:Section("Toys & dispensers", "Left",
    "travels there and uses it, then waits out the toy's own cooldown")
for _, entry in ipairs(Engine.miscList()) do
    mt:Toggle(entry.label, Engine.S.misc[entry.key] == true, function(v)
        Engine.setMisc(entry.key, v)
    end)
end
local ms = miscTab:Section("Cooldowns", "Right", "one toy per pass, in the order on the left")
ms:Label(function() return "Last: " .. tostring(Engine.miscStatus()) end)
ms:Slider("Gap between toys", Engine.S.misc_gap or 12, 1, 3, 120, "s", function(v)
    Engine.S.misc_gap = v
end, "with every toy on, farming and bosses still get their turn between trips")
ms:Divider("Ready")
for _, entry in ipairs(Engine.miscList()) do
    ms:Label(function() return entry.label .. ": " .. tostring(Engine.miscReady(entry.key)) end)
end
ms:Info("Hybrid fires each toy's own remote; Standard stands on it and presses E. The Coconut Dispenser waits until the Coconut Crab is down. Cooldowns last for the session - reloading the script clears them.")
end  

local hiveTab = win:Tab("Hive", "layers")
local det = hiveTab:Section("Detection", "Left", "find and assign your hive pad")
det:Button("Auto detect hive (instant)", function() Engine.detectHive() end)
det:Button("Claim unclaimed hive", function() Engine.claimHive() end)
det:Button("Fast pad sweep", function() Engine.fastSweep() end)
det:Button("Set hive (manual pad)", function() Engine.setHive() end)
det:Divider("Live")
det:Label(function() return "Assigned: " .. tostring(Engine.hiveName()) end)

local hiveAct = hiveTab:Section("Actions", "Right")
hiveAct:Button("Force return to hive now", function() Engine.forceReturn() end)
hiveAct:Label(function() return "State: " .. tostring(Engine.execState()) end)

local moveTab = win:Tab("Movement", "gauge")
local loco = moveTab:Section("Locomotion", "Left")

forceSpd = loco:Slider("Force tween speed", 1400, 1, 600, 3000, "", function(v) Engine.S.force_tween = v end)
loco:Button("Reset speeds", function()
    forceSpd:Set(1400)
end)
local travelSec = moveTab:Section("Travel", "Right", "how the bot crosses the map")
do
    local travelModeList = Engine.travelModes()
    if #travelModeList > 1 then
        travelModeRow = travelSec:Dropdown("Travel mode", { Engine.travelMode() }, travelModeList, false, function(v)
            Engine.setTravelMode(type(v) == "table" and v[1] or v)
        end)
    else
         
         
         
        travelSec:Info("Travel: " .. tostring(travelModeList[1] or "Pathfinding") .. " - this build has one travel mode")
    end
end
walkMethodRow = travelSec:Dropdown("Walk method", { Engine.walkMethod() }, { "Offsets", "Keyboard" }, false, function(v)
    Engine.setWalkMethod(type(v) == "table" and v[1] or v)
end)
travelSec:Toggle("Force WalkSpeed (may rubber-band)", Engine.S.speed_override == true, function(v)
    Engine.S.speed_override = v and true or false
    if not v then
        Engine.setWalkSpeed(0)
        if Engine.stopSpeedWrite then Engine.stopSpeedWrite() end
    end
end)
walkSpdRow = travelSec:Slider("Walk speed override", Engine.S.walk_speed or 0, 1, 0, 100, "", function(v)
    Engine.setWalkSpeed(v)
end)
travelSec:Info("Offsets walk at the game's own speed is the fastest, steady setting. Only raise the slider with Force WalkSpeed on.")
if _G then _G.__lolcatWalkMethodSync = function(name) pcall(function() walkMethodRow:Set({ name }) end) end end
travelSec:Label(function() return "Travel: " .. tostring(Engine.travelMode()) .. " / " .. tostring(Engine.walkMethod()) end)
local worldSec = moveTab:Section("World", "Right")
worldSec:Label(function() return "Locomotion: " .. tostring(Engine.movement()) end)

 
 
local Nav = (Engine and (Engine.nav or _G.__lolcatNav)) or {}

 
 
 
 
 
 
 
 
 
function Engine.questLog()
    local nav = (Engine.nav or _G.__lolcatNav) or Nav
    local read = nav and nav.questRead
    if type(read) ~= "function" then return {} end
    local ok, list = pcall(read)
    if ok and type(list) == "table" then return list end
    return {}
end

local qtab = win:Tab("Quests", "clock")
local qleft = qtab:Section("Quest automation", "Left")
qleft:Toggle("Auto quests", Engine.S.quests_auto == true, function(v) Engine.setQuests(v) end, "turn in the finished quest and take the next one, one giver per pass")
qleft:Dropdown("Quest mode", Engine.S.quest_mode or "Farm + quests", { "Farm + quests", "Quests only" }, false, function(v)
    Engine.S.quest_mode = type(v) == "table" and v[1] or v
end, "Farm + quests: farm between quest passes. Quests only: no farming, just the quest cycle")
qleft:Dropdown("Giver", Engine.S.quest_pick or "All enabled", Engine.questNames(), false, function(v)
    Engine.S.quest_pick = type(v) == "table" and v[1] or v
end, "All enabled uses the two groups below; a name runs that one giver alone")

do  
 
 
 
local function questOptionNames()
    local names = { "Auto" }
    local list = Engine.questLog()
    do
        for _, entry in ipairs(list) do
            local title = entry.title
            if title and #title > 0 then
                local seen = false
                for _, name in ipairs(names) do
                    if name == title then seen = true break end
                end
                if not seen then names[#names + 1] = title end
            end
        end
    end
    return names
end

local questPickRow = qleft:Dropdown("Quest", Engine.S.quest_target or "Auto", questOptionNames(), false, function(v)
    Engine.S.quest_target = type(v) == "table" and v[1] or v
end, "Auto works whatever is active; a title works that quest alone")
 
 
task.spawn(function()
    while _G.__lolcatBSS == INSTANCE do
        task.wait(2)
        pcall(function()
            local names = questOptionNames()
            questPickRow.Options = names
            local picked = Engine.S.quest_target or "Auto"
            local found = false
            for _, name in ipairs(names) do
                if name == picked then found = true break end
            end
            if not found then
                picked = "Auto"
                Engine.S.quest_target = "Auto"
            end
            if questPickRow.Selected ~= picked then questPickRow.Selected = picked end
        end)
    end
end)
end

qleft:Toggle("Farm the quest's field", Engine.S.quest_follow ~= false, function(v) Engine.S.quest_follow = v and true or false end, "a pollen task farms the field it names, beside Auto farm")
qleft:Toggle("Pollen tasks", Engine.S.qk_pollen ~= false, function(v) Engine.S.qk_pollen = v and true or false end, "work \"collect X pollen from Y\" objectives")
qleft:Toggle("Defeat tasks", Engine.S.qk_mobs ~= false, function(v) Engine.S.qk_mobs = v and true or false end, "hunt the monsters a quest names")
qleft:Toggle("Puffshroom tasks", Engine.S.qk_puff ~= false, function(v) Engine.S.qk_puff = v and true or false end, "pop the puffshrooms a quest needs")
qleft:Toggle("Token tasks", Engine.S.qk_tokens ~= false, function(v) Engine.S.qk_tokens = v and true or false end, "collect the tokens a quest names")
qleft:Toggle("Quest bears", Engine.S.quest_bears ~= false, function(v) Engine.S.quest_bears = v and true or false end, "Black, Brown, Mother, Panda, Science, Dapper, Spirit, Polar")
qleft:Toggle("Quest bees and others", Engine.S.quest_others == true, function(v) Engine.S.quest_others = v and true or false end, "Bucko, Riley, Honey Bee, Onett, Stick Bug, Robo Bear, Gummy Bear, Bee Bear")
qleft:Slider("Check every", Engine.S.quest_check or 25, 5, 10, 120, "s", function(v) Engine.S.quest_check = v end, "one giver per pass")
if HYBRID_TABS then
    qleft:Toggle("Bypass quest (no travel)", Engine.S.quest_bypass ~= false, function(v) Engine.S.quest_bypass = v and true or false end, "fire CompleteQuestFromPool / GiveQuestFromPool from here instead of walking to the bear")
end
local qright = qtab:Section("Progress", "Right")
qright:Label(function()
     
     
     
    if #Engine.questLog() == 0 then return "Quest: no quest held" end
    return "Quest: " .. tostring(Nav.questTrack or "none")
end)
qright:Label(function() return tostring(Nav.questTaskLine or "-") end)

do  
 
 
 
local function questTaskAt(index)
    local list = Engine.questLog()
    if #list < 1 then return "-" end
    local entry = nil
    for _, e in ipairs(list) do
        if e.title == (Nav.questTrack or "") then entry = e break end
    end
    if not entry then entry = list[1] end
    if not entry then return "no active quest" end
    local task = entry.tasks[index]
    if not task then return "" end

    local label
    if task.done then
        label = "done"
    elseif task.kind == "pollen" then
        label = "pollen " .. tostring(task.field or "?")
    elseif task.kind == "mobs" then
        label = "kill " .. tostring(task.mob or "?")
    elseif task.kind == "puff" then
        label = "puffshrooms"
    elseif task.kind == "tokens" then
        label = "tokens " .. tostring(task.field or "")
    elseif task.kind == "planters" then
        label = "planters"
    elseif task.kind == "nectar" then
        label = "nectar"
    else
        label = string.sub(tostring(task.text or ""), 1, 30)
    end
    if task.have and task.need then
        label = label .. " " .. tostring(task.have) .. "/" .. tostring(task.need)
    end
    return tostring(entry.quest or "") .. ": " .. label
end
for index = 1, 3 do
    qright:Label(function() return questTaskAt(index) end)
end
end

qright:Label(function() return "Last: " .. tostring(Engine.questLine()) end)
qright:Label(function() return tostring(Engine.questMode()) end)
qright:Button("Turn in + accept now", function() Engine.questNow() end)
qright:Info("Bypass on: the game's own quest remotes are fired from anywhere. Bypass off: the character travels to the giver first, with the Travel method selected, then fires them at the bear.")

 
 
do  
local consoleSec = win:SettingsSection("Console", "Left")
consoleSec:Label(function() return "Now: " .. tostring(Engine.status()) end)
consoleSec:Label(function()
    local where = "-"
    pcall(function()
        local hrp = game:GetService("Players").LocalPlayer.Character
        local root = hrp and hrp:FindFirstChild("HumanoidRootPart")
        if root then where = string.format("%.0f, %.0f", root.Position.X, root.Position.Z) end
    end)
    return "Travel: " .. tostring(Engine.movement()) .. " / " .. tostring(Engine.S.field or "-") .. " @ " .. where
end)
for index = 1, 7 do
    consoleSec:Label(function() return Engine.consoleLine(index) end)
end
consoleSec:Info("Where the bot is going and what it is doing, newest first. Visible only while this menu is open.")
end

local myCfg = win:SettingsSection("Session", "Right")
myCfg:Label(function() return "State: " .. tostring(Engine.status()) end)
myCfg:Button("Unload script", function()
    Lib:Dialog({
        title    = "Unload?",
        text     = "Stop the bot and remove the menu?",
        confirm  = "Unload",
        onConfirm = function()
            _G.__lolcatBSS = nil
            pcall(function() Engine.shutdown() end)
            pcall(function() win:Destroy() end)
        end,
    })
end):SetRisk()

SHUTDOWN_HOOK = function()
    pcall(function() Engine.stopTravel() end)
    pcall(function() Engine.setFeaturesActive(false) end)
    pcall(function() Engine.shutdown() end)
    for i = #rippleConns, 1, -1 do
        pcall(function() rippleConns[i]:Disconnect() end)
        rippleConns[i] = nil
    end
    for i = #rippleParts, 1, -1 do
        pcall(function() rippleParts[i]:Remove() end)
        rippleParts[i] = nil
    end
    if win then
        pcall(function() win:SaveConfig("lolcatbss") end)
        pcall(function() win:Destroy() end)
    end
end

task.spawn(function()
    while _G.__lolcatBSS == INSTANCE do
        local open = false
        pcall(function() open = win:IsOpen() end)
         
         
         
         
        local keepRunning = (Engine.S.hybrid and Engine.S.walk_method == "Offsets")
        pcall(function() Engine.setFeaturesActive((not open) or keepRunning) end)
         
         
         
        pcall(function() Engine.setUiOpen(open) end)
        task.wait(0.05)
    end
end)

 
 
 
 
task.spawn(function()
    local last = nil
    local forceAt = tick() + 60
    while _G.__lolcatBSS == INSTANCE do
        task.wait(1.5)
        pcall(function()
            local sig = win:ConfigSignature()
            local due = tick() >= forceAt
            if sig ~= "" and (sig ~= last or due) then
                last = sig
                forceAt = tick() + 60
                win:SaveConfig("lolcatbss")
            end
        end)
    end
end)
