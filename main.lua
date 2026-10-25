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

local LOGO_B64 = "iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAYAAABccqhmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAnaSURBVHhe7d3dsZvIFgZQBeAEJoFJYBKYCByBM3AGTsFv165b98ExOInJwsFwbu0jGMtbSGjzJ/p4raqumvKBptHQn6Bp0OkEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAcWdd1319m6rruY67vrcj7WvRXrg8OSQCMy/taJABogwAYl/e1SADQBgEwLu9rkQCgDQJgXN7XIgFAGwTAuLyvRQKANgiAcXlfiwQAbRAA4/K+FgkA2iAAxuV9LRIAtEEAjMv7WiQAaIMAGJf3tUgA0AYBMC7va5EAoA0CYFze1yIBQBsEwLi8r0UCgDYIgHF5X4sEAG0QAOPyvhYJANpwpADouu7Prus+dF33OdrVdd2PvM3Qdd0//d8/dV33vuu6P3JdS+VtFgkA2vDsAIjOEh0+113Vh8KHl5eXd3kbc+T6iwQAbXhWAPQdf/a27+kDZVEQ5DqLBABtWNIJ5wRAdMwl26yIM4K8/UfluooEAG1Y0hmrARAdI9exta7rvs05G8j1FAkA2rBXAMRgXV5/LzE+UA2BXEeRAKANewTAy8vL33ndvVVDIK9fJABow9YBELfo8nrPEoODuX235HWLBABt2CEAZte/kb9zG8fklYoEAG1Y0kGnAuCZ1/239JOLJi8F8npFAoA2bBwAozP5nu2R24N5nSIBQBu2CoA1bvn1t/D+7Uz9HIKY+rsoWGL9X1t7La9TJABow1YBsHR6771v6T4IYlR/tnjuINd7KS9fJABow4YBMPtbOtqU68uW3l241/aQly8SALRhiwBY2jkfHalfcpYxFTJ5+SIBQBu2CICl1/+5vluWTjDK9V3KyxYJANqwRQD0j+XOEtf2ub5btgyavGyRAKANGwXAx7zso6ZOzbO8fkWu61JetkgA0AYBMC4vWyQAaIMAGJeXLRIAtKHlAIh7+Xn9ilzfpbxskQCgDRsFwOxnAB6ZpTcwCAgLbREASzvmIw/rhC3PNPLyRQKANmwUAO/yshVxBpHrHLNkOvDUuwHy8kUCgDZsEQBh4VTgycuApWcZUyGTly8SALRhwwD4lJevuPcN3T8MNDtgwtSPieTliwQAbdgqAJZ+Q4e+bf8+FzA8DpyXq5q6/g95nSIBQBu2CoCw9Ft6K1On/yGvUyQAaMPGAbD423ptj4wvhLxekQCgDVsGQFgyUr+RhzpnXqnooW3A0+0QAItm663p3sBiltctEgC0YesACEe4FPDDIDBijwAIzwyBaucPuY4iAUAb9gqA8IwQ6Pev1PlDrqdIANCGPQMgxJjAXgODc9o3yHUVCQDasHcADNZ4v/8tMdg3NdNvSq6zSADQhmcFwKAPgvgBkEUiTGL68dKOP8j1FwkAqIqOE6ESgXAvmOISIv7ed/gIkFU6PQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAArOx/p+6PL6eXv7+cuo9fT933c3l5uV2GZbrPsU6/7p+5XuCg/nt6+evrqfv09dT9uO7gS0r3PUIhbw94sq+nl3f/OXUf1u/01yVvG3iic8e/7qhblbx94Ani2vzLqfsnd9CtS27H72a4xIrPPv47/x02dx7Uu+6ce5Tclrcugra/vPqWPwsBwO5ihD4fiHuW3J63JsZTvpy69+fP+f6YigBgN/2Bufspfy65XW/B5Wl93t97RQCwm7FT0GeU3K7WLbmcEgDs4tmn/Zclt611AoBDi9l4+cB7Zsnta50A4LDiuj8fdM8uuY2tEwAc1pFO/YeS29g6AcAhnUemrw+6ZSVua8Vo9/hDPvHwUGz31n3vKHmd1gkADmn6yb1K6X5Ep8/beMR5DOLnmUj+e1V0mrjP/tgTiue/D08mxiVRrm8pAcDhxDdxPtjmlrWe4Du3qfuW/31KHyDle+y3StQTAZK3M2WbM6p7pfue2wAPOT/Omw+oepnTUdbQT6zZePyidlYjAGjG1BTUR0pcx+d695Lbsm3pPuftjxEANCEG564Ppmp57sF33Z6ty3QICACasGRQaihxvZ7r3VNuzx5l6oxHANCE+6Pij5T6QN3artu0T7kXfAKAJlwfSLXyrIG/S7lN+5XblwICgCZcH0i1cu9bcC+5TXuW3JaBAODw1jhIc53PkNv0a+m+xThH7GsOq/NrzF9fxjH7LsitW4NrfLa1IgAoWn6QHuOgG2lXdPrSpcn8eQTdp1xXWP7ZVssx/l/QkOUH6TEOuov2fM7f8hXzBkRrn8GSuy6mArOqtxMA3bclHX8wt3Pmeu6Zu40oAoBVvZUAqIr9vvgJs/hVo3gIaPY4QK7/HgHAYSwPgNrBv7fYv/5R43jj7ozT+8dKpWMKAA5jjQDY4pHZJc5Tm+cO6M0rlY4pADiMNQLg1m2wvfUdf7Nv+Xul0jEFAIexzjsAb8+G28v5Xn5u136l0jEFAIeSD7I5ZY0R+Ln2/rHSsVLpmAKAQ1nntPk5DwQd5RXmlY4pADiUJQfkZanOvFtq+eXL662/eHXY6zTh/tePZ30WlY45dxvV7cBD1nkhyLnsGQJzT/3vtXFu56x0zLnbqG4HHrZkEkwuUy/KeNT5DsXtiUZz2jzVgeZ2zql6L83dRnU78LC1Xgr6s3Tf5xysw09lX77RNy8T5rzFOOrM9WS3fptgqlT2VQBwOHM61GPl/g+DnK+9z1Nyb73GO68TzmcH18veL7fPJgbX6zxWKh1zSQDEurk+WMXes+ceLbmdYc71/9QZwJw6h7JXAPSXPYeaeckbsd1ZwLKS2xnmdqJbHXXpQOitesfMbftQIsgq24OHLT04tyi5jWFJO/tZg6/fov0bgWbXNZRKh9xu7sL0JQ5MunUt/qyS2xe260TzSi0Alp1t3C4CgBVsd4DOK7l94WhtrARAyOuvUwQAKzlSB8ttG+TlnlnqAbDFgKsAYEVHCYHcrsFGnWhWndUA2GbAVQCwsv4Z+/KMuzVLbtNg3lyAe+X8XMD1v0+XagCELSZf5W3AYueHbubNkFuj5PZcWqtd/cBnzELcMQBet7figKsAYEPnkff9zwZyOy6t0YmGzh/17RkAYd0zLAHADvJc/W1L9yNvP1sSApedP+wdAKE/w1rjnQwCgP30317xSu2VvsGG0n3vnw24enbglr4Tla6px+bVPyMABkt/ouwIr2bjN3WeUffve/a/TX2jnb95X1/I8fq7fXHwr9GJoh39a8CjDb90pn6brz8ZduT59D9fTHLvtwpe/za80OT9M1/JBgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAL+1/wOSMpPY3Xd2egAAAABJRU5ErkJggg=="
local LOGO = nil
pcall(function() LOGO = base64decode(LOGO_B64) end)

local Lib = (function()local HttpService = game:GetService("HttpService")
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Fonts = Drawing.Fonts
local SystemFont = Fonts.System
local BoldFont = Fonts.SystemBold
local MonoFont = Fonts.Monospace
local UiFont = Fonts.UI
local MinecraftFont = Fonts.Minecraft
local PixelFont = Fonts.Pixel
local FortniteFont = Fonts.Fortnite

local FontWidth = {
  [SystemFont] = 0.48,
  [BoldFont] = 0.52,
  [UiFont] = 0.50,
  [MonoFont] = 0.60,
  [MinecraftFont] = 0.55,
  [PixelFont] = 0.50,
  [FortniteFont] = 0.55,
}

local LibName = "INSui"

local White = Color3.fromRGB(255, 255, 255)
local Black = Color3.fromRGB(0, 0, 0)
local AccentA = Color3.fromRGB(122, 134, 255)
local AccentB = Color3.fromRGB(189, 130, 255)
local Newline = string.char(10)

local ChipHint = "click rebind (any key / mouse)  " .. string.char(194, 183) .. "  right-click mode"
local SearchHint = "Search  " .. string.char(194, 183) .. "  Ctrl+Space"
local SpotHint = "Ctrl+Space"
local Instance = {}

_G[LibName .. "Instance"] = Instance

local function Blend(first, second, amount)
  return Color3.new(first.R + (second.R - first.R) * amount, first.G + (second.G - first.G) * amount, first.B + (second.B - first.B) * amount)
end

local Theme = {
  IconIdle = Color3.fromRGB(188, 191, 199),
  Background = Color3.fromRGB(15, 15, 15),
  Text = White,
  Idle = Color3.fromRGB(150, 153, 161),
  Category = Color3.fromRGB(120, 122, 132),
  AccentA = AccentA,
  AccentB = AccentB,
  Accent = Blend(AccentA, AccentB, 0.5),
  Track = Color3.fromRGB(61, 61, 61),
  Risk = Color3.fromRGB(255, 190, 70),
  SliderTrack = Color3.fromRGB(87, 86, 86),
  Swatch = Color3.fromRGB(40, 40, 40),
}

local Layout = {
  WindowSize = Vector2.new(560, 460),
  Corner = 8,
  MinWidth = 420,
  MinHeight = 300,

  TopbarHeight = 42,
  RailNarrow = 54,
  TitleHeight = 31,
  TopPill = 26,
  GemSize = 16,
  RailShare = 0.23,
  RailWide = 126,

  PillHeight = 30,
  PillRadius = 7,
  PillIndent = 12,
  PillIcon = 34,
  SubHeight = 24,
  SubRadius = 6,
  SubIcon = 14,
  SubIndent = 14,
  SubStagger = 0.10,
  SubSpan = 0.7,
  PillMix = 0.35,
  NavRest = 0.004,
  IconSize = 16,

  RowHeight = 26,
  RowGap = 6,
  CardRadius = 5,
  CardLeft = 20,
  CardInset = 38,
  CardTopPad = 11,
  CardBottomPad = 8,
  ColumnGap = 10,
  ContentPad = 12,
  ContentTop = 10,
  ContentBottom = 10,
  ScrollGutter = 6,
  SectionTitle = 17,
  SectionDesc = 13,

  ToggleRow = 30,
  ButtonRow = 26,
  SliderRow = 38,
  DropdownRow = 44,
  DropdownInlineRow = 26,
  TextboxRow = 44,
  ColorRow = 26,
  KeybindRow = 30,
  DividerRow = 18,

  SwitchWidth = 38,
  SwitchHeight = 20,
  SwitchKnob = 14,
  ButtonHeight = 22,
  ValueHeight = 18,
  BarHeight = 8,
  KnobRadius = 6,
  KnobHover = 9,

  MonoSize = 26,
  MonoRadius = 7,
  HeaderTitle = 16,
  SearchWidth = 190,
  SearchMin = 100,
  SearchShare = 0.28,
  SearchHeight = 18,
  ButtonBox = 20,
  UserCard = 46,
  AvatarRadius = 14,

  SwatchSize = 16,
  CheckboxSize = 18,
  CheckMax = 15.2,
  CheckHaloMax = 15.4,
  CheckRingMax = 17,
  CheckSnap = 0.0005,
  CheckRest = 0.002,
  RowSwatchSize = 14,
  RowSwatchRadius = 5,
  RowChipMin = 28,
  RowChipPad = 14,
  RowChipRadius = 5,
  ChipHeight = 20,
  FieldGap = 20,
  FieldHeight = 24,
  FieldRadius = 4,
  FieldPad = 10,
  FieldInset = 18,
  LabelHeight = 16,
  SwatchRadius = 6,
  ColorLabel = 24,
  PickerOffsetX = 12,
  PickerOffsetY = 80,
  ChipRadius = 4,
  ChipNudge = 0.37,
  ChipMin = 40,
  ChipPad = 16,
  LabelLine = 16,
  InfoLine = 15,
  DividerHeight = 16,
  DividerPad = 8,
  ButtonGap = 8,
  ShimmerMix = 0.5,
  RainbowScale = 0.3,
  RainbowSpread = 0.12,
  RangeBoxWidth = 54,
  RangeLabelRoom = 90,
  RangeFillMin = 0.5,
  EditWidth = 0.50,
  CaretWidth = 1,
  CaretBlink = 0.55,
  SelectLift = 1,
  SelectGrow = 4,
  SelectRadius = 3,
  DragSlop = 3,
  DragSpeed = 28,
  PlaceholderInset = 20,
  RepeatDelay = 0.4,
  RepeatRate = 0.035,

  MenuWidth = 96,
  MenuRow = 24,
  MenuPad = 8,
  MenuMargin = 8,
  MenuRise = 6,
  MenuRadius = 8,
  MenuInset = 4,
  MenuTrim = 2,
  MenuItemRadius = 6,
  MenuTextPad = 12,
  MenuTextRoom = 20,
  MenuEdge = 4,
  MenuSpeed = 22,
  NoteMax = 10,
  NoteWidth = 292,
  NoteMargin = 16,
  NoteGap = 8,
  NoteLines = 4,
  NoteLine = 15,
  NoteTopPad = 24,
  NoteBottomPad = 14,
  NoteRadius = 12,
  NoteSlide = 12,
  NoteFadeIn = 0.25,
  NoteFadeOut = 0.35,
  NoteShadowX = 2,
  NoteShadowY = 3,
  NoteDotX = 17,
  NoteDotY = 16,
  NoteDot = 3.5,
  NoteTextX = 29,
  NoteTitleY = 9,
  NoteTitleRoom = 42,
  NoteBodyY = 26,
  NoteBodyRoom = 40,
  NoteTrackRoom = 45,
  NoteTrackLift = 9,
  NoteBarHeight = 2,
  NoteBarRadius = 1,
  GradientSteps = 24,
  FullFrame = 1 / 144,
  LiteFrame = 1 / 60,
  IdleFrame = 1 / 30,
  IdleGrace = 0.5,
  TipDelay = 0.35,
  TipWrap = 240,
  TipStretch = 1.04,
  TipPad = 14,
  TipTopPad = 7,
  TipLine = 15,
  TipOffsetX = 12,
  TipOffsetY = 18,
  TipMargin = 8,
  TipBottom = 4,
  TipInset = 8,
  TipTextTop = 4,
  TipRadius = 6,
  DialogSpeed = 18,
  DialogHide = 0.01,
  DialogLive = 0.5,
  DialogWidth = 344,
  DialogInset = 22,
  DialogBase = 92,
  DialogLine = 18,
  DialogLift = 12,
  DialogShadowX = 3,
  DialogShadowY = 6,
  DialogRadius = 12,
  DialogHaloOut = 1,
  DialogHaloRadius = 13,
  DialogTitle = 16,
  DialogTitleTop = 18,
  DialogTextTop = 48,
  DialogButton = 30,
  DialogGap = 10,
  DialogButtonPad = 16,
  DialogButtonRadius = 6,
  ListRow = 26,
  ListVisible = 8,
  ListHeader = 30,
  ListPad = 8,
  ListInset = 4,
  ListMargin = 8,
  ListDrop = 26,
  InlineMin = 110,
  InlineShare = 0.5,
  DropdownTextRoom = 34,
  ArrowInset = 14,
  ArrowRadius = 4,
  ArrowRise = 0.55,
  ArrowThick = 1.6,
  ArrowSpeed = 16,
  ListLift = 6,
  ListReach = 4,
  ListShadow = 3,
  ListShadowRadius = 11,
  ListRadius = 8,
  ListOpenSpeed = 9,
  ListGoneAt = 0.02,
  ListScrollSpeed = 16,
  ListBarRoom = 18,
  ListRowRoom = 8,
  ListRowGap = 2,
  ListRowRadius = 6,
  ListEdgeSlack = 2,
  ListTextInset = 12,
  ListTextRoom = 42,
  ListSearchInset = 6,
  ListSearchTop = 5,
  ListSearchBox = 22,
  ListSearchRadius = 6,
  ListSearchText = 14,
  ListSearchRoom = 28,
  ListSearchField = 30,
  PanelMix = 0.03,
  CascadeStep = 0.06,
  RevealTime = 1.3,
  JumpMargin = 37,
  CascadeSpan = 0.4,
  CascadeDrop = 12,
  PressTime = 0.3,
  TickInset = 14,
  TickNudge = 1,
  TickShort = 3,
  TickLongX = 8,
  TickLongY = 4,
  TickThickness = 1.5,
  TrackNudge = 1,
  TrackTrim = 4,
  TrackInset = 6,
  TrackWidth = 3,
  TrackRadius = 2,
  TrackReach = 6,
  TrackGrab = 12,
  ThumbMin = 22,
  ThumbSpeed = 18,
  ThumbSnap = 0.1,
  ThumbGlowSpeed = 14,
  ThumbGlowSnap = 0.004,
  ThumbHaloX = 1.5,
  ThumbHaloY = 2,
  ThumbHaloWidth = 7,
  ThumbHaloGrow = 4,
  ThumbHaloRadius = 3.5,
  ThumbWidth = 4,
  ThumbRadius = 2,
  ThumbMix = 0.75,
  ContextWidth = 110,
  ContextHeight = 52,
  ContextRadius = 6,
  ContextPad = 4,
  ContextStep = 24,
  ContextInset = 3,
  ContextRow = 22,
  ContextRowRadius = 5,
  ContextText = 10,
  ContextTextRoom = 16,
  ContextReach = 4,
  ContextReachHeight = 60,
  PickerWidth = 250,
  PickerHeight = 240,
  PickerMargin = 8,
  PickerPad = 12,
  PickerBox = 128,
  PickerSlider = 10,
  PickerInfo = 22,
  PickerGap = 14,
  PickerLift = -6,
  PickerSpeed = 22,
  PickerGlow = 3,
  PickerGlowRadius = 12,
  PickerRadius = 9,
  PickerBoxRadius = 4,
  PickerSegMin = 40,
  PickerSegMax = 170,
  PickerShadeMax = 150,
  PickerHandleOuter = 7.5,
  PickerHandleRing = 7,
  PickerHandleCore = 4.5,
  PickerHandleSides = 26,
  PickerKnobOuter = 7,
  PickerKnobRing = 6.5,
  PickerKnobSides = 24,
  PickerThick = 2,
  PickerThin = 1,
  PickerRingThick = 2.4,
  PickerCoreBase = 0.4,
  PickerCoreGain = 0.6,
  PickerSwatch = 22,
  PickerChipRadius = 7,
  PickerFormatGap = 28,
  PickerFormatWidth = 40,
  PickerFormatPad = 7,
  PickerFieldRadius = 5,
  PickerChevronX = 11,
  PickerChevronDrop = 1,
  PickerChevronStep = 3,
  PickerChevronThick = 1.2,
  PickerFieldGap = 8,
  PickerOpacityWidth = 42,
  PickerOpacityGap = 4,
  PickerOpacityRoom = 6,
  PickerTextPad = 8,
  PickerTextRoom = 14,
  PickerEditRoom = 16,
  PickerEdgePad = 4,
  PickerHexMax = 8,
  PickerAlphaStart = 7,
  PickerOpaque = 0.999,
  PickerPercent = 100,
  ByteScale = 255,
  IconPunch = 1.8,
  IconBucket = 8,
  IconRebuild = 0.13,
  ColorEpsilon = 0.001,
  BoxTitle = 26,
  BoxLine = 18,
  BoxMinWidth = 140,
  BoxTitlePad = 30,
  BoxTitleX = 24,
  BoxTitleRoom = 34,
  BoxStatRoom = 70,
  BoxBarWidth = 170,
  BoxTextRoom = 24,
  BoxPad = 8,
  BoxEmptyPad = 4,
  BoxRadius = 8,
  BoxDotX = 15,
  BoxDot = 2.5,
  BoxDotSides = 10,
  BoxRuleInset = 10,
  BoxRuleLift = 1,
  BoxRuleHeight = 1.5,
  BoxLineTop = 5,
  BoxStatDotX = 16,
  BoxStatDotY = 7,
  BoxStatDot = 3,
  BoxStatDotSides = 12,
  BoxPulseSpeed = 5,
  BoxLabelX = 28,
  BoxLabelRoom = 110,
  BoxValuePad = 12,
  BoxInset = 14,
  BoxBarTop = 5,
  BoxBarHeight = 6,
  BoxBarRadius = 3,
  BoxBarMin = 6,
  BoxFull = 100,
  BoxDragSpeed = 28,
  HotkeyWidth = 180,
  HotkeyRow = 20,
  HotkeyBase = 30,
  HotkeyPad = 6,
  HotkeyX = 18,
  HotkeyY = 90,
  HotkeyRadius = 8,
  HotkeySpeed = 16,
  HotkeyFadeSpeed = 14,
  HotkeyDragSpeed = 28,
  HotkeyGone = 0.02,
  HotkeyGrab = 28,
  HotkeyTitleX = 12,
  HotkeyTitleY = 9,
  HotkeyTitleRoom = 24,
  HotkeyRuleX = 10,
  HotkeyRuleY = 26,
  HotkeyRuleRoom = 20,
  HotkeyRuleHeight = 2,
  HotkeySlide = 12,
  HotkeyDot = 2.5,
  HotkeyDotX = 14,
  HotkeyDotSides = 10,
  HotkeyLabelX = 22,
  HotkeyLabelRoom = 92,
  HotkeyChipMin = 18,
  HotkeyChipPad = 12,
  HotkeyChipRight = 10,
  HotkeyChipInset = 2,
  HotkeyChipTrim = 4,
  HotkeyChipRadius = 4,
  BubbleSize = 42,
  BubbleX = 24,
  BubbleY = 24,
  BubbleSpeed = 11,
  BubbleGone = 0.02,
  BubbleDragSpeed = 28,
  BubbleSlop = 4,
  BubbleRadius = 10,
  BubbleGlowSpeed = 12,
  BubbleSettled = 0.9,
  BubbleShown = 0.06,
  BubbleShadowSteps = 3,
  BubbleShadowStep = 3,
  BubbleShadowLift = 2,
  BubbleGlowOut = 3,
  BubbleGlowRadius = 2,
  BubbleCrown = 0.5,
  BubbleCrownMix = 0.14,
  BubbleIconAt = 0.4,
  BubbleIconSpan = 0.6,
  BarsWidth = 0.62,
  BarsThick = 0.1375,
  BarsGap = 0.275,
  SpotSpeed = 16,
  SpotGoneAt = 0.02,
  SpotWidth = 470,
  SpotRow = 34,
  SpotRows = 7,
  SpotHead = 50,
  SpotPad = 8,
  SpotEmpty = 30,
  SpotTop = 0.16,
  SpotRadius = 12,
  SpotGlassX = 24,
  SpotGlassY = 21,
  SpotGlass = 6,
  SpotGlassThick = 1.5,
  SpotGlassSides = 16,
  SpotHandleX = 28,
  SpotHandleY = 25,
  SpotHandleTipX = 33,
  SpotHandleTipY = 30,
  SpotRuleX = 14,
  SpotRuleY = 46,
  SpotRuleHeight = 2,
  SpotField = 46,
  SpotText = 15,
  SpotQueryX = 44,
  SpotTextRoom = 60,
  SpotHitX = 36,
  SpotHitRoom = 50,
  SpotEmptyX = 18,
  SpotEmptyY = 62,
  SpotEmptyRoom = 36,
  SpotScrollSpeed = 16,
  SpotSlack = 2,
  SpotRowX = 8,
  SpotRowRoom = 24,
  SpotRowWide = 16,
  SpotRowLift = 1,
  SpotRowTrim = 2,
  SpotRowRadius = 8,
  SpotMark = 3,
  SpotMarkRadius = 1.5,
  SpotNameX = 18,
  SpotNameY = 6,
  SpotName = 14,
  SpotNameRoom = 150,
  SpotPathY = 19,
  SpotKindPad = 4,
  SpotBarInset = 7,
  FuzzyGap = 4,
  FuzzyHead = 1,
  Percent = 100,
  BorderAmount = 6,
  BorderStep = 1,
  BorderMin = 0,
  BorderMax = 30,
  BorderRatio = 1.6,
  FrostAmount = 3,
  FrostStep = 1,
  FrostMin = 0,
  FrostMax = 12,
  NoteQuick = 2,
  NoteBrief = 3,
  NoteLong = 4,
  TitleSize = 15,
  TextSize = 13,
  SmallSize = 12,
  TinySize = 11,
}

local Alpha = {
  Hairline = 0.10,
  CardStroke = 0.06,
  Card = 0.03,
  Text = 0.80,
  Label = 0.50,
  Dim = 0.40,
  Hover = 0.70,
  Field = 0.05,
  SwatchEdge = 0.40,
  FieldFocus = 0.45,
  FieldHover = 0.20,
  Placeholder = 0.30,
  Select = 0.45,
  Body = 0.70,
  Divider = 0.45,
  DividerPlain = 0.40,
  Menu = 0.97,
  MenuSelect = 0.06,
  MenuHover = 0.04,
  NoteShadow = 0.16,
  NoteFill = 0.97,
  NoteTrack = 0.12,
  NoteBar = 0.95,
  TipFill = 0.96,
  DialogVeil = 0.5,
  DialogShadow = 0.3,
  DialogFill = 0.99,
  DialogHalo = 0.10,
  DialogEdge = 0.22,
  DialogHover = 0.4,
  DialogFillIdle = 0.2,
  DialogFillHover = 0.32,
  DialogEdgeIdle = 0.6,
  DialogEdgeHover = 0.95,
  DropdownFill = 0.02,
  DropdownHover = 0.03,
  ArrowLift = 0.35,
  ListShadow = 0.28,
  Panel = 0.98,
  ListSearchFocus = 0.40,
  Press = 0.45,
  RowSelect = 0.05,
  RowHover = 0.16,
  Track = 0.05,
  TabFill = 0.04,
  ThumbHalo = 0.18,
  Thumb = 0.25,
  ThumbGlow = 0.45,
  ContextHover = 0.05,
  PickerShadow = 0.30,
  PickerPanel = 0.98,
  PickerShade = 0.92,
  PickerEdge = 0.25,
  PickerHandle = 0.45,
  PickerKnob = 0.30,
  PickerFormat = 0.09,
  PickerEditing = 0.10,
  PickerHover = 0.06,
  BoxFill = 0.92,
  BoxRule = 0.7,
  BoxPulse = 0.5,
  BoxPulseGain = 0.42,
  BoxIdleDot = 0.7,
  BoxLiveDot = 0.85,
  BoxBarFill = 0.95,
  HotkeyFill = 0.92,
  HotkeyRule = 0.90,
  BubbleShadow = 0.10,
  BubbleShadowFall = 0.025,
  BubbleGlow = 0.25,
  BubbleFill = 0.96,
  BubbleFillFade = 0.04,
  BubbleCrown = 0.22,
  BubbleEdge = 0.16,
  BubbleEdgeGrow = 0.14,
  BubbleEdgeHover = 0.35,
  SpotVeil = 0.4,
  SpotFill = 0.97,
  SpotRule = 0.7,
  SpotSelect = 0.1,
  SpotMark = 0.9,
  WindowShadow = { 0.10, 0.07, 0.05, 0.03, 0.015 },
}

local Pool = { Square = {}, Text = {}, Line = {}, Circle = {}, Triangle = {} }
local Cache = { Square = {}, Text = {}, Line = {}, Circle = {}, Triangle = {} }
local Used = { Square = 0, Text = 0, Line = 0, Circle = 0, Triangle = 0 }
local Made = { Square = 0, Text = 0, Line = 0, Circle = 0, Triangle = 0 }

local DrawOrder = 0
local FrameFade = 1
local RoundScale = 1
local Interact = true

local function Layer(z)
  DrawOrder = DrawOrder + 1
  return z * 10000 + DrawOrder
end

local function Take(kind)
  local Index = Used[kind] + 1
  Used[kind] = Index

  local Object, Last = Pool[kind][Index], Cache[kind][Index]

  if not Object then
    Object, Last = Drawing.new(kind), {}
    Pool[kind][Index], Cache[kind][Index] = Object, Last
  end

  if Index > Made[kind] then Made[kind] = Index end
  if not Last.Shown then Last.Shown = true; Object.Visible = true end

  return Object, Last
end

local function ResetFrame()
  Used.Square, Used.Text, Used.Line, Used.Circle, Used.Triangle = 0, 0, 0, 0, 0
  DrawOrder = 0
end

local function HideUnused()
  for Kind, List in pairs(Pool) do
    local Last = Cache[Kind]

    for Index = Used[Kind] + 1, Made[Kind] do
      if Last[Index].Shown then Last[Index].Shown = false; List[Index].Visible = false end
    end

    if Used[Kind] > Made[Kind] then Made[Kind] = Used[Kind] end
  end
end

local function DrawRect(x, y, w, h, color, z, corner, transparency)
  if w <= 0 or h <= 0 then DrawOrder = DrawOrder + 1 return end

  local Object, Last = Take("Square")
  local Depth = Layer(z)

  if Last.X ~= x or Last.Y ~= y then Last.X, Last.Y = x, y; Object.Position = Vector2.new(x, y) end
  if Last.W ~= w or Last.H ~= h then Last.W, Last.H = w, h; Object.Size = Vector2.new(w, h) end
  if Last.Color ~= color then Last.Color = color; Object.Color = color end
  if not Last.Filled then Last.Filled = true; Object.Filled = true end
  local Round = corner * RoundScale

  if Last.Corner ~= Round then Last.Corner = Round; Object.Corner = Round end
  if Last.Depth ~= Depth then Last.Depth = Depth; Object.ZIndex = Depth end
  local Shade = transparency * FrameFade

  if Last.Alpha ~= Shade then Last.Alpha = Shade; Object.Transparency = Shade end
end

local function DrawStroke(x, y, w, h, color, z, corner, transparency)
  if w <= 0 or h <= 0 then DrawOrder = DrawOrder + 1 return end

  local Object, Last = Take("Square")
  local Depth = Layer(z)

  if Last.X ~= x or Last.Y ~= y then Last.X, Last.Y = x, y; Object.Position = Vector2.new(x, y) end
  if Last.W ~= w or Last.H ~= h then Last.W, Last.H = w, h; Object.Size = Vector2.new(w, h) end
  if Last.Color ~= color then Last.Color = color; Object.Color = color end
  if Last.Filled ~= false then Last.Filled = false; Object.Filled = false end
  local Round = corner * RoundScale

  if Last.Corner ~= Round then Last.Corner = Round; Object.Corner = Round end
  if Last.Depth ~= Depth then Last.Depth = Depth; Object.ZIndex = Depth end
  local Shade = transparency * FrameFade

  if Last.Alpha ~= Shade then Last.Alpha = Shade; Object.Transparency = Shade end
end

local function DrawLine(x1, y1, x2, y2, color, z, thickness, transparency)
  local Object, Last = Take("Line")
  local Depth = Layer(z)

  if Last.X1 ~= x1 or Last.Y1 ~= y1 then Last.X1, Last.Y1 = x1, y1; Object.From = Vector2.new(x1, y1) end
  if Last.X2 ~= x2 or Last.Y2 ~= y2 then Last.X2, Last.Y2 = x2, y2; Object.To = Vector2.new(x2, y2) end
  if Last.Color ~= color then Last.Color = color; Object.Color = color end
  if Last.Thickness ~= thickness then Last.Thickness = thickness; Object.Thickness = thickness end
  if Last.Depth ~= Depth then Last.Depth = Depth; Object.ZIndex = Depth end

  local Shade = transparency * FrameFade

  if Last.Alpha ~= Shade then Last.Alpha = Shade; Object.Transparency = Shade end
end

local function DrawTri(ax, ay, bx, by, cx, cy, color, z, transparency)
  local Object, Last = Take("Triangle")
  local Depth = Layer(z)

  if Last.AX ~= ax or Last.AY ~= ay then Last.AX, Last.AY = ax, ay; Object.PointA = Vector2.new(ax, ay) end
  if Last.BX ~= bx or Last.BY ~= by then Last.BX, Last.BY = bx, by; Object.PointB = Vector2.new(bx, by) end
  if Last.CX ~= cx or Last.CY ~= cy then Last.CX, Last.CY = cx, cy; Object.PointC = Vector2.new(cx, cy) end
  if Last.Color ~= color then Last.Color = color; Object.Color = color end
  if not Last.Filled then Last.Filled = true; Object.Filled = true end
  if Last.Thickness ~= 1 then Last.Thickness = 1; Object.Thickness = 1 end
  if Last.Depth ~= Depth then Last.Depth = Depth; Object.ZIndex = Depth end

  local Shade = transparency * FrameFade

  if Last.Alpha ~= Shade then Last.Alpha = Shade; Object.Transparency = Shade end
end

local function DrawBar(x1, y1, x2, y2, thickness, color, z, transparency)
  local Dx, Dy = x2 - x1, y2 - y1
  local Length = math.sqrt(Dx * Dx + Dy * Dy)

  if Length < 0.001 then return end

  local Px, Py = -Dy / Length * thickness / 2, Dx / Length * thickness / 2

  DrawTri(x1 + Px, y1 + Py, x1 - Px, y1 - Py, x2 - Px, y2 - Py, color, z, transparency)
  DrawTri(x1 + Px, y1 + Py, x2 - Px, y2 - Py, x2 + Px, y2 + Py, color, z, transparency)
end

local function DrawCircle(x, y, radius, color, z, filled, thickness, sides, transparency)
  local Object, Last = Take("Circle")
  local Depth = Layer(z)

  if Last.X ~= x or Last.Y ~= y then Last.X, Last.Y = x, y; Object.Position = Vector2.new(x, y) end
  if Last.Radius ~= radius then Last.Radius = radius; Object.Radius = radius end
  if Last.Color ~= color then Last.Color = color; Object.Color = color end
  if Last.Filled ~= filled then Last.Filled = filled; Object.Filled = filled end
  if Last.Thickness ~= thickness then Last.Thickness = thickness; Object.Thickness = thickness end
  if Last.Sides ~= sides then Last.Sides = sides; Object.NumSides = sides end
  if Last.Depth ~= Depth then Last.Depth = Depth; Object.ZIndex = Depth end

  local Shade = transparency * FrameFade

  if Last.Alpha ~= Shade then Last.Alpha = Shade; Object.Transparency = Shade end
end

local function TextWidth(text, size, font)
  return #text * size * FontWidth[font]
end

local function TrimText(text, room, size, font)
  local Fit = math.floor(room / (size * FontWidth[font]))

  if #text <= Fit then return text end
  if Fit <= 2 then return "" end

  return string.sub(text, 1, Fit - 2) .. ".."
end

local function TextTop(y, height, size)
  return math.floor(y + (height - size) / 2 + 0.5)
end

local function PutText(text, x, y, color, size, font, z, centered, transparency)
  local Object, Last = Take("Text")
  local Depth = Layer(z + 10)

  if Last.Text ~= text then Last.Text = text; Object.Text = text end
  if Last.Color ~= color then Last.Color = color; Object.Color = color end
  if Last.Font ~= font then Last.Font = font; Object.Font = font end
  if Last.Size ~= size then Last.Size = size; Object.Size = size end
  if Last.Outline ~= false then Last.Outline = false; Object.Outline = false end
  if Last.Center ~= centered then Last.Center = centered; Object.Center = centered end
  if Last.X ~= x or Last.Y ~= y then Last.X, Last.Y = x, y; Object.Position = Vector2.new(x, y) end
  if Last.Depth ~= Depth then Last.Depth = Depth; Object.ZIndex = Depth end

  local Shade = transparency * FrameFade

  if Last.Alpha ~= Shade then Last.Alpha = Shade; Object.Transparency = Shade end
end

local function DrawText(text, x, y, color, size, font, z, transparency, room)
  if room then text = TrimText(text, room, size, font) end
  if text == "" then DrawOrder = DrawOrder + 1 return end

  PutText(text, x, y, color, size, font, z, false, transparency)
end

local function DrawTextMid(text, cx, y, color, size, font, z, transparency)
  if text == "" then DrawOrder = DrawOrder + 1 return end

  PutText(text, cx, y, color, size, font, z, true, transparency)
end

local function DrawTextCenter(text, cx, y, color, size, font, z, transparency, room)
  if room then text = TrimText(text, room, size, font) end
  if text == "" then DrawOrder = DrawOrder + 1 return end

  PutText(text, cx - TextWidth(text, size, font) / 2, y, color, size, font, z, false, transparency)
end

local IconMasks = {}
local IconAlias = {
  ["home"] = "house",
  ["settings"] = "gear",
  ["cog"] = "gear",
  ["user"] = "person",
  ["users"] = "two-people",
  ["people"] = "two-people",
  ["sliders"] = "three-sliders-horizontal",
  ["shield"] = "shield-check",
  ["zap"] = "lightning-bolt",
  ["lightning"] = "lightning-bolt",
  ["box"] = "gift-box",
  ["globe"] = "globe-simplified",
  ["world"] = "globe-simplified",
  ["layers"] = "two-stacked-squares",
  ["gauge"] = "speedometer",
  ["speed"] = "speedometer",
  ["map"] = "location-pin-map",
  ["fire"] = "flame",
  ["lock"] = "lock-closed",
  ["notification"] = "bell",
  ["gamepad"] = "controller",
  ["search"] = "magnifying-glass",
  ["target"] = "crosshairs",
  ["crosshair"] = "crosshairs",
  ["swords"] = "sword",
  ["edit"] = "pencil",
  ["trash"] = "trash-can",
  ["delete"] = "trash-can",
  ["book"] = "book-closed",
  ["menu"] = "three-bars-horizontal",
  ["cart"] = "shopping-cart",
  ["mail"] = "envelope",
  ["email"] = "envelope",
  ["mic"] = "microphone",
  ["volume"] = "speaker",
  ["sound"] = "speaker",
  ["close"] = "x",
  ["info"] = "circle-i",
  ["question"] = "circle-question",
  ["warning"] = "triangle-exclamation",
  ["alert"] = "triangle-exclamation",
  ["time"] = "clock",
  ["camera"] = "photo-camera",
  ["hash"] = "hashtag",
  ["monitor"] = "code",
  ["plus"] = "plus-small",
  ["minus"] = "minus-small",
  ["play"] = "play-small",
  ["pause"] = "pause-small",
  ["stop"] = "stop-small",
}
local IconImages = { Grey = {} }
local IconKey = 0
local IconShown = setmetatable({}, { __mode = "k" })
local IconTint

local IconBytes

do
  local function Xor(first, second)
    local Result, Bit = 0, 1

    for _ = 1, 32 do
      local Left, Right = first % 2, second % 2

      if Left ~= Right then Result = Result + Bit end

      first, second, Bit = (first - Left) / 2, (second - Right) / 2, Bit * 2
    end

    return Result
  end

  local CrcTable = {}

  for Value = 0, 255 do
    local Code = Value

    for _ = 1, 8 do
      local Low = Code % 2

      Code = (Code - Low) / 2
      if Low == 1 then Code = Xor(3988292384, Code) end
    end

    CrcTable[Value] = Code
  end

  local function Crc32(text)
    local Code = 4294967295

    for Index = 1, #text do
      local Low = Xor(Code, string.byte(text, Index)) % 256

      Code = Xor((Code - Code % 256) / 256, CrcTable[Low])
    end

    return Xor(Code, 4294967295)
  end

  local function Big32(value)
    return string.char(math.floor(value / 16777216) % 256, math.floor(value / 65536) % 256, math.floor(value / 256) % 256, value % 256)
  end

  local function Little16(value)
    return string.char(value % 256, math.floor(value / 256) % 256)
  end

  local function Chunk(kind, data)
    local Body = kind .. data

    return Big32(#data) .. Body .. Big32(Crc32(Body))
  end

  local function PngFromMask(mask, width, height, r, g, b)
    local Rgb = string.char(r, g, b)
    local Rows = {}
    local Index = 0

    for _ = 1, height do
      local Row = {}

      Rows[#Rows + 1] = string.char(0)

      for _ = 1, width do
        Index = Index + 1
        Row[#Row + 1] = Rgb .. string.char(string.byte(mask, Index) or 0)
      end

      Rows[#Rows + 1] = table.concat(Row)
    end

    local Raw = table.concat(Rows)
    local SumA, SumB = 1, 0

    for Index2 = 1, #Raw do
      SumA = (SumA + string.byte(Raw, Index2)) % 65521
      SumB = (SumB + SumA) % 65521
    end

    local Blocks = { string.char(120, 1) }
    local At, Left = 1, #Raw

    while At <= Left do
      local Size = math.min(Left - At + 1, 65535)
      local Final = (At + Size - 1 >= Left) and 1 or 0

      Blocks[#Blocks + 1] = string.char(Final) .. Little16(Size) .. Little16(65535 - Size) .. string.sub(Raw, At, At + Size - 1)
      At = At + Size
    end

    Blocks[#Blocks + 1] = Big32(SumB * 65536 + SumA)

    local Header = Big32(width) .. Big32(height) .. string.char(8, 6, 0, 0, 0)

    return string.char(137, 80, 78, 71, 13, 10, 26, 10) .. Chunk("IHDR", Header) .. Chunk("IDAT", table.concat(Blocks)) .. Chunk("IEND", "")
  end

  function IconBytes(name, tint)
    local Mask = IconMasks[name] or IconMasks[IconAlias[name]]
    if not Mask then return nil end

    local Store = IconImages.Grey

    if tint then
      Store = IconImages[IconKey]

      if not Store then Store = {} IconImages[IconKey] = Store end
    end

    local Ready = Store[name]
    if Ready then return Ready end

    if not Mask.Raw then Mask.Raw = base64decode(Mask.Data) end

    local Color = tint and IconTint or Theme.IconIdle
    local Red, Green, Blue = Color.R * Layout.ByteScale, Color.G * Layout.ByteScale, Color.B * Layout.ByteScale

    if tint then
      local Light = 0.3 * Red + 0.59 * Green + 0.11 * Blue

      Red = math.min(math.max(Light + (Red - Light) * Layout.IconPunch, 0), Layout.ByteScale)
      Green = math.min(math.max(Light + (Green - Light) * Layout.IconPunch, 0), Layout.ByteScale)
      Blue = math.min(math.max(Light + (Blue - Light) * Layout.IconPunch, 0), Layout.ByteScale)
    end

    local Bytes = PngFromMask(Mask.Raw, Mask.Width, Mask.Height, math.floor(Red + 0.5), math.floor(Green + 0.5), math.floor(Blue + 0.5))

    Store[name] = Bytes

    return Bytes
  end
end

local KindName = {
  Toggle = "checkbox",
  Slider = "slider",
  Range = "rangeslider",
  Dropdown = "dropdown",
  Color = "colorpicker",
  Keybind = "keybind",
  Textbox = "textbox",
  Button = "button",
  Info = "info",
  Label = "label",
  Divider = "divider",
}

local function DrawIcon(owner, key, name, x, y, size, z, transparency, tint)
  local Bytes = IconBytes(name, tint)
  if not Bytes then return end

  local Image = owner[key]

  if not Image then
    Image = Drawing.new("Image")
    owner[key] = Image
  end

  if IconShown[Image] ~= Bytes then
    IconShown[Image] = Bytes
    Image.Data = Bytes
  end

  local Shade = transparency * FrameFade

  Image.Position = Vector2.new(x, y)
  Image.Size = Vector2.new(size, size)
  Image.ZIndex = z
  Image.Transparency = Shade
  Image.Visible = Shade > 0.01
end

local EffectNames = { "Off", "Snow", "Matrix", "Rain" }

local LoadPicture, DrawPicture, HidePicture, FetchAvatar

do
  local function IsPicture(bytes)
    if type(bytes) ~= "string" or #bytes < 24 then return false end

    local First, Second = string.byte(bytes, 1, 2)

    return (First == 137 and Second == 80) or (First == 255 and Second == 216) or (First == 71 and Second == 73)
  end

  local function MakeImage(bytes)
    local Image = Drawing.new("Image")

    Image.Data = bytes
    Image.Visible = false

    return Image
  end

  local function PictureBytes(target, kind)
    local Hash = 5381

    for Index = 1, #target do Hash = (Hash * 33 + string.byte(target, Index)) % 2147483648 end

    local Cache = LibName .. "_" .. kind .. "_" .. string.format("%08x", Hash) .. ".dat"

    local Remote = string.find(target, "://", 1, true) ~= nil

    if not Remote and isfile(target) then
      local Bytes = readfile(target)

      if IsPicture(Bytes) then return Bytes end
    end

    if isfile(Cache) then
      local Bytes = readfile(Cache)

      if IsPicture(Bytes) then return Bytes end
    end

    if not Remote then return nil end

    local Bytes = httpget(target)
    if not IsPicture(Bytes) then return nil end

    writefile(Cache, Bytes)

    return Bytes
  end

  local AvatarSizes = {
    "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%d&size=150x150&format=Png&isCircular=false",
    "https://thumbnails.roproxy.com/v1/users/avatar-headshot?userIds=%d&size=150x150&format=Png&isCircular=false",
    "https://thumbnails.roblox.com/v1/users/avatar-bust?userIds=%d&size=150x150&format=Png&isCircular=false",
  }

  local function ResolveUserId()
    for _ = 1, 30 do
      local Id = LocalPlayer.UserId

      if type(Id) == "number" and Id ~= 0 then return Id end

      task.wait(0.12)
    end

    local Name = LocalPlayer.Name
    if type(Name) ~= "string" then return nil end

    local Reply = httppost("https://users.roblox.com/v1/usernames/users", '{"usernames":["' .. Name .. '"],"excludeBannedUsers":false}')

    return tonumber(string.match(Reply, '"id":%s*(%d+)'))
  end

  function FetchAvatar()
    local Id = ResolveUserId()
    if not Id then return end

    local Cache = LibName .. "_av_" .. Id .. ".dat"

    if isfile(Cache) then
      local Bytes = readfile(Cache)

      if IsPicture(Bytes) then return { Image = MakeImage(Bytes) } end
    end

    for _ = 1, 5 do
      for _, Pattern in ipairs(AvatarSizes) do
        local Url = string.match(httpget(string.format(Pattern, Id)), '"imageUrl":"([^"]+)"')

        if Url then
          local Bytes = httpget((string.gsub(Url, "\/", "/")))

          if IsPicture(Bytes) then
            writefile(Cache, Bytes)

            return { Image = MakeImage(Bytes) }
          end
        end
      end

      task.wait(0.7)
    end
  end

  function LoadPicture(source, kind)
    if source == nil or source == "" then return nil end

    local Target = tostring(source)
    local Holder = {}

    if IsPicture(Target) then
      Holder.Image = MakeImage(Target)

      return Holder
    end

    task.spawn(function()
      local Bytes = PictureBytes(Target, kind)

      if Bytes then Holder.Image = MakeImage(Bytes) end
    end)
return Holder
  end

  function DrawPicture(holder, x, y, width, height, z, transparency, corner)
    local Image = holder and holder.Image
    if not Image then return false end

    Image.Position = Vector2.new(x, y)
    Image.Size = Vector2.new(width, height)
    Image.Rounding = corner or 0
    Image.ZIndex = z
    Image.Transparency = transparency
    Image.Visible = transparency > 0.01

    return true
  end

  function HidePicture(holder)
    if holder and holder.Image then holder.Image.Visible = false end
  end
end

local Input = {
  X = 0,
  Y = 0,
  Down = false,
  RightDown = false,
  Click = false,
  Right = false,
  Up = false,
}

local BuildSettingsTab
local SettingsTab
local ApplyInputState
local ShowSpotlight
local WantTooltip
local DrawMenuBars
local BarTint = Color3.fromRGB(36, 38, 50)

local function ReadInput()
  local WasDown, WasRight = Input.Down, Input.RightDown

  Input.X, Input.Y = Mouse.X, Mouse.Y
  Input.Down = ismouse1pressed()
  Input.RightDown = ismouse2pressed()
  Input.Click = Input.Down and not WasDown
  Input.Right = Input.RightDown and not WasRight
  Input.Up = WasDown and not Input.Down
end

local function IsMouseIn(x, y, w, h)
  return Input.X >= x and Input.X <= x + w and Input.Y >= y and Input.Y <= y + h
end

local State = {
  Open = false,
  BubbleFade = 0,
  Visible = 0,
  Delta = 1 / 60,
  LastFrame = os.clock(),

  X = math.floor(Camera.ViewportSize.X / 2 - Layout.WindowSize.X / 2),
  Y = math.floor(Camera.ViewportSize.Y / 2 - Layout.WindowSize.Y / 2),
  W = Layout.WindowSize.X,
  H = Layout.WindowSize.Y,

  Title = "INSUI",
  Tabs = {},
  ActiveIndex = 1,
  ActiveSub = nil,

  Drag = nil,
  Sliding = nil,
  RailOpen = 0,
  SearchGlow = 0,
  Buttons = {},
  Rolled = false,
  Panning = nil,
  Resize = nil,
  Picker = nil,
  Capture = nil,
  Focus = nil,
  Notes = {},
  Menu = nil,
  Dropdown = nil,
  Boxes = {},
  Spotlight = { Value = "", Caret = 0, Sel = 1, Offset = 0 },
  SpotlightOpen = false,
  SpotlightEnabled = true,
  HotkeyShown = true,
  Tip = nil,
  Dialog = nil,
  ContentFade = 1,
  SeenView = nil,
  SpotJump = nil,
  IconAt = 0,
  ConfigName = "default",
  MenuKey = "P",
  Alive = true,
  Frame = 0,
  Folder = LibName .. "_configs",
  CheckboxStyle = false,
  Rainbow = false,
  RainbowSpeed = 0.3,
  Glow = 1,
  HoverEffects = true,
  RailPinned = false,
  DropdownInline = false,
  SearchStyle = "bar",
  NoAnim = false,
  NoteDuration = 5,
  FontName = nil,
  BaseAccentA = nil,
  BaseAccentB = nil,
  Shipped = nil,
  Loading = false,
  Lite = false,
  RowLines = false,
  Opacity = 0.98,
  AutoSave = false,
  GameInput = true,
  InputSent = true,
  SmartFps = false,
  LastAct = 0,
  LastX = 0,
  LastY = 0,
  TabLayout = "side",
  Effect = nil,
  EffectColor = nil,
  Subtitle = "",
  Logo = nil,
  LogoSize = 30,
  Icon = nil,
  Avatar = nil,
  Backdrop = nil,
  BackdropAlpha = 0.5,
  BackdropWide = nil,
  BackdropTall = nil,
  TextDrag = nil,
  RepeatKey = nil,
  RepeatAt = 0,
}

local Keys = {}
local KeyOrder = {}

do
  local function AddKey(name, code, char, shifted)
    Keys[name] = { Code = code, Held = false, Click = false, Char = char, Shifted = shifted }
    KeyOrder[#KeyOrder + 1] = name
  end

  AddKey("m1", 0x01)
AddKey("m2", 0x02)
AddKey("mb3", 0x04)
AddKey("mb4", 0x05)
AddKey("mb5", 0x06)
AddKey("Backspace", 0x08)
  AddKey("Tab", 0x09)
  AddKey("Enter", 0x0D)
  AddKey("Shift", 0x10)
AddKey("LeftShift", 0xA0)
AddKey("RightShift", 0xA1)
  AddKey("Ctrl", 0x11)
  AddKey("Alt", 0x12)
  AddKey("Escape", 0x1B)
  AddKey("Space", 0x20, " ", " ")
  AddKey("Left", 0x25)
  AddKey("Up", 0x26)
  AddKey("Right", 0x27)
  AddKey("Down", 0x28)
  AddKey("Home", 0x24)
  AddKey("End", 0x23)
  AddKey("Delete", 0x2E)
  AddKey("LeftCtrl", 0xA2)
  AddKey("RightCtrl", 0xA3)
  AddKey("PageUp", 0x21)
  AddKey("PageDown", 0x22)

  do
    local Shifted = { ")", "!", "@", "#", "$", "%", "^", "&", "*", "(" }

    for Index = 0, 9 do AddKey(tostring(Index), 0x30 + Index, tostring(Index), Shifted[Index + 1]) end
    for Index = 0, 25 do
      local Letter = string.char(97 + Index)
      AddKey(Letter, 0x41 + Index, Letter, string.upper(Letter))
    end
    for Index = 1, 12 do AddKey("f" .. Index, 0x6F + Index) end
  end

  AddKey("Minus", 0xBD, "-", "_")
  AddKey("Plus", 0xBB, "=", "+")
  AddKey("Comma", 0xBC, ",", "<")
  AddKey("Period", 0xBE, ".", ">")
  AddKey("Slash", 0xBF, "/", "?")
end

local function ReleaseDrags()
  State.Drag = nil
  State.Resize = nil
  State.Sliding = nil
  State.BarDrag = nil
  State.Panning = nil
  State.TextDrag = nil
  State.HotkeyDrag = nil

  if State.Picker then State.Picker.Drag, State.Picker.HexDrag = nil, nil end
  if State.Dropdown then State.Dropdown.BarDrag = nil end

  State.Spotlight.BarDrag = nil
end

local function ReadKeys()
  for Index = 1, #KeyOrder do
    local Key = Keys[KeyOrder[Index]]
    local Held = iskeypressed(Key.Code)

    Key.Click = Held and not Key.Held
    Key.Held = Held
  end
end

local function KeyRepeat(key)
  if key.Click then
    State.RepeatKey = key
    State.RepeatAt = os.clock() + Layout.RepeatDelay
    return true
  end

  if not key.Held or State.RepeatKey ~= key or os.clock() < State.RepeatAt then return false end

  State.RepeatAt = os.clock() + Layout.RepeatRate

  return true
end

local function TypedChar()
  local Shift = Keys.Shift.Held

  for Index = 1, #KeyOrder do
    local Key = Keys[KeyOrder[Index]]

    if Key.Char and KeyRepeat(Key) then return (Shift and Key.Shifted) or Key.Char end
  end

  return nil
end

local EditText

do
  local function ShiftHeld()
    return Keys.Shift.Held or Keys.LeftShift.Held or Keys.RightShift.Held
  end

  local function CtrlHeld()
    return Keys.Ctrl.Held or Keys.LeftCtrl.Held or Keys.RightCtrl.Held
  end

  function EditText(row, field, allowed)
    local Key = field or "Value"
    local Value = row[Key] or ""
    local Caret = math.min(math.max(row.Caret or #Value, 0), #Value)
    local Anchor = row.Anchor and math.min(math.max(row.Anchor, 0), #Value) or nil
    local Selected = Anchor ~= nil and Anchor ~= Caret
    local Low = Selected and math.min(Anchor, Caret) or Caret
    local High = Selected and math.max(Anchor, Caret) or Caret
    local Fire = Key == "Value" and row.Callback or nil

    local function Apply(text, caret)
      row[Key], row.Caret, row.Anchor = text, caret, nil

      if Fire then Fire(text) end
    end

    local function Cut()
      Apply(string.sub(Value, 1, Low) .. string.sub(Value, High + 1), Low)
    end

    if CtrlHeld() then
      if Keys.a.Click then row.Anchor, row.Caret = 0, #Value Keys.a.Click = false end
      if Keys.c.Click and Selected then setclipboard(string.sub(Value, Low + 1, High)) Keys.c.Click = false end
      if Keys.x.Click and Selected then setclipboard(string.sub(Value, Low + 1, High)) Cut() Keys.x.Click = false end

      return
    end

    local Step = Keys.Left.Click and -1 or Keys.Right.Click and 1 or nil
    local Jump = Keys.Home.Click and 0 or Keys.End.Click and #Value or nil

    if Step or Jump then
      local Moved = Jump

      if Step then Moved = (Selected and not ShiftHeld()) and (Step < 0 and Low or High) or math.min(math.max(Caret + Step, 0), #Value) end

      row.Anchor = ShiftHeld() and (Anchor or Caret) or nil
      row.Caret = Moved

      Keys.Left.Click, Keys.Right.Click, Keys.Home.Click, Keys.End.Click = false, false, false, false

      return
    end

    if Keys.Escape.Click or Keys.Enter.Click then
      State.Focus = nil

      if Fire then Fire(Value) end

      return
    end

    if KeyRepeat(Keys.Backspace) then
      if Selected then Cut() return end
      if Caret == 0 then return end

      Apply(string.sub(Value, 1, Caret - 1) .. string.sub(Value, Caret + 1), Caret - 1)

      return
    end

    if KeyRepeat(Keys.Delete) then
      if Selected then Cut() return end
      if Caret == #Value then return end

      Apply(string.sub(Value, 1, Caret) .. string.sub(Value, Caret + 2), Caret)

      return
    end

    local Char = TypedChar()
    if not Char then return end
    if allowed and not string.match(Char, allowed) then return end

    Apply(string.sub(Value, 1, Low) .. Char .. string.sub(Value, High + 1), Low + 1)
  end
end

local function CaptureKey(row)
  for Index = 1, #KeyOrder do
    local Name = KeyOrder[Index]
    local Key = Keys[Name]

    if Key.Click and Name ~= "Shift" and Name ~= "Ctrl" and Name ~= "Alt" then
      local Escaped = Name == "Escape"

      row.Listening = false
      State.Capture = nil

      if row.Kind ~= "Keybind" then
        row.Value = Escaped and "none" or string.lower(Name)

        return
      end

      if Escaped then return end

      row.Value = string.lower(Name)

      row.Callback(row.Value)

      return
    end
  end
end

local function Approach(current, target, speed)
  if State.NoAnim or State.Lite then return target end

  return current + (target - current) * (1 - math.exp(-speed * State.Delta))
end

local function CopyList(source)
  local Copy = {}

  for Index = 1, #source do Copy[Index] = source[Index] end

  return Copy
end

local function SnapValue(value, row)
  local Snapped = math.floor(value / row.Step + 0.5) * row.Step

  return math.min(math.max(Snapped, row.Min), row.Max)
end

local function Settle(current, target, speed, epsilon)
  local Value = Approach(current, target, speed)

  if math.abs(Value - target) < epsilon then return target end

  return Value
end

local function GradientRect(x, y, width, height, first, second, z, transparency)
  if width <= 0 then return end

  local Steps = State.Lite and 6 or Layout.GradientSteps
  local Prev = math.floor(x + 0.5)

  for Index = 1, Steps do
    local Next = math.floor(x + width * Index / Steps + 0.5)
    local Slice = math.max(1, Next - Prev)
    local Tint = Blend(first, second, (Index - 0.5) / Steps)

    DrawRect(Prev, y, Slice, height, Tint, z, 0, transparency)

    Prev = Next
  end
end

local function FadeLine(x, y, width, color, z, transparency, reverse)
  if width <= 6 or transparency <= 0.003 then return end

  local Steps = State.Lite and 8 or math.min(26, math.max(10, math.floor(width / 6)))
  local Prev = math.floor(x + 0.5)

  for Index = 1, Steps do
    local Next = math.floor(x + width * Index / Steps + 0.5)
    local Slice = Next - Prev
    local Along = (Index - 0.5) / Steps

    if not reverse then Along = 1 - Along end
    if Slice >= 1 then DrawRect(Prev, y, Slice, 1, color, z, 0, transparency * Along * Along) end

    Prev = Next
  end
end

local function ActiveView()
  local Tab = State.Tabs[State.ActiveIndex]
  if not Tab then return nil end
  if #Tab.Subs == 0 then return Tab end
  if State.ActiveSub and State.ActiveSub.Parent == Tab then return State.ActiveSub end

  return Tab.Subs[1]
end

local function TopHeight()
  return State.TabLayout == "top" and Layout.TitleHeight or Layout.TopbarHeight
end

local function TitleMid()
  return State.Y + TopHeight() / 2
end

local function RailWidth()
  if State.TabLayout == "top" then return 0 end

  local Wide = math.max(Layout.RailWide, math.floor(State.W * Layout.RailShare))
  local Shown = Layout.RailNarrow + (Wide - Layout.RailNarrow) * State.RailOpen
  local Target = (State.Lite or State.RailPinned or IsMouseIn(State.X, State.Y, Shown, State.H)) and 1 or 0

  State.RailOpen = Approach(State.RailOpen, Target, 10)
  if math.abs(State.RailOpen - Target) < 0.003 then State.RailOpen = Target end

  return Layout.RailNarrow + (Wide - Layout.RailNarrow) * State.RailOpen
end

local function ClampWindow()
  local View = Camera.ViewportSize

  State.X = math.min(math.max(State.X, 0), math.max(0, View.X - math.min(80, State.W)))
  State.Y = math.min(math.max(State.Y, 0), math.max(0, View.Y - math.min(40, State.H)))
end

local ApplyDrag, GrabWindow, DrawFrame, ControlButton, DrawSearchBar, DrawBrand, DrawUserCard, DrawGem, DrawTopStrip

do
  function ApplyDrag()
    local Drag = State.Drag

    if Input.Down and Drag then Drag.WantX, Drag.WantY = Input.X - Drag.GrabX, Input.Y - Drag.GrabY end
    if not Drag or not Drag.WantX then return end

    local FromX, FromY = State.X, State.Y

    State.X = Approach(FromX, Drag.WantX, Layout.DragSpeed)
    State.Y = Approach(FromY, Drag.WantY, Layout.DragSpeed)

    ClampWindow()

    local MovedX, MovedY = State.X - FromX, State.Y - FromY
    if MovedX == 0 and MovedY == 0 then return end

    for _, Popup in ipairs({ State.Dropdown, State.Picker, State.Menu }) do
      Popup.X, Popup.Y = Popup.X + MovedX, Popup.Y + MovedY
    end
  end

  function GrabWindow(rail)
    if State.Drag then return end
    if not Input.Click or State.Resize or State.Dropdown or State.Picker or State.Menu or State.SpotlightOpen then return end

    local Wide = State.TabLayout == "top"
    local OnBar = Wide and IsMouseIn(State.X, State.Y, State.W, Layout.TitleHeight)
      or IsMouseIn(State.X + rail, State.Y, State.W - rail, Layout.TopbarHeight)
      or IsMouseIn(State.X, State.Y, rail, Layout.TopbarHeight)

    if not OnBar then return end

    State.Drag = { GrabX = Input.X - State.X, GrabY = Input.Y - State.Y }
    Input.Click = false
  end

  function DrawFrame(rail)
    local Shadow = Alpha.WindowShadow

    if not State.Lite then
      for Index = 1, #Shadow do
        local Spread = Index * 4

        DrawRect(State.X - Spread, State.Y - Spread + 6, State.W + Spread * 2, State.H + Spread * 2, Black, 9, 16, Shadow[Index])
      end
    end

    DrawRect(State.X, State.Y, State.W, State.H, Theme.Background, 10, Layout.Corner, State.Opacity)

    local Backdrop = State.Backdrop

    if Backdrop then
      local PaneHeight = State.H - Layout.TopbarHeight
      local Wide = State.BackdropWide and State.BackdropWide * State.W or PaneHeight * 0.6
      local Tall = State.BackdropWide and (State.BackdropTall or 1) * PaneHeight or PaneHeight

      DrawPicture(Backdrop, State.X + (State.W - Wide) / 2, State.Y + Layout.TopbarHeight + (PaneHeight - Tall) / 2, Wide, Tall, 119999, State.BackdropAlpha * State.Visible)
    end

    DrawStroke(State.X, State.Y, State.W, State.H, Theme.Text, 12, Layout.Corner, Alpha.Hairline)

    if State.TabLayout == "top" then
      DrawRect(State.X + 1, State.Y + Layout.TitleHeight, State.W - 2, 4, Theme.Accent, 11, 0, 0.035)
      GradientRect(State.X + 1, State.Y + Layout.TitleHeight - 1.4, State.W - 2, 1.4, Theme.AccentA, Theme.AccentB, 12, 0.55)
    else
      local Tab = ActiveView()

      DrawRect(State.X + rail, State.Y + Layout.TopbarHeight, State.W - rail, State.H - Layout.TopbarHeight, Theme.Text, 11, 7, 0.045)

      if Tab then DrawText(Tab.Name, State.X + rail + 16, TextTop(State.Y, Layout.TopbarHeight, Layout.TitleSize), Theme.Text, Layout.TitleSize, BoldFont, 13, Alpha.Text, State.W - rail - 272) end
    end

    local Sweep = State.X - 46 + (State.W + 92) * State.Visible
    local Shade = 4 * State.Visible * (1 - State.Visible)
    local GlowLeft = math.max(State.X + 2, Sweep)
    local GlowRight = math.min(State.X + State.W - 2, Sweep + 30)
    local TrailLeft = math.max(State.X + 2, Sweep - 18)
    local TrailRight = math.min(State.X + State.W - 2, Sweep)

    DrawRect(GlowLeft, State.Y + 2, GlowRight - GlowLeft, Layout.TopbarHeight - 3, Theme.Text, 12, 6, 0.09 * Shade)
    DrawRect(TrailLeft, State.Y + 2, TrailRight - TrailLeft, Layout.TopbarHeight - 3, Theme.Accent, 12, 6, 0.06 * Shade)
  end

  function ControlButton(cx, kind)
    local Gx, Gy = math.floor(cx + 0.5), math.floor(TitleMid() + 0.5)
    local Size = Layout.ButtonBox
    local Bx, By = Gx - Size / 2, Gy - Size / 2
    local Hovered = IsMouseIn(Bx, By, Size, Size)
    local Glow = State.Buttons[kind] or 0

    Glow = Approach(Glow, Hovered and 1 or 0, 14)
    State.Buttons[kind] = Glow

    local Tint = Blend(Theme.Text, Theme.Accent, Glow)
    local Shade = 0.5 + 0.45 * Glow

    DrawRect(Bx, By, Size, Size, Theme.Accent, 13, 6, 0.14 * Glow)
    DrawStroke(Bx, By, Size, Size, Theme.Accent, 14, 6, 0.55 * Glow)

    if kind == "Close" then
      DrawBar(Gx - 4, Gy - 4, Gx + 4, Gy + 4, 1.8, Tint, 16, Shade)
      DrawBar(Gx + 4, Gy - 4, Gx - 4, Gy + 4, 1.8, Tint, 16, Shade)
    elseif kind == "Search" then
      DrawCircle(Gx - 1, Gy - 1, 3.2, Tint, 16, false, 1.5, 18, Shade)
      DrawBar(Gx + 1.3, Gy + 1.3, Gx + 4.2, Gy + 4.2, 1.7, Tint, 16, Shade)
    else
      DrawBar(Gx - 4, Gy, Gx + 4, Gy, 1.8, Tint, 15, Shade)
    end

    return Hovered
  end

  function DrawSearchBar(rail)
    local Style = State.SearchStyle

    if Style == "off" then return end

    if Style == "icon" then
      if not ControlButton(State.X + State.W - 71, "Search") then return end

      WantTooltip(SearchHint, Input.X, Input.Y)

      if Input.Click then ShowSpotlight(true) Input.Click = false end

      return
    end

    local Width = math.floor(math.min(Layout.SearchWidth, math.max(Layout.SearchMin, (State.TabLayout == "top" and State.W or (State.W - rail)) * Layout.SearchShare)))
    local Bx = State.X + State.W - 66 - Width
    local By = TitleMid() - 9
    local Hovered = IsMouseIn(Bx, By, Width, Layout.SearchHeight)
    local Glow = Settle(State.SearchGlow, Hovered and 1 or 0, 12, Layout.NavRest)
    local Bright = (0.7 + 0.3 * Glow)

    State.SearchGlow = Glow

    DrawRect(Bx, By, Width, Layout.SearchHeight, Theme.Text, 13, 9, Alpha.Field + 0.04 * Glow)
    DrawStroke(Bx, By, Width, Layout.SearchHeight, Theme.Accent, 14, 9, 0.12 + 0.4 * Glow)
    DrawCircle(Bx + 10, By + 8, 3, Theme.Accent, 15, false, 1.3, 18, Bright)
    DrawBar(Bx + 11.8, By + 10.2, Bx + 14.4, By + 12.8, 1.4, Theme.Accent, 15, Bright)
    DrawText("Search", Bx + 20, TextTop(By, Layout.SearchHeight, Layout.SmallSize), Theme.Text, Layout.SmallSize, SystemFont, 15, Alpha.Dim + 0.12 * Glow, Width - 26)

    if not Hovered then return end

    WantTooltip(SpotHint, Input.X, Input.Y)

    if Input.Click then ShowSpotlight(true) Input.Click = false end
  end

  function DrawBrand(rail)
    local Edge = State.X + rail - 14
    local HeadX = State.X + 16
    local Logo = State.Logo
    local Size = Layout.MonoSize
    local Middle = State.Y + 22 + ((State.Subtitle ~= "" and 30 or 18) - 22) * State.RailOpen

    if Logo and DrawPicture(Logo, HeadX - 4 * (1 - State.RailOpen), Middle - State.LogoSize / 2, State.LogoSize, State.LogoSize, 629999, 1, State.LogoSize * 0.22) then
      HidePicture(State.Icon)

      HeadX = HeadX + State.LogoSize + 9
    elseif State.Icon then
      HeadX = State.X + 44
    else
      local Letter = string.upper(string.sub(State.Title, 1, 1))
      local Cx = State.X + 16 + Size / 2 - 4 * (1 - State.RailOpen)

      DrawRect(Cx - Size / 2, Middle - Size / 2, Size, Size, Theme.Accent, 61, Layout.MonoRadius, 0.16)
      DrawStroke(Cx - Size / 2, Middle - Size / 2, Size, Size, Theme.Text, 61, Layout.MonoRadius, Alpha.CardStroke)
      DrawTextMid(Letter, Cx, Middle, Theme.Accent, Layout.TitleSize, BoldFont, 62, Alpha.Text)

      HeadX = State.X + 16 + Size + 9
    end

    local Room = math.max(2, Edge - HeadX)
    local TitleSize = Layout.HeaderTitle
    local Full = TextWidth(State.Title, TitleSize, BoldFont)

    if Full > Room then TitleSize = math.max(11, math.floor(TitleSize * Room / Full)) end

    local Top = State.Y + 20 - math.floor(TitleSize / 2)
    local Shade = Alpha.Text * State.RailOpen
    local InfoBottom = State.Y + 34

    DrawText(State.Title, HeadX, Top + 1, Black, TitleSize, BoldFont, 60, 0.28 * Shade, Room)
    DrawText(State.Title, HeadX, Top, Theme.Accent, TitleSize, BoldFont, 61, Shade, Room)

    if State.Subtitle ~= "" then
      DrawText(State.Subtitle, HeadX, State.Y + 34, Theme.Text, Layout.TinySize, SystemFont, 61, Alpha.Dim * State.RailOpen, Room)

      InfoBottom = State.Y + 50
    end

    GradientRect(State.X + 12, InfoBottom, rail - 24, 1, Theme.AccentA, Theme.AccentB, 61, 0.3 * State.RailOpen)

    return InfoBottom
  end

  local function DrawGear(cx, cy, box, icon, zFill, zImage, scale, stroke)
    local Active = State.Tabs[State.ActiveIndex] == SettingsTab
    local Hovered = scale > 0.5 and IsMouseIn(cx - box / 2, cy - box / 2, box, box)
    local Shade = (Active and Alpha.Hover or (Hovered and Alpha.Label or Alpha.Dim)) * scale

    State.GearGlow = Approach(State.GearGlow or 0, (Active or Hovered) and 1 or 0, 13)

    local Glow = State.GearGlow * scale

    DrawRect(cx - box / 2, cy - box / 2, box, box, Theme.Text, zFill, 8, Alpha.TabFill * (Active and 1 or 0.6) * Glow)

    if stroke then DrawStroke(cx - box / 2, cy - box / 2, box, box, Theme.Text, zFill, 8, Alpha.CardStroke * Glow) end

    DrawIcon(State, "GearImage", State.SettingsIcon, cx - icon / 2, cy - icon / 2, icon, zImage, Shade)

    if not (Hovered and Input.Click) then return end

    State.ActiveIndex = Active and (State.LastIndex or 1) or State.SettingsIndex
    State.LastIndex = Active and State.LastIndex or State.ActiveIndex
    State.ActiveSub = nil
    State.ContentFade = 0
    Input.Click = false
  end

  local function ReadPlayer()
    if State.PlayerInitial then return end

    local Name = LocalPlayer.Name
    local Display = LocalPlayer.DisplayName

    Name = (type(Name) == "string" and Name ~= "") and Name or "player"
    Display = (type(Display) == "string" and Display ~= "") and Display or Name

    State.PlayerName = Display
    State.PlayerHandle = "@" .. Name
    State.PlayerInitial = string.upper(string.sub(Display, 1, 1))
  end

  function DrawUserCard(rail)
    ReadPlayer()

    local CardY = State.Y + State.H - Layout.UserCard
    local Half = (rail - 28) / 2
    local Rule = Alpha.Hairline * 1.8 * State.RailOpen
    local Cx, Cy = State.X + 29, CardY + 16
    local Room = math.max(2, rail - 100)

    FadeLine(State.X + 14, CardY - 10, Half, Theme.Text, 61, Rule, true)
    FadeLine(State.X + 14 + Half, CardY - 10, Half, Theme.Text, 61, Rule)
    if DrawPicture(State.Avatar, Cx - Layout.AvatarRadius, Cy - Layout.AvatarRadius, Layout.AvatarRadius * 2, Layout.AvatarRadius * 2, 629999, 1, Layout.AvatarRadius) then
      DrawCircle(Cx, Cy, Layout.AvatarRadius, Theme.Text, 63, false, 1, 28, Alpha.Hairline)
    else
      DrawCircle(Cx, Cy, Layout.AvatarRadius, Theme.Accent, 61, true, 1, 28, 0.18)
      DrawCircle(Cx, Cy, Layout.AvatarRadius, Theme.Text, 62, false, 1, 28, Alpha.Hairline)
      DrawTextCenter(State.PlayerInitial, Cx, Cy - 7, Theme.Text, Layout.TextSize, BoldFont, 62, Alpha.Text)
    end
    DrawText(State.PlayerName, State.X + 50, CardY + 6, Theme.Text, Layout.SmallSize, BoldFont, 62, Alpha.Text * State.RailOpen, Room)
    DrawText(State.PlayerHandle, State.X + 50, CardY + 22, Theme.Text, Layout.TinySize, SystemFont, 62, Alpha.Dim * State.RailOpen, Room)

    if SettingsTab then DrawGear(State.X + rail - 26, Cy, 30, 20, 61, 629999, State.RailOpen, true) end
  end

  function DrawGem()
    local Size = Layout.GemSize
    local Cx, Cy = State.X + 20, TitleMid()
    local Wide = Size + 6

    if DrawPicture(State.Icon, Cx - Wide / 2, Cy - Wide / 2, Wide, Wide, 169999, 1, 5) then return end
    if DrawPicture(State.Logo, Cx - Wide / 2, Cy - Wide / 2, Wide, Wide, 169999, 1, 5) then return end

    DrawRect(Cx - Size / 2, Cy - Size / 2, Size, Size, Theme.Accent, 14, 2.5, 0.95)
    DrawMenuBars(Cx, Cy, Size, BarTint, 15, 1)
  end

  function DrawTopStrip()
    local StripY = State.Y + Layout.TitleHeight
    local Middle = StripY + Layout.TopbarHeight / 2
    local RightEdge = State.X + State.W - 14

    if SettingsTab then
      local GearX = State.X + State.W - 26

      DrawGear(GearX, Middle, 28, 18, 13, 169999, 1, false)

      RightEdge = GearX - 22
    end

    local Cx = RightEdge - 13

    ReadPlayer()

    if DrawPicture(State.Avatar, Cx - 11, Middle - 11, 22, 22, 169999, 1, 11) then
      DrawCircle(Cx, Middle, 11, Theme.Text, 17, false, 1, 24, Alpha.Hairline)
    else
      DrawCircle(Cx, Middle, 11, Theme.Accent, 13, true, 1, 24, 0.18)
      DrawCircle(Cx, Middle, 11, Theme.Text, 14, false, 1, 24, Alpha.Hairline)
      DrawTextCenter(State.PlayerInitial, Cx, Middle - 6, Theme.Text, Layout.SmallSize, BoldFont, 15, Alpha.Text)
    end

    local PillX = State.X + 14

    for Index, Tab in ipairs(State.Tabs) do
      if not Tab.Hidden then
        local Active = State.ActiveIndex == Index
        local PillWidth = (Tab.Icon and 22 or 0) + TextWidth(Tab.Name, 14, BoldFont) + 24
        local PillY = Middle - Layout.TopPill / 2
        local Hovered = IsMouseIn(PillX, PillY, PillWidth, Layout.TopPill)
        local Lit = Hovered and State.HoverEffects ~= false
        local LabelX = PillX + 12

        Tab.Glow = Approach(Tab.Glow or 0, Active and 1 or 0, 13)

        local Glow = Tab.Glow
        local Shade = Active and Alpha.Hover or (Lit and Alpha.Label or Alpha.Dim)

        DrawRect(PillX, PillY, PillWidth, Layout.TopPill, Theme.Text, 13, 7, Alpha.TabFill * Glow)
        DrawStroke(PillX, PillY, PillWidth, Layout.TopPill, Theme.Text, 14, 7, Alpha.CardStroke * Glow)
        DrawRect(PillX + PillWidth / 2 - 8 * Glow, StripY + Layout.TopbarHeight - 3, math.max(1, 16 * Glow), 2, Theme.Accent, 15, 1, 0.95 * Glow)
        DrawRect(PillX, PillY, PillWidth, Layout.TopPill, Theme.Text, 13, 7, (Lit and not Active) and 0.07 or 0)

        if Tab.Icon then
          LabelX = PillX + 30

          DrawIcon(Tab, "Image", Tab.Icon, PillX + 10, Middle - 8, Layout.IconSize, 169998, Shade)
          DrawIcon(Tab, "ImageOn", Tab.Icon, PillX + 10, Middle - 8, Layout.IconSize, 169999, Shade * Glow, Theme.Accent)
        end

        DrawText(Tab.Name, LabelX, TextTop(PillY, Layout.TopPill, 14), Active and Theme.Accent or Theme.Text, 14, BoldFont, 15, Shade, PillWidth)

        if Hovered and Input.Click and State.ActiveIndex ~= Index then
          State.ActiveIndex = Index
          State.ActiveSub = nil
          State.ContentFade = 0
          Input.Click = false
        end

        PillX = PillX + PillWidth + 6
      end
    end

    DrawLine(State.X, StripY + Layout.TopbarHeight, State.X + State.W, StripY + Layout.TopbarHeight, Theme.Text, 12, 1, Alpha.Hairline)
  end
end

local function Minimize()
  State.Rolled = not State.Rolled

  if not State.Rolled then return end

  State.BubblePos = { X = State.X + 6, Y = State.Y + 4 }
  State.Dropdown = nil
  State.Picker = nil
  State.Menu = nil
  State.Focus = nil
end

local function DrawHeader(rail)
  DrawSearchBar(rail)

  if ControlButton(State.X + State.W - 21, "Close") and Input.Click then State.Open = false Input.Click = false end
  if ControlButton(State.X + State.W - 46, "Min") and Input.Click then Minimize() Input.Click = false end
end

local function DrawSubs(tab, top, pillX, pillWidth, reveal)
  local Count = #tab.Subs
  local Stagger = math.min(Layout.SubStagger, Layout.SubSpan / math.max(1, Count - 1))
  local Denominator = math.max(0.001, 1 - (Count - 1) * Stagger)
  local SubX = pillX + Layout.SubIndent
  local SubWidth = pillWidth - Layout.SubIndent
  local Pill = Blend(Theme.Text, Theme.Accent, Layout.PillMix)

  for Index, Sub in ipairs(tab.Subs) do
    local Raw = math.min(math.max((reveal - (Index - 1) * Stagger) / Denominator, 0), 1)
    local Rise = Raw * Raw * (3 - 2 * Raw) * State.RailOpen
    local SubY = top + (Index - 1) * (Layout.SubHeight + 4) - 3 * (1 - Rise)
    local Live = Rise > 0.5 and reveal > 0.5
    local Active = State.ActiveSub == Sub
    local Hovered = Live and IsMouseIn(SubX, SubY, SubWidth, Layout.SubHeight)

    Sub.Glow = Settle(Sub.Glow or 0, Active and 1 or 0, 12, Layout.NavRest)
    Sub.Hover = Settle(Sub.Hover or 0, Hovered and 1 or 0, 18, Layout.NavRest)

    local Bright = Sub.Glow + (1 - Sub.Glow) * 0.35 * Sub.Hover
    local LabelX = SubX + 20

    DrawRect(SubX, SubY, SubWidth, Layout.SubHeight, Pill, 62, Layout.SubRadius, (0.05 * Sub.Glow + 0.04 * Sub.Hover * (1 - Sub.Glow)) * Rise)

    if Sub.Icon then
      LabelX = SubX + 28

      DrawIcon(Sub, "Image", Sub.Icon, SubX + 9, SubY + (Layout.SubHeight - Layout.SubIcon) / 2, Layout.SubIcon, 629998, Rise * (0.7 + 0.3 * Bright))
      DrawIcon(Sub, "ImageOn", Sub.Icon, SubX + 9, SubY + (Layout.SubHeight - Layout.SubIcon) / 2, Layout.SubIcon, 629999, Rise * (0.7 + 0.3 * Bright) * Bright, Theme.Accent)
    else
      DrawCircle(SubX + 11, SubY + Layout.SubHeight / 2, 2, Blend(Theme.IconIdle, Theme.Accent, Bright), 63, true, 1, 12, Rise * (0.5 + 0.5 * Sub.Glow))
    end

    DrawText(Sub.Name, LabelX, TextTop(SubY, Layout.SubHeight, Layout.SmallSize), Blend(Theme.Idle, Theme.Text, Bright), Layout.SmallSize, SystemFont, 63, (0.86 + 0.14 * Sub.Glow) * Rise * State.RailOpen, SubWidth - (LabelX - SubX) - 6)

    if Live and IsMouseIn(SubX, SubY, SubWidth, Layout.SubHeight) and Input.Click then
      State.ActiveSub = Sub
      State.ContentFade = 0
      tab.LastSub = Sub
      Input.Click = false
    end
  end
end

local function DrawRail(rail, infoBottom)
  local PillX = State.X + Layout.PillIndent
  local PillWidth = rail - Layout.PillIndent * 2
  local RowY = math.floor(State.Y + 50 + (infoBottom + 12 - (State.Y + 50)) * State.RailOpen)
  local Pill = Blend(Theme.Text, Theme.Accent, Layout.PillMix)
  local Edge = State.X + rail - 18
  local Category = nil

  for Index, Tab in ipairs(State.Tabs) do
    if not Tab.Hidden then
      if Tab.Category and Tab.Category ~= Category then
        RowY = RowY + (Category == nil and 6 or 12) * State.RailOpen

        DrawText(string.upper(Tab.Category), PillX + 2, RowY, Theme.Category, Layout.TinySize, BoldFont, 61, 0.42 * State.RailOpen, PillWidth - 4)

        RowY = RowY + 4 + 16 * State.RailOpen
        Category = Tab.Category
      end

      local Count = #Tab.Subs
      local Branch = State.ActiveIndex == Index
      local Leaf = Branch and Count == 0
      local Hovered = IsMouseIn(PillX, RowY, PillWidth, Layout.PillHeight)

      Tab.Glow = Settle(Tab.Glow or 0, Leaf and 1 or 0, 12, Layout.NavRest)
      Tab.Hover = Settle(Tab.Hover or 0, Hovered and 1 or 0, 18, Layout.NavRest)
      Tab.Open = Settle(Tab.Open or 0, Branch and 1 or 0, Branch and 14 or 17, Layout.NavRest)
      Tab.Flash = Settle(Tab.Flash or 0, 0, 5, Layout.NavRest)

      local Bright = Tab.Glow + (1 - Tab.Glow) * 0.5 * Tab.Hover
      local IconBright = Count > 0 and math.max(0.5 * Tab.Hover, Tab.Flash) or Bright
      local Slide = 1.5 * Tab.Hover * (1 - Tab.Glow)
      local Top = TextTop(RowY, Layout.PillHeight, Layout.TextSize)
      local LabelX = PillX + 13

      DrawRect(PillX, RowY, PillWidth, Layout.PillHeight, Pill, 61, Layout.PillRadius, 0.055 * Tab.Glow + 0.05 * Tab.Hover * (1 - Tab.Glow))

      if Tab.Icon then
        local IconX = PillX + 10 - 3 * (1 - State.RailOpen) + Slide
        local IconY = RowY + (Layout.PillHeight - Layout.IconSize) / 2

        LabelX = PillX + Layout.PillIcon

        DrawIcon(Tab, "Image", Tab.Icon, IconX, IconY, Layout.IconSize, 629998, 0.7 + 0.3 * IconBright)
        DrawIcon(Tab, "ImageOn", Tab.Icon, IconX, IconY, Layout.IconSize, 629999, (0.7 + 0.3 * IconBright) * IconBright, Theme.Accent)
      end

      local Room = math.max(2, Edge - LabelX)

      DrawText(Tab.Name, LabelX + 1, Top + 1, Black, Layout.TextSize, BoldFont, 62, 0.22 * Tab.Glow, Room)
      DrawText(Tab.Name, LabelX + Slide, Top, Blend(Theme.Idle, Theme.Text, Bright), Layout.TextSize, BoldFont, 63, (0.90 + 0.10 * Tab.Glow) * State.RailOpen, Room)

      if Hovered and Input.Click then
        State.ActiveIndex = Index
        State.ActiveSub = Count > 0 and (Tab.LastSub or Tab.Subs[1]) or nil
        State.ContentFade = 0
        Tab.LastSub = State.ActiveSub
        Tab.Flash = 1
        Input.Click = false
      end

      local Advance = Layout.PillHeight

      if Count > 0 then
        DrawSubs(Tab, RowY + Layout.PillHeight + 4, PillX, PillWidth, Tab.Open)

        Advance = Advance + Tab.Open * State.RailOpen * (4 + Count * (Layout.SubHeight + 4))
      end

      RowY = RowY + Advance + 2 + 4 * State.RailOpen
    end
  end
end

local KeyName = {}

do
  local MouseNames = { m1 = "MB1", m2 = "MB2", mb3 = "MB3", mb4 = "MB4", mb5 = "MB5" }

  local function Shown(name)
    return MouseNames[string.lower(name)] or string.upper(name)
  end

  function KeyName.Label(value)
    if value == nil or value == "" then return "none" end

    local Mod, Key = string.match(value, "^(%w+)%+(.+)$")

    if Mod then return Shown(Mod) .. "+" .. Shown(Key) end

    return Shown(value)
  end

  local KeyAlias = {
    mouse1 = "m1", mousebutton1 = "m1", leftclick = "m1", lmb = "m1",
    mouse2 = "m2", mousebutton2 = "m2", rightclick = "m2", rmb = "m2",
    mouse3 = "mb3", mousebutton3 = "mb3", middlemouse = "mb3", mmb = "mb3", m3 = "mb3", wheel = "mb3", scrollclick = "mb3",
    mouse4 = "mb4", mousebutton4 = "mb4", xbutton1 = "mb4", m4 = "mb4",
    mouse5 = "mb5", mousebutton5 = "mb5", xbutton2 = "mb5", m5 = "mb5",
    escape = "esc", ["return"] = "enter", control = "ctrl", pgup = "pageup", pgdn = "pagedown",
  }

  function KeyName.Plain(value)
    local Name = string.lower(tostring(value or "none"))

    return KeyAlias[Name] or Name
  end
end

local ChipWidth, DrawToggle, DrawSlider, WrapText, DrawLabel, DrawInfo, DrawDivider, DrawButtonRow, DrawKeybind, DrawRangeSlider, DrawTextbox, DrawDropdown, DrawDropdownList, DrawPicker, DrawColourRow, StartPicker

do
  local function DrawChevron(cx, cy, radius, turn, color, z, transparency)
  local Angle = turn * math.pi
  local Cos, Sin = math.cos(Angle), math.sin(Angle)
  local Rise = radius * Layout.ArrowRise

  local function Spin(ox, oy)
    return cx + ox * Cos - oy * Sin, cy + ox * Sin + oy * Cos
  end

  local LeftX, LeftY = Spin(-radius, -Rise)
  local TipX, TipY = Spin(0, Rise)
  local RightX, RightY = Spin(radius, -Rise)

  DrawBar(LeftX, LeftY, TipX, TipY, Layout.ArrowThick, color, z, transparency)
  DrawBar(TipX, TipY, RightX, RightY, Layout.ArrowThick, color, z, transparency)
end

  local function DrawSwatch(x, y, size, radius, color, alpha, hovered, fade)
    DrawRect(x, y, size, size, Theme.Swatch, 30, radius, fade)
    DrawRect(x, y, size, size, color, 31, radius, fade * (alpha or 1))
    DrawStroke(x, y, size, size, Theme.Text, 32, radius, (hovered and Alpha.SwatchEdge or Alpha.Hairline) * fade)
  end

  function ChipWidth(bind, minimum, pad)
    return math.max(minimum, TextWidth(bind.Listening and "..." or KeyName.Label(bind.Value), Layout.TextSize, MonoFont) + pad)
  end

  local function DrawChip(bind, x, y, width, radius, fade, hovered, plain)
    local Label = bind.Listening and "..." or KeyName.Label(bind.Value)
    local Mode = bind.Mode or "Hold"
    local ModeColor = (Mode == "Always" and Theme.AccentB) or (Mode == "Toggle" and Theme.AccentA) or Theme.Text
    local Shade = bind.Listening and Alpha.Text or (hovered and Alpha.Hover or Alpha.Dim)
    local EdgeColor = plain and Theme.Text or ModeColor
    local EdgeAlpha = (plain or Mode == "Hold") and Alpha.Hairline or 0.55

    if bind.Listening then
      DrawRect(x - 1, y - 1, width + 2, Layout.ChipHeight + 2, Theme.AccentB, 30, radius + 1, 0.18 * fade)
      DrawRect(x, y, width, Layout.ChipHeight, Theme.Accent, 31, radius, 0.6 * fade)
      DrawStroke(x, y, width, Layout.ChipHeight, Theme.AccentB, 32, radius, 0.85 * fade)
    else
      DrawRect(x, y, width, Layout.ChipHeight, Theme.Text, 31, radius, (Alpha.Field + 0.05 * bind.Glow) * fade)
      DrawStroke(x, y, width, Layout.ChipHeight, Theme.AccentA, 32, radius, 0.45 * bind.Glow * fade)
      DrawStroke(x, y, width, Layout.ChipHeight, EdgeColor, 32, radius, EdgeAlpha * fade)
    end

    DrawTextMid(Label, x + width / 2 + Layout.ChipNudge, y + 10, Theme.Text, Layout.TextSize, MonoFont, 33, Shade * fade)
  end

  local function OpenPicker(row)
    local Picker = { Row = row, X = Input.X + Layout.PickerOffsetX, Y = Input.Y - Layout.PickerOffsetY }

    StartPicker(Picker)
    State.Picker = Picker
    State.Dropdown = nil
    Input.Click = false
  end

  local function DrawSwitch(row, x, y, width, fade, on, onColor)
    local TrackX, TrackY = x + width - Layout.SwitchWidth, y + 3
    local Travel = Layout.SwitchWidth - Layout.SwitchKnob - 6

    row.Fill = Approach(row.Fill or on, on, 16)

    DrawRect(TrackX, TrackY, Layout.SwitchWidth, Layout.SwitchHeight, Blend(Theme.Track, onColor, row.Fill), 30, 6, fade)
    DrawRect(TrackX + 3 + Travel * row.Fill, TrackY + 3, Layout.SwitchKnob, Layout.SwitchKnob, Theme.Text, 32, 4, fade)

    return TrackX
  end

  local function DrawCheck(row, x, y, width, fade, on, onColor)
    local Size = Layout.CheckboxSize
    local BoxX, BoxY = x + width - Size, y + 4
    local MidX, MidY = BoxX + Size / 2, BoxY + Size / 2
    local Hovered = Interact and IsMouseIn(BoxX, BoxY, Size, Size)
    local WantGlow = Hovered and 1 or 0
    local WantPress = (Hovered and Input.Down) and 1 or 0

    if row.Last == nil then row.Last = row.Value end
    if row.Value ~= row.Last then row.Flash, row.Last = 1, row.Value end

    row.Fill = Settle(row.Fill or on, on, row.Value and 13 or 15, Layout.CheckSnap)
    row.Snap = Settle(row.Snap or on, on, 34, Layout.CheckSnap)
    row.Glow = Settle(row.Glow or 0, WantGlow, 12, Layout.CheckRest)
    row.Press = Settle(row.Press or 0, WantPress, 22, Layout.CheckRest)
    row.Flash = Settle(row.Flash or 0, 0, 22, Layout.CheckRest)

    local Ease, Snap, Flash = row.Fill, row.Snap, row.Flash
    local Shape = Ease * Ease * (3 - 2 * Ease) + 1.70658 * Ease * Ease * Ease * (1 - Ease) * Snap * on
    local Scale = math.min(1, Shape)
    local Over = math.min(math.max((Shape - 1) / 0.1, 0), 1)
    local Swell = 4 * Ease * (1 - Ease)
    local Stretch = 0.24 * Swell * Swell * (2 * Snap - 1)
    local Grow = (2 + 10 * Shape) * (1 - 0.06 * row.Press)
    local CoreW = math.min(Grow * (1 + Stretch), Layout.CheckMax)
    local CoreH = math.min(Grow * (1 - 0.85 * Stretch), Layout.CheckMax)
    local Radius = math.min(math.min(CoreW, CoreH) / 2, 3 + 2 * (1 - Scale))
    local Lift = math.max(Swell, Over)
    local HaloW = math.min(CoreW * (1 + 0.1 * Lift), Layout.CheckHaloMax)
    local HaloH = math.min(CoreH * (1 + 0.1 * Lift), Layout.CheckHaloMax)
    local Deep = Blend(onColor, Theme.Background, 0.5)
    local Hot = Blend(onColor, Theme.Text, 0.55)
    local Solid = math.min(1, Shape * 3)
    local FlashW, FlashH = CoreW * (0.36 + 0.6 * Flash), CoreH * (0.36 + 0.6 * Flash)
    local Span = math.max(CoreW, CoreH)
    local Ring = math.min(Layout.CheckRingMax, Span + 3.6 * (1 - Over))
    local CoreColor = Blend(Blend(Deep, onColor, math.min(1, Shape * 1.25)), Hot, math.min(1, 0.55 * Flash + 0.35 * Swell))

    DrawRect(BoxX, BoxY, Size, Size, Blend(Theme.Track, Deep, 0.55 * Scale), 30, 5, (0.5 + 0.12 * row.Glow) * fade)
    DrawRect(MidX - HaloW / 2, MidY - HaloH / 2, HaloW, HaloH, Blend(onColor, Theme.Text, 0.35), 31, math.min(math.min(HaloW, HaloH) / 2, Radius + 1.2), 0.3 * Lift * Solid * fade)
    DrawRect(MidX - CoreW / 2, MidY - CoreH / 2, CoreW, CoreH, CoreColor, 32, Radius, Solid * fade)
    DrawRect(MidX - FlashW / 2, MidY - FlashH / 2, FlashW, FlashH, Theme.Text, 33, math.min(FlashW, FlashH) / 2 * (1 - 0.45 * Flash), 0.78 * Flash * Flash * fade)
    DrawStroke(BoxX + (Size - Ring) / 2, BoxY + (Size - Ring) / 2, Ring, Ring, Hot, 34, math.min(Ring / 2, Radius + (Ring - Span) / 2), 0.5 * Over * fade)
    DrawStroke(BoxX, BoxY, Size, Size, Blend(Theme.Text, onColor, math.min(1, 0.9 * Scale + 0.35 * Flash)), 35, 5, (Alpha.Hairline + 0.5 * math.max(Scale, row.Glow)) * fade)

    return BoxX
  end

  function DrawToggle(row, x, y, width, fade)
    local On = row.Value and 1 or 0
    local OnColor = row.Risk and Theme.Risk or Theme.Accent
    local Drawer = State.CheckboxStyle and DrawCheck or DrawSwitch
    local RightX = Drawer(row, x, y, width, fade, On, OnColor) - 8
    local Swatch, Bind = row.Swatch, row.Bind
    local OnSwatch, OnChip = false, false

    if Swatch then
      RightX = RightX - Layout.RowSwatchSize
      OnSwatch = Interact and IsMouseIn(RightX, y + 6, Layout.RowSwatchSize, Layout.RowSwatchSize)

      DrawSwatch(RightX, y + 6, Layout.RowSwatchSize, Layout.RowSwatchRadius, Swatch.Value, Swatch.Alpha, OnSwatch, fade)

      RightX = RightX - 8

      if OnSwatch and Input.Click then OpenPicker(Swatch) end
    end

    if Bind then
      local ChipSize = ChipWidth(Bind, Layout.RowChipMin, Layout.RowChipPad)

      RightX = RightX - ChipSize
      OnChip = Interact and IsMouseIn(RightX, y + 3, ChipSize, Layout.ChipHeight)
      Bind.Glow = Approach(Bind.Glow or 0, (OnChip or Bind.Listening) and 1 or 0, 14)

      DrawChip(Bind, RightX, y + 3, ChipSize, Layout.RowChipRadius, fade, OnChip, false)

      RightX = RightX - 8

      if OnChip and not Bind.Listening then WantTooltip(ChipHint, Input.X, Input.Y) end

      if OnChip and Input.Right and not Bind.Listening then
        State.Menu = { Row = Bind, X = Input.X, Y = Input.Y, Anim = 0 }
        State.Dropdown = nil
        State.Picker = nil
        Input.Right = false
      end

      if OnChip and Input.Click then
        Bind.Listening = true
        State.Capture = Bind
        Input.Click = false
      end
    end

    DrawText(row.Name, x, TextTop(y, Layout.RowHeight, Layout.TextSize), Theme.Text, Layout.TextSize, SystemFont, 31, Alpha.Label * fade, RightX - x - 4)

    if not (Interact and IsMouseIn(x, y, width, Layout.RowHeight) and Input.Click) then return end
    if OnSwatch or OnChip then return end

    row.Value = not row.Value
    Input.Click = false

    row.Callback(row.Value)
  end

  function DrawSlider(row, x, y, width, fade)
    local BarY = y + Layout.RowHeight
    local Span = row.Max - row.Min
    local Fraction = (row.Value - row.Min) / Span
    local Focused = State.Focus == row
    local Typed = row.Typing or ""
    local Text = Focused and Typed or (tostring(row.Value) .. (row.Suffix ~= "" and (" " .. row.Suffix) or ""))
    local CharWidth = Layout.SmallSize * Layout.EditWidth
    local BoxWidth = math.max(40, (Focused and #Typed * CharWidth or TextWidth(Text, Layout.SmallSize, SystemFont)) + 16)
    local BoxX = x + width - BoxWidth
    local TextX = BoxX + 7
    local TextY = TextTop(y, Layout.ValueHeight, Layout.SmallSize)
    local OnBox = Interact and IsMouseIn(BoxX, y, BoxWidth, Layout.ValueHeight)

    row.Fill = Approach(row.Fill or Fraction, Fraction, 20)
    row.Knob = Approach(row.Knob or Layout.KnobRadius, ((Interact and IsMouseIn(x + width * row.Fill - 9, BarY - 5, 18, 18)) or State.Sliding == row) and Layout.KnobHover or Layout.KnobRadius, 16)

    DrawText(row.Name, x, TextTop(y, 16, Layout.TextSize), Theme.Text, Layout.TextSize, SystemFont, 31, Alpha.Label * fade, width - BoxWidth - 8)
    DrawRect(BoxX, y, BoxWidth, Layout.ValueHeight, Theme.Text, 30, 3, Alpha.Field * fade)
    DrawStroke(BoxX, y, BoxWidth, Layout.ValueHeight, Theme.Text, 31, 3, (Focused and 0.4 or Alpha.Hairline) * fade)

    if Focused then
      local Caret = math.min(math.max(row.Caret or #Typed, 0), #Typed)
      local Blink = os.clock() % 1 < Layout.CaretBlink

      row.CharWidth, row.EditX, row.Scroll = CharWidth, TextX, 0

      for Index = 1, #Typed do
        DrawText(string.sub(Typed, Index, Index), TextX + (Index - 1) * CharWidth, TextY, Theme.Text, Layout.SmallSize, UiFont, 32, Alpha.Text * fade)
      end

      if Blink then DrawRect(TextX + Caret * CharWidth, TextY, Layout.CaretWidth, Layout.SmallSize, Theme.Text, 32, 0, Alpha.Text * fade) end
    else
      DrawTextCenter(Text, BoxX + BoxWidth / 2, TextY, Theme.Text, Layout.SmallSize, SystemFont, 32, Alpha.Dim * fade, BoxWidth - 8)
    end

    DrawRect(x, BarY, width, Layout.BarHeight, Theme.SliderTrack, 30, 4, fade)

    if row.Fill > 0.001 then DrawRect(x, BarY, math.max(Layout.BarHeight, width * row.Fill), Layout.BarHeight, Blend(Theme.AccentA, Theme.AccentB, row.Fill), 31, 4, fade) end

    DrawCircle(x + width * row.Fill, BarY + 4, row.Knob, Theme.Text, 32, true, 1, 24, fade)

    if Input.Click and OnBox then
      if not Focused then row.Typing = tostring(row.Value) end

      State.Focus = row
      row.Caret = #row.Typing
      row.Anchor = row.Caret
      Input.Click = false
    end

    if Input.Click and Interact and IsMouseIn(x - 4, BarY - 8, width + 8, 16) and not OnBox then
      State.Sliding = row
      Input.Click = false
    end

    if State.Sliding ~= row then return end

    local Along = math.min(math.max((Input.X - x) / width, 0), 1)
    local Snapped = math.floor((row.Min + Span * Along) / row.Step + 0.5) * row.Step

    if Snapped == row.Value then return end

    row.Value = Snapped
    row.Callback(Snapped)
  end

  local function DrawButton(row, x, y, width, fade)
    local Hovered = Interact and IsMouseIn(x, y, width, Layout.ButtonHeight)

    row.Glow = Approach(row.Glow or 0, Hovered and 1 or 0, 16)

    DrawRect(x, y, width, Layout.ButtonHeight, Theme.Text, 30, Layout.CardRadius, (Alpha.Field + 0.06 * row.Glow) * fade)
    DrawStroke(x, y, width, Layout.ButtonHeight, Theme.Text, 31, Layout.CardRadius, (Alpha.Hairline + 0.22 * row.Glow) * fade)
    DrawTextMid(row.Name, x + width / 2, TextTop(y, Layout.ButtonHeight, Layout.TextSize), Theme.Text, Layout.TextSize, SystemFont, 32, (Alpha.Label + (Alpha.Hover - Alpha.Label) * row.Glow) * fade)

    if Hovered and Input.Click then row.Callback() end
  end

  function WrapText(text, room, size, font)
    local Fit = math.max(1, math.floor(room / (size * FontWidth[font])))
    local Lines = {}
    local Current = ""

    for Word in string.gmatch(text, "%S+") do
      local Candidate = Current == "" and Word or Current .. " " .. Word

      if #Candidate <= Fit then
        Current = Candidate
      else
        if Current ~= "" then Lines[#Lines + 1] = Current end
        while #Word > Fit do Lines[#Lines + 1] = string.sub(Word, 1, Fit); Word = string.sub(Word, Fit + 1) end
        Current = Word
      end
    end

    if Current ~= "" then Lines[#Lines + 1] = Current end
    if #Lines == 0 then Lines[1] = "" end

    return Lines
  end

  local function WrapRow(row, room, size)
    if row.WrapWidth == room and row.WrapSource == row.Name then return end

    local Lines = {}

    for Segment in (row.Name .. "\n"):gmatch("(.-)\n") do
      for _, Line in ipairs(WrapText(Segment, room, size, SystemFont)) do Lines[#Lines + 1] = Line end
    end

    row.WrapWidth, row.WrapSource, row.Lines, row.LineCount = room, row.Name, Lines, #Lines
  end

  function DrawLabel(row, x, y, width, fade)
    if row.Source then row.Name = tostring(row.Source()) end

    WrapRow(row, width, Layout.TextSize)

    local Color = row.Color or Theme.Text
    local Shade = Alpha.Body * fade
    local Lines = row.Lines

    for Index = 1, #Lines do DrawText(Lines[Index], x, y + (Index - 1) * Layout.LabelLine, Color, Layout.TextSize, SystemFont, 31, Shade) end
  end

  function DrawInfo(row, x, y, width, fade)
    WrapRow(row, width, Layout.SmallSize)

    local Color = row.Color or Theme.Text
    local Shade = Alpha.Dim * fade
    local Lines = row.Lines

    for Index = 1, #Lines do DrawText(Lines[Index], x, y + (Index - 1) * Layout.InfoLine, Color, Layout.SmallSize, SystemFont, 31, Shade) end
  end

  function DrawDivider(row, x, y, width, fade)
    local Tint = Blend(Theme.AccentA, Theme.AccentB, Layout.ShimmerMix)
    local LineY = y + Layout.DividerHeight / 2

    if not row.Name then
      local Half = width / 2
      local Plain = Alpha.DividerPlain * fade

      FadeLine(x, LineY, Half, Tint, 30, Plain, true)
      FadeLine(x + Half, LineY, Half, Tint, 30, Plain)

      return
    end

    local Center = x + width / 2
    local Half = TextWidth(row.Name, Layout.SmallSize, SystemFont) / 2 + Layout.DividerPad
    local Tail = Center + Half
    local HeadWidth = Center - Half - x
    local TailWidth = x + width - Tail
    local Shade = Alpha.Divider * fade
    local TextAlpha = Alpha.Dim * fade

    FadeLine(x, LineY, HeadWidth, Tint, 30, Shade, true)
    DrawTextMid(row.Name, Center, LineY, Theme.Text, Layout.SmallSize, SystemFont, 31, TextAlpha)
    FadeLine(Tail, LineY, TailWidth, Tint, 30, Shade)
  end

  function DrawButtonRow(row, x, y, width, fade)
    local Buttons = row.Buttons or { row }
    local Count = #Buttons
    local ButtonWidth = (width - Layout.ButtonGap * (Count - 1)) / Count
    local TextY = y + Layout.ButtonHeight / 2
    local Color = row.Color or Theme.Text
    local Clicked = Input.Click

    for Index, Button in ipairs(Buttons) do
      local ButtonX = x + (Index - 1) * (ButtonWidth + Layout.ButtonGap)
      local Hovered = Interact and IsMouseIn(ButtonX, y, ButtonWidth, Layout.ButtonHeight)

      Button.Glow = Approach(Button.Glow or 0, Hovered and 1 or 0, 16)

      local Glow = Button.Glow
      local MidX = ButtonX + ButtonWidth / 2
      local FillAlpha = (Alpha.Field + 0.06 * Glow) * fade
      local EdgeAlpha = (Alpha.Hairline + 0.22 * Glow) * fade
      local TextAlpha = (Alpha.Label + (Alpha.Hover - Alpha.Label) * Glow) * fade

      DrawRect(ButtonX, y, ButtonWidth, Layout.ButtonHeight, Theme.Text, 30, Layout.CardRadius, FillAlpha)
      DrawStroke(ButtonX, y, ButtonWidth, Layout.ButtonHeight, Theme.Text, 31, Layout.CardRadius, EdgeAlpha)
      DrawTextMid(Button.Name, MidX, TextY, Color, Layout.TextSize, SystemFont, 32, TextAlpha)

      if Clicked and Hovered then
        Clicked, Input.Click = false, false

        Button.Callback()
      end
    end
  end

  function DrawKeybind(row, x, y, width, fade)
    local ChipSize = ChipWidth(row, Layout.ChipMin, Layout.ChipPad)
    local ChipX = x + width - ChipSize
    local Hovered = Interact and IsMouseIn(ChipX, y + 3, ChipSize, Layout.ChipHeight)

    row.Glow = Approach(row.Glow or 0, (Hovered or row.Listening) and 1 or 0, 14)

    DrawText(row.Name, x, TextTop(y, Layout.RowHeight, Layout.TextSize), Theme.Text, Layout.TextSize, SystemFont, 31, Alpha.Label * fade, ChipX - x - 6)
    DrawChip(row, ChipX, y + 3, ChipSize, Layout.ChipRadius, fade, Hovered, true)

    if Hovered and Input.Right and not row.Listening then
      State.Menu = { Row = row, X = Input.X, Y = Input.Y, Anim = 0 }
      Input.Right = false
      return
    end

    if not (Hovered and Input.Click) then return end

    row.Listening = true
    State.Capture = row
    Input.Click = false
  end

  function DrawRangeSlider(row, x, y, width, fade)
    local BarY = y + Layout.RowHeight
    local Span = row.Max - row.Min
    local Text = tostring(row.Low) .. " - " .. tostring(row.High) .. (row.Suffix ~= "" and (" " .. row.Suffix) or "")
    local BoxWidth = math.max(Layout.RangeBoxWidth, TextWidth(Text, Layout.SmallSize, SystemFont) + 16)
    local BoxX = x + width - BoxWidth
    local FractionLow = math.min(math.max((row.Low - row.Min) / Span, 0), 1)
    local FractionHigh = math.min(math.max((row.High - row.Min) / Span, 0), 1)

    row.FillLow = Approach(row.FillLow or 0, FractionLow, 20)
    row.FillHigh = Approach(row.FillHigh or 1, FractionHigh, 20)

    local LowX = x + width * row.FillLow
    local HighX = x + width * row.FillHigh
    local FillWidth = HighX - LowX
    local FillColor = Blend(Theme.AccentA, Theme.AccentB, (row.FillLow + row.FillHigh) / 2)
    local Dragging = State.Sliding == row
    local ActiveLow = Interact and IsMouseIn(LowX - 9, BarY - 5, 18, 18) or (Dragging and row.Handle == "Low")
    local ActiveHigh = Interact and IsMouseIn(HighX - 9, BarY - 5, 18, 18) or (Dragging and row.Handle == "High")

    row.KnobLow = Approach(row.KnobLow or Layout.KnobRadius, ActiveLow and Layout.KnobHover or Layout.KnobRadius, 16)
    row.KnobHigh = Approach(row.KnobHigh or Layout.KnobRadius, ActiveHigh and Layout.KnobHover or Layout.KnobRadius, 16)

    DrawText(row.Name, x, TextTop(y, 16, Layout.TextSize), Theme.Text, Layout.TextSize, SystemFont, 31, Alpha.Label * fade, width - Layout.RangeLabelRoom)
    DrawRect(BoxX, y, BoxWidth, Layout.ValueHeight, Theme.Text, 30, 3, Alpha.Field * fade)
    DrawStroke(BoxX, y, BoxWidth, Layout.ValueHeight, Theme.Text, 31, 3, Alpha.Hairline * fade)
    DrawTextCenter(Text, BoxX + BoxWidth / 2, TextTop(y, Layout.ValueHeight, Layout.SmallSize), Theme.Text, Layout.SmallSize, SystemFont, 32, Alpha.Dim * fade, BoxWidth - 8)
    DrawRect(x, BarY, width, Layout.BarHeight, Theme.SliderTrack, 30, 4, fade)
    if FillWidth > Layout.RangeFillMin then DrawRect(LowX, BarY, math.max(Layout.BarHeight, FillWidth), Layout.BarHeight, FillColor, 31, 4, fade) end
    DrawCircle(LowX, BarY + 4, row.KnobLow, Theme.Text, 32, true, 1, 24, fade)
    DrawCircle(HighX, BarY + 4, row.KnobHigh, Theme.Text, 32, true, 1, 24, fade)

    if Input.Click and Interact and IsMouseIn(x - 4, BarY - 8, width + 8, 16) then
      row.Handle = Input.X < (LowX + HighX) / 2 and "Low" or "High"
      State.Sliding = row
      Input.Click = false
    end

    if State.Sliding ~= row then return end

    local Along = math.min(math.max((Input.X - x) / width, 0), 1)
    local Snapped = math.floor((row.Min + Span * Along) / row.Step + 0.5) * row.Step
    local Low = row.Handle == "Low" and math.min(Snapped, row.High) or row.Low
    local High = row.Handle == "High" and math.max(Snapped, row.Low) or row.High

    if Low == row.Low and High == row.High then return end

    row.Low, row.High = Low, High
    row.Callback(Low, High)
  end

  function DrawTextbox(row, x, y, width, fade)
    local BoxY = y + Layout.FieldGap
    local TextX = x + Layout.FieldPad
    local TextY = TextTop(BoxY, Layout.FieldHeight, Layout.TextSize)
    local Value = row.Value or ""
    local Length = #Value
    local Focused = State.Focus == row
    local Hovered = Interact and IsMouseIn(x, BoxY, width, Layout.FieldHeight)
    local Empty = Value == "" and not Focused
    local Edge = Focused and Alpha.FieldFocus or (Hovered and Alpha.FieldHover or Alpha.Hairline)
    local CharWidth = Layout.TextSize * Layout.EditWidth
    local Caret = math.min(math.max(row.Caret or Length, 0), Length)
    local Fit = math.max(1, math.floor((width - Layout.FieldInset) / CharWidth))
    local Scroll = Focused and Caret > Fit and Caret - Fit or 0
    local Shown = string.sub(Value, Scroll + 1, math.min(Length, Scroll + Fit))
    local Anchor = row.Anchor or Caret
    local Selecting = Focused and row.Anchor ~= nil and row.Anchor ~= Caret
    local Blink = os.clock() % 1 < Layout.CaretBlink
    local Low = math.min(math.max(math.min(Anchor, Caret) - Scroll, 0), #Shown)
    local High = math.min(math.max(math.max(Anchor, Caret) - Scroll, 0), #Shown)
    local CaretX = TextX + math.min(math.max(Caret - Scroll, 0), #Shown) * CharWidth
    local SelectX = TextX + Low * CharWidth
    local SelectWidth = math.max(1, (High - Low) * CharWidth)
    local SelectShade = High > Low and Alpha.Select * Alpha.Text * fade or 0

    if Focused then row.CharWidth, row.EditX, row.Scroll = CharWidth, TextX, Scroll end

    local Hit = math.min(math.max((row.Scroll or 0) + math.floor((Input.X - (row.EditX or 0)) / (row.CharWidth or CharWidth) + 0.5), 0), Length)

    DrawText(row.Name, x, TextTop(y, Layout.LabelHeight, Layout.TextSize), Theme.Text, Layout.TextSize, SystemFont, 31, Alpha.Label * fade, width)
    DrawRect(x, BoxY, width, Layout.FieldHeight, Theme.Text, 30, Layout.FieldRadius, Alpha.Field * fade)
    DrawStroke(x, BoxY, width, Layout.FieldHeight, Theme.Text, 31, Layout.FieldRadius, Edge * fade)

    if Empty then DrawText(row.Name, TextX, TextY, Theme.Text, Layout.TextSize, SystemFont, 32, Alpha.Placeholder * fade, width - Layout.PlaceholderInset) end
    if not Empty and not Focused then DrawText(Value, TextX, TextY, Theme.Text, Layout.TextSize, SystemFont, 32, Alpha.Text * fade, width - Layout.FieldInset) end

    if Focused then
      for Index = 1, #Shown do
        DrawText(string.sub(Shown, Index, Index), TextX + (Index - 1) * CharWidth, TextY, Theme.Text, Layout.TextSize, UiFont, 32, Alpha.Text * fade)
      end

      if not Selecting and Blink then DrawRect(CaretX, TextY, Layout.CaretWidth, Layout.TextSize, Theme.Text, 32, 0, Alpha.Text * fade) end
      if Selecting then DrawRect(SelectX, TextY - Layout.SelectLift, SelectWidth, Layout.TextSize + Layout.SelectGrow, Theme.Accent, 32, Layout.SelectRadius, SelectShade) end
    end

    if Input.Click and Hovered then
      State.Focus = row
      State.TextDrag = row
      row.Caret = Hit
      row.Anchor = Hit
      row.DragX = Input.X
      Input.Click = false
    end

    if State.TextDrag ~= row then return end
    if math.abs(Input.X - (row.DragX or Input.X)) <= Layout.DragSlop then return end

    row.Caret = Hit
  end

  local SelectActions = { "Select All", "Clear All" }

  local function SetDropdownValue(row, value)
    local Current = row.Value
    local Changed = #value ~= #Current

    for Index = 1, math.max(#Current, #value) do if Current[Index] ~= value[Index] then Changed = true break end end
    for Index = #Current, 1, -1 do Current[Index] = nil end
    for Index = 1, #value do Current[Index] = value[Index] end

    if not Changed then return end

    row.Callback(Current)
  end

  local function ResetDropdownScroll()
    State.Dropdown.Offset = 0
  end

  local function OpenDropdown(row, x, y, width)
    local Searchable = row.Searchable == true
    local HeaderHeight = Searchable and Layout.ListHeader or 0
    local Visible = math.min(#row.Choices, Layout.ListVisible)
    local Height = math.max(Layout.ListRow, Visible * Layout.ListRow) + Layout.ListPad + HeaderHeight
    local Viewport = Camera.ViewportSize
    local Left = math.min(math.max(x, Layout.ListMargin), math.max(Layout.ListMargin, Viewport.X - width - Layout.ListMargin))
    local Top = math.min(math.max(y, Layout.ListMargin), math.max(Layout.ListMargin, Viewport.Y - Height - Layout.ListMargin))
    local Search = { Value = "", Caret = 0, Callback = ResetDropdownScroll }

    State.Dropdown = { Row = row, Choices = CopyList(row.Choices), Value = row.Value, X = Left, Y = Top, W = width, H = Height, Multi = row.Multi, Offset = 0, Anim = 0, Searchable = Searchable, Search = Search }
    State.Picker = nil

    if not Searchable then return end

    State.Focus = Search
  end

  function DrawDropdown(row, x, y, width, fade)
    local Inline = State.DropdownInline
    local BoxWidth = Inline and math.max(Layout.InlineMin, math.floor(width * Layout.InlineShare)) or width
    local BoxX = Inline and (x + width - BoxWidth) or x
    local BoxY = Inline and y or (y + Layout.FieldGap)
    local LabelRoom = Inline and (BoxX - x - 8) or width
    local LabelY = TextTop(y, Inline and Layout.FieldHeight or Layout.LabelHeight, Layout.TextSize)
    local Hovered = Interact and IsMouseIn(BoxX, BoxY, BoxWidth, Layout.FieldHeight)
    local Display = row.Multi and (#row.Value > 0 and table.concat(row.Value, ", ") or "none") or (row.Value[1] or "none")
    local BoxAlpha = Alpha.Field + Alpha.DropdownFill + (Hovered and Alpha.DropdownHover or 0)
    local Open = State.Dropdown and State.Dropdown.Row == row and not State.Dropdown.Closing

    row.Glow = Approach(row.Glow or 0, (Open or Hovered) and 1 or 0, Layout.ArrowSpeed)
    row.Arrow = Approach(row.Arrow or 0, Open and 1 or 0, Layout.ArrowSpeed)

    local Turn = row.Arrow * row.Arrow * (3 - 2 * row.Arrow)
    local ArrowColor = Blend(Theme.Text, Theme.Accent, row.Glow)

    DrawText(row.Name, x, LabelY, Theme.Text, Layout.TextSize, SystemFont, 31, Alpha.Label * fade, LabelRoom)
    DrawRect(BoxX, BoxY, BoxWidth, Layout.FieldHeight, Theme.Text, 30, Layout.CardRadius, BoxAlpha * fade)
    DrawText(Display, BoxX + Layout.FieldPad, TextTop(BoxY, Layout.FieldHeight, Layout.TextSize), Theme.Text, Layout.TextSize, SystemFont, 32, Alpha.Dim * fade, BoxWidth - Layout.DropdownTextRoom)
    DrawChevron(BoxX + BoxWidth - Layout.ArrowInset, BoxY + Layout.FieldHeight / 2, Layout.ArrowRadius, Turn, ArrowColor, 32, (Alpha.Dim + Alpha.ArrowLift * row.Glow) * fade)

    if not (Hovered and Input.Click) then return end

    Input.Click = false

    if Open then
      State.Dropdown.Closing = true
      return
    end

    OpenDropdown(row, BoxX, BoxY + Layout.ListDrop, BoxWidth)
  end

  local function DropdownChoices()
    local Drop = State.Dropdown
    local Query = Drop.Search.Value

    if not Drop.Searchable or Query == "" then return Drop.Choices end
    if Drop.FilterQuery == Query then return Drop.Filtered end

    local Needle = string.lower(Query)
    local Found = {}

    for Index = 1, #Drop.Choices do
      local Choice = Drop.Choices[Index]
      if string.find(string.lower(Choice), Needle, 1, true) then Found[#Found + 1] = Choice end
    end

    Drop.FilterQuery, Drop.Filtered = Query, Found

    return Found
  end

  local function DrawDropdownSearch(x, y, width, anim)
    local Search = State.Dropdown.Search
    local BoxX = x + Layout.ListSearchInset
    local BoxY = y + Layout.ListSearchTop
    local BoxWidth = width - Layout.ListSearchInset * 2
    local Focused = State.Focus == Search
    local Hovered = Interact and IsMouseIn(BoxX, BoxY, BoxWidth, Layout.ListSearchBox)
    local Value = Search.Value
    local Length = #Value
    local Empty = Value == "" and not Focused
    local Edge = Focused and Alpha.ListSearchFocus or Alpha.Hairline
    local TextX = x + Layout.ListSearchText
    local TextY = TextTop(BoxY, Layout.ListSearchBox, Layout.TextSize)
    local CharWidth = Layout.TextSize * Layout.EditWidth
    local Caret = math.min(math.max(Search.Caret or Length, 0), Length)
    local Fit = math.max(1, math.floor((width - Layout.ListSearchField) / CharWidth))
    local Scroll = Focused and Caret > Fit and Caret - Fit or 0
    local Shown = string.sub(Value, Scroll + 1, math.min(Length, Scroll + Fit))
    local Anchor = Search.Anchor or Caret
    local Selecting = Focused and Search.Anchor ~= nil and Search.Anchor ~= Caret
    local Blink = os.clock() % 1 < Layout.CaretBlink
    local Low = math.min(math.max(math.min(Anchor, Caret) - Scroll, 0), #Shown)
    local High = math.min(math.max(math.max(Anchor, Caret) - Scroll, 0), #Shown)
    local CaretX = TextX + math.min(math.max(Caret - Scroll, 0), #Shown) * CharWidth
    local SelectX = TextX + Low * CharWidth
    local SelectWidth = math.max(1, (High - Low) * CharWidth)
    local SelectShade = High > Low and Alpha.Select * Alpha.Dim * anim or 0
    local Hit = math.min(math.max(Scroll + math.floor((Input.X - TextX) / CharWidth + 0.5), 0), Length)

    DrawRect(BoxX, BoxY, BoxWidth, Layout.ListSearchBox, Theme.Text, 202, Layout.ListSearchRadius, Alpha.Field * anim)
    DrawStroke(BoxX, BoxY, BoxWidth, Layout.ListSearchBox, Theme.Text, 203, Layout.ListSearchRadius, Edge * anim)

    if Empty then DrawText("search...", TextX, TextY, Theme.Text, Layout.TextSize, SystemFont, 204, Alpha.Placeholder * anim, width - Layout.ListSearchRoom) end

    if not Empty then
      for Index = 1, #Shown do
        DrawText(string.sub(Shown, Index, Index), TextX + (Index - 1) * CharWidth, TextY, Theme.Text, Layout.TextSize, UiFont, 204, Alpha.Dim * anim)
      end

      if Focused and not Selecting and Blink then DrawRect(CaretX, TextY, Layout.CaretWidth, Layout.TextSize, Theme.Text, 204, 0, Alpha.Dim * anim) end
      if Selecting then DrawRect(SelectX, TextY - Layout.SelectLift, SelectWidth, Layout.TextSize + Layout.SelectGrow, Theme.Accent, 204, Layout.SelectRadius, SelectShade) end
    end

    if Input.Click and Hovered then
      State.Focus = Search
      State.TextDrag = Search
      Search.Caret = Hit
      Search.Anchor = Hit
      Input.Click = false
    end

    if not State.TextDrag then return end
    if State.TextDrag ~= Search then return end

    Search.Caret = Hit
  end

  local function DrawDropdownRow(choice, index, step, x, width, rowsTop, rowWidth, areaHeight, smooth, anim)
    local Drop = State.Dropdown
    local RawY = rowsTop + (index - smooth) * Layout.ListRow

    if RawY + Layout.ListRow <= rowsTop or RawY >= rowsTop + areaHeight then return end

    local Height = Layout.ListRow - Layout.ListRowGap
    local EdgeFade = math.min(math.max((RawY + Layout.ListRow - rowsTop) / Layout.ListRow, 0), 1) * math.min(math.max((rowsTop + areaHeight - RawY) / Layout.ListRow, 0), 1)
    local Cascade = math.min(math.max((anim - step * Layout.CascadeStep) / Layout.CascadeSpan, 0), 1)
    local Shade = Cascade * EdgeFade
    local RowY = RawY + (1 - Cascade) * Layout.CascadeDrop
    local RowX = x + Layout.ListInset
    local Now = os.clock()
    local Selected = false

    for Order = 1, #Drop.Value do
      if Drop.Value[Order] == choice then Selected = true break end
    end

    local Inside = RawY >= rowsTop - Layout.ListEdgeSlack and RawY + Layout.ListRow <= rowsTop + areaHeight + Layout.ListEdgeSlack
    local Hovered = Inside and Interact and IsMouseIn(RowX, RowY, rowWidth, Height)
    local Pressing = Drop.PressRow == index and Drop.PressAt and Drop.PressAt > Now
    local PressShade = Pressing and Alpha.Press * ((Drop.PressAt - Now) / Layout.PressTime) or 0
    local TextShade = (Hovered or Selected) and Alpha.Text or Alpha.Label
    local TickX = RowX + rowWidth - Layout.TickInset
    local TickY = RowY + Height / 2 + Layout.TickNudge

    DrawRect(RowX, RowY, rowWidth, Height, Theme.Accent, 202, Layout.ListRowRadius, PressShade * Shade)
    DrawRect(RowX, RowY, rowWidth, Height, Theme.Text, 202, Layout.ListRowRadius, (Selected and Alpha.RowSelect or 0) * Shade)
    DrawRect(RowX, RowY, rowWidth, Height, Theme.Accent, 202, Layout.ListRowRadius, (Hovered and Alpha.RowHover or 0) * Shade)
    DrawText(choice, x + Layout.ListTextInset, TextTop(RowY, Height, Layout.TextSize), Theme.Text, Layout.TextSize, SystemFont, 203, TextShade * Shade, width - Layout.ListTextRoom)

    if Selected then
      DrawLine(TickX, TickY, TickX + Layout.TickShort, TickY + Layout.TickShort, Theme.Text, 204, Layout.TickThickness, Alpha.Text * Shade)
      DrawLine(TickX + Layout.TickShort, TickY + Layout.TickShort, TickX + Layout.TickLongX, TickY - Layout.TickLongY, Theme.Text, 204, Layout.TickThickness, Alpha.Text * Shade)
    end

    if not Input.Click or not Hovered or Drop.Closing then return end

    Drop.PressRow, Drop.PressAt = index, Now + Layout.PressTime
    Input.Click = false

    if not Drop.Multi then
      SetDropdownValue(Drop.Row, { choice })
      Drop.Closing = true
      State.Focus = nil
      return
    end

    local Next = CopyList(Drop.Value)
    local Found = nil

    for Order = #Next, 1, -1 do
      if Next[Order] == choice then Found = Order end
    end

    if Found then
      table.remove(Next, Found)
    elseif not Drop.Row.MaxSelections or #Next < Drop.Row.MaxSelections then
      Next[#Next + 1] = choice
    end

    SetDropdownValue(Drop.Row, Next)

    Drop.Value = Drop.Row.Value
  end

  local function DrawDropdownBar(list, x, width, rowsTop, maxRows, anim)
    local Drop = State.Dropdown
    local MaxOffset = math.max(0, #list - maxRows)

    if MaxOffset <= 0 then return end

    local TrackY = rowsTop + Layout.TrackNudge
    local TrackHeight = maxRows * Layout.ListRow - Layout.TrackTrim
    local BarX = x + width - Layout.TrackInset
    local ThumbHeight = math.max(Layout.ThumbMin, TrackHeight * maxRows / #list)
    local Fraction = Drop.Offset / MaxOffset
    local TargetY = TrackY + (TrackHeight - ThumbHeight) * Fraction

    Drop.BarY = Approach(Drop.BarY or TargetY, TargetY, Layout.ThumbSpeed)

    if math.abs(Drop.BarY - TargetY) < Layout.ThumbSnap then Drop.BarY = TargetY end

    local Hot = Interact and IsMouseIn(BarX - Layout.TrackReach, TrackY, Layout.TrackGrab, TrackHeight) or Drop.BarDrag
    local Target = Hot and 1 or 0

    Drop.BarGlow = Approach(Drop.BarGlow or 0, Target, Layout.ThumbGlowSpeed)

    if math.abs(Drop.BarGlow - Target) < Layout.ThumbGlowSnap then Drop.BarGlow = Target end

    local Glow = Drop.BarGlow
    local BarColor = Blend(Theme.AccentA, Theme.AccentB, Fraction)
    local ThumbColor = Blend(Theme.Text, BarColor, Layout.ThumbMix)

    DrawRect(BarX, TrackY, Layout.TrackWidth, TrackHeight, Theme.Text, 204, Layout.TrackRadius, Alpha.Track * anim)
    DrawRect(BarX - Layout.ThumbHaloX, Drop.BarY - Layout.ThumbHaloY, Layout.ThumbHaloWidth, ThumbHeight + Layout.ThumbHaloGrow, BarColor, 205, Layout.ThumbHaloRadius, Alpha.ThumbHalo * Glow * anim)
    DrawRect(BarX, Drop.BarY, Layout.ThumbWidth, ThumbHeight, ThumbColor, 205, Layout.ThumbRadius, (Alpha.Thumb + Alpha.ThumbGlow * Glow) * anim)

    if Input.Click and Interact and IsMouseIn(BarX - Layout.TrackReach, TrackY, Layout.TrackGrab, TrackHeight) then
      Drop.BarDrag = true
      Input.Click = false
    end

    if not Drop.BarDrag or not Input.Down then return end

    local Along = math.min(math.max((Input.Y - TrackY - ThumbHeight / 2) / math.max(1, TrackHeight - ThumbHeight), 0), 1)

    Drop.Offset = math.floor(Along * MaxOffset + 0.5)
  end

  local function ApplySelectAction(index)
    local Drop = State.Dropdown
    local Next = {}

    if index == 1 then
      for Order = 1, #Drop.Choices do
        if not Drop.Row.MaxSelections or #Next < Drop.Row.MaxSelections then Next[#Next + 1] = Drop.Choices[Order] end
      end
    end

    SetDropdownValue(Drop.Row, Next)

    Drop.Value = Drop.Row.Value
    Drop.Context = nil
    Input.Click = false
  end

  local function DrawDropdownContext(anim)
    local Drop = State.Dropdown
    local Context = Drop.Context

    if not Context then return end

    local X, Y = Context.X, Context.Y
    local Width = Layout.ContextWidth
    local RowX = X + Layout.ContextInset
    local RowWidth = Width - Layout.ContextInset * 2

    DrawRect(X, Y, Width, Layout.ContextHeight, Theme.Background, 206, Layout.ContextRadius, Alpha.Panel * anim)
    DrawStroke(X, Y, Width, Layout.ContextHeight, Theme.Text, 207, Layout.ContextRadius, Alpha.CardStroke * anim)

    for Index = 1, #SelectActions do
      local RowY = Y + Layout.ContextPad + (Index - 1) * Layout.ContextStep
      local Hovered = Interact and IsMouseIn(RowX, RowY, RowWidth, Layout.ContextRow)

      DrawRect(RowX, RowY, RowWidth, Layout.ContextRow, Theme.Text, 207, Layout.ContextRowRadius, (Hovered and Alpha.ContextHover or 0) * anim)
      DrawText(SelectActions[Index], X + Layout.ContextText, TextTop(RowY, Layout.ContextRow, Layout.SmallSize), Theme.Text, Layout.SmallSize, SystemFont, 208, Alpha.Label * anim, Width - Layout.ContextTextRoom)

      if Input.Click and Hovered then ApplySelectAction(Index) end
    end

    if not Input.Click then return end
    if Interact and IsMouseIn(X - Layout.ContextReach, Y - Layout.ContextReach, Width + Layout.ContextReach * 2, Layout.ContextReachHeight) then return end

    Drop.Context = nil
    Input.Click = false
  end

  function DrawDropdownList()
    local Drop = State.Dropdown

    if not Drop then return end

    Drop.Anim = Approach(Drop.Anim, Drop.Closing and 0 or 1, Layout.ListOpenSpeed)

    if Drop.Closing and Drop.Anim < Layout.ListGoneAt then
      if State.Focus == Drop.Search then State.Focus = nil end

      State.Dropdown = nil

      return
    end

    local Anim = Drop.Anim
    local X = Drop.X
    local Y = Drop.Y - (1 - Anim) * Layout.ListLift
    local Width, Height = Drop.W, Drop.H
    local HeaderHeight = Drop.Searchable and Layout.ListHeader or 0
    local List = DropdownChoices()
    local MaxRows = math.max(1, math.floor((Height - Layout.ListPad - HeaderHeight) / Layout.ListRow))
    local Hovered = Interact and IsMouseIn(X - Layout.ListReach, Y - Layout.ListReach, Width + Layout.ListReach * 2, Height + Layout.ListReach * 2)
    local RowsTop = Y + Layout.ListInset + HeaderHeight
    local RowWidth = #List > MaxRows and (Width - Layout.ListBarRoom) or (Width - Layout.ListRowRoom)
    local AreaHeight = MaxRows * Layout.ListRow
    local Panel = Blend(Theme.Background, Theme.Text, Layout.PanelMix)

    Drop.Offset = math.min(math.max(Drop.Offset, 0), math.max(0, #List - MaxRows))
    Drop.Smooth = Approach(Drop.Smooth or Drop.Offset, Drop.Offset, Layout.ListScrollSpeed)

    local Smooth = Drop.Smooth

    DrawRect(X - Layout.ListShadow, Y - Layout.ListShadow, Width + Layout.ListShadow * 2, Height + Layout.ListShadow * 2, Black, 199, Layout.ListShadowRadius, Alpha.ListShadow * Anim)
    DrawRect(X, Y, Width, Height, Panel, 200, Layout.ListRadius, Alpha.Panel * Anim)

    if Drop.Searchable then DrawDropdownSearch(X, Y, Width, Anim) end

    for Step = 0, MaxRows do
      local Index = math.floor(Smooth) + Step
      local Choice = Index >= 0 and List[Index + 1] or nil

      if Choice then DrawDropdownRow(Choice, Index, Step, X, Width, RowsTop, RowWidth, AreaHeight, Smooth, Anim) end
    end

    DrawDropdownBar(List, X, Width, RowsTop, MaxRows, Anim)

    if Drop.Multi and Input.Right and Hovered then
      Drop.Context = { X = Input.X, Y = Input.Y }
      Input.Right = false
    end

    DrawDropdownContext(Anim)

    if not Input.Click or Hovered or Drop.Context or Drop.Closing then return end

    Drop.Closing = true
    State.Focus = nil
    Input.Click = false
  end

  local TrackGrey = Color3.fromRGB(70, 70, 70)
  local WellGrey = Color3.fromRGB(50, 50, 50)

  local PickerCache = {}

  local function ToHsv(color)
    local Red, Green, Blue = color.R, color.G, color.B
    local High, Low = math.max(Red, Green, Blue), math.min(Red, Green, Blue)
    local Span = High - Low
    local Saturation = High > 0 and Span / High or 0

    if Span <= 0 then return 0, Saturation, High end
    if High == Red then return (((Green - Blue) / Span) % 6) / 6, Saturation, High end
    if High == Green then return (((Blue - Red) / Span) + 2) / 6, Saturation, High end

    return (((Red - Green) / Span) + 4) / 6, Saturation, High
  end

  local function HexByte(value)
    return string.format("%02X", math.floor(math.min(math.max(value, 0), 1) * Layout.ByteScale + 0.5))
  end

  local function ToHex(color)
    return "#" .. HexByte(color.R) .. HexByte(color.G) .. HexByte(color.B)
  end

  local function ParseHex(text)
    local Clean = string.gsub(tostring(text), "[^0-9a-fA-F]", "")

    if #Clean == 3 then Clean = string.gsub(Clean, "(.)", "%1%1") end
    if #Clean < 6 then return nil end

    local Red = tonumber(string.sub(Clean, 1, 2), 16)
    local Green = tonumber(string.sub(Clean, 3, 4), 16)
    local Blue = tonumber(string.sub(Clean, 5, 6), 16)

    if not (Red and Green and Blue) then return nil end

    return Color3.fromRGB(Red, Green, Blue)
  end

  local function ColorChanged(first, second)
    return math.abs(first.R - second.R) > Layout.ColorEpsilon or math.abs(first.G - second.G) > Layout.ColorEpsilon or math.abs(first.B - second.B) > Layout.ColorEpsilon
  end

  local function ShadeStrip(hue, count)
    if PickerCache.Shade and PickerCache.ShadeHue == hue and PickerCache.ShadeCount == count then return PickerCache.Shade end

    local Pure = Color3.fromHSV(hue, 1, 1)
    local Strip = {}

    for Index = 0, count - 1 do Strip[Index] = Blend(White, Pure, Index / (count - 1)) end

    PickerCache.Shade, PickerCache.ShadeHue, PickerCache.ShadeCount = Strip, hue, count

    return Strip
  end

  local function HueStrip(count)
    if PickerCache.Hue and PickerCache.HueCount == count then return PickerCache.Hue end

    local Strip = {}

    for Index = 0, count - 1 do Strip[Index] = Color3.fromHSV(Index / (count - 1), 1, 1) end

    PickerCache.Hue, PickerCache.HueCount = Strip, count

    return Strip
  end

  function StartPicker(picker)
    local Hue, Saturation, Value = ToHsv(picker.Row.Value)
    local Viewport = Camera.ViewportSize
    local Margin = Layout.PickerMargin
    local RightEdge = math.max(Margin, Viewport.X - Layout.PickerWidth - Margin)
    local BottomEdge = math.max(Margin, Viewport.Y - Layout.PickerHeight - Margin)

    picker.Hue, picker.Sat, picker.Val = Hue, Saturation, Value
    picker.Alpha = picker.Row.Alpha
    picker.Format = "HEX"
    picker.Anim = 0
    picker.X = math.min(math.max(picker.X, Margin), RightEdge)
    picker.Y = math.min(math.max(picker.Y, Margin), BottomEdge)
  end

  local function PickerPush(picker)
    local Current = Color3.fromHSV(picker.Hue, picker.Sat, picker.Val)

    picker.Row.Value = Current
    picker.Row.Alpha = picker.Alpha
    picker.Row.Callback(Current, picker.Alpha)
  end

  local function PickerDrag(picker, boxX, boxY, boxWidth, boxHeight, hueY, alphaY)
    local Pad = Layout.PickerEdgePad
    local Slider = Layout.PickerSlider
    local OnSquare = picker.Drag == "Sat" or Interact and IsMouseIn(boxX, boxY, boxWidth, boxHeight)
    local OnHue = picker.Drag == "Hue" or Interact and IsMouseIn(boxX - Pad, hueY - Pad, boxWidth + Pad * 2, Slider + Pad * 2)
    local OnAlpha = picker.Drag == "Alpha" or Interact and IsMouseIn(boxX - Pad, alphaY - Pad, boxWidth + Pad * 2, Slider + Pad * 2)
    local Along = math.min(math.max((Input.X - boxX) / boxWidth, 0), 1)
    local Down = math.min(math.max(1 - (Input.Y - boxY) / boxHeight, 0), 1)
    local Was, WasAlpha = picker.Row.Value, picker.Row.Alpha

    if OnSquare then
      picker.Drag = "Sat"
      picker.Sat, picker.Val = Along, Down
    elseif OnHue then
      picker.Drag = "Hue"
      picker.Hue = Along
    elseif OnAlpha then
      picker.Drag = "Alpha"
      picker.Alpha = Along
    else
      return
    end

    local Next = Color3.fromHSV(picker.Hue, picker.Sat, picker.Val)

    if not ColorChanged(Was, Next) and math.abs(WasAlpha - picker.Alpha) <= Layout.ColorEpsilon then return end

    PickerPush(picker)
  end

  local function ApplyPickerEdit(picker)
    local Text = picker.Hex
    local Scale = Layout.ByteScale

    picker.Hex = nil

    if picker.Format == "RGB" then
      local Red, Green, Blue = string.match(Text, "(%d+)%D+(%d+)%D+(%d+)")
      if not Red then return end

      local Color = Color3.fromRGB(math.min(tonumber(Red), Scale), math.min(tonumber(Green), Scale), math.min(tonumber(Blue), Scale))

      picker.Hue, picker.Sat, picker.Val = ToHsv(Color)
      PickerPush(picker)

      return
    end

    local Clean = string.gsub(Text, "[^0-9a-fA-F]", "")
    local Color = ParseHex(Text)
    if not Color then return end

    picker.Hue, picker.Sat, picker.Val = ToHsv(Color)

    if #Clean >= Layout.PickerHexMax then picker.Alpha = tonumber(string.sub(Clean, Layout.PickerAlphaStart, Layout.PickerHexMax), 16) / Scale end

    PickerPush(picker)
  end

  function DrawPicker()
    local Picker = State.Picker
    if not Picker then return end
    if not Picker.Format then StartPicker(Picker) end

    Picker.Anim = Approach(Picker.Anim, 1, Layout.PickerSpeed)

    local Anim = Picker.Anim
    local Pad = Layout.PickerPad
    local Panel = Layout.PickerWidth
    local BoxWidth = Panel - Pad * 2
    local BoxHeight = Layout.PickerBox
    local Slider = Layout.PickerSlider
    local Info = Layout.PickerInfo
    local Gap = Layout.PickerGap
    local Height = Pad + BoxHeight + Gap + Slider + Gap + Slider + Gap + Info + Pad
    local Margin = Layout.PickerMargin
    local Floor = math.max(Margin, Camera.ViewportSize.Y - Height - Margin)

    Picker.Y = math.min(math.max(Picker.Y, Margin), Floor)

    local X = Picker.X
    local Y = Picker.Y + (1 - Anim) * Layout.PickerLift
    local Glow = Layout.PickerGlow
    local BoxX, BoxY = X + Pad, Y + Pad
    local HueY = BoxY + BoxHeight + Gap
    local AlphaY = HueY + Slider + Gap
    local InfoY = AlphaY + Slider + Gap
    local Segments = math.min(math.max(math.floor(BoxWidth), Layout.PickerSegMin), Layout.PickerSegMax)
    local Rows = math.min(math.max(math.floor(BoxHeight), Layout.PickerSegMin), Layout.PickerShadeMax)
    local Inset = Slider / 2
    local Editing = Picker.Hex ~= nil

    if Input.Down and not Editing then PickerDrag(Picker, BoxX, BoxY, BoxWidth, BoxHeight, HueY, AlphaY) end

    local Current = Color3.fromHSV(Picker.Hue, Picker.Sat, Picker.Val)
    local Pure = Color3.fromHSV(Picker.Hue, 1, 1)
    local Shades = ShadeStrip(Picker.Hue, Segments)
    local Hues = HueStrip(Segments)
    local HandleX = BoxX + Picker.Sat * BoxWidth
    local HandleY = BoxY + (1 - Picker.Val) * BoxHeight
    local HueKnobX = BoxX + Picker.Hue * BoxWidth
    local HueMid = HueY + Inset
    local AlphaKnobX = BoxX + Picker.Alpha * BoxWidth
    local AlphaMid = AlphaY + Inset

    DrawRect(X - Glow, Y - Glow, Panel + Glow * 2, Height + Glow * 2, Black, 209, Layout.PickerGlowRadius, Alpha.PickerShadow * Anim)
    DrawRect(X, Y, Panel, Height, Theme.Background, 210, Layout.PickerRadius, Alpha.PickerPanel * Anim)
    DrawStroke(X, Y, Panel, Height, Theme.Text, 211, Layout.PickerRadius, Alpha.CardStroke * Anim)

    for Index = 0, Segments - 1 do
      local Start = math.floor(BoxX + BoxWidth * Index / Segments + 0.5)
      local Stop = math.floor(BoxX + BoxWidth * (Index + 1) / Segments + 0.5)

      if Stop > Start then DrawRect(Start, BoxY, Stop - Start, BoxHeight, Shades[Index], 212, 0, Anim) end
    end

    for Index = 1, Rows - 1 do
      local Start = math.floor(BoxY + BoxHeight * Index / Rows + 0.5)
      local Stop = math.floor(BoxY + BoxHeight * (Index + 1) / Rows + 0.5)

      if Stop > Start then DrawRect(BoxX, Start, BoxWidth, Stop - Start, Black, 213, 0, (Index / (Rows - 1)) * Alpha.PickerShade * Anim) end
    end

    DrawStroke(BoxX, BoxY, BoxWidth, BoxHeight, Black, 214, Layout.PickerBoxRadius, Alpha.PickerEdge * Anim)
    DrawCircle(HandleX, HandleY, Layout.PickerHandleOuter, Black, 214, false, Layout.PickerThick, Layout.PickerHandleSides, Alpha.PickerHandle * Anim)
    DrawCircle(HandleX, HandleY, Layout.PickerHandleRing, Theme.Text, 215, false, Layout.PickerRingThick, Layout.PickerHandleSides, Anim)
    DrawCircle(HandleX, HandleY, Layout.PickerHandleCore, Current, 216, true, Layout.PickerThin, Layout.PickerHandleSides, Anim)
    DrawRect(BoxX, HueY, BoxWidth, Slider, Hues[0], 213, Inset, Anim)

    for Index = 0, Segments - 1 do
      local Start = math.floor(BoxX + Inset + (BoxWidth - Inset * 2) * Index / Segments + 0.5)
      local Stop = math.floor(BoxX + Inset + (BoxWidth - Inset * 2) * (Index + 1) / Segments + 0.5)

      if Stop > Start then DrawRect(Start, HueY, Stop - Start, Slider, Hues[Index], 214, 0, Anim) end
    end

    DrawCircle(HueKnobX, HueMid, Layout.PickerKnobOuter, Black, 214, false, Layout.PickerThick, Layout.PickerKnobSides, Alpha.PickerKnob * Anim)
    DrawCircle(HueKnobX, HueMid, Layout.PickerKnobRing, Theme.Text, 215, true, Layout.PickerThin, Layout.PickerKnobSides, Anim)
    DrawCircle(HueKnobX, HueMid, Layout.PickerHandleCore, Pure, 216, true, Layout.PickerThin, Layout.PickerKnobSides, Anim)
    DrawRect(BoxX, AlphaY, BoxWidth, Slider, TrackGrey, 213, Inset, Anim)

    for Index = 0, Segments - 1 do
      local Start = math.floor(BoxX + BoxWidth * Index / Segments + 0.5)
      local Stop = math.floor(BoxX + BoxWidth * (Index + 1) / Segments + 0.5)
      local Corner = (Index == 0 or Index == Segments - 1) and Inset or 0

      if Stop > Start then DrawRect(Start, AlphaY, Stop - Start, Slider, Current, 214, Corner, (Index / (Segments - 1)) * Anim) end
    end

    DrawCircle(AlphaKnobX, AlphaMid, Layout.PickerKnobOuter, Black, 214, false, Layout.PickerThick, Layout.PickerKnobSides, Alpha.PickerKnob * Anim)
    DrawCircle(AlphaKnobX, AlphaMid, Layout.PickerKnobRing, Theme.Text, 215, true, Layout.PickerThin, Layout.PickerKnobSides, Anim)
    DrawCircle(AlphaKnobX, AlphaMid, Layout.PickerHandleCore, Current, 216, true, Layout.PickerThin, Layout.PickerKnobSides, Anim * (Layout.PickerCoreBase + Layout.PickerCoreGain * Picker.Alpha))

    local FormatX = BoxX + Layout.PickerFormatGap
    local FormatWide = Layout.PickerFormatWidth
    local FormatHovered = Interact and IsMouseIn(FormatX, InfoY, FormatWide, Info)
    local ChevronX = FormatX + FormatWide - Layout.PickerChevronX
    local ChevronY = InfoY + Info / 2 - Layout.PickerChevronDrop
    local Step = Layout.PickerChevronStep
    local FormatAlpha = FormatHovered and Alpha.PickerFormat or Alpha.Field

    DrawRect(BoxX, InfoY, Layout.PickerSwatch, Info, WellGrey, 213, Layout.PickerChipRadius, Anim)
    DrawRect(BoxX, InfoY, Layout.PickerSwatch, Info, Current, 214, Layout.PickerChipRadius, Anim * Picker.Alpha)
    DrawStroke(BoxX, InfoY, Layout.PickerSwatch, Info, Theme.Text, 214, Layout.PickerChipRadius, Alpha.Hairline * Anim)
    DrawRect(FormatX, InfoY, FormatWide, Info, Theme.Text, 213, Layout.PickerFieldRadius, FormatAlpha * Anim)
    DrawText(Picker.Format, FormatX + Layout.PickerFormatPad, TextTop(InfoY, Info, Layout.TinySize), Theme.Text, Layout.TinySize, BoldFont, 214, Alpha.Text * Anim)
    DrawLine(ChevronX, ChevronY, ChevronX + Step, ChevronY + Step, Theme.Text, 214, Layout.PickerChevronThick, Alpha.Dim * Anim)
    DrawLine(ChevronX + Step, ChevronY + Step, ChevronX + Step * 2, ChevronY, Theme.Text, 214, Layout.PickerChevronThick, Alpha.Dim * Anim)

    if Input.Click and FormatHovered then
      Picker.Format = Picker.Format == "HEX" and "RGB" or "HEX"
      Picker.Hex = nil
      Input.Click = false
    end

    local Typing = Picker.Hex ~= nil
    local OpacityWide = Layout.PickerOpacityWidth
    local HexX = FormatX + FormatWide + Layout.PickerFieldGap
    local HexWide = (BoxX + BoxWidth) - OpacityWide - Layout.PickerOpacityGap - HexX
    local HexHovered = Interact and IsMouseIn(HexX, InfoY, HexWide, Info)
    local TextX = HexX + Layout.PickerTextPad
    local TextY = TextTop(InfoY, Info, Layout.SmallSize)
    local Scale = Layout.ByteScale
    local Tail = Picker.Alpha < Layout.PickerOpaque and HexByte(Picker.Alpha) or ""
    local CurrentHex = ToHex(Current) .. Tail
    local RgbText = string.format("%d, %d, %d", math.floor(Current.R * Scale + 0.5), math.floor(Current.G * Scale + 0.5), math.floor(Current.B * Scale + 0.5))
    local Shown = Picker.Format == "RGB" and RgbText or CurrentHex
    local Percent = math.floor(Picker.Alpha * Layout.PickerPercent + 0.5) .. "%"
    local FieldAlpha = Typing and Alpha.PickerEditing or (HexHovered and Alpha.PickerHover or Alpha.Field)

    DrawRect(HexX, InfoY, HexWide, Info, Theme.Text, 213, Layout.PickerFieldRadius, FieldAlpha * Anim)

    if not Typing then DrawText(Shown, TextX, TextY, Theme.Text, Layout.SmallSize, MonoFont, 214, Alpha.Text * Anim, HexWide - Layout.PickerTextRoom) end

    if Typing then
      local CharWidth = Layout.SmallSize * Layout.EditWidth
      local Value = Picker.Hex
      local Length = #Value
      local Caret = math.min(math.max(Picker.Caret, 0), Length)
      local Fit = math.max(1, math.floor((HexWide - Layout.PickerEditRoom) / CharWidth))
      local Scroll = Caret > Fit and Caret - Fit or 0
      local Visible = string.sub(Value, Scroll + 1, math.min(Length, Scroll + Fit))
      local Anchor = Picker.Anchor or Caret
      local Selecting = Picker.Anchor ~= nil and Picker.Anchor ~= Caret
      local Blink = os.clock() % 1 < Layout.CaretBlink
      local Low = math.min(math.max(math.min(Anchor, Caret) - Scroll, 0), #Visible)
      local High = math.min(math.max(math.max(Anchor, Caret) - Scroll, 0), #Visible)
      local CaretX = TextX + math.min(math.max(Caret - Scroll, 0), #Visible) * CharWidth
      local SelectX = TextX + Low * CharWidth
      local SelectWide = math.max(1, (High - Low) * CharWidth)
      local SelectShade = High > Low and Alpha.Select * Alpha.Text * Anim or 0

      Picker.CharWidth, Picker.EditX, Picker.Scroll = CharWidth, TextX, Scroll

      for Index = 1, #Visible do
        DrawText(string.sub(Visible, Index, Index), TextX + (Index - 1) * CharWidth, TextY, Theme.Text, Layout.SmallSize, UiFont, 214, Alpha.Text * Anim)
      end

      if not Selecting and Blink then DrawRect(CaretX, TextY, Layout.CaretWidth, Layout.SmallSize, Theme.Text, 214, 0, Alpha.Text * Anim) end
      if Selecting then DrawRect(SelectX, TextY - Layout.SelectLift, SelectWide, Layout.SmallSize + Layout.SelectGrow, Theme.Accent, 214, Layout.SelectRadius, SelectShade) end
    end

    DrawText(Percent, BoxX + BoxWidth - OpacityWide + Layout.PickerOpacityGap, TextY, Theme.Text, Layout.SmallSize, SystemFont, 214, Alpha.Label * Anim, OpacityWide - Layout.PickerOpacityRoom)

    local Edge = Layout.PickerEdgePad
    local Outside = not IsMouseIn(X - Edge, Y - Edge, Panel + Edge * 2, Height + Edge * 2)

    if Input.Click and HexHovered and not Typing then
      Picker.Hex = Picker.Format == "RGB" and RgbText or string.sub(string.gsub(CurrentHex, "#", ""), 1, Layout.PickerHexMax)
      Picker.Caret = #Picker.Hex
      Picker.Anchor = 0
      Picker.CharWidth, Picker.EditX, Picker.Scroll = Layout.SmallSize * Layout.EditWidth, TextX, 0
      Picker.HexDrag = true
      State.Focus = nil
      Input.Click = false
    elseif Typing and Keys.Enter.Click then
      ApplyPickerEdit(Picker)
      Keys.Enter.Click = false
    elseif Typing and Keys.Escape.Click then
      Picker.Hex = nil
      Keys.Escape.Click = false
    elseif Typing and Input.Click and Outside then
      ApplyPickerEdit(Picker)
    elseif Typing then
      EditText(Picker, "Hex", Picker.Format ~= "RGB" and "[0-9a-fA-F]" or nil)
    end

    if Picker.Hex and Input.Down and Picker.HexDrag then Picker.Caret = math.min(math.max(Picker.Scroll + math.floor((Input.X - Picker.EditX) / Picker.CharWidth + 0.5), 0), #Picker.Hex) end
    if not (Input.Click and Outside) then return end

    State.Picker = nil
    Input.Click = false
  end

  function DrawColourRow(row, x, y, width, fade)
    local SwatchX, SwatchY = x + width - Layout.SwatchSize, y + 5
    local Hovered = Interact and IsMouseIn(SwatchX, SwatchY, Layout.SwatchSize, Layout.SwatchSize)

    DrawText(row.Name, x, TextTop(y, Layout.ColorLabel, Layout.TextSize), Theme.Text, Layout.TextSize, SystemFont, 31, Alpha.Label * fade, width - Layout.SwatchSize - 8)
    DrawSwatch(SwatchX, SwatchY, Layout.SwatchSize, Layout.SwatchRadius, row.Value, row.Alpha, Hovered, fade)

    if not (Hovered and Input.Click) then return end

    OpenPicker(row)
  end
end

local RowHeight = {
  Toggle = Layout.ToggleRow,
  Button = Layout.ButtonRow,
  Slider = Layout.SliderRow,
  Range = Layout.SliderRow,
  Dropdown = Layout.DropdownRow,
  Color = Layout.ColorRow,
  Keybind = Layout.KeybindRow,
  Divider = Layout.DividerRow,
  Textbox = Layout.TextboxRow,
}

local function RowSpan(row)
  if row.Kind == "Dropdown" and State.DropdownInline then return Layout.DropdownInlineRow end
  if row.Kind == "Label" then return math.max(18, (row.LineCount or 1) * Layout.LabelLine + 2) end
  if row.Kind == "Info" then return math.max(16, (row.LineCount or 1) * Layout.InfoLine + 2) end

  return RowHeight[row.Kind]
end

local RowDrawer = {
  Toggle = DrawToggle,
  Button = DrawButtonRow,
  Slider = DrawSlider,
  Range = DrawRangeSlider,
  Dropdown = DrawDropdown,
  Color = DrawColourRow,
  Keybind = DrawKeybind,
  Divider = DrawDivider,
  Textbox = DrawTextbox,
  Label = DrawLabel,
  Info = DrawInfo,
}

local RowLocked, DrawSectionTitle, DrawSectionCard, DrawSectionRows, ContentHeight, ScrollInput, DrawScrollBar, DragBody

do
  local function SectionTitleHeight(section)
    if section.Name == "" then return 0 end

    return Layout.SectionTitle + (section.Desc and Layout.SectionDesc or 0)
  end

  local function SectionHeight(section)
    local Target = section.Collapsed and 1 or 0
    local Title = SectionTitleHeight(section)
    local Full = Title + Layout.CardTopPad + Layout.CardBottomPad
    local Count = #section.Rows

    section.Fold = Approach(section.Fold or Target, Target, 10)

    for Index, Row in ipairs(section.Rows) do
      Full = Full + RowSpan(Row)
      if Index < Count then Full = Full + Layout.RowGap end
    end

    return Full + ((Title + Layout.RowGap) - Full) * section.Fold
  end

  function WantTooltip(text, x, y)
    local Tip = State.Tip

    if not Tip then
      Tip = { Text = "", At = os.clock() }
      State.Tip = Tip
    end

    if Tip.Text ~= text then Tip.At = os.clock() end

    Tip.Text, Tip.X, Tip.Y, Tip.Frame = text, x, y, State.Frame
  end

  function RowLocked(row)
    local Parent = row.Parent

    while Parent do
      if not Parent.Value then return true end

      Parent = Parent.Parent
    end

    return row.Locked == true
  end

  function DrawSectionTitle(section, x, y, width, clipTop, clipBottom, fade, blocked)
    local Title = SectionTitleHeight(section)
    if Title == 0 then return end

    local Shade = fade * math.min(math.max((y + Title - clipTop) / Title, 0), 1) * math.min(math.max((clipBottom - y) / Title, 0), 1)
    if Shade <= 0.01 then return end

    local Upper = string.upper(section.Name)
    local RuleX = x + 4 + math.min(TextWidth(Upper, Layout.TinySize, BoldFont), width - 40) + 10

    DrawText(Upper, x + 4, y + 2, Theme.Accent, Layout.TinySize, BoldFont, 31, (section.Collapsed and 0.55 or 0.85) * Shade, width - 22)

    if section.Desc then DrawText(section.Desc, x + 4, y + 15, Theme.Text, 10, SystemFont, 31, Alpha.Dim * 0.72 * Shade, width - 22) end

    FadeLine(RuleX, y + 8, (x + width - 6) - RuleX, Theme.Accent, 31, (section.Collapsed and 0.18 or 0.30) * Shade)

    if blocked or not Input.Click then return end
    if not IsMouseIn(x, y, width, Title) then return end

    section.Collapsed = not section.Collapsed
    Input.Click = false
  end

  function DrawSectionCard(section, x, y, width, height, clipTop, clipBottom, fade, blocked)
    if section.Fold > 0.98 then return end

    local Title = SectionTitleHeight(section)
    local CardTop = y + Title
    local CardY = math.max(CardTop, clipTop)
    local CardBottom = math.min(y + height, clipBottom)
    local CardHeight = CardBottom - CardY
    local Hovered = not blocked and IsMouseIn(x, CardY, width, CardHeight) and State.HoverEffects ~= false

    section.Glow = Approach(section.Glow or 0, Hovered and 1 or 0, 6)

    local Halo = section.Glow * fade * State.Glow

    DrawRect(x, CardY, width, CardHeight, Blend(Theme.Text, Theme.Idle, 0.40), 28, Layout.CardRadius, Alpha.Card * 2.1 * fade)

    if not State.Lite then
      DrawStroke(x - 2, CardY - 2, width + 4, CardHeight + 4, Theme.Accent, 32, 7, 0.05 * Halo)
      DrawStroke(x - 1, CardY - 1, width + 2, CardHeight + 2, Theme.Accent, 32, 6, 0.11 * Halo)
    end

    DrawStroke(x, CardY, width, CardHeight, Theme.Accent, 33, Layout.CardRadius, 0.34 * Halo)
  end

  function DrawSectionRows(section, x, y, width, height, clipTop, clipBottom, fade, blocked)
    local CardBottom = math.min(clipBottom, y + height)
    local RowX = x + Layout.CardLeft
    local RowY = y + SectionTitleHeight(section) + Layout.CardTopPad
    local RowWidth = width - Layout.CardInset
    local Gap = State.RowLines and 4 or Layout.RowGap
    local Count = #section.Rows

    for Index, Row in ipairs(section.Rows) do
      local Height = RowSpan(Row)

      if Row == State.SpotJump then
        local Tab = ActiveView()

        local Settled = RowY - (1 - State.ContentFade) * Layout.CascadeDrop

        Tab.WantScroll = math.min(math.max(Tab.WantScroll + Settled - clipTop - Layout.JumpMargin, 0), Tab.MaxScroll)
        State.SpotJump = nil
      end

      if RowY + Height >= clipTop - 2 and RowY <= CardBottom + 2 then
        local Clip = 1

        if RowY < clipTop then Clip = math.min(math.max(1 - (clipTop - RowY) / (Height * 0.5), 0), 1) end
        if RowY + Height > CardBottom then Clip = math.min(Clip, math.min(math.max(1 - (RowY + Height - CardBottom) / (Height * 0.5), 0), 1)) end

        local Shade = (RowLocked(Row) and 0.4 or 1) * fade * Clip

        Interact = Shade > 0.5 and not blocked

        if Row.Tip and Interact and IsMouseIn(RowX, RowY, RowWidth, Height) then WantTooltip(Row.Tip, Input.X, Input.Y) end

        RowDrawer[Row.Kind](Row, RowX, RowY, RowWidth, Shade)

        if (Row.Reveal or 0) > os.clock() then
          local Pulse = 0.35 + 0.5 * math.min(math.max(0.5 + 0.5 * math.sin(os.clock() * 9), 0), 1)

          DrawStroke(RowX - 4, RowY - 4, RowWidth + 8, Height + 8, Theme.Accent, 33, 7, Pulse * Shade)
        end

        if State.RowLines and Index < Count then
          local LineY = RowY + Height + Gap / 2

          if LineY > clipTop and LineY < CardBottom then DrawLine(x + 14, LineY, x + width - 14, LineY, Theme.Text, 31, 1, 0.12 * fade * Clip) end
        end
      end

      RowY = RowY + Height + (Index < Count and Gap or 0)
    end

    Interact = true
  end

  function ContentHeight(tab, height)
    local LeftEnd, RightEnd = 0, 0

    for _, Section in ipairs(tab.Sections) do
      Section.Height = SectionHeight(Section)

      if Section.Side == "Full" then
        LeftEnd = math.max(LeftEnd, RightEnd) + Section.Height + Layout.ColumnGap
        RightEnd = LeftEnd
      elseif Section.Side == "Right" then
        RightEnd = RightEnd + Section.Height + Layout.ColumnGap
      else
        LeftEnd = LeftEnd + Section.Height + Layout.ColumnGap
      end
    end

    local Total = math.max(LeftEnd, RightEnd)

    tab.MaxScroll = math.max(0, Total - height)

    return Total
  end

  function ScrollInput(tab, x, y, width, height, blocked)
    local Reach = tab.MaxScroll

    if Reach > 0 and not blocked and not State.Focus and not State.SpotlightOpen and IsMouseIn(x, y, width, height) then
      local Page = height * 0.8

      if Keys.Up.Click then tab.WantScroll = tab.WantScroll - 60 end
      if Keys.Down.Click then tab.WantScroll = tab.WantScroll + 60 end
      if Keys.PageUp.Click then tab.WantScroll = tab.WantScroll - Page end
      if Keys.PageDown.Click then tab.WantScroll = tab.WantScroll + Page end
    end

    tab.WantScroll = math.min(math.max(tab.WantScroll, 0), Reach)
    tab.Scroll = Approach(tab.Scroll, tab.WantScroll, 15)

    if math.abs(tab.Scroll - tab.WantScroll) < 0.1 then tab.Scroll = tab.WantScroll end
  end

  function DrawScrollBar(tab, x, y, width, height, total, fade)
    local TrackX = x + width + 4
    local BarHeight = math.max(34, (height / total) * height)
    local Fraction = tab.Scroll / tab.MaxScroll
    local BarY = y + Fraction * (height - BarHeight)
    local Dragging = State.BarDrag and State.BarDrag.Tab == tab
    local Hovered = IsMouseIn(TrackX - 7, BarY, 18, BarHeight) or Dragging
    local Want = Hovered and 1 or math.min(math.max(math.abs(tab.WantScroll - tab.Scroll) / 30, 0), 1)
    local Glow = Settle(tab.BarGlow or 0, Want, 12, Layout.NavRest)
    local BarColor = Blend(Theme.AccentA, Theme.AccentB, Fraction)
    local BarWidth = 4.5 + Glow
    local BarX = TrackX + 2 - BarWidth / 2

    tab.BarGlow = Glow

    DrawRect(TrackX + 0.5, y, 3, height, Theme.Text, 34, 1.5, (0.05 + 0.05 * Glow) * fade)
    DrawRect(BarX - 2, BarY - 3, BarWidth + 4, BarHeight + 6, BarColor, 35, (BarWidth + 4) / 2, 0.16 * Glow * fade)
    DrawRect(BarX, BarY, BarWidth, BarHeight, BarColor, 36, BarWidth / 2, (0.55 + 0.45 * Glow) * fade)

    if Input.Click and IsMouseIn(TrackX - 7, y, 18, height) then
      State.BarDrag = { Tab = tab, Grab = IsMouseIn(TrackX - 7, BarY, 18, BarHeight) and (Input.Y - BarY) or (BarHeight / 2) }
      Input.Click = false
    end

    if not (Input.Down and Dragging) then return end

    tab.WantScroll = math.min(math.max((Input.Y - y - State.BarDrag.Grab) / math.max(1, height - BarHeight), 0), 1) * tab.MaxScroll
  end

  function DragBody(tab, x, y, width, height, blocked)
    if tab.MaxScroll > 0 and Input.Click and not blocked and not State.BarDrag and IsMouseIn(x, y, width, height) then
      State.Panning = { Tab = tab, Y = Input.Y, From = tab.WantScroll }
      tab.Fling = 0
      Input.Click = false
    end

    local Drag = State.Panning

    if Input.Down and Drag and Drag.Tab == tab then
      local Want = math.min(math.max(Drag.From - (Input.Y - Drag.Y), 0), tab.MaxScroll)

      tab.Fling = (tab.Fling or 0) * 0.72 + ((Want - tab.WantScroll) / State.Delta) * 0.28
      tab.WantScroll = Want

      return
    end

    if (tab.Fling or 0) == 0 or State.BarDrag then return end

    tab.WantScroll = math.min(math.max(tab.WantScroll + tab.Fling * State.Delta, 0), tab.MaxScroll)
    tab.Fling = tab.Fling * math.exp(-5 * State.Delta)

    if math.abs(tab.Fling) < 4 or tab.WantScroll <= 0 or tab.WantScroll >= tab.MaxScroll then tab.Fling = 0 end
  end
end

local function DrawSections(rail)
  local Tab = ActiveView()
  if not Tab then return end

  local Blocked = State.Dropdown ~= nil or State.Picker ~= nil or State.Menu ~= nil or State.Dialog ~= nil
  local Wide = State.TabLayout == "top"
  local Left = Wide and (State.X + 14) or (State.X + rail + Layout.ContentPad)
  local Width = Wide and (State.W - 34) or (State.W - rail - Layout.ContentPad * 2 - Layout.ScrollGutter)
  local ColumnWidth = math.floor((Width - Layout.ColumnGap) / 2)
  local Top = Wide and (State.Y + Layout.TitleHeight + Layout.TopbarHeight + 8) or (State.Y + Layout.TopbarHeight + Layout.ContentTop)
  local Height = State.Y + State.H - Top - Layout.ContentBottom
  local Total = ContentHeight(Tab, Height)

  ScrollInput(Tab, Left, Top, Width, Height, Blocked)

  local StartY = Top - Tab.Scroll + (1 - State.ContentFade) * 12
  local Bottom = Top + Height
  local ColumnY = { StartY, StartY }

  for Index, Section in ipairs(Tab.Sections) do
    local Stagger = math.min(Index - 1, 6) * Layout.CascadeStep
    local Fade = math.min(math.max((State.ContentFade - Stagger) / (1 - Stagger), 0), 1)
    local Column = Section.Side == "Right" and 2 or 1
    local CardX = Left + (Column - 1) * (ColumnWidth + Layout.ColumnGap)
    local CardY = ColumnY[Column]

    if Section.Side == "Full" then
      CardX, CardY = Left, math.max(ColumnY[1], ColumnY[2])
      ColumnY[1] = CardY + Section.Height + Layout.ColumnGap
      ColumnY[2] = ColumnY[1]
    else
      ColumnY[Column] = CardY + Section.Height + Layout.ColumnGap
    end

    local CardWidth = Section.Side == "Full" and Width or ColumnWidth

    DrawSectionTitle(Section, CardX, CardY, CardWidth, Top, Bottom, Fade, Blocked)
    DrawSectionCard(Section, CardX, CardY, CardWidth, Section.Height, Top, Bottom, Fade, Blocked)

    if Section.Fold <= 0.98 then DrawSectionRows(Section, CardX, CardY, CardWidth, Section.Height, Top, Bottom, Fade, Blocked) end
  end

  if Tab.MaxScroll > 0 then
    DrawScrollBar(Tab, Left, Top, Width, Height, Total, State.ContentFade)
  elseif State.BarDrag and State.BarDrag.Tab == Tab then
    State.BarDrag = nil
  end

  DragBody(Tab, Left, Top, Width, Height, Blocked)
end

local function DrawGrip()
  local Right = State.X + State.W - 5
  local Bottom = State.Y + State.H - 5

  DrawLine(State.X + State.W - 14, Bottom, Right, State.Y + State.H - 14, Theme.Text, 13, 1, Alpha.Dim)
  DrawLine(State.X + State.W - 11, Bottom, Right, State.Y + State.H - 11, Theme.Text, 13, 1, Alpha.Dim)
  DrawLine(State.X + State.W - 8, Bottom, Right, State.Y + State.H - 8, Theme.Text, 13, 1, Alpha.Dim)

  if Input.Click and IsMouseIn(State.X + State.W - 22, State.Y + State.H - 22, 24, 24) then
    State.Resize = { W = State.W, H = State.H, X = Input.X, Y = Input.Y }
  end

  if not State.Resize then return end

  State.W = math.max(Layout.MinWidth, State.Resize.W + (Input.X - State.Resize.X))
  State.H = math.max(Layout.MinHeight, State.Resize.H + (Input.Y - State.Resize.Y))
end

local DrawKeyMenu

do
  local KeyMenu = { "Hold", "Toggle", "Always" }

  function DrawKeyMenu()
    local Menu = State.Menu
    if not Menu then return end

    Menu.Anim = Approach(Menu.Anim or 0, 1, Layout.MenuSpeed)

    local Fade = Menu.Anim
    local Width = Layout.MenuWidth
    local Height = #KeyMenu * Layout.MenuRow + Layout.MenuPad
    local Viewport = Camera.ViewportSize
    local MaxX = math.max(Layout.MenuMargin, Viewport.X - Width - Layout.MenuMargin)
    local MaxY = math.max(Layout.MenuMargin, Viewport.Y - Height - Layout.MenuMargin)
    local X = math.min(math.max(Menu.X, Layout.MenuMargin), MaxX)
    local Y = math.min(math.max(Menu.Y, Layout.MenuMargin), MaxY) - (1 - Fade) * Layout.MenuRise
    local ItemX = X + Layout.MenuInset
    local ItemWidth = Width - Layout.MenuInset * 2
    local ItemHeight = Layout.MenuRow - Layout.MenuTrim
    local Room = Width - Layout.MenuTextRoom

    DrawRect(X, Y, Width, Height, Theme.Background, 250, Layout.MenuRadius, Alpha.Menu * Fade)
    DrawStroke(X, Y, Width, Height, Theme.Text, 251, Layout.MenuRadius, Alpha.CardStroke * Fade)

    for Index, Mode in ipairs(KeyMenu) do
      local RowY = Y + Layout.MenuInset + (Index - 1) * Layout.MenuRow
      local Selected = Menu.Row.Mode == Mode
      local Hovered = IsMouseIn(ItemX, RowY, ItemWidth, ItemHeight)
      local FillAlpha = (Selected and Alpha.MenuSelect or (Hovered and Alpha.MenuHover or 0)) * Fade
      local TextAlpha = (Selected and Alpha.Text or Alpha.Label) * Fade

      DrawRect(ItemX, RowY, ItemWidth, ItemHeight, Theme.Text, 252, Layout.MenuItemRadius, FillAlpha)
      DrawText(Mode, X + Layout.MenuTextPad, TextTop(RowY, ItemHeight, Layout.TextSize), Theme.Text, Layout.TextSize, SystemFont, 253, TextAlpha, Room)

      if Input.Click and Hovered then
        Menu.Row.Mode = Mode
        State.Menu = nil
        Input.Click = false
      end
    end

    if not Input.Click then return end
    if IsMouseIn(X - Layout.MenuEdge, Y - Layout.MenuEdge, Width + Layout.MenuEdge * 2, Height + Layout.MenuEdge * 2) then return end

    State.Menu = nil
    Input.Click = false
  end
end

local DrawNotifications

do
  local NoteTint = {
    success = Color3.fromRGB(95, 210, 135),
    warning = Color3.fromRGB(255, 190, 70),
    error = Color3.fromRGB(250, 93, 86),
  }

  local function DrawNote(note, stackY)
    local Viewport = Camera.ViewportSize
    local Room = Layout.NoteWidth - Layout.NoteBodyRoom
    local Lines = WrapText(note.Body, Room, Layout.SmallSize, SystemFont)
    local Count = math.min(#Lines, Layout.NoteLines)
    local Height = Layout.NoteTopPad + Count * Layout.NoteLine + Layout.NoteBottomPad
    local TargetX = Viewport.X - Layout.NoteWidth - Layout.NoteMargin
    local TargetY = stackY - Height

    note.X = Approach(note.X or Viewport.X, TargetX, Layout.NoteSlide)
    note.Y = Approach(note.Y or TargetY, TargetY, Layout.NoteSlide)

    local NoteX, NoteY = note.X, note.Y
    local Remaining = note.Duration - note.Elapsed
    local FadeIn = note.Elapsed / Layout.NoteFadeIn
    local FadeOut = Remaining / Layout.NoteFadeOut
    local Fade = FadeIn < 1 and FadeIn or math.min(1, FadeOut)
    local Kind = note.Kind or (note.Title == "error" and "error")
    local Tint = NoteTint[Kind] or Blend(Theme.AccentA, Theme.AccentB, Layout.ShimmerMix)
    local TitleColor = Kind and Tint or Theme.Text
    local TitleAlpha = (Kind and 1 or Alpha.Text) * Fade
    local TitleRoom = Layout.NoteWidth - Layout.NoteTitleRoom
    local BodyAlpha = Alpha.Label * Fade
    local TrackX = NoteX + Layout.NoteTextX
    local TrackY = NoteY + Height - Layout.NoteTrackLift
    local TrackWidth = Layout.NoteWidth - Layout.NoteTrackRoom
    local Fraction = math.min(math.max(1 - note.Elapsed / note.Duration, 0), 1)
    local BarWidth = TrackWidth * Fraction
    local BarShown = math.max(1, BarWidth)
    local BarAlpha = Alpha.NoteBar * Fade * math.min(math.max(BarWidth, 0), 1)

    DrawRect(NoteX + Layout.NoteShadowX, NoteY + Layout.NoteShadowY, Layout.NoteWidth, Height, Black, 299, Layout.NoteRadius, Alpha.NoteShadow * Fade)
    DrawRect(NoteX, NoteY, Layout.NoteWidth, Height, Theme.Background, 300, Layout.NoteRadius, Alpha.NoteFill * Fade)
    DrawStroke(NoteX, NoteY, Layout.NoteWidth, Height, Theme.Text, 301, Layout.NoteRadius, Alpha.Hairline * Fade)
    DrawCircle(NoteX + Layout.NoteDotX, NoteY + Layout.NoteDotY, Layout.NoteDot, Tint, 302, true, 1, 16, Fade)
    DrawText(note.Title, NoteX + Layout.NoteTextX, NoteY + Layout.NoteTitleY, TitleColor, Layout.TextSize, BoldFont, 302, TitleAlpha, TitleRoom)

    for Index = 1, Count do DrawText(Lines[Index], NoteX + Layout.NoteTextX, NoteY + Layout.NoteBodyY + (Index - 1) * Layout.NoteLine, Theme.Text, Layout.SmallSize, SystemFont, 302, BodyAlpha, Room) end

    DrawRect(TrackX, TrackY, TrackWidth, Layout.NoteBarHeight, Theme.Text, 302, Layout.NoteBarRadius, Alpha.NoteTrack * Fade)

    if Kind then
      DrawRect(TrackX, TrackY, BarShown, Layout.NoteBarHeight, Tint, 303, Layout.NoteBarRadius, BarAlpha)
    else
      GradientRect(TrackX, TrackY, BarShown, Layout.NoteBarHeight, Theme.AccentA, Theme.AccentB, 303, BarAlpha)
    end

    return TargetY - Layout.NoteGap
  end

  function DrawNotifications()
    local Notes = State.Notes
    local StackY = Camera.ViewportSize.Y - Layout.NoteMargin
    local Index = 1

    while #Notes > Layout.NoteMax do table.remove(Notes, 1) end

    while Index <= #Notes do
      local Note = Notes[Index]

      Note.Elapsed = Note.Elapsed + State.Delta

      if Note.Elapsed >= Note.Duration then
        table.remove(Notes, Index)
      else
        StackY = DrawNote(Note, StackY)
        Index = Index + 1
      end
    end
  end
end

local function DrawTooltip()
  local Tip = State.Tip
  if not Tip then return end
  if Tip.Frame ~= State.Frame then Tip.Text = "" end
  if Tip.Text == "" then return end
  if os.clock() - Tip.At < Layout.TipDelay then return end

  if Tip.Source ~= Tip.Text then Tip.Source, Tip.Lines = Tip.Text, WrapText(Tip.Text, Layout.TipWrap, Layout.SmallSize, UiFont) end

  local Lines = Tip.Lines
  local Widest = 0

  for Index = 1, #Lines do Widest = math.max(Widest, TextWidth(Lines[Index], Layout.SmallSize, UiFont)) end

  local View = Camera.ViewportSize
  local Width = math.floor(Widest * Layout.TipStretch) + Layout.TipPad
  local Height = Layout.TipTopPad + Layout.TipLine * #Lines
  local BoxX = math.min(math.max(Tip.X + Layout.TipOffsetX, Layout.TipMargin), View.X - Width - Layout.TipMargin)
  local BoxY = math.min(math.max(Tip.Y + Layout.TipOffsetY, Layout.TipMargin), View.Y - Height - Layout.TipBottom)
  local TextX = BoxX + Layout.TipInset
  local TextY = BoxY + Layout.TipTextTop

  DrawRect(BoxX, BoxY, Width, Height, Theme.Background, 320, Layout.TipRadius, Alpha.TipFill)
  DrawStroke(BoxX, BoxY, Width, Height, Theme.Text, 321, Layout.TipRadius, Alpha.CardStroke)

  for Index = 1, #Lines do DrawText(Lines[Index], TextX, TextY + (Index - 1) * Layout.TipLine, Theme.Text, Layout.SmallSize, UiFont, 322, Alpha.Text) end
end

local function DrawDialog()
  local Dialog = State.Dialog

  State.DialogFade = Approach(State.DialogFade or 0, Dialog and 1 or 0, Layout.DialogSpeed)

  local Fade = State.DialogFade
  if Fade < Layout.DialogHide then return end

  local View = Camera.ViewportSize

  DrawRect(0, 0, View.X, View.Y, Black, 450, 0, Alpha.DialogVeil * Fade)

  if not Dialog then return end

  local Room = Layout.DialogWidth - Layout.DialogInset * 2
  local Lines = WrapText(Dialog.Text, Room, Layout.TextSize, SystemFont)
  local Height = Layout.DialogBase + #Lines * Layout.DialogLine
  local BoxX = math.floor(View.X / 2 - Layout.DialogWidth / 2)
  local BoxY = math.floor(View.Y / 2 - Height / 2) - math.floor((1 - Fade) * Layout.DialogLift)
  local Accent = Blend(Theme.AccentA, Theme.AccentB, Layout.ShimmerMix)
  local TextX = BoxX + Layout.DialogInset
  local TitleY = BoxY + Layout.DialogTitleTop
  local BodyY = BoxY + Layout.DialogTextTop
  local ButtonY = BoxY + Height - Layout.DialogButton - Layout.DialogButtonPad
  local ButtonWidth = (Room - Layout.DialogGap) / 2
  local ButtonTextY = ButtonY + Layout.DialogButton / 2
  local CancelX = TextX
  local ConfirmX = CancelX + ButtonWidth + Layout.DialogGap
  local CancelHover = IsMouseIn(CancelX, ButtonY, ButtonWidth, Layout.DialogButton)
  local ConfirmHover = IsMouseIn(ConfirmX, ButtonY, ButtonWidth, Layout.DialogButton)
  local Outside = not IsMouseIn(BoxX, BoxY, Layout.DialogWidth, Height)
  local CancelEdge = (CancelHover and Alpha.DialogHover or Alpha.Hairline) * Fade
  local CancelLabel = (CancelHover and Alpha.Text or Alpha.Dim) * Fade
  local ConfirmFill = (ConfirmHover and Alpha.DialogFillHover or Alpha.DialogFillIdle) * Fade
  local ConfirmEdge = (ConfirmHover and Alpha.DialogEdgeHover or Alpha.DialogEdgeIdle) * Fade
  local Clicked = Input.Click

  DrawRect(BoxX + Layout.DialogShadowX, BoxY + Layout.DialogShadowY, Layout.DialogWidth, Height, Black, 451, Layout.DialogRadius, Alpha.DialogShadow * Fade)
  DrawRect(BoxX, BoxY, Layout.DialogWidth, Height, Theme.Background, 452, Layout.DialogRadius, Alpha.DialogFill * Fade)
  DrawStroke(BoxX - Layout.DialogHaloOut, BoxY - Layout.DialogHaloOut, Layout.DialogWidth + Layout.DialogHaloOut * 2, Height + Layout.DialogHaloOut * 2, Accent, 453, Layout.DialogHaloRadius, Alpha.DialogHalo * Fade)
  DrawStroke(BoxX, BoxY, Layout.DialogWidth, Height, Theme.Text, 453, Layout.DialogRadius, Alpha.DialogEdge * Fade)
  DrawText(Dialog.Title, TextX, TitleY, Accent, Layout.DialogTitle, BoldFont, 454, Fade, Room)

  for Index = 1, #Lines do DrawText(Lines[Index], TextX, BodyY + (Index - 1) * Layout.DialogLine, Theme.Text, Layout.TextSize, SystemFont, 454, Alpha.Label * Fade, Room) end

  DrawStroke(CancelX, ButtonY, ButtonWidth, Layout.DialogButton, Theme.Text, 454, Layout.DialogButtonRadius, CancelEdge)
  DrawTextMid(Dialog.Cancel, CancelX + ButtonWidth / 2, ButtonTextY, Theme.Text, Layout.TextSize, BoldFont, 455, CancelLabel)
  DrawRect(ConfirmX, ButtonY, ButtonWidth, Layout.DialogButton, Accent, 454, Layout.DialogButtonRadius, ConfirmFill)
  DrawStroke(ConfirmX, ButtonY, ButtonWidth, Layout.DialogButton, Accent, 455, Layout.DialogButtonRadius, ConfirmEdge)
  DrawTextMid(Dialog.Confirm, ConfirmX + ButtonWidth / 2, ButtonTextY, Accent, Layout.TextSize, BoldFont, 455, Fade)

  Input.Click = false

  if Fade <= Layout.DialogLive then return end

  if Keys.Escape.Click then
    State.Dialog = nil
    Keys.Escape.Click = false
    Dialog.OnCancel()
    return
  end

  if not Clicked then return end

  if ConfirmHover then
    State.Dialog = nil
    Dialog.OnConfirm()
    return
  end

  if not CancelHover and not Outside then return end

  State.Dialog = nil
  Dialog.OnCancel()
end

local function SplitCombo(value)
  local Mod, Key = string.match(string.lower(value), "^(%w+)%+(.+)$")

  if Mod then return Keys[Mod], Keys[Key] end

  return nil, Keys[string.lower(value)]
end

local function RunKeybinds()
  if State.Focus or State.Capture then return end

  for _, Tab in ipairs(State.Tabs) do
    for _, Section in ipairs(Tab.Sections) do
      for _, Row in ipairs(Section.Rows) do
        local Bind = Row.Bind

        if Bind and Bind.Value ~= "" and Bind.Value ~= "none" and not Bind.Listening and not RowLocked(Row) then
          local Mod, Key = SplitCombo(Bind.Value)
          local Mode = Bind.Mode or "Hold"
          local Live = not Mod or Mod.Held
          local Active = Bind.Callback and Bind.Active or Row.Value

          if not Key then
          elseif not Live then
          elseif Mode == "Always" then
            Active = true
          elseif Mode == "Toggle" then
            if Key.Click then Active = not Active end
          else
            Active = Key.Held
          end

          if Bind.Callback and Active ~= Bind.Active then
            Bind.Active = Active
            Bind.Callback(Active)
          elseif not Bind.Callback and Active ~= Row.Value then
            Row.Value = Active
            Row.Callback(Active)
          end
        end
      end
    end
  end
end

local FontList = {
  { Name = "Default", Font = SystemFont },
  { Name = "Bold", Font = BoldFont },
  { Name = "Proggy", Font = UiFont },
  { Name = "Minecraft", Font = MinecraftFont },
  { Name = "JetBrains", Font = MonoFont },
  { Name = "Pixel", Font = PixelFont },
  { Name = "Fortnite", Font = FortniteFont },
}

local function FontByName(name)
  for Index = 1, #FontList do
    local Choice = FontList[Index]

    if Choice.Name == name or Choice.Font == name then return Choice.Font end
  end

  return FontList[1].Font
end

local StripGlyphs, PlaceName, SafeFolder, ConfigDir

do
  function StripGlyphs(text)
    local Clean = tostring(text or "")

    Clean = string.gsub(Clean, "[\240-\244][\128-\191]*", "")
    Clean = string.gsub(Clean, "\226[\134-\191][\128-\191]", "")
    Clean = string.gsub(Clean, "\226\128[\139-\143]", "")
    Clean = string.gsub(Clean, "^%s+", "")

    return (string.gsub(Clean, "%s+$", ""))
  end

  function PlaceName()
    local Name = StripGlyphs(getgamename())

    if Name ~= "" then return Name end

    Name = StripGlyphs(game.Name)

    if Name == "Game" or Name == "Ugc" then return "" end

    return Name
  end

  function SafeFolder(name)
    return (tostring(name):gsub("[^%w%-_ ]", ""):gsub("^%s+", ""):gsub("%s+$", ""))
  end

  function ConfigDir()
    return State.Folder
  end
end

local function EnsureFolder()
  local Dir = ConfigDir()

  if not isfolder(Dir) then makefolder(Dir) end
end

local function RowPath(tab, section, row)
  if type(row.Name) ~= "string" then return "" end

  return tab.Name .. "." .. section.Name .. "." .. row.Name
end

local function EachRow(visit)
  for _, Tab in ipairs(State.Tabs) do
    for _, Section in ipairs(Tab.Sections) do
      for _, Row in ipairs(Section.Rows) do visit(Tab, Section, Row) end
    end

    for _, Sub in ipairs(Tab.Subs) do
      for _, Section in ipairs(Sub.Sections) do
        for _, Row in ipairs(Section.Rows) do visit(Sub, Section, Row) end
      end
    end
  end
end

local PackConfig, ApplyConfig

local ConfigPath, ReadAutoload, WriteAutoload, ReadAutoSave, WriteAutoSave

do
  function ConfigPath(name)
    return ConfigDir() .. "/" .. name .. ".json"
  end

  local function AutoloadFile()
    return ConfigDir() .. "/_autoload.json"
  end

  local function ReadAutoloadTable()
    local Path = AutoloadFile()
    if not isfile(Path) then return nil end
    local ok, Decoded = pcall(function() return HttpService:JSONDecode(readfile(Path)) end)
if not ok or type(Decoded) ~= "table" then return nil end
    return Decoded
  end

  function ReadAutoload()
    local Saved = ReadAutoloadTable()
    if not Saved then return nil end

    local Name = Saved.autoload
    if type(Name) ~= "string" or Name == "" then Name = Saved[State.ConfigName] end
    if type(Name) ~= "string" or Name == "" then return nil end

    return Name
  end

  function WriteAutoload(name)
    local Path = AutoloadFile()
    local Saved = ReadAutoloadTable() or {}

    Saved.autoload = name
    Saved[State.ConfigName] = name
    EnsureFolder()
    pcall(function() writefile(Path, HttpService:JSONEncode(Saved)) end)
end

  local function AutoSaveFile()
    return ConfigDir() .. "/_autosave.json"
  end

  function ReadAutoSave()
    local Path = AutoSaveFile()
    if not isfile(Path) then return nil end

    local Saved = HttpService:JSONDecode(readfile(Path))

    return Saved and Saved[State.ConfigName]
  end

  function WriteAutoSave(on)
    local Path = AutoSaveFile()
    local Saved = isfile(Path) and HttpService:JSONDecode(readfile(Path)) or {}

    Saved[State.ConfigName] = on
    EnsureFolder()
    writefile(Path, HttpService:JSONEncode(Saved))
  end
end

local ThemePresets = {
  Indigo = { Color3.fromRGB(122, 134, 255), Color3.fromRGB(189, 130, 255) },
  NeverBlox = { Color3.fromRGB(82, 122, 246), Color3.fromRGB(120, 150, 255) },
  Lemon = { Color3.fromRGB(252, 211, 49), Color3.fromRGB(240, 165, 25) },
  Mono = { White, White },
  Sunset = { Color3.fromRGB(255, 150, 90), Color3.fromRGB(255, 90, 140) },
  Mint = { Color3.fromRGB(110, 230, 180), Color3.fromRGB(90, 200, 255) },
  Rose = { Color3.fromRGB(255, 120, 160), Color3.fromRGB(200, 120, 255) },
  Gold = { Color3.fromRGB(255, 210, 120), Color3.fromRGB(255, 150, 80) },
  Crimson = { Color3.fromRGB(255, 100, 100), Color3.fromRGB(255, 60, 140) },
  Ocean = { Color3.fromRGB(90, 200, 255), Color3.fromRGB(120, 140, 255) },
  Toxic = { Color3.fromRGB(150, 255, 120), Color3.fromRGB(60, 220, 160) },
  Lavender = { Color3.fromRGB(180, 160, 255), Color3.fromRGB(220, 160, 255) },
  Aqua = { Color3.fromRGB(80, 230, 230), Color3.fromRGB(80, 180, 255) },
  Ember = { Color3.fromRGB(255, 120, 60), Color3.fromRGB(255, 70, 70) },
  Cyber = { Color3.fromRGB(0, 255, 200), Color3.fromRGB(120, 100, 255) },
  Bubblegum = { Color3.fromRGB(255, 140, 220), Color3.fromRGB(150, 180, 255) },
  Forest = { Color3.fromRGB(120, 220, 120), Color3.fromRGB(180, 230, 90) },
  Slate = { Color3.fromRGB(150, 170, 200), Color3.fromRGB(110, 130, 170) },
  Cherry = { Color3.fromRGB(255, 90, 120), Color3.fromRGB(255, 150, 110) },
  Aurora = { Color3.fromRGB(120, 255, 200), Color3.fromRGB(160, 140, 255) },
  Sky = { Color3.fromRGB(120, 200, 255), Color3.fromRGB(180, 210, 255) },
  Magma = { Color3.fromRGB(255, 80, 40), Color3.fromRGB(255, 180, 40) },
  Grape = { Color3.fromRGB(170, 110, 255), Color3.fromRGB(255, 110, 200) },
  Steel = { Color3.fromRGB(120, 200, 220), Color3.fromRGB(150, 160, 200) },
  Peach = { Color3.fromRGB(255, 180, 150), Color3.fromRGB(255, 130, 160) },
  Neon = { Color3.fromRGB(0, 240, 255), Color3.fromRGB(180, 0, 255) },
  Waifu = { Color3.fromRGB(150, 205, 120), Color3.fromRGB(195, 230, 130) },
}

local PresetBackground = {
  Waifu = Color3.fromRGB(15, 19, 13),
  NeverBlox = Color3.fromRGB(15, 16, 21),
  Lemon = Color3.fromRGB(18, 17, 13),
}

local DefaultBackground = Color3.fromRGB(15, 15, 15)

local InsUi = {}
local Window
local ApplyOptions
local WindowClass = {}
local TabClass = {}
local SectionClass = {}

WindowClass.__index = WindowClass
TabClass.__index = TabClass
SectionClass.__index = SectionClass

setmetatable(WindowClass, { __index = InsUi })

function InsUi:CreateWindow(config)
  local Title = StripGlyphs(config.title)

  State.Title = Title ~= "" and Title or "INSUI"
  State.Subtitle = config.subtitle == "auto" and "" or StripGlyphs(config.subtitle)

  if config.subtitle == "auto" then task.spawn(function() State.Subtitle = PlaceName() end) end

  State.ConfigName = config.configName or State.ConfigName
  State.Folder = config.configFolder and SafeFolder(config.configFolder) or (LibName .. "_" .. SafeFolder(State.Title))
  State.W = config.size and config.size.X or Layout.WindowSize.X
  State.H = config.size and config.size.Y or Layout.WindowSize.Y
  State.X = config.position and config.position.X or math.floor(Camera.ViewportSize.X / 2 - State.W / 2)
  State.Y = config.position and config.position.Y or math.floor(Camera.ViewportSize.Y / 2 - State.H / 2)

  ApplyOptions(config)
  task.spawn(function() State.Avatar = FetchAvatar() end)
State.Open = config.startOpen ~= false

  ApplyInputState(true)

  Window = setmetatable({}, WindowClass)

  task.spawn(function()
    task.wait()

    local okWant, Wanted = pcall(ReadAutoload)
    if not okWant or not Wanted then return end

    local Loaded = false
    local okFile, Exists = pcall(function() return isfile(ConfigPath(tostring(Wanted))) end)
if okFile then Loaded = Exists == true end

    if Loaded then
      pcall(function() InsUi:LoadConfig(Wanted) end)
pcall(function() InsUi:Notify("config", "auto-loaded: " .. tostring(Wanted), 4, "success") end)
else

      pcall(function() InsUi:Notify("config", "auto-load: " .. tostring(Wanted) .. " not found", 4, "warning") end)
pcall(function() WriteAutoload(nil) end)
end
  end)
return Window
end

function InsUi:Tab(name, icon)
  return Window:Tab(name, icon)
end

function InsUi:Category(name)
  State.Heading = name
  return self
end

function WindowClass:Tab(name, icon)
  local Tab = setmetatable({ Name = name, Icon = icon, Category = State.Heading, Sections = {}, Subs = {}, Scroll = 0, WantScroll = 0, MaxScroll = 0, Fling = 0 }, TabClass)

  table.insert(State.Tabs, Tab)

  local Active = State.Tabs[State.ActiveIndex]

  if not Active or Active.Hidden then State.ActiveIndex = #State.Tabs end

  return Tab
end

function TabClass:Sub(name, icon)
  local Sub = setmetatable({ Name = name, Icon = icon, Parent = self, Sections = {}, Subs = {}, Scroll = 0, WantScroll = 0, MaxScroll = 0, Fling = 0 }, TabClass)

  table.insert(self.Subs, Sub)

  return Sub
end

function TabClass:Section(name, side, desc)
  local Section = setmetatable({ Name = name, Side = side or "Left", Desc = desc, Rows = {} }, SectionClass)

  table.insert(self.Sections, Section)

  return Section
end

function WindowClass:AddSettingsTab(icon)
  if SettingsTab then return SettingsTab end

  local Wanted = State.ActiveIndex

  State.SettingsIcon = icon or "cog"

  SettingsTab = BuildSettingsTab(self, icon)
  State.ActiveIndex = Wanted
  State.SettingsIndex = #State.Tabs
  State.Tabs[#State.Tabs].Hidden = true

  return SettingsTab
end

function WindowClass:GetSettingsTab()
  return SettingsTab
end

function WindowClass:SettingsSection(name, side, desc)
  return self:AddSettingsTab():Section(name, side or "Right", desc)
end

function SectionClass:Paragraph(title, body)
  return AddRow(self, { Kind = "Info", Name = title .. Newline .. tostring(body or "") })
end

function SectionClass:Progressbar(name, value)
  return AddRow(self, { Kind = "Progress", Name = name, Value = value or 0, Callback = function() end })
end

function SectionClass:Space(height)
  return AddRow(self, { Kind = "Space", Height = height or 10 })
end

function SectionClass:Checkbox(name, default, callback)
  return self:Toggle(name, default, callback)
end

local RowClass = {}
RowClass.__index = RowClass

function RowClass:Tooltip(text)
  self.Tip = tostring(text)

  return self
end

function RowClass:Set(value)
  self.Value = value
  self.Callback(value)
  return self
end

function RowClass:Get()
  return self.Value
end

function RowClass:SetText(text)
  self.Name = tostring(text)
  return self
end

function RowClass:AddKeybind(key, mode, callback)
  self.Bind = { Value = KeyName.Plain(key), Mode = mode or "Hold", Active = false, Glow = 0, Callback = callback }

  return self
end

function RowClass:AddColorpicker(name, default, callback, alpha)
  self.Swatch = { Name = name, Value = default, Alpha = alpha or 1, Callback = callback or function() end }

  return self
end

function RowClass:AddButton(name, callback)
  if not self.Buttons then self.Buttons = { { Name = self.Name, Callback = self.Callback, Glow = 0 } } end

  table.insert(self.Buttons, { Name = name, Callback = callback or function() end, Glow = 0 })

  return self
end

function RowClass:DependsOn(parent)
  self.Parent = parent

  return self
end

function RowClass:SetRisk(risk)
  self.Risk = risk ~= false

  return self
end

function RowClass:SetVisible(visible)
  self.Hidden = visible == false

  return self
end

function RowClass:SetLocked(locked)
  self.Locked = locked == true

  return self
end

function RowClass:UpdateChoices(choices)
  self.Choices = choices

  return self
end

function RowClass:AddChoice(choice)
  for _, Have in ipairs(self.Choices) do
    if Have == choice then return self end
  end

  table.insert(self.Choices, choice)

  return self
end

function RowClass:RemoveChoice(choice)
  for Index = #self.Choices, 1, -1 do
    if self.Choices[Index] == choice then table.remove(self.Choices, Index) end
  end

  for Index = #self.Value, 1, -1 do
    if self.Value[Index] == choice then table.remove(self.Value, Index) end
  end

  return self
end

function RowClass:ClearChoices()
  self.Choices = {}
  self.Value = {}

  return self
end

function RowClass:SetSearchable(searchable)
  self.Searchable = searchable == true

  return self
end

function RowClass:SetMaxSelections(count)
  self.MaxSelections = count

  return self
end

function RowClass:SetRefresh(provider)
  self.Provider = provider

  return self
end

function RowClass:Refresh(choices)
  if choices then return self:UpdateChoices(choices) end
  if not self.Provider then return self end

  return self:UpdateChoices(self.Provider())
end

function RowClass:IsActivated()
  if self.Bind then return self.Bind.Active end

  return self.Value == true
end

function RowClass:Reset()
  if self.Default == nil then return self end

  self.Value = self.Default
  self.Callback(self.Value)

  return self
end

function RowClass:SetColor(color)
  self.Color = color

  return self
end

local function AddRow(section, row)
  table.insert(section.Rows, setmetatable(row, RowClass))

  return section.Rows[#section.Rows]
end

function SectionClass:Toggle(name, default, callback, tooltip)
  local Row = { Kind = "Toggle", Name = name, Value = default == true, Tip = tooltip, Callback = callback or function() end }

  return AddRow(self, Row)
end

function SectionClass:Slider(name, default, step, minimum, maximum, suffix, callback, tooltip)
  local Row = { Kind = "Slider", Name = name, Value = default, Step = step, Min = minimum, Max = maximum, Suffix = suffix or "", Tip = tooltip, Callback = callback or function() end }

  return AddRow(self, Row)
end

function SectionClass:Button(name, callback, tooltip)
  local Row = { Kind = "Button", Name = name, Tip = tooltip, Callback = callback or function() end }

  return AddRow(self, Row)
end

function SectionClass:Dropdown(name, default, choices, multi, callback, tooltip, searchable, maxSelections)
  local Provider = type(choices) == "function" and choices or nil
  local List = Provider and Provider() or choices
  local Row = { Kind = "Dropdown", Name = name, Value = default or {}, Choices = CopyList(List), Provider = Provider, Multi = multi == true, Tip = tooltip, Searchable = searchable == true, MaxSelections = maxSelections, Callback = callback or function() end }

  return AddRow(self, Row)
end

function SectionClass:Colorpicker(name, default, callback, alpha)
  local Row = { Kind = "Color", Name = name, Value = default, Alpha = alpha or 1, Callback = callback or function() end }

  return AddRow(self, Row)
end

function SectionClass:Keybind(name, default, callback, tooltip)
  local Row = { Kind = "Keybind", Name = name, Value = KeyName.Plain(default), Mode = "Hold", Active = false, Tip = tooltip, Callback = callback or function() end }

  return AddRow(self, Row)
end

function SectionClass:RangeSlider(name, low, high, step, minimum, maximum, suffix, callback, tooltip)
  local Row = { Kind = "Range", Name = name, Low = low, High = high, Step = step, Min = minimum, Max = maximum, Suffix = suffix or "", Tip = tooltip, Callback = callback or function() end }

  return AddRow(self, Row)
end

function SectionClass:Label(text)
  local Row = { Kind = "Label", Name = type(text) == "function" and text() or text, Source = type(text) == "function" and text or nil }

  return AddRow(self, Row)
end

function SectionClass:Info(text)
  local Row = { Kind = "Info", Name = text }

  return AddRow(self, Row)
end

function SectionClass:Textbox(name, default, callback, tooltip)
  local Row = { Kind = "Textbox", Name = name, Value = default or "", Tip = tooltip, Callback = callback or function() end }

  return AddRow(self, Row)
end

function SectionClass:Divider(text)
  local Row = { Kind = "Divider", Name = text }

  return AddRow(self, Row)
end

IconMasks["house"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAACAAAAAAAAAAAAAAAAAAAAAAAEAAZ7fggABAAAAAAAAAAAAAAAAAAAAQMAL8v//88zAAICAAAAAAAAAAAAAAADAABq9f/6+v/3bwAAAwAAAAAAAAAAAQQAF6v///z///z//68ZAAQBAAAAAAACAQBJ4f/7/v/////++//kTQAAAwAAAAAABIn///v///////////z//40GAAAAAAAwxf/9/f/////////////9/f/INAAAAADn//v///////////////////v/7QAAAAAmpv/8/////////////////P+rJwAAAAAAmP/7/////fv7+/v9////+/+eAAAAAAACnP/7////////////////+/+iAgAAAAAAm//7//3/zI2Pj43J//3/+/+hAAAAAAAAm//7//v/WAAAAABQ//z/+/+hAAAAAAAAm//7//v/YAUJCQVZ//z/+/+hAAAAAAAAmv36//v/XgAEBABX//z/+v2gAAAAAAAAoP/8/fj7WQAAAABS+/n9/P+nAAAAAAAASuP7////9+fo6Of2/////ORPAAAAAAAAAAklP1RmeYWJiYV5ZlU/JgoAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["gear"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAgECCMPv7roEAgECAwAAAAAAAAAAAAEAAAUAR/////86AAUAAAEAAAAAAAABAQBKHwAOu/37+/6xCgAjSQABAAAAAAACAI3/9L7e//7///7/2sD2/4EAAwAAAAAAW//6/////v37+/3+////+/9QAAAAAAAAtv77/vz9/P/////9/fz++/+pAAAAAAAAN/z9///9/9iWmNv//f/+/vgtAAAAAAADAKv//P3/kQcAAAma//37/54ABAAAAAADALb/+f/IAAAFBQAA0v/5/6kABAAAAAAAb/n9+v9wAQUAAAUAff/6/fZoAAAAAAC5////+/9lAgQAAAQCcv/7////rwAAAAD//P7//P+qAAYDBAUAt//8//78/AAAAADc/vr8//39VgAAAABg//3//Pr+0AAAAACQ/////v7+/5xRU6D//v7+////ggAAAAAJNlay//3///////////3/qVM0BwAAAAAAAAAG1v79/vv7+/v//f/NAQAAAAAAAAABAgYAu/78//3///3//P6uAAYCAQAAAAAAAAAB4v/6/f/3+P/9+v/XAQEAAAAAAAAAAAIBg/f//6gbHrH///V7AAIAAAAAAAAAAAABADGjnAAAAAOjoC0AAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["person"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAfO/EfzwKAAAAAAAAAAAAAAAAAAAAAQAL6/////3dcgECAAAAAAAAAAAAAAAAAwA8//39/P7/8woAAQAAAAAAAAAAAAAABAB9//v///z9wwEBAAAAAAAAAAAAAAAAAgC+/vz///v/ggAEAAAAAAAAAAAAAAABAAry//v7/fz+QQADAAAAAAAAAAAAAAAAAgKF7v/////zDgABAAAAAAAAAAAAAAAAAAMAGU+QzfGGAwUAAAAAAAAAAAAAAAAAAgAAAAAAAAMAAAACAAAAAAAAAAAAAAACADmTp6qsqKOokzkAAgAAAAAAAAAAAAMAWf7///////////5ZAAMAAAAAAAAAAQEL6f/5+/v7+/v7+f/pCwEBAAAAAAAAAwA4//3///////////3/OAADAAAAAAAABABr/vv///////////v+bAAEAAAAAAAAAwCi//v///////////v/owADAAAAAAAAAQHU//3///////////3/1AEBAAAAAAACAB/1/v7///////////7+9R8AAgAAAAADAEL//vz9/v/////+/fz+/0IAAwAAAAABAQ2i/f/////////////9og0BAQAAAAAAAAAAOo3F5fb+/vblxY06AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["two-people"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAABAAAAAAAAAAEAAAAAAAAAAwBQ1bd3OQcAAgBrv8aDDQABAAAAAAAAAgDQ/////9kpAJr/////xgkCAQAAAAACABz2/fv7+v9cIf/7/P34/2MABAAAAAAEAFf//P///v0dWfz7///7/JoABAAAAAAEAJ/99/z8/t8AR//6/v/5/34ABAAAAAAEAHT////+/6QACc///v7/8R8BAgAAAAAAAQBBhsX1+EQAAB+7/f/SPQACAAAAAAAAAAMAAAAJDwADAQAAEBYAAAQAAAAAAAAAAQApaHVrTxEAAhNUaWpkKwABAAAAAAACAIH5/////+FEAMH/////+oUAAgAAAAAAZf/++/v7+v/2GF39+Pv7/v9pAAAAAAAF2P38//////n/hAP2//7//P3bBgAAAAAs+v////////z+ygDI//z////7LwAAAABk//3///////7/9gaJ//v///z/aQAAAACh//z////////9/zRG//z///z/pwAAAADj/Pr9/f7+/fz3/X0P/P79/fr86AAAAADG/////////////2IZ////////zAAAAAANYKXM3+jn3MOURwBz5+XgzKZjDgAAAAAAAAAAChEQBwAAAAEOEBEKAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["eye"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgMAAAAAAAAAAAMCAAAAAAAAAAAAAAADAAAVTXeNjXdNFQAAAwAAAAAAAAAAAAMAHZft////////7ZcdAAMAAAAAAAAAAwBK6f///Pr4+Pr8///pSgADAAAAAAADAEr9//v+/P/////8/vv//UoAAwAAAAABHvH+/P/9/+y/vev//v/8//EeAQAAAAAAqf/7//3/fw8AABSJ//3/+/+pAAAAAAA1/f3//P+BPMRxAwAAjP/8//39NQAAAACe//z+/+wI2v/6DAIDDez//vz/ngAAAADr//78/74AeOiSAgICALz//P7/6wAAAADt//78/7oAAA8AAAACALr//P7/7QAAAACj//z+/+kKBAABAAIDCun//vz/owAAAAA6/v3//P+EAAEDAwAAhP/8//3+OgAAAAAAsP/7//3/fg0AAA1+//3/+/+wAAAAAAABI/X+/f/+/+OysuP//v/9/vUjAQAAAAADAFP///v+/P/////8/vv//1MAAwAAAAAAAwBT7////Pn4+Pn8///vUwADAAAAAAAAAAMAJKP0////////9KMkAAMAAAAAAAAAAAADAAAdWIOamoNYHQAAAwAAAAAAAAAAAAAAAgMAAAAAAAAAAAMCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["folder"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAA+jI+Pj4+Pij8AAwAAAAAAAAAAAAAAAAD4//////////9PAAYDAwMDAwMDAwAAAAD/+/v7+/v7+v3zMAAAAAAAAAAAAAAAAAD+//////////3/6K6wrq6urq2rVwAAAAD////////////+/////////////wAAAAD//////////////vz8/Pz8/Pz7/wAAAAD//////////////////////////gAAAAD//////////////////////////wAAAAD//////////////////////////wAAAAD//////////////////////////wAAAAD//////////////////////////wAAAAD//////////////////////////wAAAAD//////////////////////////wAAAAD//////////////////////////wAAAAD+/////////////////////////gAAAAD/+/v7+/v7+/v7+/v7+/v7+/v7/wAAAAD9/////////////////////////QAAAABJmpydnZ2dnZ2dnZ2dnZ2dnZyaSQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["code"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQQAAAAAAgMAAQQBAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAIAEVoKAAIANkwAEVsJAAIAAAAAAAAAAwARxv86AAQA2fsATf+3CQACAAAAAAADABHF/44FBAAZ/LsACJ7/twkAAgAAAAAAEMb/kAABBABO/3cAAwCg/7cIAAAAAAARxP+RAAMBBACO/zoABAIAof+1CQAAAADS/4gABAEAAQDS9QwAAQEDAJr/vgAAAADT/4oABAEBABj9vAACAAEDAZv/vwAAAAARxP+TAAMFAE3/eAAEAQIAo/+1CQAAAAAAEMX/kgAEAI3/OwAEAACh/7cIAAAAAAADABDE/5AFAM/0DAADCZ//tgkAAgAAAAAAAwAQxf82A//CAAYAT/+2CQACAAAAAAAAAAIAEFgKAFIsAAIAEFkJAAIAAAAAAAAAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAQQAAAMCAAAAAQQBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["three-sliders-horizontal"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEBAQEBAQEBAgABKx8AAAEBAAAAAAAAAAAAAAAAAAAAADPL+PGaCAAAAAAAAAAABAMEBAQEBAUFEuP//v//iQMHAAAAAADb9PP09PT09PT0+P/9//78//P0zgAAAACKoqChoaKioaKgrv/8/fz96J+jgQAAAAAAAAAAAAAAAAAAAL//////XQAAAAAAAAAEBAQEAA4UAAAGAxWk5NhtAAYEBAAAAAADAwQDhOLqqRcCBAAADQUAAwICAwAAAAAAAAB8/////78AAAAAAAAAAAAAAAAAAACux8X3/P3+/P/MxcbGx8fGxsXHowAAAAC91tX7/P7+/P/b1tbW1tbW1tXWsgAAAAAAAACH///+/8oAAAAAAAAAAAAAAAAAAAACAgMHmfH3viEBAwAAAAAAAwEBAgAAAAAEBAQDABwkAAAGAw6Q08VcAAYEBAAAAAAAAAAAAAAAAAAAALj/////VwAAAAAAAACKoqChoaKjoaKgrf/7/fv96J+jgQAAAADb9PP09PT09PT0+f/9//78//P0zgAAAAAABAMEBAQEBAUEE+j//Pz/jgMHAAAAAAAAAAAAAAAAAAAAAD/c//ytDAAAAAAAAAABAQEBAQEBAQEBAgAORDUAAAEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["shield-check"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQQAAAADPpLk45E9AwAAAAQBAAAAAAAAAAACOIXQ/v/////+z4Q3AgAAAAAAAAABEITU//////z+/vz/////04MQAQAAAAAAhf///vv9/////////fv+//+FAAAAAAAAnvv5///////////++/7/+fueAAAAAAAAmf/7//////////7/////+/+YAAAAAAAAlf/7/////////v//iNj/+f+VAAAAAAAAjv/7//77/v/9/f9WAML/+P+OAAAAAAAAgv/7//////z+/1cAqv/9+/+CAAAAAAAAbv/5/99i5v/9VwCo//z/+/9uAAAAAAAAUv/6/t4FJNtZAKf/+v///P9SAAAAAAAALv///f/UDwEAo//6/////v8sAAAAAAAACOP//vz/0y6i//r////9/+EHAAAAAAAEAJj/+//9/////f/////7/5YABAAAAAADACv9/P7//f/9//////78/CoAAgAAAAAAAwCH//n///////////n/hQADAAAAAAAAAQMCrf/7/f/////9+/+sAgMBAAAAAAAAAAEBA5j///z+/vz//5gDAQEAAAAAAAAAAAABAQBV2P/////YVQABAQAAAAAAAAAAAAAAAQMADnvp6XsOAAMBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["lightning-bolt"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABABa7KcFAgAAAAAAAAAAAAAAAAAAAAADADL0//8kAAIAAAAAAAAAAAAAAAAAAAIBE+D//f0oAAIAAAAAAAAAAAAAAAAAAQQAuf/7//4nAAIAAAAAAAAAAAAAAAAABACM//v+//4nAAIAAAAAAAAAAAAAAAAEAFv/+//+//4qAgIAAAAAAAAAAAAAAAMAMff8/v/+//4aAAMEAwAAAAAAAAAAAgAS3f/9/////v5wIAAAAAEAAAAAAAAAAgS3//z/////////98aGPAABAAAAAAAEAGn/9v3+///////8/////1IAAwAAAAAEAF3//////P///////v32/2oABAAAAAAAAQBKldP+//////////z/vQYCAQAAAAAAAAAAAAMsfv7+/////f/hFQACAAAAAAAAAAADBAEAHP/////+/Pk3AAMAAAAAAAAAAAAAAAMCLf/////7/2IABAAAAAAAAAAAAAAAAAIAKv////v/kgAEAAAAAAAAAAAAAAAAAAIAKv//+//AAgMBAAAAAAAAAAAAAAAAAAIAKv79/+QXAQIAAAAAAAAAAAAAAAAAAAIAKP//9zgAAwAAAAAAAAAAAAAAAAAAAAEBCLj3YwAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["gift-box"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAbKtZaqxaAAEAAAAAAAAAAAACBAQEBgB2//f///f/WAAHBAQEAQAAAAAAAAAAAAHa0gDmuwDvuAEAAAAAAAAAAAAga29xUgCd/63v4LH/ewBgcW9pGQAAAADg////+RkRoP////+QBy3/////0QAAAAD/+/v4/7cAaP+Vq/9LANH9+Pv79wAAAAD//v/9/uYAWIUAAJBDBPj+/v/+9QAAAADz//////9uAABbSgAAiP//////5QAAAAAeIyAhICElAAA2LQAAJyEhISAkHAAAAAAAPklISEhIUlMAC1NRR0hIR0k3AAAAAABG//////////8mSP//////////KQAAAABL/fv8/Pz8+/wiQfz5/Pz8/Pz7LgAAAABK//7//////v8iQv/8///////8LQAAAABK//7//////v8iQv/8///////8LQAAAABK//7//////v8iQv/8///////8LQAAAABK//7//////v8iQv/8///////8LQAAAABJ/v7//////v8iQv/8///////6LQAAAABN//39/Pz8+/wiQfz5/Pz8/f7/LgAAAAAc3P////////8kRf/////////IDQAAAAAAFkpieYyapKsXLayimIp2X0YOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["star"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQmRkQgBAQAAAAAAAAAAAAAAAAAAAAAEAGT//2IABAAAAAAAAAAAAAAAAAAAAAACAMD9/b4AAgAAAAAAAAAAAAAAAAAAAAIAIfj+/vggAAIAAAAAAAAAAAACBAQEBAgDcP/7+/9uAwgEBAQEAgAAAAAAAAAAAAAAxP/8/P/EAAAAAAAAAAAAAAAncXR1dnSC+v/////6gnR2dXRxJwAAAADo////////////////////////6AAAAADk//f7+/v7////////+/v7+/f/5AAAAAAmxf/8/v/////////////+/P/FJgAAAAAABpf//////////////////5cGAAAAAAACAABi8v3+/////////v3yYgAAAgAAAAAAAQQAR//9/////////f9IAAQBAAAAAAAAAAQDXP/8/////////P9cAwQAAAAAAAAAAAMAsf/7//78/P7/+/+yAAMAAAAAAAAAAQAQ7f/+/f/////9/v/tEAABAAAAAAAAAwBL//z7//16ev3/+/z/SwADAAAAAAAABACc/Pr/1DwAADzU//r8nAAEAAAAAAAAAwCf//2QCwAEBAALkP3/nwADAAAAAAAAAQAWhEwAAAMAAAMAAEyEFgABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["globe-simplified"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACABFqxo8AAI/FaA4AAwAAAAAAAAAAAQIAYN3/+RRYSRb4/9paAAIBAAAAAAABAwCY////awL04wBu////kQADAQAAAAADAJb/+f3rA3r//2IF6/35/40AAwAAAAAAVv/6+v+PAur+/toAkf/6+v9NAAAAAAAM3v79/f8yP//8/f8qNf/9/P7WBwAAAABg//z+//QDi/76+v50BPT//v3/UwAAAAC1/vz9/9cAuv/8+/+kANf//fz+qQAAAADp/////8gA0/////+/AMr/////4QAAAAAaGhoaGxMAFRoaGhsTABMbGhoaGgAAAABbZGRjZEwAU2RjY2RLAFBkY2RkXQAAAADx/////9YA3f/////EAOH/////7AAAAACx+vj5+9cAsfv49/qSAOT7+fj6qQAAAABh//3+//YFhf77/P9YFf7//v3/VQAAAAAK2/78/f8zOv/8/voRXf/7/P/RBgAAAAAATP/6+v+MAen+/7AAwf/7+/9BAAAAAAADAIP/+vznAX7//i0p/vr8/3cAAwAAAAAAAwB/////XQb+qwC0////dAADAAAAAAAAAAIARMT/8RJYGVH//789AAMAAAAAAAAAAAADAABHoWEACLCWQwAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["grid"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACZ////////////////////////igAAAAD/y4mNi4r03IqMjIrk7YqLjYnT/AAAAAD+gQAAAADkrQAAAADA1AAAAACU/wAAAAD/jAQJBATmtAQHBwTF2AQFCASe/wAAAAD/igEGAQHmswEEBAHE1wECBQGc/wAAAAD/hgAAAADlsAAAAADC1gAAAACZ/wAAAAD/7dfZ2Nj789fY2Nf2+dfY2Nfw9QAAAAD/5MTFxMT57cTFxcTx9sTExcTo9gAAAAD/gwAAAADlrwAAAADB1QAAAACW/wAAAAD/iwMIAwPmtAMGBgPF1wMEBwOd/wAAAAD/jAMIAwPmtAMGBgPF2AMEBwOd/wAAAAD/ggAAAADkrgAAAADA1AAAAACW/wAAAAD/3bO2tLT46bO1tbPu87S0tbPi9wAAAAD/8+bm5ub99+bm5ub5++bm5ub19AAAAAD/iAABAADmsgAAAADD1gAAAACa/wAAAAD/igAFAADmswADAwDE1wABBACc/wAAAAD/jAUJBQXmtAUICAXF2AUGCQWe/wAAAAD+gQAAAADkrQAAAADA1AAAAACU/wAAAAD/y4qNi4v03YqNjIrk7YuMjYrT/AAAAACZ////////////////////////igAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["two-stacked-squares"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACK////////////////7kEAAgAAAAAAAAD72ZmbmpqampqampqX+6MABAAAAAAAAAD/lAAAAAAAAAAAAAAA66oABAAAAAAAAAD/ngQIBAQEBAQEBQQE7KgABAAAAAAAAAD/nAAEAAACAQAAAQEA9q0ABQABAwAAAAD/nAAEAAAAAAAAAAAAQykAAAAAAAAAAAD/nAAEAgBCxM/Pz8/PwsfPz8/KawAAAAD/nAAEAgDH/////////////////wAAAAD/nAAEAQDJ/Pr9/f39/f39/f38/gAAAAD/nAAEAQDJ//z//////////////wAAAAD/nAAFAQDJ//z//////////////wAAAAD+nAADAQHJ//z//////////////wAAAAD/mQABAADK//z//////////////wAAAADr/+bn5kS7//z//////////////wAAAAA7oa6trC+///z//////////////wAAAAAAAAAAAADK//z//////////////wAAAAACBAMDBQHI//z//////////////wAAAAAAAAAAAQDJ//z//////////////gAAAAAAAAAAAgDK//z//////////////wAAAAAAAAAAAwBl9fz///////////37mQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["speedometer"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQQAAAAAAAAAAAABAgAAAAAAAAAAAAACAAAFOGWAgGJADQIBAF5SAAAAAAAAAAMACXXY///////QHgACjP9xAAAAAAAAAwAx0f///vn6/5oLABu6/6kAAgAAAAADADrx//v9+//7bgAAQOH/2hEEAgAAAAACGur/+//7/+JBAABt+//4OAAAAQAAAAAAqP/7//z/vR0ACpz/+v9xABd5AAAAAAA1/f3//P+tAwAmx//4/6wAAKH/LwAAAACX//z+/uoRAEnp//n/3RIAZf/9lQAAAADY//37/6QAKPj/+vz7OQAw9/z/1wAAAAD2///7/4wCWP/2+f9wAA7W//z/9QAAAAD////8/64AHef//6kAAKP/+////gAAAAD1///+/vMiACuLdAoAZ//7////9QAAAADW//3//f/LHAAAAABP+fz+//3/1gAAAACT//z///3/6IhaY6n///7///z/lAAAAAAx/P3////9/////////v////38MQAAAAAAov/4+/v7+vf4+Pj7+/v7+P+iAAAAAAACFub//////////////////+YXAgAAAAACADGcnJ2dnZ2dnZ2dnZ2cnDEAAgAAAAAAAQAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["location-pin"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQAymNn09NeULgABAQAAAAAAAAAAAAECAYb3////////9H8AAgEAAAAAAAAAAQMBqf///P37+/38//+gAAMAAAAAAAAAAwB+//n//f/////9/vn/cwADAAAAAAACAB/4/P7+//CztPL//v788xkAAgAAAAAEAHr/+/3/xR8AACPM//37/28ABAAAAAADALj++/72IQAFBQAq+f37/q0AAwAAAAAAAND/+v/IAAMAAAIA0v/6/8YAAQAAAAABAM3/+v/RAAQBAQMB2v/6/8MAAgAAAAADAKz++/39PwAAAABJ/v37/qIABAAAAAAEAGT//P7/5k0LDFLq/v78/1kABAAAAAABAQ/o/v3////j5f////3+4QsBAQAAAAAAAwBW//v9/v3///3+/Pz/TAADAAAAAAAAAAMAdv///f/9/f/9//9tAAMAAAAAAAAAAAADAFDX//7///7/00oAAwAAAAAAAAAAAAAAAwAIsf78/P6oBgADAAAAAAAAAAAAAAAAAAYARP/8/f85AAYAAAAAAAAAAAAAAAAAAAEBE+///+gNAQEAAAAAAAAAAAAAAAAAAAACALv//7AAAwAAAAAAAAAAAAAAAAAAAAADAVb49UwBAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["location-pin-map"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwAAAAADAAAAAAAAAAAAAAAAAAAAAAACAAUrKwUAAgAAAAAAAAAAAAAAAAAAAAIAXtr9/dpeAAIAAAAAAAAAAAAAAAAAAwBi////////YQADAAAAAAAAAAACBAECAQ/s/f/Gxv/97A8BAgEEAgAAAAAAAAAAAED//7gAALj//0AAAAAAAAAAAAAefNpxAEv//6QAAKT//0oAcdp8HgAAAADf/7k8ABz4/PuVlfv89xwAPbn/3wAAAAD/cgAABgCF//3///3/hQAGAABy/wAAAAD+bgMGAAACjv75+f6OAgAABgNu/gAAAAD/cAACXV0BAGb//2UAAV1dAgBw/wAAAAD/cAAAz9AAAgr19AoCANDPAABw/wAAAAD/cAAAwMEAAwLa2gIDAMHAAABw/wAAAAD/cAACxMUDBQAaGgAFA8XEAgBw/wAAAAD/cgEAvr8AAgQhJQQCAL++AAFy/wAAAAD9ZAAq2981CAC5ygAGNN/bKgBk/QAAAAD/ws7/8u//76TZ4aLu/+/y/87C/wAAAACY8L5hGBJMmuX//+WaTRIYYb7wlwAAAAAACAAAAAAAAAArKwAAAAAAAAAIAAAAAAACAAMEAQEDBAAAAAAEAwEBBAMAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["crown"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAgAAAAAAAgA4OQABAAAAAAACAQAAAAAAAAECAAADAEX8/UcAAwAAAgEAAAAAAAABJgAABAICCd3//90JAgIEAAAnAgAAAACt/bkwAAMAg//7+/+AAAMAMrr9sQAAAAD4///5hgYl+Pz+/vz2IAiJ+v//+gAAAADX/vv//83L//3///3/yND///v+2QAAAAC9//3+/P///v/////+///8/v3/vwAAAACf//z///39/////////f3///z/oQAAAACA//z///////////////////z/gQAAAABh//3///////////////////3/YgAAAABE//7///////////////////7/RQAAAAAq+v/+/////////////////v/6KwAAAAAV6//9/Pv7/P3+/v38+/v8/f/rFQAAAAAE1vz///////////////////zWBAAAAAAAyv/ptH9YPi8oKC8+WH+06f/KAAAAAAAAfFkAAAQfNkZOTkY2HwQAAFl8AAAAAAABABl7yfH///////////HJexkAAQAAAAABG+b///////z7+/z//////+YbAQAAAAABAR9trNTr+P7///7469SsbR8BAQAAAAAAAAAAAAMWJzQ7OzQnFgMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["flame"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEP3vXRhhwAAwAAAAAAAAAAAAAAAAAABAFQ//7//+dWAAMAAAAAAAAAAAAAAAAAAwC+//v+/P//UQADAAAAAAAAAAAAAAAEAE3//P////z+6xMBAQAAAAAAAAAAAAIBFeX+/f/////7/3EABAAAAAAAAAAAAQMBuf/8///////8/rkBBQEAAAAAAAAAAwCH//v////////9/9gAAAAAAAAAAAADAD//+/7////+///9/9cOOxwAAQAAAAACAcX//P////////////Ti/7cAAgAAAAAAKf7+//////39/f7//////vQVAAAAAAAAVv/8///9/85c//39//79/f89AAAAAAAAZf/7///7/4oAev///v///P5TAAAAAAAAWf/7///9/0ACAD7f/v3//P9OAAAAAAAAMf/+//7/9BcCCQBw//v//v8sAAAAAAABBdv+/f7+9x0ABACJ//v9/dgEAQAAAAAEAGr/+v/9/7MbBkvx/v76/2kABAAAAAABAgTD//n//v/w3f///vr/xAQCAQAAAAAAAgEX0//+/fz///38/v/UGAECAAAAAAAAAAIAEqP9/////v///qMSAAIAAAAAAAAAAAACAABCpOD6++KlQgAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["lock-closed"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAUtT//8I4AAIAAAAAAAAAAAAAAAAAAwBu/+KVnfP7RgADAAAAAAAAAAAAAAACACj/tAgAABna7A4BAQAAAAAAAAAAAAAEAIj+GQAHBwBE/1UABAAAAAAAAAAAAAMFAbHqAAIBAwIX/nwBBgMAAAAAAAAAAQAAAK/mAAAAAAAT/3oAAAABAAAAAAACAGTCye/6y8vLy8rQ/+TJukcAAgAAAAAAR/////////////////////okAQAAAAAAhv34/f7//Pz7+/z9//79+f9XAAAAAAAAg//7/////////////////P5XAAAAAAAAhP/7/////v/h6v/+/////P9XAAAAAAAAhP/7/////v8kVf/8/////P9XAAAAAAAAhP/7//////8ZSP/8/////P9XAAAAAAAAhP/7//////8dS//8/////P9XAAAAAAAAhP/7/////v8UR//8/////P9XAAAAAAAAhP/7/////v+/0P/+/////P9XAAAAAAAAhP37////////////////+/xXAAAAAAAAhv/8/Pz9/v/8/f/+/fz9/v9WAAAAAAABLs/8////////////////+L0WAQAAAAABAAM3c6nQ6ff+/fXlyaFqLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["bell"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAABawO349+q2SwABAAAAAAAAAAAAAAECCaj//////////5MBAwEAAAAAAAAAAAIArf/7/f7///79/P+QAAMAAAAAAAAAAwBQ//r//////////vv/NQADAAAAAAAAAwCy/fv///////////v+kwAEAAAAAAABAArl//7///////////3/zQABAAAAAAADADP//v////////////7/9hoAAgAAAAAEAGv/+//////////////8/00AAwAAAAADAKb/+//////////////7/4gABAAAAAAABNz//f/////////////8/8EAAgAAAAAAJvz////////////////+/+8RAAAAAAAAW//8/////////////////f8/AAAAAAAAlf/7////////////////+/93AAAAAAAAy//9/////////////////P+wAAAAAAAi8/v6/Pz+//39/f3//vz8+vvjDgAAAAA7///////////////////////3IQAAAAACNXCatsP4+Nzn5df88sK0lWosAAAAAAAAAAAAAACl+ioAAED/gQAAAAAAAAAAAAAAAgQEBQIi6fOWnv/WEgMEBAQCAAAAAAAAAAAAAAIALcD//7AdAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["compass"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAECABBpue07ZemxXwkAAwAAAAAAAAAAAQEAYN3///8nU////9NQAAMAAAAAAAABAwGa///8/P4bTP74/f//hQADAAAAAAADAJv/+v3//f+nvP77/f37/4EAAwAAAAAAXP/6/////fv////////++/9DAAAAAAAP4/39///+/////+/M0P/+/P7OBAAAAABo//z///7/xoZUNBgAB+T//f3/SgAAAAC6/Pv9/P/GAAAcAAABFO7//Pr9nAAAAAD6////+/+HALH/24kBN//+////4AAAAABBLS6q/v9YBu39//gBW///iCwuQAAAAABeTE24//8nLP///7oBjv/+nEtMWgAAAAD8//////ERCoTL82MAuP/7////4gAAAAC2+/n7/8kAAAAAAwAf6f7+/fj7mAAAAABi//39/8oHDzJWfa3p//7///3/RQAAAAAL3v79///c5////////v///P/HAgAAAAAAU//6/v////////z+///++/87AAAAAAADAJD/+/39/P+Qq//9//z8/3YAAwAAAAABAwCO///9+/4aSv74/f//eAADAAAAAAAAAQIAVNP///8nVf///8hEAAMAAAAAAAAAAAADAAlcq+E7Y92jUQIAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["controller"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAECAAAAAAAAAAAAAAAAAwAAAAAAAAAAAQAALmVyc3Nzc3NzcVgXAAIAAAAAAAABAQyj///////////////ubQACAAAAAAACArb//fv7+/v7+/v7+Pj//2oAAwAAAAAAU//5/vz+/////////////fMVAAAAAAAApf35/////f////r7kWPw+f9SAAAAAAAAyP//2UfX//3/////HwDb//+AAAAAAAAO5f/hlgCT4f39/p6Nxqu/fviwAAAAAAAr+v8fAAkAHf/+9QAA8f9BAMniAQAAAABQ//ywbABqr/39/6qavp7Hjvj1HQAAAAB5//n/zxTN//z/////HADa//7/RgAAAACj//z8+vD6/P////r7onfz+vv/dQAAAADL//3///////39/f7///////z/pwAAAADu//7///7//v///////Pv///3/1gAAAAD+///////8/8o/ReD//f////7/7gAAAADj/f3///77/DAAAEP/+v7///z90wAAAABq//77+/3/hAAGBgCP//v7+/3/XwAAAAAAhv////yTAgMBAQMFqP////+CAAAAAAABAC1kYCkAAAAAAAEAAD93cTAAAQAAAAAAAgAAAAACAAAAAAABAQAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["magnifying-glass"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAEmj2/T026NJAAADAAAAAAAAAAAAAwAotf//////////tSgAAwAAAAAAAAADAD/u//+0akREarT//+4/AAMAAAAAAAABJfH/2EEAAAAAAABB2P/wJgECAAAAAAABuv/aGgADBAMDBAMAGtr/vgECAAAAAABI//s7AAUAAAAAAAAFADv6/0MAAwAAAACo/7MABAAAAAAAAAAABACz/p4ABAAAAADh/2EBBAAAAAAAAAAABAFh/9ICAAAAAAD5/z0AAwAAAAAAAAAAAwA8/+kOAAAAAAD7/zoAAwAAAAAAAAAAAwA6/+sPAAAAAADm/1kBBAAAAAAAAAAABAFZ/9cDAAAAAACz/qYABAAAAAAAAAAABACl/qgAAwAAAABX//YpAAQAAAAAAAAEACn1/1IABAAAAAAFzP/HCgAFAwICAwUACsj/0AYBAQAAAAAAOPz/wSYAAAAAAAAmwf/4MgAFAAAAAAADAFr7/++SRyYmR5Lv////nQkABAAAAAAAAwBD1P////7+////1VDG/8YeAAAAAAAAAAMACma56P396LpmCwAf5f/hQAAAAAAAAAACAAAADyIiDwAAAAUAOPH/6QAAAAAAAAAAAQQCAAAAAAIEAQAEAF3ndgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["sword"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABACY8vL08/PscwAAAAAAAAAAAAAAAAAEAHH/////////6QAAAAAAAAAAAAAAAAMARf/8/v////7+6AAAAAAAAAAAAAAAAgAf6/79//////7/6AAAAAAAAAAAAAABAwbK//z///////7/6AAAAAAAAAAAAAAEAJ7/+/z+//////7/5gAAAAAAAAAAAAQAbf/6/v////////3+7wAAAAAAAQMAAwBA/fr9/6no//7//f//gwAAAAAAAAABARvo/fr/awC4//z8//lhAAAAAAAAKbEPAMf/+f9sAID+/fv/4DoAAwAAAAAASv9ci//4/24Aff/8+/+9GQAEAAAAAAACC77///z/cAB7//n+/5IDAAMAAAAAAAACAg7C//lmAHj/+P/6ZgABAgAAAAAAAAAAAAAFv/9Zav/3/+I9AAQBAAAAAAAAAAAAOKsqBMT///3/wRsABAAAAAAAAAAAAACf///lJgTA//iJAAADAAAAAAAAAAAAAAD9/vn/5C0MwP9bGAQBAAAAAAAAAAAAAABx//35/7EADLz/uQADAAAAAAAAAAAAAAAAbv///zgBAARGKAABAAAAAAAAAAAAAAAEAHLtoQECAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["crosshairs"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAADbyAAAAAMAAAAAAAAAAAAAAAAAAgAHQYT/+3o7AgADAAAAAAAAAAAAAAEBAF3U///9////zFAAAgAAAAAAAAAAAQMCnP//3Kf/+qXk//+JAAMBAAAAAAAAAwCc//h2CwDo1gARhP//hAADAAAAAAADAFb/9ksAAAIZFQMAAGD8/z8AAwAAAAACBtf/eAAGAQIAAAEBBgCS/78BAwAAAAAAO//gBQQBAAAAAAAAAgMT8P0kAAAAAAAAff6gCQABAReZkRABAQALuv9lAAAAAADJ+P7z6lEBAKf//5EAAWns9P32swAAAADc//76+lsAAK///5oAAHX8+v3/xQAAAAAFiP6kFwABAR+rpBYBAQAYvP9wAgAAAAAAPv/aAAQBAAAAAAAAAgMM7P4mAAAAAAACCNz/cQAGAQEAAAEBBgCL/8UCAwAAAAAEAF3/80UAAQRdUwQAAFn6/0UAAwAAAAAAAwCi//ZxCQj/9QAPf/3/igADAAAAAAAAAQIEof//26X69KPi//+OAAMBAAAAAAAAAAEBAGDU///+////zFMAAgAAAAAAAAAAAAABAgAHQYT/+3o7AgACAAAAAAAAAAAAAAAAAAMAAADbyAAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["pencil"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAQ962DgADAAAAAAAAAAAAAAAAAAAABQRO7///whIAAwAAAAAAAAAAAAAAAAADAACv//j7/88XAAAAAAAAAAAAAAAAAAQAUUYAtf/7+//TIAAAAAAAAAAAAAAABQBO//c8ALf/+/v/zwAAAAAAAAAAAAAFAFH8/f/0PQC4//j/1AAAAAAAAAAAAAUAVPz+/v3/9D0At//dJwAAAAAAAAAABQBX/f79///9//Q6AJ8sAAAAAAAAAAAFAFn+/f3//////f72QAAAAgAAAAAAAAUAXP/9/v///////f/uOgMEAAAAAAAABABf//3+///////9/+4zAAIAAAAAAAAEAGL//f7///////3/8TgABAAAAAAAAAAAY//9/v///////f/0PQAEAAAAAAAAAABl//3+///////9/vdCAAQAAAAAAAAAAAD2//7///////3++UcABAAAAAAAAAAAAAD//////////f77TAAEAAAAAAAAAAAAAAD+///////+/f1RAAUAAAAAAAAAAAAAAAD+//////3+/1cABQAAAAAAAAAAAAAAAAD//////v/9WwAEAAAAAAAAAAAAAAAAAACh/P3+/exhAAUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["pencil-square"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADMDIyMjIyMjItAwABBAWP6HkAAwAAAAC3////////////OQAFAG3//P99AAAAAAD/o0xPTExMTE1HCwAFJQ26//j/hgAAAAD9cgAAAAAAAAAAAACg8jIAvv/88AAAAAD/fAMHAwMDAwUFAJ7///A1Ab7/ZwAAAAD/egAEAAAAAQIAof/7/P/vMA1VAAAAAAD/egAEAAACAgCk//r///z/9RcAAwAAAAD/egAEAAEBAaf/+v///vv/gQcIAQAAAAD/egAEAQIEqv/6////+/+DAAAAAAAAAAD/egAEAgGg//r////7/4kAAw8/AgAAAAD/egAGAB3//f7///r/jwAHAFj/IQAAAAD/egAGACj7/v3++v+VAAMFAF3+JgAAAAD/egAGACX//////5oAAwEEAFz/JQAAAAD/egAFAQi3+vnzlAACAQAEAFz/JQAAAAD/egAEAQABISQaAAEBAAAEAFz/JQAAAAD/egAEAAAAAAAAAgAAAAAEAFz/JQAAAAD/fAQIBAQFBgYGBAQEBAQIBF//JQAAAAD+cAAAAAAAAAAAAAAAAAAAAE//JQAAAAD/u3p9e3t7e3t7e3t7e3t9eqv/JAAAAACh//////////////////////+rBgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["trash-can"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwFP8f/////xTwEDAAAAAAAAAAAAAQMEBQDJ2XZ6enbYygAFBAMBAAAAAAAAAAAAAAv9gQMHBwOB/QsAAAAAAAAAAAAAFlCErdT/9ff39/f1/9SthFAXAAAAAAAt/f/////////////////////9LQAAAAARWMj7+f3//f7+/v79//35+8hYEQAAAAABAKL/+//////////////7/6IAAQAAAAAFBJT/+///6//////r///7/5QEBQAAAAAEAID/+f/XEs///88S1//5/4AABAAAAAAEAG3/+f/UALP//7MA1P/5/20ABAAAAAAEAFr/+v/kAaX//6UB5P/6/1oABAAAAAADAEn/+//uAJT//5MA7v/7/0kAAwAAAAADADj//f/4CIP//4MI+P/9/zgAAwAAAAACACj+////C2n//2kL/////igAAgAAAAACABr1//3/Pn3//30+//3/9RoAAgAAAAABAA7q//3/+v3///35//3/6g4AAQAAAAABAATc//3///////////3/3AQAAQAAAAAAAADT/Pr9/f7///79/fr80wAAAAAAAAAAAwCl////////////////pQADAAAAAAAAAQEVdqrQ6ff+/vfp0Kp2FQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["book-closed"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgB83gR48e3w8PDw8O/vxSMBAgAAAAAEAGb/+QKB//7////+/////68AAwAAAAACAMz98gOA/vr///////79/dYAAAAAAAAAANH/9AOA//7RL1Cb2P/9/9EAAAAAAAAAANH/9AOA//93ACYABHX//9IAAAAAAAAAANH/9AOA//8sQv/ZB2H//9IAAAAAAAAAANH/9AN+/+IAgv/gALX//9IAAAAAAAAAANH/9AN+/8wCADU+B+v//9IAAAAAAAAAANH/9AOA//zSjEMKU//7/9IAAAAAAAAAANH/9AOA//v////z+P/8/9IAAAAAAAAAANH/9AOA//v9+/z////9/9IAAAAAAAAAANH/9AOA//v////+/v/9/9IAAAAAAAAAANH/9AOA//v////////9/9IAAAAAAAAAANH/9AOA//v////////9/9IAAAAAAAAAANH/9AOA//v////////9/9EAAAAAAAAAANH+8wOA//v////////8/tUAAAAAAAAAAM///AeG/////////////8gAAQAAAAAAAOLAHAAEGxobGxseG8XYHwsAAQAAAAADAL/fZG9pZGRkZGRmY9bnaUMAAQAAAAACASze/////////////////8YAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["check"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQQEAgAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIABYOaJAAAAAAAAAAAAAAAAAAAAAAAAgEFsv//0gAAAAAAAAAAAAAAAAAAAAACAQWy//f95gAAAAAAAAAAAAAAAAAAAAIBBbL/+P/2SQAAAAAAAAAAAAAAAAAAAgEFsv/4/vlIAAAAAAACBAQAAAAAAAACAQWy//j/+UoABQAAAAAAAAAAAAAAAAIBBbL/+P74SQAEAAAAAAAum3QAAgEAAgEFsv/4/vlKAAQAAAAAAADn//+cAAIDAQWy//n/+UoABAAAAAAAAAD8+/n/mwAABrP/+f75SgAFAAAAAAAAAABg//35/5oRtP/4/vlKAAQAAAAAAAAAAAAAXv/8/P/j//v++UoABQAAAAAAAAAAAAAFAGH//fz/+/75SgAFAAAAAAAAAAAAAAAABQBh//z4//lLAAQAAAAAAAAAAAAAAAAAAAQAYv//+EsABQAAAAAAAAAAAAAAAAAAAAAEAEeLNwAEAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAMEAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["three-dots-horizontal"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAwQDAQAAAAMDBAIAAAACAwQDAQAAAAAAAAAAAAEAAAAAAAABAAAAAAAAAAAAAAAMlJxWGAACAGynaCsAAgA8qn07AwAAAABg////6iwAHP////1lAQDG////sgAAAACo+vj6/0gAV/z49/+QABvv+/n+5AAAAADu//r76hEAmP/6+f9KAE7//vj8mgAAAACK7f//swABSd////MTAR3G/P//TQAAAAAAFEt2IAACAAk3c0IAAgAAKGhjAwAAAAACAAAAAAAAAgAAAAABAAEAAAAAAAAAAAAAAQMEAgAAAAEDBAMAAAAAAgQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["three-bars-horizontal"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADBAQEBAQEBAQEBAQEBAQEBAQEAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnk5KTk5OTk5OTk5OTk5OTk5KTWwAAAAD/////////////////////////+gAAAABJdHN0dHR0dHR0dHR0dHR0dHN0QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAIISAhISEhISEhISEhISEhISEhBQAAAADg////////////////////////zgAAAADE6unp6enp6enp6enp6enp6ejptAAAAAAADAwMDAwMDAwMDAwMDAwMDAwMAAAAAAAEAQEBAQEBAQEBAQEBAQEBAQEBBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkkY+QkJCQkJCQkJCQkJCQkI+QWAAAAAD/////////////////////////+gAAAABNd3Z3d3d3d3d3d3d3d3d3d3Z3QwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADBAQEBAQEBAQEBAQEBAQEBAQEAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["chevron-small-down"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEAAAAAAAAAAAAAAAAAAAEBAAAAAAADAAADAAAAAAAAAAAAAAAAAwAAAgAAAAAAEBAAAgAAAAAAAAAAAAACAA8SAAAAAABj6OljAAQAAAAAAAAAAAQAYObqZwAAAAD7////ZwAEAAAAAAAABABm////9QAAAADw//v8/2YABQAAAAAEAGj//Pr/2wAAAABQ+f/8/P9lAAQAAAQAaP/8/P/wOwAAAAAATvz+/P3/ZAAFBABq//z8//Q9AAAAAAAFAFH7/vz9/2MAAGv//fz/9UEABAAAAAAABABR+/78/f9ZYv/8/P/2QwAEAAAAAAAAAAUAUvz+/f////78//hGAAUAAAAAAAAAAAAFAFL9/v3//v3/+EgABQAAAAAAAAAAAAAABQBT/P78/P75SwAEAAAAAAAAAAAAAAAAAAQAVP3///tOAAUAAAAAAAAAAAAAAAAAAAAEAE7U2EwABAAAAAAAAAAAAAAAAAAAAAAAAwABAwACAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["chevron-small-up"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAgAQEQACAAAAAAAAAAAAAAAAAAAAAAAEAGXo6mIABAAAAAAAAAAAAAAAAAAAAAQAaf////9jAAUAAAAAAAAAAAAAAAAABABp//z8/Pz/YQAFAAAAAAAAAAAAAAAEAGj//P3///39/14ABQAAAAAAAAAAAAQAZ//8/P/6/P/8/f9bAAQAAAAAAAAABABn//38//pETf7+/P3+WAAFAAAAAAAEAGf//Pz++k4AAFX9/vz+/lUABQAAAAAAZP/9/P77TwAEBQBU/P78/v1RAAAAAABk//38/vtPAAQAAAUAU/z+/P76TQAAAAD4/fv++1AABQAAAAAFAFL7/vr+5QAAAADz///8UQAEAAAAAAAABABR/P//7gAAAABP1tdNAAQAAAAAAAAAAAQAStPZUwAAAAAAAgIAAgAAAAAAAAAAAAADAAEDAAAAAAADAAADAAAAAAAAAAAAAAAAAwAAAgAAAAAAAQEAAAAAAAAAAAAAAAAAAAEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["chevron-large-left"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQIAmtg3AAIAAAAAAAAAAAAAAAAAAAABAgCd//9+AAQAAAAAAAAAAAAAAAAAAAECAKL//9IYAQEAAAAAAAAAAAAAAAAAAQIAo///1RkAAgAAAAAAAAAAAAAAAAABAgCk///WGgADAAAAAAAAAAAAAAAAAAICAab//9caAAMAAAAAAAAAAAAAAAAAAQIBp///1xsAAwAAAAAAAAAAAAAAAAABAAGp///YHAADAAAAAAAAAAAAAAAAAAECBar//9ocAAMAAAAAAAAAAAAAAAAAAAMAkf/7zxsAAwAAAAAAAAAAAAAAAAAAAAQAnv/7wgkBAgAAAAAAAAAAAAAAAAAAAAECDsD//8YOAAIAAAAAAAAAAAAAAAAAAAABAAvA///FDgACAAAAAAAAAAAAAAAAAAAAAgALwP//xQ4AAwAAAAAAAAAAAAAAAAAAAAIAC8D//8UOAAIAAAAAAAAAAAAAAAAAAAACAAvA///FDgACAAAAAAAAAAAAAAAAAAAAAgALwP//xg8AAQAAAAAAAAAAAAAAAAAAAAIAC8H//8USAgEAAAAAAAAAAAAAAAAAAAACAAu8//97AAQAAAAAAAAAAAAAAAAAAAAAAgAMwfFCAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["chevron-large-right"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAXdtxAAQAAAAAAAAAAAAAAAAAAAAAAAQAt///cgAEAAAAAAAAAAAAAAAAAAAAAAIBNu7//3YABAAAAAAAAAAAAAAAAAAAAAACADnw/v93AAQAAAAAAAAAAAAAAAAAAAAABAA68f7/eAAEAQAAAAAAAAAAAAAAAAAAAAQAO/H+/3oABAAAAAAAAAAAAAAAAAAAAAAEADzy/v97AAQBAAAAAAAAAAAAAAAAAAAABAA88v7/fQADAAAAAAAAAAAAAAAAAAAAAAQAPvT//34AAgAAAAAAAAAAAAAAAAAAAAAEADjo+/9eAAMAAAAAAAAAAAAAAAAAAAADACHi+/9oAAQAAAAAAAAAAAAAAAAAAAQAKef//5YBAgAAAAAAAAAAAAAAAAAABAAq5f//lgACAQAAAAAAAAAAAAAAAAAEACnl//+WAAMBAAAAAAAAAAAAAAAAAAQAKuX//5cAAwEAAAAAAAAAAAAAAAAABAAq5f//lwADAQAAAAAAAAAAAAAAAAACACrl//+XAAMBAAAAAAAAAAAAAAAAAAIBKeX//5gAAwEAAAAAAAAAAAAAAAAAAAQAs///lAADAQAAAAAAAAAAAAAAAAAAAAMAbPWZAAMBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["skull"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAEDAwAAAAADAwEAAAAAAAAAAAAAAAAAAgAAAAEODgEAAAACAAAAAAAAAAAAAAADAABMn9Xx8dWfTAAAAwAAAAAAAAAAAAMAL7/////09f///74vAAMAAAAAAAAAAwBG8f/cdDASEzB03P/wRgADAAAAAAACACzy/54PAAAAAAAAEJ7/8isAAgAAAAACA8T/nwAABAIBAQIEAACf/8MCAgAAAAMASf/dCwEDAQAAAAABAwEM3v9IAAMAAAMAof5yAAcAAAIAAAIAAAYAc/6gAAMAAQAD1/8tAQAGBgAAAAAGBgABLv/WAwABAQAO8PYWAFPc3FMAAFLc3FQAFvbvDgABAQAO8PcRBOf//+cGB+f//+cEEvfvDgABAQAD1v8rBOj//+YHB+b//+gELP/WAwABAAMAof51AFTb3FMAAFHb3FYAdv6gAAMAAAMASP/eDAAHBgACAgAGBwAM3/9IAAMAAAACAsP/oQYBAAfCwgcAAQai/8ICAgAAAAACACrq/18BAWH//2EBAV//6ikAAgAAAAABAAXh+S0AAFLo6FIAAC364AUAAQAAAAABAAzs+D8BAgAPDwACAUD46wwAAQAAAAAAAwCP//+4AgAAAAACuP//jgADAAAAAAAAAQEHk/32IA8REQ8g9v2SBwEBAAAAAAAAAAEAAOb/8/T09PTz/+UAAAEAAAAAAAAAAAADAlHZ7O7v7+7s2VACAwAAAAAAAAAAAAAAAQAHERAQEBARBwABAAAAAAAA" }
IconMasks["leaf"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAIAAgMAAQAAAAAAAAAAAAAAAAAAAAABBQANxL8GAQEAAAAAAAAAAAAAAQIDBAIAABe+//9aAAQAAAAAAAAAAAMDAAAAAAAZaN7/8v3IAQEAAAAAAAABAgAAARxEd7Tw//+4MuP/LgACAAAAAAEAADqW0vr////5tlUBAJn/cwAEAAAAAQAKmv///+zCjVUfAAAEAlf/rAADAAABAgu///OFNA8AAAAAAQMDAC//0QEAAAACAJ3/2S4AAAABBAQCAAABABv86AkAAAMAOP/vKQAGAgECAAAAAAABABHz8w8AAAMAm/+EAAYAAQQAAQEAAAABABP28A4AAQAD2P8uAgUEAAAlycMHAQECACn/2wMAAQAR8/ISAAAACWvr/8oGAQEEAV3+rQADAQAR9fMEAytz1P//pBAAAQADALz/YgAEAQAF1P6n2P///8pSAAABAAUASf7pEgABAAMAuP3//+CfSwIAAgEABQAZ3v9vAAMAAwBy/v/3XQAAAAEEAgQCABzK/7sDAwEAACn89sf/0C0AAAAAAAAAUN7/zxUBAgAAAI7/lQjD//SHNhQTLGG7//+3FgACAAAAAs39NQALmf////b1////424BAAIAAAAAD/P/FAEAADmV0O/w1qdfEgAAAQAAAAAABr/CBQEBAgAAAA4OAgAAAAMAAAAAAAAAAAICAAAAAAIDAAAAAAMEAQAAAAAAAAAAAAAAAAAAAAAAAQEBAQAAAAAAAAAAAAAA" }
IconMasks["rocket"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAABBAAAAAAIEgEAAAAAAAAAAAAAAAAAAAIAAAdHjMDd67MGAAAAAAAAAAAAAAAAAwAGbNf///////ISAAAAAAAAAAAAAAAEADTJ///Pfz08/dwHAAAAAAABAwQEAwUAVvX/z1EDAAA4/78AAAAAAAEAAAAAAABV/v+VCgAACAN7/o0AAAAAAQAESG5vTk70/38AAAQBAgLP/0gAAAACARrI////////mwAEAQAEAEn/3wkBAAACAbr/1o2I1/3cCgICAAEDB9D/bgAEAAMARP/eEgAA3P9KAAQAAQQAlf/RCQIBAAMAnP1/DBN9/7oAAwAEAACB//UyAAMAAQAI5//z9PP8/E8ACAIADJr//VUAAwAAAQEHue/y9PP2/8gYAABK0//wVAAEAAAAAAAAAhMLDRQlzv/LWbf///xSAAUAAAAAAAABAAAKBgAAF83////e1f9TAwQAAAAAAAEAF6Xu5o0KACDz+HoQgf9yAAQAAAAAAQIHx//6//+PAA/y8wgAiv5xAAQAAAAABABj/9YlPffsCA708wAY0/9IAAMAAAAAAQHI/1MAHvbwCQzx8n/g/8sIAgEAAAAAACH85hpZ1/+nABT3////tRwAAgAAAAAAAFj76ub//8MYAge535xGAAABAAAAAAAAAHj////DZQUAAQACCAAAAQEAAAAAAAAAABh1ViQAAAABAAAAAAMDAAAAAAAAAAAAAAAAAAABBAEAAAABAQAAAAAAAAAAAAAA" }
IconMasks["heart"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQIAAAAAAAADAwAAAAAAAAIBAAAAAAABAAAycot9TQoAAApNfYtyMgAAAQAAAAAADKP//////91RUd3//////6MMAAAAAAAFuf/9+/v7/P/////8+/v7/f+5BQAAAABz//r///////3+/v3///////r/cwAAAADb/f3///////////////////392wAAAAD7////////////////////////+wAAAAD6////////////////////////+QAAAADY/v3///////////////////3+2AAAAACI//z///////////////////z/iAAAAAAc8P3+/////////////////v3wHAAAAAAAcf/6////////////////+v9xAAAAAAADAbb/+v/////////////6/7YBAwAAAAABAQ7L//r///////////r/yw4BAQAAAAAAAgATxv/6/v/////++v/GEwACAAAAAAAAAAIAC6r//vz///z+/6oLAAIAAAAAAAAAAAACAAB4+//7+//7eAAAAgAAAAAAAAAAAAAAAQIAOcr//8o5AAIBAAAAAAAAAAAAAAAAAAADAANkZAMAAwAAAAAAAAAAAAAAAAAAAAAAAwAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["clock"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAApdr9/z8tunUwMAAwAAAAAAAAAAAQIAVtX//////////8pGAAMAAAAAAAABAwCQ///9/f78/P78/f//egADAAAAAAADAJH/+/3///////////z8/3cAAwAAAAAAVP/6/v///f+Lnv/8///++/88AAAAAAAM3v79/////f8hQf/8/////P/IAwAAAABj//3//////f8xTv/8//////3/RQAAAAC6/vz//////f8uS//8//////z+mwAAAADp//7//////f8wT/38//////3/0AAAAAD8/////////f8nQ//7//////7/5gAAAAD9/////////P98AJb//f////7/5wAAAADr//7///////3/bgCR//z///3/0QAAAAC9/vz///////79/2hc//z///z+nwAAAABo//3////////+/v////////3/SgAAAAAP4/39//////////3+/////P7OBAAAAAAAXP/6///////////////++/9DAAAAAAADAJv/+v3///////////37/4EAAwAAAAABAwGb///9/f7///79/f//hQADAAAAAAAAAQEAYN3//////////9NQAAMAAAAAAAAAAAECABBpu+n8++WzXwkAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["key"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAMeLhZgAAAwAAAAAAAAAAAAAAAAAABAAu5f///7YfAAMAAAAAAAAAAAAAAAADAC7q//z+/P/nOAADAAAAAAAAAAAAAAIALun//P/9//n/8TQAAgAAAAAAAAAAAgEg6P/8///////8/+UXAgAAAAAAAAAABABg//r//vlmKrH/+f+uAAAAAAAAAAAABABg/vv8/88AAC///Pz/UAAAAAAAAAAABAJY//v+/vJGEJb//P380QAAAAAAAAAABgCB//v//v/+6v////v/sgAAAAAAAAAEAGT9/f////7///3/+/+8DgAAAAAAAAUAYv/9/v/////+/v/7/8ALAAAAAAAABABh//z+/////vz9/fv/wQwAAgAAAAAFAGD//f7////7//////+9DAACAAAAAAAAXP/9/v//////71hDQz4EAAIAAAAAAABg/v3+///+++2rNgAAAAAAAQAAAAAAAAD7//7////8/7kAAAMDAwMBAAAAAAAAAAD//v////73gjsEBAAAAAAAAAAAAAAAAAD+/v//+//fAAABAAAAAAAAAAAAAAAAAAD//////+49BAQAAAAAAAAAAAAAAAAAAACT8PLz4EEAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["flag"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACZsAAka7fZy4QWAAAAAAY5gVcAAQAAAACM+rvy///////gdUJTldb+//8rAAAAAAA3/////f3+/fz/////////+/gjAAAAAAAJ3vz8///////9+/38+/37/7AAAwAAAAAApf/7///////////////9/0oABAAAAAAAY//7//////////////3/2wADAQAAAAAAJvz+/v////////////799VwABAAAAAABAtX//f/////////////+//5MAAAAAAAEAJb/+/78/P3//////////f7zPQAAAAAEAFL//P/////8/v////78/Pz/lgAAAAACABn0/+/FueT///z8/f////vCKAAAAAAAAgDPzxUAAA105////+2yaigAAAAAAAAABACJ8gIBAwAAEUheRhUAAAABAQAAAAAAAwA+/zsAAwEDAAAAAAACBAIAAAAAAAAAAQAK+IMABAAAAQMEAwEAAAAAAAAAAAAAAAMAwNAAAgAAAAAAAAAAAAAAAAAAAAAAAAQAc/0SAAEAAAAAAAAAAAAAAAAAAAAAAAIALf9LAAQAAAAAAAAAAAAAAAAAAAAAAAEAA/GiAAQAAAAAAAAAAAAAAAAAAAAAAAADAJigAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["tag"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABQBZ3+jq6urq6ejjbwAAAAAAAAAAAAAEAFX6////////////6gAAAAAAAAAAAAUAV//+/f7+/v/+//7+6QAAAAAAAAAABQBW/v3+///+/+guVvz/6AAAAAAAAAAFAFb+/f7////9/9oAIfr/6AAAAAAAAAUAVv79/f///////v/R4v//6QAAAAAABABW/v3+//////////////7/6QAAAAAFAFb+/f3////////////9/f7/6AAAAAAAVP79/f////////////////7+6QAAAABW/P79//////////////////3/6AAAAAD1/v3//////////////////v79WgAAAACw//v////////////////+/f9YAAAAAAAJs//7//////////////79/1oABQAAAAAABrf/+v///////////v3/WgAFAAAAAAACAQe3//v////////+/f9bAAUAAAAAAAAAAgAHt//6//////79/1sABQAAAAAAAAAAAAIAB7j/+////v3/XAAEAAAAAAAAAAAAAAACAAe5//v+/v9cAAUAAAAAAAAAAAAAAAAAAgAHtf///FsABQAAAAAAAAAAAAAAAAAAAAIACbXtXwAFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["photo-camera"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQMCBAIKbH99fX9oBgIDAgIBAAAAAAACAAAAAACv////////oQAAAAAAAgAAAAAAEzU4Nn3/+fv7+/v6/3E2ODQPAAAAAABV6P/////+/////////v/////jSQAAAADx//3+/v3//v/7/P7///3+/vz/4wAAAAD//v/////////////+/f/////99AAAAAD+//////z/kS1sreT/////////8gAAAAD///////7/MAAAAA4+w/79////8wAAAAD//////f/iCQIFAwEAkf/7////8wAAAAD/////+/+pAAMAAQEG2f/9////8wAAAAD/////+/9gBAgCAwAq/f7/////8wAAAAD//////f8/AAAABANo//v/////8wAAAAD//////v7moV8lAACu//v/////8wAAAAD+///////////6zKX3//7/////8gAAAAD//P3+/v/++/z////////+/v389wAAAADX//////38/Pv6+fj7/P3/////xAAAAAAmrdzx////////////////79qkHAAAAAAAAAQVKT1NWWFlZWFYTDsoFAMAAAAAAAACAwAAAAAAAAAAAAAAAAAAAAADAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["image"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+kpmZmpqampqampqampqamZmSPgAAAAD4+ubo5+jo5+fn5+fn5+fn6Ob6+AAAAAD/awAAAAAAAAAAAAAAAAAAAABr/wAAAAD+cAAEAAcAAAAAAAAAAAAABABw/gAAAAD/cAACR96vDAIBAQQFAQAABABw/wAAAAD/cAAArP//MQADAgAAAAEABABw/wAAAAD/cAABOc2cBwIEAFZ4BwACBABw/wAAAAD/cAAFAAAAAAUAdP//ugkABgBw/wAAAAD/cAEGAAMCBQBz//v4/7oIAwFw/wAAAAD/cgAABQAEAHH//P7/+/+5CQBz/wAAAAD/agCm3mIAcf/8/v////v/uwBq/wAAAAD/dKH///+q//7+///////6/6R0/wAAAAD/8v/8/f///v///////////f/z/wAAAAD///3////8//////////////3//wAAAAD+/v/////////////////////+/gAAAAD/+/v7+/v7+/v7+/v7+/v7+/v7/wAAAAD9/////////////////////////AAAAABJmpydnZ2dnZ2dnZ2dnZ2dnZyaSQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["cloud"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEEBAQEBAEAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAADAAAAAAAAAAAAAAAAAAADAAVQjqSTWgwAAwAAAAAAAAAAAAAAAAMAPND//////95RAAMAAAAAAAAAAAAAAwBA+P/7+/v7+///XQADAAAAAAAAAAABARDl//v///////z9+CUEBgIAAAAAAAAEAG//+//////////7/5IAAAADAAAAAAADAbv+/P/////////+/uyfficAAgAAAAABANH//f////////////////dkAAAAAAAAA9b+/f////////////77+v//RwAAAAAVwv79//////////////////z+ywAAAACo//3/////////////////////+gAAAAD4/f/////////////////////++wAAAAD7/P7///////////////////v/wwAAAACT//37/f////////////79+v/0MwAAAAAEkv/////8+/v7+/v7/P///9o8AAAAAAAAADma3v////////////fHbw0AAgAAAAAAAgAACC9Wd4yYmItyTSEAAAACAAAAAAAAAAIDAAAAAAAAAAAAAAABBAEAAAAAAAAAAAAAAQIEBAQEBAQEBAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["sun"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAwComgADAAAAAgAAAAAAAAAAAAAAAgAAAgDYyAADAAABAAAAAAAAAAAAAAopAAAAAgCZjQADAQAAKwMAAAAAAAADAD7/bAIDAwIAAAMDAgWS/x0AAgAAAAAAAgWW/xUCAAAKCAAAAjX/cAICAAAAAAAAAAAAJgMAVbvi369AAAklAAAAAAAAAAAAAAABAACO////////agAAAgAAAAAAAAADAwMEAlv/+vz+/fv9/zYCAwMDAwAAAAAAAAABAs/9/P/////7/6YAAwAAAAAAAACju4MAF/L//v/////9/tUBA5S7kQAAAACyzI8AGPP//v/////9/9YAA6HMnwAAAAAAAAABAtH9/P/////7/qkAAwAAAAAAAAADAgIEAWD/+vz+/vv8/zoCAwMCAwAAAAAAAAABAACW////////cgAAAgAAAAAAAAAAAAAAHgIAXcPp5rhHAAgdAAAAAAAAAAAAAgOM/BUBAAAQDgAAAjX/ZwECAAAAAAADAD3/dgIDBAEAAAIDAgec/x0AAgAAAAABAA0zAAAAAgCPgwADAQAANQUAAAAAAAAAAAAAAgAAAgDYyAADAAAAAAAAAAAAAAAAAAEDAAAAAwCyowADAAABAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["moon"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAK77sOQADAAAAAAAAAAAAAAAAAAAAAwBS7f//owAEAAAAAAAAAAAAAAAAAAADAFT///j+mwAEAAAAAAAAAAAAAAAAAAABJvb+/fv/fQAEAAAAAAAAAAAAAAAAAAAAtf/7//v/gQAEAAAAAAAAAAAAAAAAAAA6/v3///v/oQADAAAAAAAAAAAAAAAAAACa//z///3/3AQBAAAAAAAAAAAAAAAAAADY//3////9/0cABAAAAAAAAAAAAAAAAAD2///////8/swBAwIAAAAAAAAAAAAAAAD//////////P+QAAIDAQAAAAAAAAAAAAD2//////////z/jwMAAAMEBAQEAgAAAADZ//7////////8/8hLBgAAAAAAAAAAAACc//z//////////P//2aOCfpyeNgAAAAA9//3///////////39////////8AAAAAAAuP/7/////////////fv7+/j+uwAAAAABKfj9/f///////////////f7vIgAAAAADAFj///v////////////7//9LAAAAAAAAAwBZ9v/+/P7////+/P//8lIAAwAAAAAAAAMALbT+//////////yvKAADAAAAAAAAAAADAABAmdf0/vTVljwAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["trophy"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAis7Mzs7Ozs7Ozc+wEAAAAAAAAAANUVZy////////////////oVVVFQAAAADA/////v39/f39/f39/f39////2QAAAADyuCA/+v/+//////////z/eCCf/wAAAACo6AAM8f/+//////////z/TQDQywAAAABd/yYE5//+//////////3/Owr+fQAAAAAe/2MC3P/9////////////Izz/NwAAAAAA4bMAyv/8/////////v/+BIn2BwAAAAAAf/8pe/77/////////f/EF/WjAAAAAAACDMz/w//9/////////f7Z7uYcAQAAAAABAA+T6vz//v/////+/f/trCAAAQAAAAAAAQAABjn0//3///77/20LAAABAAAAAAAAAAEDAABG9v/+//7/ggAAAwIAAAAAAAAAAAAAAQQAQOj+/Pt3AAQBAAAAAAAAAAAAAAAAAAAGAE/6/5EAAgEAAAAAAAAAAAAAAAAAAAIAdef8/fGlCwEBAAAAAAAAAAAAAAAAAwBi////////qgACAAAAAAAAAAAAAAABAAvn+/n8/Pv3/zwAAwAAAAAAAAAAAAABARHg////////+0MAAwAAAAAAAAAAAAAAAQAeYo+rsJpyNwABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["bug"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAQAAAAIAHK/08qkWAAEAAAABAgAAAAAAAAAAAQEL0P/////GBgIBAAAAAAAAAAAbBwAABAB1/+fV1+n/ZQAEAAAKGAAAAADzYgAEAgNDLQAAAAAzQAMCBACB6wAAAAD/bgQIAwAARpEaN4s6AAADCASO/wAAAAD/dgAAAFXc//8qWv//z0QAAACX/QAAAADA/qWXqP//+/snU/v4//+hman/oAAAAAATnd3+//39/v8nVP/7/f7/99yNCQAAAAAAAA3g+/3//v8nVP/7//z7yAAAAAAAAAAFA3H/+////v8nVP/7///9/0kDBAAAAAADALn+/P///v8nVP/7///7/pAABAAAAAAAAdf//f///v8nVP/7///8/7MAAwAAAAAABdz//f///v8nVP/7///8/7kDAwAAAAADALj+/P///v8nVP/7///7/osABgAAAAAAZOv//v///v8nVP/7///9/9lQAAAAAACE/8P4/f7//v8nVP/7//7+7cr/YgAAAAD8mwCI//n+/v8nVP/7/vr/YAC66QAAAAD/bgIFr///+/4nVP34//+OAAGR/wAAAABuJwABA4n3//8nVf//7XAAAwA1ZQAAAAAAAAABAAAzldokTtSGIwACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["wallet"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGjw5OTk5OTk5OTk5OTcGAAEAAAAAAABZ6v/////////////////WDwMCAAAAAAD0//14TE5MTExMTExMS0xUBgAAAQAAAAD//fxHEhYUFBQUFBQUFBQSISQHAAAAAAD+////////////////////+/zSGgAAAAD////+//////////////////7/ZAAAAAD//////v7+/v7+/v7+/v7+/vv9kgAAAAD////////////////+/Pz7/v3/uAAAAAD///////////////////////3/0wAAAAD//////////////v7xX0yQ7P7/5QAAAAD/////////////+/+aAAAATf//7wAAAAD//////////////P9QBw0HO///8wAAAAD//////////////P9bAAAAgv/+8AAAAAD//////////////v7ui0ZN5v7/6AAAAAD///////////////////////3/1wAAAAD////////////////++/39/v3/vQAAAAD9//////////////////////z+mQAAAAD//v7+/v7+/v7+/v7+/v7+/vv/bQAAAADA///////////////////////nJAAAAAAKRUpKSkpKSkpKSkpKSkpKSUofAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["shopping-cart"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADz//ZgBAcEBQUFBQUFBQUFBQUEAQAAAACNpu/eAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJr/iICBgICAgICAgICAgIByFQAAAAAIA2P+////////////////////wgAAAAADADH++vr7+/v7+/v7+/v7+/r74wAAAAABAArm//3///////////////z/nAAAAAAAAgC4//z///////////////3/UwAAAAAABACD//v//////////////v/tFgAAAAAAAwBN//z//////////////P64AAAAAAAAAgAe+P/7+/v7+/v7+/v79/53AAAAAAAAAAEC1P////////////////8tAAAAAAAAAAQAo/6ZkZKSkpKSkpKQkU0AAgAAAAAAAAQAa/82AAAAAAAAAAAAAAABAAAAAAAAAAIAI/r70NLR0dHR0dDRySsAAgAAAAAAAAACAEnK5OLj4+Pj5Ofl3C4AAgAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAC6FQAABAAEAFYBeAAIAAAAAAAAAAAEBDeH/+SQBAgMAtP//UgADAAAAAAAAAAEAE/P//y8AAwIAxf//YQAEAAAAAAAAAAACAF3MegACAAIAMr2XCAEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["phone"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA5buzSsBAgAAAAAAAAAAAAAAAAAAAAAWtv/+/8oCAgEAAAAAAAAAAAAAAAAAAADE//v/+/9eAAQAAAAAAAAAAAAAAAAAAAD//f///f7gDQEBAAAAAAAAAAAAAAAAAAD6//////z/UgAEAAAAAAAAAAAAAAAAAADs//7///v/PQADAAAAAAAAAAAAAAAAAADN//3/+v+RAAIAAAAAAAAAAAAAAAAAAACX//z7/5UAAgEAAAAAAAAAAAAAAAAAAABN//z/lgADAQAAAAAAAAAAAAAAAAAAAAAL3v6SAAMBAAAAAAAAAAAAAAAAAAAAAAAAf/8fAgMAAAAAAAAAAAMDAQAAAAAAAAABEvW2AAQAAAAAAAAAAQAAAAMAAAAAAAADAGn/XwAFAAAAAAEBAENSCgABAgAAAAAAAwCz/zkABQAAAQIAmf//2l8AAAAAAAAAAQIO0/c6AAMDAgCc//v7///DKQAAAAAAAAIAGNP/XwAAAJz/+v///fr/ygAAAAAAAAACABCy/7MumP/6//////778QAAAAAAAAAAAgAAbPj///z8/f7///v/jAAAAAAAAAAAAAEBABaB2v///////f+vAgAAAAAAAAAAAAAABAAADE+WzOv6+7sPAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["envelope"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA9jI+Pj4+Pj4+Pj4+Pj4+Pj4+MPQAAAAD6////////////////////////+gAAAAD4//n5+/v7+/v7+/v7+/v7+fn/+AAAAAAZqf//+/7///////////77//+pGQAAAAA8AEna///8/////////P//2kkAPAAAAAD/phEAg/r//P3///38//qDABGm/wAAAAD9/+9sACO5///7+///uSMAbO///QAAAAD//P//yTMAWOT//+RYADPJ///8/wAAAAD///78//+WBwSZmQQHlv///P7//wAAAAD//////f7/5lwAAFzm//79/////wAAAAD////////7//+9vf//+////////wAAAAD//////////v3///3+/////////wAAAAD////////////8/P///////////wAAAAD//////////////////////////wAAAAD9/////////////////////////QAAAAD///37+/v7+/v7+/v7+/v7+/3//wAAAADC////////////////////////wgAAAAADK0ZcbX2Hj5SWlpSPh31tXEYrAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["microphone"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgBn3/3+/vrTTQACAAAAAAAAAAAAAAADAGP/////////+j8AAwAAAAAAAAAAAAEBCOT+/P/////6/78AAgAAAAAAAAAAAAIAH/r//v/////9/t8EAAEAAAAAAAAAAAIAIPr//v/////9/98GAAEAAAAAAAAAAAIAIPr//v/////9/98GAAEAAAAAAAAAAAIAIPr//v/////9/98GAAEAAAAAAAAAAAIAIPr//v/////9/98GAAEAAAAAAAAAAAIAIPr//v/////9/98GAAEAAAAAAAAAAAIBHvn+/v/////9/t4EAQEAAAAAAAAAAAAAB9v/+f39/f34/7QAAAAAAAAAAAAAAAIdAFX/////////9TMAHAAAAAAAAAACACv9UwBGudnb29etLgB/9w0AAQAAAAABAge2/2MAAAAAAAAAA4D/jwIDAAAAAAAAAQAJpv/xysO2ucTO+v+HAAEBAAAAAAAAAAEAAD6Xv8T/9sO9ii4AAQAAAAAAAAAAAAABAgAAAADUpgAAAAADAAAAAAAAAAAAAAAAAAMAAADXpwAAAAIAAAAAAAAAAAAAAAAAAgA1cW/q0W9xJAABAAAAAAAAAAAAAAAABACV////////aAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["headphones"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAADWY4P////3WhiUAAAEAAAAAAAAAAgAXpP//yqOamqjT//+IBwABAAAAAAACACrj/4YcAAAAAAAAKqH/xBEBAQAAAAACFeLwOAAAAgQEBAMBAABW/8AEAwAAAAAArP80AAYCAAAAAAAAAgUAWv97AAAAAAA4/4IABgAAAAAAAAAAAAAFALP2FQAAAACl9xACAgAAAAAAAAAAAAADAjP/bQAAAADvvgACAAAAAAAAAAAAAAABAALpuwAAAAD/kQEEAAAAAAAAAAAAAAAAAgDE4gAAAAD+igQIAQAAAAAAAAAAAAACBwS86gAAAAD/gAAAAAEAAAAAAAAAAAIAAAC26wAAAAD/wHhrEwACAAAAAAAAAgAkcnjc4gAAAAD/////1xMBAgAAAAADAC/v////2QAAAAD//fv5/7kAAwEAAAEBEdv/+fr+2gAAAAD0////+v+LAAMAAAIDtf/7//3/zQAAAADJ/v3//vz/NwADBABh//r///z/mAAAAABi//v///v/YAAEBACQ/Pv//vz+NQAAAAAEwf/6/vz4IAACAwBF//v++v+WAAAAAAABGdH//v+YAAMAAAIBxf///7MHAgAAAAACABKg6a4QAgEAAAIBJMXmhQMAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["speaker"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAQCAAAAAAAAAAAAAAMAWop9GAABAAAAAAAAAAAAAAAAAAAABQB4////ogAEAAAEAWUoAQAAAAABAwMGAGb/+vf7uAADAAAAAfS1AAAAAAAAAAAAVv/8/vz/tAADAQNFBHT8GQAAAAARSEpm+v7+//z/tQAEABf/WRD/aQAAAADS//////7///z/tQAEDwHXvADitwAAAAD//Pz8/v////z/uABW5gCN9gCp7QAAAAD9//////////z/uABN/x1X/wR//wAAAAD///////////z/twAt/jg//xNq/wAAAAD///////////z/twAt/Tc//xJq/wAAAAD9//////////z/uABP/xxY/wSA/wAAAAD//Pz8/v////z/uABV4QCP9QCr6wAAAADV//////////z/tQADCwHZugDktQAAAAATTE1r/P7+//z/tQAEABf/VhL/ZwAAAAAAAAAAXP/7/vz/tAADAQM+A3n7FwAAAAABAwMGAHD/+vj7twADAAAAAfWxAAAAAAAAAAAABACE////qQAEAAADAV4lAQAAAAAAAAAAAQMAa52QIQABAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAQCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["x"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACE98AQAAIAAAAAAAAAAAMAG832cAAAAAD//v/BDgACAAAAAAAAAwAY0P//8gAAAADE//j/xQ4AAgAAAAADABjU//j/rgAAAAATxv/3/8MNAAIAAAMAF9L/9/+2CgAAAAAAEMn/9//CDQACAwAX0v/2/7oIAAAAAAADABLK//f/wQwBABbR//f/uggAAgAAAAAAAwASy//3/8EFEND/9/+7CQACAAAAAAAAAAMAEsv/+P+9yP/3/7wJAAIAAAAAAAAAAAADABPO//v///v/vQoAAgAAAAAAAAAAAAAAAgAQxf76+v+1CAECAAAAAAAAAAAAAAAAAgAQxf76+v+1CAECAAAAAAAAAAAAAAADABPO//v///v/vQoAAgAAAAAAAAAAAAMAEsv/+P+9yP/3/7wJAAIAAAAAAAAAAwASy//3/8EFEND/9/+7CQACAAAAAAADABLK//f/wQwBABbR//f/uggAAgAAAAAAEMr/9//CDQACAwAX0v/2/7oIAAAAAAATxv/3/8MNAAIAAAMAF9L/9/+2CgAAAADE//j/xQ4AAgAAAAADABjU//j/rgAAAAD//v/BDgACAAAAAAAAAwAY0P//8gAAAACE98AQAAIAAAAAAAAAAAMAG832cQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["pin"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwBZ20AAAwEAAAAAAAAAAAAAAAAAAAAAAwIg5fdqAAIBAAAAAAAAAAAAAAAAAAADAABs7P3/kgACAQAAAAAAAAAAAAAAAAQAE6z///77/6YCAQEAAAAAAAACAQABAwA93P/7/v//+v+sAgIBAAAAAAAAAAMAAHL7//v///////r/pAADAQAAAAAzCwAUq//+/f/////////6/48ABAAAAAD/u0fd//v+////////////+v9kAAAAAABX/////P///////////////v/9OQAAAAAATvv8/v/////////////+/u7p4wAAAAAFAFP9/v3////////////7/14kUgAAAAAABABT/f/+//////////v/pAAAAAAAAAAAAAQAVu76/f///////f/YDAIDAwAAAAAAAAEGAK///f7////+/PkyAAMAAAAAAAAAAQQAjP+s+P/9///7/2kABAAAAAAAAAABBACH/4cAVv39/vz/pwAEAAAAAAAAAAAEAIb/ggAGAFb9/f7ZDgIBAAAAAAAAAAAAg/+DAAQBBQBV/v83AAQAAAAAAAAAAACS/4EABAEAAAQAUvm0DwIBAAAAAAAAAAD4kQAEAQAAAAAFAFz7LAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["circle-i"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAApdr9/z8tunUwMAAwAAAAAAAAAAAQIAVtX//////////8pGAAMAAAAAAAABAwCQ///9/f78/P78/f//egADAAAAAAADAJH/+/3///////////z8/3cAAwAAAAAAVP/6/v///f9nff/9///++/88AAAAAAAM3v79/////f1NZ//8/////P/IAwAAAABj//3///////////////////3/RQAAAAC6/vz///3/1Co2f//9//////z+mwAAAADp//7///3/21EETP/8//////3/0AAAAAD8//////////80Tf/8//////7/5gAAAAD9/////////PstTP/8//////7/5wAAAADr//7/////+/stS/v6//////3/0QAAAAC9/vz///////8yUv////////z+nwAAAABo//3///3/x5saLZvS//3///3/SgAAAAAP4/39//v/dAAQDgCR//v//P7OBAAAAAAAXP/6////9u7s7O74///++/9DAAAAAAADAJv/+v3///////////37/4EAAwAAAAABAwGb///9/P3+/v38/f//hQADAAAAAAAAAQEAYN3//////////9NQAAMAAAAAAAAAAAECABBpu+n8++WzXwkAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["circle-question"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAARSotTq6c+aRwAAAwAAAAAAAAAAAAIATMz//////////8E9AAMAAAAAAAABAwCG///9/Pv6+vr8/v//cQAEAAAAAAADAIn/+/3//f///////vz9/28AAwAAAAAAT//6/v///8SAdKX4//7+/P83AAAAAAAK2/79//32aAAAAAA88v7+/P/EAgAAAABf//3//v7sHS/E0EgAqf/7//3/QgAAAAC4/vz///7/7+///50Anf/7//z/mQAAAADo//7////+////1h0O4v79//3/zwAAAAD8////////+/3QFA7C//3///7/5gAAAAD9/////////f8jANb//P////7/5wAAAADr//7////+//5iiv/7//////3/0gAAAAC+/v3///////////3///////z+oAAAAABp//3////+/+8tU//+//////3/SwAAAAAP5P39///+/+sFMv/+/////P7PBQAAAAAAXv/6//////7t8P/////++/9EAAAAAAADAJz/+v3///////////37/4MAAwAAAAABAgGc///8/f7+/v79/f//hgADAAAAAAAAAQEAYd3//////////9NRAAMAAAAAAAAAAAECABFqu+n8++WzYAkAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["triangle-exclamation"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAgNycgMCAQAAAAAAAAAAAAAAAAAAAAADAH///38AAwAAAAAAAAAAAAAAAAAAAAIBI/f6+vcjAQIAAAAAAAAAAAAAAAAAAAMAsv/8/P+yAAMAAAAAAAAAAAAAAAAAAwBL//z9/fz/TAADAAAAAAAAAAAAAAABAwja/v3///3+2gkDAQAAAAAAAAAAAAADAH3/+f9+cf/5/30AAwAAAAAAAAAAAAIBIfX9+/86Kv/8/fUhAQIAAAAAAAAAAAMAr//8/P9HOf/9/P+vAAMAAAAAAAAAAwBI//z//P9AMf/9//z/SAADAAAAAAABAgfY/v3//P9VRv/8//3+2AcCAQAAAAAEAHr/+//////////+///7/3oABAAAAAABHvT9/v///v+4rP7+///+/fQeAQAAAAAAqP/8///+//IAAOH//f///P+oAAAAAABL//3//////v2IePn+//////3/SgAAAADf+/n7+/v7+/v///z7+/v7+/n73wAAAADi////////////////////////4gAAAAAlfIKDg4ODg4ODg4ODg4ODg4J8JQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["calendar"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgYCKe83AgQBAQQCOe0eAgUCAAAAAAABAAAAMv9DAAAAAAAARP8lAAAAAQAAAAAAMafE0v7WxsfHx8fG1v7Pw6MpAAAAAAAr7/////3///////////3////nIQAAAACg////////////////////////jgAAAACf4+Hk5OTk5OTk5OTk5OTk5OHjkQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABgi4mLi4uLi4uLi4uLi4uLi4mLVwAAAAC9////////////////////////rAAAAACt+/j7////+/v///v7///++/j7nQAAAACw//v/63Dj//+Vlf//4XLx//v/oAAAAACw//v/4C/T//9jY///0TLo//v/oAAAAACw//z///////////////////z/oAAAAACw//z///////////////////z/oAAAAACw//z//Nn6///l5f//+tr9//z/oAAAAACv//r/1gDH//88PP//xQDh//r/nwAAAACx/vz/+cP2///V1f//9cX7//z+oQAAAACj//n9///////////////+/fn/kgAAAAA28//////////9/f/////////tLAAAAAAAOqHC1+jx+P3///z48efWwJ4yAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["hashtag"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEL3cQEAQIAHu2dAAIAAAAAAAAAAAAAAgAu/+YHAAQAUv/DAAIAAAAAAAAAAAAABABQ/r0AAgQAdv6WAAQAAAAAAAAABAQECAR1/5sECAgEnf9zBAgEAwAAAAAAAAAAAACX/2IAAAAAwP86AAAAAAAAAAAHZIB+gH/d/6d+gX+C7v6Wf39/RwAAAAA4////////////////////////9QAAAAAJbIaGhpf+9YyGiIam/uWHhoWGTwAAAAAAAAAAAC3/zgAAAABU/6cAAAAAAAAAAAAABAQIBGX/qwQHCASM/4QECAQEAwAAAAADBAQIBIf/iAQIBgOv/2EECAQEAQAAAAAAAAAAAKv/UgAAAADS/ysAAAAAAAAAAABgm5qcnOr+tZudm6H3/qmbm52BDQAAAADy////////////////////////NwAAAAA1aWlphf7qa2lraZn/1WlqaGlRBAAAAAAAAAAAPf+8AAAAAGb/kwAAAAAAAAAAAAACBAgEdf+YBAgIBJ3/cQQIBAQDAAAAAAAAAAQAl/5yAAQCAL7+TAADAAAAAAAAAAAAAAIAxf9NAAQAB+n/KgACAAAAAAAAAAAAAAIAj9oXAAIBA7TICAEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["robux"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAHKP/94sNAAADAAAAAAAAAAAAAAMBAAl5+feUof/pYQAAAgIAAAAAAAAAAgAAXOj/mxYAACmz/9RFAAACAAAAAAACAD/M/7ovAAJpVQAARdD/tCsAAgAAAAAAdf/VSgAAUdL//7g1AABg6f9RAAAAAAAn/44AAC+y///+///7lBcACbbvDAAAAABZ/xwAavj/+/L19fL//+dAAEb/LAAAAABZ/yQB0P/1QhkbHBlw+/+YAU3+LQAAAABZ/yIAxv7xEQAAAAA///6TAEz/LQAAAABZ/yIAyP/yGwECBAFJ//+UAEz/LQAAAABZ/yIAyP/yHAIDBQJJ//+UAEz/LQAAAABZ/yIAx/7xDQAAAAA9//2UAEz/LQAAAABZ/yQBzf/2Vy4wMS6B+/+UAU3+LQAAAABZ/xwAVun//////////9MyAEX/LAAAAAAn/44AAByY+//8/v/seQkACbbvDAAAAAAAdf/VSgAAOrz//58hAABg6f9RAAAAAAACAD/M/7kxAABOPAAARdD/tCsAAgAAAAAAAgAAXOj/mxkAACqz/9RFAAACAAAAAAAAAAMBAAl5+feToP/pYQAAAgIAAAAAAAAAAAAABAAAHKP/94sNAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["discord"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQMEAgAAAAACBAMBAAAAAAAAAAAAAAADAAAAAAQDAwQAAAAAAwAAAAAAAAAAAAAABTh4LwAAAAA1dzcEAAEAAAAAAAAAAgJ62P//05atrJbY///WdwECAAAAAAAEAGj///77////////+/7//2YAAwAAAAABEOr8+////fv8+/v9///7/OoQAQAAAAAAc//7///9/v/////+/f//+/9yAAAAAAAF1f79//////7///7///7//f7UBQAAAAA9/v7+///N7f/+/v/rzf///v7+PAAAAACF//z9/2gAIuH+/twdAGr//fz/ggAAAAC8//v/5gIFAIz//4EABQLm//v/uAAAAADd//3+8RcAAKn//6AAABfx/v3/2gAAAADu//79/7g/dvz+/vpzP7j//f7/6gAAAADv/v7///////39/f3///////797AAAAAD1//r+6dD//////////87q/vn/8QAAAABd5f//4X5gl8DU1MGWYYDj///iWQAAAAAAF43s/+wBAAAAAAAABfL/6ooVAAAAAAADAAAYcEABBgIAAAIGAENuFgAAAwAAAAAAAQMAAAABAAAAAAAAAQAAAAMBAAAAAAAAAAACBAIAAAAAAAAAAAIEAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["plus-small"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACADjZ1DEBAgAAAAAAAAAAAAAAAAAAAAADALf//6oAAwAAAAAAAAAAAAAAAAAAAAACAMX+/roAAgAAAAAAAAAAAAAAAAAAAAACAML//7cAAgAAAAAAAAAAAAAAAAAAAAACAMP//7gAAgAAAAAAAAAAAAAAAAAAAAACAMP//7gAAgAAAAAAAAAAAAACAwICAgIEAsT//7kCBAICAgIDAgAAAAAAAAAAAAAAAMD//7UAAAAAAAAAAAAAAAA+rbu6urq7uu///+y6u7q6ubynKgAAAADw////////////////////////zwAAAAD1////////////////////////1AAAAABFt8LDw8PEw/H//+7DxMPDwsKwMAAAAAAAAAAAAAAAAMH//7UAAAAAAAAAAAAAAAADAgICAgIEAsP//7kCBAICAgIDAgAAAAAAAAAAAAACAMP//7gAAgAAAAAAAAAAAAAAAAAAAAACAMP//7gAAgAAAAAAAAAAAAAAAAAAAAACAML//7cAAgAAAAAAAAAAAAAAAAAAAAACAMT+/rkAAgAAAAAAAAAAAAAAAAAAAAADALz//7AAAwAAAAAAAAAAAAAAAAAAAAADAEbt6j4AAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["minus-small"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAQEBAQEBAQEBAQEBAQEBAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAwAAAAAABA0MDAwMDAwMDAwMDAwMDA0EAAAAAABc2Ofm5+fn5+fn5+fn5+fn5ufYXAAAAAD7////////////////////////+wAAAADt////////////////////////7QAAAAA+uMfIycnJycnJycnJycnJyMe4PgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAgEBAQEBAQEBAQEBAQEBAQECAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["play-small"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAT/GpHwAAAwAAAAAAAAAAAAAAAAAAAAAAjf//6G4EAAMCAAAAAAAAAAAAAAAAAAAAiP74///MRgAABAEAAAAAAAAAAAAAAAAAif/7/vz//6MgAAADAAAAAAAAAAAAAAAAif/7///9/f/udQcAAwIAAAAAAAAAAAAAif/7//////z//89JAAAEAQAAAAAAAAAAif/7///////++///pyQAAAMAAAAAAAAAif/7//////////39//F7CAABAAAAAAAAif/7/////////////P//004AAgAAAAAAif/7//////////////77//9mAAAAAAAAif/7//////////////78//9iAAAAAAAAif/7/////////////P//zEYAAQAAAAAAif/7//////////3+/+xxBQABAAAAAAAAif/7///////+/P//nh4AAAMAAAAAAAAAif/7//////v//8dAAAAEAQAAAAAAAAAAif/7///8/v/oawIAAwEAAAAAAAAAAAAAif/7/vz//pcaAAEDAAAAAAAAAAAAAAAAiP74///COwAABAAAAAAAAAAAAAAAAAAAjf//4GMAAAMBAAAAAAAAAAAAAAAAAAAASOmcFgABAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["pause-small"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC3397f397YOQADAwBg3t3f393fjQAAAAD/////////cQAEBACk////////3gAAAAD9/v7+/vr+bAAEBACd/vr+/v3+1QAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD///////v/bQAEBACe//v///7/1wAAAAD+//////v/bAAEBACd//v///7/1gAAAAD///////v/cQAEBACj//v///7/3AAAAADb//7///35SgADBAB3/vz///3/rQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }
IconMasks["stop-small"] = { Width = 24, Height = 24, Data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWpN3f4ODg4ODg4ODg4ODg39uKBQAAAAC5////////////////////////hQAAAAD//f7+/v7+/v7+/v7+/v7+/vz92QAAAAD+//////////////////////7/1gAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD///////////////////////7/1wAAAAD+//////////////////////7/1gAAAAD//f////////////////////392gAAAADP//3///////////////////3/nAAAAAAtzP3+/////////////////vqzEwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" }

function InsUi:SetAccent(first, second)
  Theme.AccentA = first
  Theme.AccentB = second or first
  Theme.Accent = Blend(Theme.AccentA, Theme.AccentB, Layout.ShimmerMix)

  return self
end

function InsUi:SetTheme(overrides)
  local First = overrides.accentA or overrides.accent
  local Second = overrides.accentB or overrides.accent
  local Fields = { bg = "Background", sidebar = "Background", text = "Text", idle = "Idle", track = "Track", slider = "SliderTrack", risk = "Risk" }

  for Public, Field in pairs(Fields) do
    local Color = overrides[Public]

    if Color then Theme[Field] = Color end
  end

  if not First and not Second then return self end

  return self:SetAccent(First or Theme.AccentA, Second or Theme.AccentB)
end

function InsUi:ApplyThemePreset(name)
  local Preset = ThemePresets[name]
  if not Preset then return self end

  Theme.Background = PresetBackground[name] or DefaultBackground

  return self:SetAccent(Preset[1], Preset[2])
end

function InsUi:ThemePresets()
  local Names = {}

  for Name in pairs(ThemePresets) do Names[#Names + 1] = Name end

  table.sort(Names)

  return Names
end

function InsUi:FontChoices()
  local Names = {}

  for Index = 1, #FontList do Names[Index] = FontList[Index].Name end

  return Names
end

function InsUi:SetFont(name)
  local Chosen = FontByName(name)

  State.FontName = name
  SystemFont, BoldFont = Chosen, Chosen

  return self
end

function InsUi:Notify(title, description, duration, kind)
  State.Notes[#State.Notes + 1] = {
    Title = string.lower(tostring(title or "notification")),
    Body = string.lower(tostring(description or "")),
    Duration = tonumber(duration) or State.NoteDuration,
    Kind = kind and string.lower(tostring(kind)) or nil,
    Elapsed = 0,
  }

  return self
end

function InsUi:SaveConfig(name)
  name = tostring(name or State.ConfigName)

  EnsureFolder()
  writefile(ConfigPath(name), HttpService:JSONEncode(PackConfig()))

  return self
end

function InsUi:LoadConfig(name)
  name = tostring(name or State.ConfigName)

  local Path = ConfigPath(name)
  if not isfile(Path) then return self end

  ApplyConfig(HttpService:JSONDecode(readfile(Path)))

  return self
end

function InsUi:ListConfigs()
  local Names = {}

  for _, File in ipairs(listfiles(ConfigDir())) do
    local Name = string.match(File, "([^/\]+)%.json$")

    if Name and string.sub(Name, 1, 1) ~= "_" then Names[#Names + 1] = Name end
  end

  return Names
end

function InsUi:DeleteConfig(name)
  local Path = ConfigPath(tostring(name))

  if isfile(Path) then delfile(Path) end

  return self
end

function InsUi:GetValue(path)
  local Found

  EachRow(function(tab, section, row)
    if RowPath(tab, section, row) == path then Found = row end
  end)
if not Found then return nil end
  if Found.Kind == "Range" then return Found.Low, Found.High end
  if Found.Kind == "Color" then return Found.Value, Found.Alpha end

  return Found.Value
end

function InsUi:SetValue(path, value)
  EachRow(function(tab, section, row)
    if RowPath(tab, section, row) ~= path then return end

    row.Value = value
    row.Callback(value)
  end)
return self
end

function InsUi:Dialog(options)
  State.Dialog = {
    Title = tostring(options.title or "Confirm"),
    Text = tostring(options.text or ""),
    Confirm = tostring(options.confirm or "Confirm"),
    Cancel = tostring(options.cancel or "Cancel"),
    OnConfirm = options.onConfirm or function() end,
    OnCancel = options.onCancel or function() end,
  }

  return self
end

local BoxClass = {}
BoxClass.__index = BoxClass

function InsUi:CreateBox(options)
  options = options or {}

  local Box = setmetatable({
    Title = tostring(options.title or "Box"),
    X = options.position and options.position.X or options.x or 20,
    Y = options.position and options.position.Y or options.y or 140,
    Width = options.width or options.w,
    Visible = options.visible ~= false,
    Lines = {},
  }, BoxClass)

  table.insert(State.Boxes, Box)

  return Box
end

local function BoxLine(box, kind, value, color)
  local Line = { Kind = kind, Value = value, Color = color }

  table.insert(box.Lines, Line)

  return Line
end

function BoxClass:Text(value, color)
  return BoxLine(self, "Text", value, color)
end

function BoxClass:Stat(value, color)
  return BoxLine(self, "Stat", value, color)
end

function BoxClass:Bar(value, color)
  return BoxLine(self, "Bar", value, color)
end

function BoxClass:SetTitle(title)
  self.Title = tostring(title)
  return self
end

function BoxClass:SetVisible(visible)
  self.Visible = visible ~= false
  return self
end

function BoxClass:Clear()
  self.Lines = {}
  return self
end

function BoxClass:Remove()
  for Index, Box in ipairs(State.Boxes) do
    if Box == self then
      table.remove(State.Boxes, Index)
      return
    end
  end
end

function InsUi:SetTitle(title)
  State.Title = tostring(title)
  return self
end

function InsUi:SetSize(width, height)
  State.W = math.max(Layout.MinWidth, width)
  State.H = math.max(Layout.MinHeight, height)
  return self
end

function InsUi:SetPos(x, y)
  State.X, State.Y = x, y
  return self
end

function InsUi:Center()
  local Viewport = Camera.ViewportSize

  State.X = math.floor(Viewport.X / 2 - State.W / 2)
  State.Y = math.floor(Viewport.Y / 2 - State.H / 2)

  return self
end

function InsUi:SetMenuKey(key)
  State.MenuKey = KeyName.Plain(key)

  return self
end

function InsUi:Toggle()
  State.Open = not State.Open
  return self
end

function InsUi:Destroy()
  State.Alive = false
  State.Open = false

  setrobloxinput(true)

  for Kind, List in pairs(Pool) do
    for Index = 1, #List do
      List[Index].Visible = false
      List[Index]:Remove()
      List[Index] = nil
      Cache[Kind][Index] = nil
    end
  end

  for _, Tab in ipairs(State.Tabs) do
    if Tab.Image then Tab.Image:Remove() end
    if Tab.ImageOn then Tab.ImageOn:Remove() end
  end

  State.Tabs = {}

  for _, Key in ipairs({ LibName, LibName .. "UI", "INSUI" }) do
    if _G[Key] == InsUi then _G[Key] = nil end
  end

  return self
end

function InsUi:SetAutoLoad(name)
  WriteAutoload(name)
  return self
end

function InsUi:GetAutoLoad()
  return ReadAutoload()
end

function InsUi:SetOpen(open)
  State.Open = open == true
  return self
end

function InsUi:SetLayout(mode)
  State.TabLayout = (mode == "Top" or mode == "top") and "top" or "side"

  return self
end

function InsUi:BackgroundEffects()
  return EffectNames
end

function InsUi:SetBackgroundEffect(name)
  State.Effect = nil

  for Index = 1, #EffectNames do
    if EffectNames[Index] == name and name ~= "Off" then State.Effect = name end
  end

  return self
end

function InsUi:SetBackgroundEffectColor(color)
  State.EffectColor = color

  return self
end

function InsUi:SetGameInput(on)
  State.GameInput = (on == "always") and "always" or (on ~= false)

  ApplyInputState(true)

  return self
end

function InsUi:SetSpotlight(on)
  State.SpotlightEnabled = on ~= false

  if not State.SpotlightEnabled then ShowSpotlight(false) end

  return self
end

function InsUi:OpenSettings()
  if not SettingsTab then return self end

  for Index, Tab in ipairs(State.Tabs) do
    if Tab == SettingsTab then State.ActiveIndex = Index end
  end

  State.ActiveSub = nil
  State.ContentFade = 0

  return self
end

function ShowSpotlight(open)
  State.SpotlightOpen = open
  State.Spotlight.Value = ""
  State.Spotlight.Caret = 0
  State.Spotlight.Sel = 1
  State.Focus = open and State.Spotlight or nil
end

function InsUi:OpenSpotlight(open)
  ShowSpotlight(open ~= false)

  return self
end

function InsUi:OpenColorpicker(row)
  local Target = row.Swatch or row

  if Target.Value then StartPicker({ Row = Target, X = State.X + 80, Y = State.Y + 80 }) end

  return self
end

function InsUi:SetCheckboxStyle(on)
  State.CheckboxStyle = on == true

  return self
end

function InsUi:IsCheckboxStyle()
  return State.CheckboxStyle == true
end

function InsUi:SetPerformance(on)
  State.Lite = on == true

  return self
end

function InsUi:IsPerformance()
  return State.Lite == true
end

function InsUi:SetRounding(value)
  local Amount = tonumber(value)
  if not Amount then return self end

  if Amount > 2.5 then Amount = Amount / Layout.Percent end

  RoundScale = math.min(math.max(Amount, 0), 2.5)

  return self
end

function InsUi:GetRounding()
  return RoundScale
end

function InsUi:SetRowLines(on)
  State.RowLines = on == true

  return self
end

function InsUi:SetOpacity(value)
  local Amount = tonumber(value)
  if not Amount then return self end

  if Amount > 1 then Amount = Amount / Layout.Percent end

  State.Opacity = math.min(math.max(Amount, 0.4), 1)

  return self
end

function InsUi:SetKeybindOverlay(on)
  State.HotkeyShown = on ~= false

  return self
end

function InsUi:SetAutoSave(on)
  State.AutoSave = on == true

  return self
end

function InsUi:ExportConfig()
  return "INScfg_" .. base64encode(HttpService:JSONEncode(PackConfig()))
end

function InsUi:ImportConfig(code)
  local Body = string.match(tostring(code), "^INScfg_(.+)$") or tostring(code)

  ApplyConfig(HttpService:JSONDecode(base64decode(Body)))

  return self
end

function InsUi:SetLogo(source)
  State.Logo = LoadPicture(source, "logo")

  return self
end

function InsUi:SetIcon(source)
  State.Icon = LoadPicture(source, "icon")

  return self
end

function InsUi:SetBackgroundImage(source, alpha, widthFraction, heightFraction)
  State.Backdrop = LoadPicture(source, "bg")
  State.BackdropAlpha = alpha or State.BackdropAlpha
  State.BackdropWide = tonumber(widthFraction)
  State.BackdropTall = tonumber(heightFraction)

  return self
end

function ApplyOptions(config)
  if config.menuKey then InsUi:SetMenuKey(config.menuKey) end
  if config.gameInput ~= nil then InsUi:SetGameInput(config.gameInput) end
  if config.spotlight ~= nil then InsUi:SetSpotlight(config.spotlight) end
  if config.logo then InsUi:SetLogo(config.logo) end
  if config.logoSize then State.LogoSize = math.min(math.max(tonumber(config.logoSize), 16), 96) end
  if config.icon then InsUi:SetIcon(config.icon) end
  if config.opacity then InsUi:SetOpacity(config.opacity) end
  if config.rounding ~= nil then InsUi:SetRounding(config.rounding) end
  if config.rowLines ~= nil then InsUi:SetRowLines(config.rowLines) end
  if config.checkboxStyle ~= nil then InsUi:SetCheckboxStyle(config.checkboxStyle) end
  if config.smartFps ~= nil then State.SmartFps = config.smartFps == true end
  if config.keybindOverlay ~= nil then State.HotkeyShown = config.keybindOverlay ~= false end
  if config.theme then InsUi:SetTheme(config.theme) end
  if config.accent or config.accentA or config.accentB then InsUi:SetAccent(config.accentA or config.accent, config.accentB or config.accent) end
  if config.font then InsUi:SetFont(config.font) end
  if config.backgroundEffect then InsUi:SetBackgroundEffect(config.backgroundEffect) end
  if config.backgroundEffectColor then InsUi:SetBackgroundEffectColor(config.backgroundEffectColor) end
  if config.autoSave then InsUi:SetAutoSave(true) end
end

function InsUi:IsOpen()
  return State.Open
end

local BoxWidth, DrawBoxes

do
  local BoxIdleTint = Color3.fromRGB(120, 122, 130)
  local BoxLiveTint = Color3.fromRGB(195, 197, 205)
  local BoxReadyWords = { "READY", "FARMING", "GO" }
  local BoxIdleWords = { "PAUSED", "WAIT", "IDLE", "OFF", "SOON" }

  local function BoxHasWord(text, words)
    for Index = 1, #words do
      if string.find(text, words[Index], 1, true) then return true end
    end

    return false
  end

  local function SplitStat(value)
    local Label, Text = string.match(value, "^(.-)%s+|%s+(.+)$")
    if Label then return Label, Text end

    Label, Text = string.match(value, "^(.-):%s+(.+)$")
    if Label then return Label, Text end

    return "", value
  end

  local function BuildStat(line, lines)
    local Value = tostring(line.Value)
    if Value == "" then return end

    local Label, Text = SplitStat(Value)

    lines[#lines + 1] = { Kind = "Stat", Label = Label, Text = Text, Color = line.Color }
  end

  local function BuildBar(line, lines)
    local Number = tonumber(line.Value) or 0
    local Percent = (Number > 0 and Number <= 1) and Number * Layout.BoxFull or Number

    lines[#lines + 1] = { Kind = "Bar", Percent = math.min(math.max(Percent, 0), Layout.BoxFull) }
  end

  local function BuildText(line, lines)
    lines[#lines + 1] = { Kind = "Text", Text = tostring(line.Value), Color = line.Color }
  end

  local BoxBuilder = {
    Stat = BuildStat,
    Bar = BuildBar,
    Text = BuildText,
  }

  local function BoxContent(box)
    local Lines = {}

    for _, Line in ipairs(box.Lines) do BoxBuilder[Line.Kind](Line, Lines) end

    return Lines
  end

  function BoxWidth(box, lines)
    local Widest = TextWidth(box.Title, Layout.SmallSize, BoldFont) + Layout.BoxTitlePad

    for Index = 1, #lines do
      local Line = lines[Index]

      if Line.Kind == "Stat" then
        Widest = math.max(Widest, TextWidth(Line.Label, Layout.SmallSize, SystemFont) + TextWidth(Line.Text, Layout.SmallSize, MonoFont) + Layout.BoxStatRoom)
      elseif Line.Kind == "Bar" then
        Widest = math.max(Widest, Layout.BoxBarWidth)
      else
        Widest = math.max(Widest, TextWidth(Line.Text, Layout.SmallSize, SystemFont) + Layout.BoxTextRoom)
      end
    end

    return box.Width or math.max(Layout.BoxMinWidth, Widest)
  end

  local function DrawStatLine(line, x, y, width)
    local Upper = string.upper(line.Text)
    local Ready = BoxHasWord(Upper, BoxReadyWords)
    local Idle = BoxHasWord(Upper, BoxIdleWords) or Upper == "--" or string.match(Upper, "^%d+:%d") ~= nil
    local DotColor = Ready and Theme.Accent or (Idle and BoxIdleTint or BoxLiveTint)
    local Pulse = Alpha.BoxPulse + Alpha.BoxPulseGain * math.sin(os.clock() * Layout.BoxPulseSpeed)
    local DotAlpha = Ready and Pulse or (Idle and Alpha.BoxIdleDot or Alpha.BoxLiveDot)
    local ValueX = x + width - Layout.BoxValuePad - TextWidth(line.Text, Layout.SmallSize, MonoFont)
    local ValueColor = line.Color or Theme.Text
    local ValueAlpha = Ready and Alpha.Text or Alpha.Label

    DrawCircle(x + Layout.BoxStatDotX, y + Layout.BoxStatDotY, Layout.BoxStatDot, DotColor, 163, true, 1, Layout.BoxStatDotSides, DotAlpha)
    DrawText(line.Label, x + Layout.BoxLabelX, y, Theme.Text, Layout.SmallSize, SystemFont, 162, Alpha.Label, width - Layout.BoxLabelRoom)
    DrawText(line.Text, ValueX, y, ValueColor, Layout.SmallSize, MonoFont, 162, ValueAlpha)
  end

  local function DrawBarLine(line, x, y, width)
    local BarX = x + Layout.BoxInset
    local BarY = y + Layout.BoxBarTop
    local TrackWidth = width - Layout.BoxInset * 2
    local FillWidth = math.max(Layout.BoxBarMin, TrackWidth * line.Percent / Layout.BoxFull)

    DrawRect(BarX, BarY, TrackWidth, Layout.BoxBarHeight, Theme.Text, 162, Layout.BoxBarRadius, Alpha.Field)

    if line.Percent <= 0 then return end

    DrawRect(BarX, BarY, FillWidth, Layout.BoxBarHeight, Theme.AccentA, 163, Layout.BoxBarRadius, Alpha.BoxBarFill)
  end

  local function DrawTextLine(line, x, y, width)
    local TextColor = line.Color or Theme.Text

    DrawText(line.Text, x + Layout.BoxInset, y, TextColor, Layout.SmallSize, SystemFont, 162, Alpha.Label, width - Layout.BoxTextRoom)
  end

  local BoxDrawer = {
    Stat = DrawStatLine,
    Bar = DrawBarLine,
    Text = DrawTextLine,
  }

  local function DragBox(box)
    if not Input.Down then box.Drag = nil end

    local Drag = box.Drag
    if not Drag then return end

    if State.Open then Drag.ToX, Drag.ToY = Input.X - Drag.GrabX, Input.Y - Drag.GrabY end
    if not Drag.ToX then return end

    box.X = Approach(box.X, Drag.ToX, Layout.BoxDragSpeed)
    box.Y = Approach(box.Y, Drag.ToY, Layout.BoxDragSpeed)
  end

  local function DrawBox(box)
    if not box.Visible then return end

    DragBox(box)

    local Lines = BoxContent(box)
    local Count = #Lines
    local Width = BoxWidth(box, Lines)
    local Height = Layout.BoxTitle + Count * Layout.BoxLine + (Count > 0 and Layout.BoxPad or Layout.BoxEmptyPad)
    local X, Y = box.X, box.Y
    local TitleY = TextTop(Y, Layout.BoxTitle, Layout.SmallSize)
    local RuleY = Y + Layout.BoxTitle - Layout.BoxRuleLift
    local RuleWidth = Width - Layout.BoxRuleInset * 2
    local LineTop = Y + Layout.BoxTitle + Layout.BoxLineTop

    DrawRect(X, Y, Width, Height, Theme.Background, 160, Layout.BoxRadius, Alpha.BoxFill)
    DrawStroke(X, Y, Width, Height, Theme.Text, 161, Layout.BoxRadius, Alpha.CardStroke)
    DrawCircle(X + Layout.BoxDotX, Y + Layout.BoxTitle / 2, Layout.BoxDot, Theme.AccentA, 162, true, 1, Layout.BoxDotSides, 1)
    DrawText(box.Title, X + Layout.BoxTitleX, TitleY, Theme.Text, Layout.SmallSize, BoldFont, 162, Alpha.Text, Width - Layout.BoxTitleRoom)
    GradientRect(X + Layout.BoxRuleInset, RuleY, RuleWidth, Layout.BoxRuleHeight, Theme.AccentA, Theme.AccentB, 162, Alpha.BoxRule)

    for Index = 1, Count do
      local Line = Lines[Index]

      BoxDrawer[Line.Kind](Line, X, LineTop + (Index - 1) * Layout.BoxLine, Width)
    end

    if not State.Open or not Input.Click or box.Drag then return end
    if not IsMouseIn(X, Y, Width, Layout.BoxTitle) then return end

    box.Drag = { GrabX = Input.X - X, GrabY = Input.Y - Y }
    Input.Click = false
  end

  function DrawBoxes()
    for _, Box in ipairs(State.Boxes) do DrawBox(Box) end
  end
end

local DrawHotkeyOverlay, DrawMinBubble

do
  local HotkeyPlain = { enabled = true, enable = true, active = true, on = true }

  local function CollectHotkeys(view, list)
    for _, Section in ipairs(view.Sections) do
      for _, Row in ipairs(Section.Rows) do
        local Bind = Row.Bind

        if Bind then
          local Bound = Bind.Value ~= "" and Bind.Value ~= "none" and Row.Value == true
          local Plain = HotkeyPlain[string.lower(Row.Name)] and Section.Name ~= ""

          Row.Overlay = Approach(Row.Overlay or 0, Bound and 1 or 0, Layout.HotkeySpeed)

          if Row.Overlay > Layout.HotkeyGone then list[#list + 1] = { Name = Plain and Section.Name or Row.Name, Key = KeyName.Label(Bind.Value), Fade = Row.Overlay } end
        end
      end
    end

    for _, Sub in ipairs(view.Subs) do CollectHotkeys(Sub, list) end
  end

  function DrawHotkeyOverlay()
    if not Window or State.HotkeyShown == false then return end

    local List = {}

    for _, Tab in ipairs(State.Tabs) do CollectHotkeys(Tab, List) end

    local Span = 0

    for Index = 1, #List do Span = Span + List[Index].Fade end

    State.HotkeyFade = Approach(State.HotkeyFade or 0, 1, Layout.HotkeyFadeSpeed)

    local Fade = State.HotkeyFade
    if Fade < Layout.HotkeyGone then return end

    local Width = Layout.HotkeyWidth
    local Height = Layout.HotkeyBase + Span * Layout.HotkeyRow + Layout.HotkeyPad
    local Pos = State.HotkeyPos or { X = Layout.HotkeyX, Y = Layout.HotkeyY }
    local Viewport = Camera.ViewportSize

    State.HotkeyPos = Pos

    local Drag = State.HotkeyDrag

    if Drag then
      Pos.X = Approach(Pos.X, Input.X - Drag.X, Layout.HotkeyDragSpeed)
      Pos.Y = Approach(Pos.Y, Input.Y - Drag.Y, Layout.HotkeyDragSpeed)
    end

    local X = math.min(math.max(Pos.X, 0), math.max(0, Viewport.X - Width))
    local Y = math.min(math.max(Pos.Y, 0), math.max(0, Viewport.Y - Height))
    local RowTop = Y + Layout.HotkeyBase

    Pos.X, Pos.Y = X, Y

    DrawRect(X, Y, Width, Height, Theme.Background, 150, Layout.HotkeyRadius, Alpha.HotkeyFill * Fade)
    DrawStroke(X, Y, Width, Height, Theme.Text, 151, Layout.HotkeyRadius, Alpha.CardStroke * Fade)
    DrawText("keybinds", X + Layout.HotkeyTitleX, Y + Layout.HotkeyTitleY, Theme.Text, Layout.SmallSize, BoldFont, 152, Alpha.Text * Fade, Width - Layout.HotkeyTitleRoom)
    GradientRect(X + Layout.HotkeyRuleX, Y + Layout.HotkeyRuleY, Width - Layout.HotkeyRuleRoom, Layout.HotkeyRuleHeight, Theme.AccentA, Theme.AccentB, 152, Alpha.HotkeyRule * Fade)

    for Index = 1, #List do
      local Item = List[Index]
      local Shade = Item.Fade * Fade
      local Slide = (1 - Item.Fade) * Layout.HotkeySlide
      local ChipWidth = math.max(Layout.HotkeyChipMin, TextWidth(Item.Key, Layout.TinySize, MonoFont) + Layout.HotkeyChipPad)
      local ChipX = X + Width - Layout.HotkeyChipRight - ChipWidth + Slide
      local ChipY = RowTop + Layout.HotkeyChipInset
      local ChipHeight = Layout.HotkeyRow - Layout.HotkeyChipTrim
      local DotX = X + Layout.HotkeyDotX + Slide
      local DotY = RowTop + Layout.HotkeyRow / 2
      local LabelX = X + Layout.HotkeyLabelX + Slide
      local LabelY = TextTop(RowTop, Layout.HotkeyRow, Layout.SmallSize)
      local KeyY = RowTop + Layout.HotkeyRow / 2

      DrawCircle(DotX, DotY, Layout.HotkeyDot, Theme.AccentA, 152, true, 1, Layout.HotkeyDotSides, Shade)
      DrawText(Item.Name, LabelX, LabelY, Theme.Text, Layout.SmallSize, SystemFont, 152, Alpha.Text * Shade, Width - Layout.HotkeyLabelRoom)
      DrawRect(ChipX, ChipY, ChipWidth, ChipHeight, Theme.Text, 152, Layout.HotkeyChipRadius, Alpha.Field * Shade)
      DrawTextMid(Item.Key, ChipX + ChipWidth / 2, KeyY, Theme.Text, Layout.TinySize, MonoFont, 153, Alpha.Text * Shade)

      RowTop = RowTop + Layout.HotkeyRow * Item.Fade
    end

    if Drag then return end
    if not Input.Click then return end
    if not IsMouseIn(X, Y, Width, Layout.HotkeyGrab) then return end

    State.HotkeyDrag = { X = Input.X - X, Y = Input.Y - Y }
    Input.Click = false
  end

  function DrawMenuBars(cx, cy, size, color, z, transparency)
    local BarWidth = size * Layout.BarsWidth
    local BarThick = size * Layout.BarsThick
    local Gap = size * Layout.BarsGap
    local BarX = cx - BarWidth / 2
    local BarY = cy - BarThick / 2
    local Radius = BarThick / 2

    DrawRect(BarX, BarY - Gap, BarWidth, BarThick, color, z, Radius, transparency)
    DrawRect(BarX, BarY, BarWidth, BarThick, color, z, Radius, transparency)
    DrawRect(BarX, BarY + Gap, BarWidth, BarThick, color, z, Radius, transparency)
  end

  function DrawMinBubble()
    State.BubbleFade = Approach(State.BubbleFade, State.Rolled and 1 or 0, Layout.BubbleSpeed)

    local Shown = State.Visible
    local Live = State.BubbleFade * Shown
    if Live < Layout.BubbleGone then return end

    local Pos = State.BubblePos or { X = Layout.BubbleX, Y = Layout.BubbleY }
    local Drag = State.BubbleDrag
    local Viewport = Camera.ViewportSize

    State.BubblePos = Pos

    if Drag and Input.Down then
      local ToX = Approach(Pos.X, Input.X - Drag.X, Layout.BubbleDragSpeed)
      local ToY = Approach(Pos.Y, Input.Y - Drag.Y, Layout.BubbleDragSpeed)

      if math.abs(Input.X - Drag.DownX) + math.abs(Input.Y - Drag.DownY) > Layout.BubbleSlop then Drag.Moved = true end

      Pos.X = math.min(math.max(ToX, 0), math.max(0, Viewport.X - Layout.BubbleSize))
      Pos.Y = math.min(math.max(ToY, 0), math.max(0, Viewport.Y - Layout.BubbleSize))
    end

    if Drag and not Input.Down then
      if not Drag.Moved then
        State.X, State.Y = Pos.X, Pos.Y
        State.Rolled = false
      end

      State.BubbleDrag = nil
    end

    local Grow = State.BubbleFade
    local Ease = Grow * Grow * (3 - 2 * Grow)
    local Size = Layout.BubbleSize
    local BoxX = State.X + (Pos.X - State.X) * Ease
    local BoxY = State.Y + (Pos.Y - State.Y) * Ease
    local BoxWidth = State.W + (Size - State.W) * Ease
    local BoxHeight = State.H + (Size - State.H) * Ease
    local Radius = Layout.BubbleRadius + Ease
    local Cx, Cy = BoxX + BoxWidth / 2, BoxY + BoxHeight / 2
    local Settled = State.BubbleFade > Layout.BubbleSettled
    local Hovered = Settled and IsMouseIn(BoxX, BoxY, BoxWidth, BoxHeight)
    local Glow = Approach(State.BubbleGlow or 0, Hovered and 1 or 0, Layout.BubbleGlowSpeed)

    State.BubbleGlow = Glow

    local Fill = Blend(Theme.Background, Theme.Accent, Ease)
    local Crown = Blend(Theme.Accent, Theme.Text, Layout.BubbleCrownMix)
    local GlowOut = Layout.BubbleGlowOut
    local FillAlpha = (Alpha.BubbleFill - Alpha.BubbleFillFade * Ease) * Shown
    local EdgeAlpha = (Alpha.BubbleEdge + Alpha.BubbleEdgeGrow * Ease + Alpha.BubbleEdgeHover * Glow) * Shown

    for Index = 1, Layout.BubbleShadowSteps do
      local Spread = Index * Layout.BubbleShadowStep

      DrawRect(BoxX - Spread, BoxY - Spread + Layout.BubbleShadowLift, BoxWidth + Spread * 2, BoxHeight + Spread * 2, Black, 199, Radius + Spread, (Alpha.BubbleShadow - Index * Alpha.BubbleShadowFall) * Ease * Shown)
    end

    DrawRect(BoxX - GlowOut, BoxY - GlowOut, BoxWidth + GlowOut * 2, BoxHeight + GlowOut * 2, Theme.Accent, 200, Radius + Layout.BubbleGlowRadius, Alpha.BubbleGlow * Glow * Shown)
    DrawRect(BoxX, BoxY, BoxWidth, BoxHeight, Fill, 201, Radius, FillAlpha)
    DrawRect(BoxX, BoxY, BoxWidth, BoxHeight * Layout.BubbleCrown, Crown, 202, Radius, Alpha.BubbleCrown * Ease * Shown)
    DrawStroke(BoxX, BoxY, BoxWidth, BoxHeight, Theme.Text, 203, Radius, EdgeAlpha)

    if Ease > Layout.BubbleIconAt then
      local IconAlpha = math.min(math.max((Ease - Layout.BubbleIconAt) / Layout.BubbleIconSpan, 0), 1) * Shown

      DrawMenuBars(Cx, Cy, BoxHeight, BarTint, 204, IconAlpha)
    end

    if not Hovered then return end
    if not Input.Click then return end
    if State.BubbleDrag then return end

    State.BubbleDrag = { X = Input.X - BoxX, Y = Input.Y - BoxY, DownX = Input.X, DownY = Input.Y, Moved = false }
    Input.Click = false
  end
end

local DrawSpotlight

do
  local function FuzzyScore(query, text)
    local QueryLength, TextLength = #query, #text

    if QueryLength == 0 then return 0 end

    local QueryIndex, TextIndex, First, Prev, Gaps = 1, 1, nil, 0, 0

    while QueryIndex <= QueryLength and TextIndex <= TextLength do
      if string.sub(query, QueryIndex, QueryIndex) == string.sub(text, TextIndex, TextIndex) then
        if not First then First = TextIndex elseif TextIndex - Prev > 1 then Gaps = Gaps + 1 end

        Prev = TextIndex
        QueryIndex = QueryIndex + 1
      end

      TextIndex = TextIndex + 1
    end

    if QueryIndex <= QueryLength then return nil end

    local Head = (First == 1 or string.sub(text, First - 1, First - 1) == " ") and -Layout.FuzzyHead or 0

    return (First - 1) + Gaps * Layout.FuzzyGap + Head
  end

  local function SpotlightOrder(first, second)
    if first.Score ~= second.Score then return first.Score < second.Score end

    return first.Name < second.Name
  end

  local function AddSpotlightResult(found, tab, index, section, row, needle)
    if not row.Name then return end
    if row.Kind == "Divider" or row.Kind == "Label" then return end

    local Score = needle == "" and 0 or FuzzyScore(needle, string.lower(row.Name))
    if not Score then return end

    found[#found + 1] = { Tab = tab, Index = index, Row = row, Name = row.Name, Path = tab.Name .. "  >  " .. section.Name, Kind = row.Kind, Score = Score }
  end

  local function SpotlightResults(query)
    local Needle = string.lower(query)
    local Found = {}

    for Index, Tab in ipairs(State.Tabs) do
      for _, Section in ipairs(Tab.Sections) do
        for _, Row in ipairs(Section.Rows) do AddSpotlightResult(Found, Tab, Index, Section, Row, Needle) end
      end
    end

    table.sort(Found, SpotlightOrder)

    return Found
  end

  local function SpotlightJump(result)
    if not result then return end

    if State.ActiveIndex ~= result.Index then
      State.ActiveIndex = result.Index
      State.ActiveSub = nil
      State.ContentFade = 0
    end

    result.Row.Reveal = os.clock() + Layout.RevealTime
    State.SpotJump = result.Row
    State.Rolled = false
    State.Open = true
    State.SpotlightOpen = false
  end

  local function ResetSpotlightSelection()
    State.Spotlight.Sel = 1
  end

  State.Spotlight.Callback = ResetSpotlightSelection

  local function DrawSpotlightField(x, y, width, fade)
    local Spot = State.Spotlight
    local Open = State.SpotlightOpen
    local Value = Spot.Value
    local Length = #Value
    local TextX = x + Layout.SpotQueryX
    local TextY = TextTop(y, Layout.SpotField, Layout.SpotText)
    local Room = width - Layout.SpotTextRoom
    local CharWidth = Layout.SpotText * Layout.EditWidth
    local Caret = math.min(math.max(Spot.Caret or Length, 0), Length)
    local Fit = math.max(1, math.floor(Room / CharWidth))
    local Scroll = Open and Caret > Fit and Caret - Fit or 0
    local Shown = string.sub(Value, Scroll + 1, math.min(Length, Scroll + Fit))
    local Anchor = Spot.Anchor or Caret
    local Selecting = Open and Spot.Anchor ~= nil and Spot.Anchor ~= Caret
    local Blink = os.clock() % 1 < Layout.CaretBlink
    local Low = math.min(math.max(math.min(Anchor, Caret) - Scroll, 0), #Shown)
    local High = math.min(math.max(math.max(Anchor, Caret) - Scroll, 0), #Shown)
    local CaretX = TextX + math.min(math.max(Caret - Scroll, 0), #Shown) * CharWidth
    local SelectX = TextX + Low * CharWidth
    local SelectWidth = math.max(1, (High - Low) * CharWidth)
    local SelectShade = High > Low and Alpha.Select * Alpha.Text * fade or 0
    local Accent = Blend(Theme.AccentA, Theme.AccentB, Layout.ShimmerMix)
    local Hit = math.min(math.max(Scroll + math.floor((Input.X - TextX) / CharWidth + 0.5), 0), Length)

    if Value == "" and not Open then
      DrawText("Search widgets...", TextX, TextY, Theme.Text, Layout.SpotText, SystemFont, 402, Alpha.Placeholder * fade, Room)
      return
    end

    for Index = 1, #Shown do
      DrawText(string.sub(Shown, Index, Index), TextX + (Index - 1) * CharWidth, TextY, Theme.Text, Layout.SpotText, UiFont, 402, Alpha.Text * fade)
    end

    if Open and not Selecting and Blink then DrawRect(CaretX, TextY, Layout.CaretWidth, Layout.SpotText, Theme.Text, 402, 0, Alpha.Text * fade) end
    if Selecting then DrawRect(SelectX, TextY - Layout.SelectLift, SelectWidth, Layout.SpotText + Layout.SelectGrow, Accent, 402, Layout.SelectRadius, SelectShade) end
    if not Open then return end

    if Input.Click and IsMouseIn(x + Layout.SpotHitX, y, width - Layout.SpotHitRoom, Layout.SpotField) then
      Spot.Caret = Hit
      Spot.Anchor = Hit
      State.TextDrag = Spot
      Input.Click = false
    end

    if not State.TextDrag then return end
    if State.TextDrag ~= Spot then return end

    Spot.Caret = Hit
  end

  local function DrawSpotlightRow(result, index, x, width, rowWidth, areaTop, areaHeight, smooth, moved, fade)
    local Spot = State.Spotlight
    local RowY = areaTop + (index - smooth) * Layout.SpotRow

    if RowY + Layout.SpotRow <= areaTop or RowY >= areaTop + areaHeight then return end

    local EdgeFade = math.min(math.max((RowY + Layout.SpotRow - areaTop) / Layout.SpotRow, 0), 1) * math.min(math.max((areaTop + areaHeight - RowY) / Layout.SpotRow, 0), 1)
    local Shade = fade * EdgeFade
    local RowX = x + Layout.SpotRowX
    local Inside = RowY >= areaTop - Layout.SpotSlack and RowY + Layout.SpotRow <= areaTop + areaHeight + Layout.SpotSlack
    local Hovered = Inside and IsMouseIn(RowX, RowY, rowWidth, Layout.SpotRow)

    if Hovered and moved and not Spot.BarDrag then Spot.Sel = index + 1 end

    local Selected = index + 1 == Spot.Sel
    local Height = Layout.SpotRow - Layout.SpotRowTrim
    local FillY = RowY + Layout.SpotRowLift
    local Accent = Blend(Theme.AccentA, Theme.AccentB, Layout.ShimmerMix)
    local NameRoom = width - Layout.SpotNameRoom
    local Kind = KindName[result.Kind]
    local KindX = x + rowWidth - Layout.SpotKindPad - TextWidth(Kind, Layout.TinySize, SystemFont)

    DrawRect(RowX, FillY, rowWidth, Height, Accent, 401, Layout.SpotRowRadius, (Selected and Alpha.SpotSelect or 0) * Shade)
    DrawRect(RowX, FillY, Layout.SpotMark, Height, Accent, 402, Layout.SpotMarkRadius, (Selected and Alpha.SpotMark or 0) * Shade)
    DrawText(result.Name, x + Layout.SpotNameX, RowY + Layout.SpotNameY, Theme.Text, Layout.SpotName, BoldFont, 402, Alpha.Text * Shade, NameRoom)
    DrawText(result.Path, x + Layout.SpotNameX, RowY + Layout.SpotPathY, Theme.Text, Layout.TinySize, SystemFont, 402, Alpha.Dim * Shade, NameRoom)
    DrawText(Kind, KindX, TextTop(RowY, Layout.SpotRow, Layout.TinySize), Theme.Text, Layout.TinySize, SystemFont, 402, Alpha.Dim * Shade)

    if not Inside or not Input.Click or not Hovered then return end

    SpotlightJump(result)

    Input.Click = false
  end

  local function DrawSpotlightBar(count, x, width, areaTop, areaHeight, maxOffset, fade)
    local Spot = State.Spotlight
    local BarX = x + width - Layout.SpotBarInset
    local ThumbHeight = math.max(Layout.ThumbMin, areaHeight * Layout.SpotRows / count)
    local Fraction = Spot.Offset / maxOffset
    local ThumbY = areaTop + (areaHeight - ThumbHeight) * Fraction
    local Grab = IsMouseIn(BarX - Layout.TrackReach, areaTop, Layout.TrackGrab, areaHeight)
    local Target = (Grab or Spot.BarDrag) and 1 or 0

    Spot.BarGlow = Approach(Spot.BarGlow or 0, Target, Layout.ThumbGlowSpeed)

    if math.abs(Spot.BarGlow - Target) < Layout.ThumbGlowSnap then Spot.BarGlow = Target end

    local Glow = Spot.BarGlow
    local BarColor = Blend(Theme.AccentA, Theme.AccentB, Fraction)
    local ThumbColor = Blend(Theme.Text, BarColor, Layout.ThumbMix)

    DrawRect(BarX, areaTop, Layout.TrackWidth, areaHeight, Theme.Text, 403, Layout.TrackRadius, Alpha.Track * fade)
    DrawRect(BarX - Layout.ThumbHaloX, ThumbY - Layout.ThumbHaloY, Layout.ThumbHaloWidth, ThumbHeight + Layout.ThumbHaloGrow, BarColor, 404, Layout.ThumbHaloRadius, Alpha.ThumbHalo * Glow * fade)
    DrawRect(BarX, ThumbY, Layout.ThumbWidth, ThumbHeight, ThumbColor, 404, Layout.ThumbRadius, (Alpha.Thumb + Alpha.ThumbGlow * Glow) * fade)

    if Input.Click and Grab then Spot.BarDrag = true Input.Click = false end
    if not Spot.BarDrag or not Input.Down then return end

    local Along = math.min(math.max((Input.Y - areaTop - ThumbHeight / 2) / math.max(1, areaHeight - ThumbHeight), 0), 1)

    Spot.Offset = math.min(math.max(math.floor(Along * maxOffset + 0.5), 0), maxOffset)
    Spot.Sel = math.min(math.max(Spot.Sel, Spot.Offset + 1), Spot.Offset + Layout.SpotRows)
  end

  function DrawSpotlight()
    local Spot = State.Spotlight

    if not Spot then Spot = { Value = "", Caret = 0, Sel = 1, Offset = 0, Callback = ResetSpotlightSelection } State.Spotlight = Spot end

    State.SpotlightFade = Approach(State.SpotlightFade or 0, State.SpotlightOpen and 1 or 0, Layout.SpotSpeed)

    local Fade = State.SpotlightFade
    if Fade < Layout.SpotGoneAt then return end

    local Open = State.SpotlightOpen

    if Open and Keys.Escape.Click then State.SpotlightOpen = false Keys.Escape.Click = false end

    local Live = State.SpotlightOpen
    local Jump = Live and Keys.Enter.Click

    if Open then Keys.Enter.Click = false end
    if Spot.Value ~= Spot.Query then Spot.Query, Spot.Results = Spot.Value, SpotlightResults(Spot.Value) end

    local Results = Spot.Results
    local Count = #Results

    Spot.Sel = math.min(math.max(Spot.Sel, 1), math.max(1, Count))

    if Live and Keys.Down.Click then Spot.Sel = math.min(Count, Spot.Sel + 1) Keys.Down.Click = false end
    if Live and Keys.Up.Click then Spot.Sel = math.max(1, Spot.Sel - 1) Keys.Up.Click = false end
    if Jump then SpotlightJump(Results[Spot.Sel]) return end

    local MaxOffset = math.max(0, Count - Layout.SpotRows)

    Spot.Offset = math.min(math.max(Spot.Offset, 0), MaxOffset)

    if Spot.Sel - 1 < Spot.Offset then Spot.Offset = Spot.Sel - 1 end
    if Spot.Sel - 1 > Spot.Offset + Layout.SpotRows - 1 then Spot.Offset = Spot.Sel - Layout.SpotRows end

    Spot.Offset = math.min(math.max(Spot.Offset, 0), MaxOffset)
    Spot.Smooth = Approach(Spot.Smooth or Spot.Offset, Spot.Offset, Layout.SpotScrollSpeed)

    local View = Camera.ViewportSize
    local Width = Layout.SpotWidth
    local Shown = math.min(Count, Layout.SpotRows)
    local Height = Layout.SpotHead + (Shown > 0 and (Shown * Layout.SpotRow + Layout.SpotPad) or Layout.SpotEmpty)
    local X = math.floor((View.X - Width) / 2)
    local Y = math.floor(View.Y * Layout.SpotTop)
    local RuleWidth = Width - Layout.SpotRuleX * 2
    local AreaTop = Y + Layout.SpotHead
    local AreaHeight = Layout.SpotRows * Layout.SpotRow
    local RowWidth = Count > Layout.SpotRows and (Width - Layout.SpotRowRoom) or (Width - Layout.SpotRowWide)
    local Smooth = Spot.Smooth
    local Moved = Input.X ~= Spot.MouseX or Input.Y ~= Spot.MouseY

    Spot.MouseX, Spot.MouseY = Input.X, Input.Y

    DrawRect(0, 0, View.X, View.Y, Black, 398, 0, Alpha.SpotVeil * Fade)
    DrawRect(X, Y, Width, Height, Theme.Background, 400, Layout.SpotRadius, Alpha.SpotFill * Fade)
    DrawStroke(X, Y, Width, Height, Theme.Text, 401, Layout.SpotRadius, Alpha.CardStroke * Fade)
    DrawCircle(X + Layout.SpotGlassX, Y + Layout.SpotGlassY, Layout.SpotGlass, Theme.Text, 402, false, Layout.SpotGlassThick, Layout.SpotGlassSides, Alpha.Label * Fade)
    DrawLine(X + Layout.SpotHandleX, Y + Layout.SpotHandleY, X + Layout.SpotHandleTipX, Y + Layout.SpotHandleTipY, Theme.Text, 402, Layout.SpotGlassThick, Alpha.Label * Fade)
    GradientRect(X + Layout.SpotRuleX, Y + Layout.SpotRuleY, RuleWidth, Layout.SpotRuleHeight, Theme.AccentA, Theme.AccentB, 402, Alpha.SpotRule * Fade)
    DrawSpotlightField(X, Y, Width, Fade)

    if Count == 0 then DrawText("no matches", X + Layout.SpotEmptyX, Y + Layout.SpotEmptyY, Theme.Text, Layout.TextSize, SystemFont, 402, Alpha.Dim * Fade, Width - Layout.SpotEmptyRoom) end

    for Step = 0, Layout.SpotRows do
      local Index = math.floor(Smooth) + Step
      local Result = Index >= 0 and Results[Index + 1] or nil

      if Result then DrawSpotlightRow(Result, Index, X, Width, RowWidth, AreaTop, AreaHeight, Smooth, Moved, Fade) end
    end

    if MaxOffset > 0 then DrawSpotlightBar(Count, X, Width, AreaTop, AreaHeight, MaxOffset, Fade) end
    if not Input.Click then return end
    if IsMouseIn(X, Y, Width, Height) then return end

    State.SpotlightOpen = false
    Input.Click = false
  end
end

local ApplyAccents, ThemeSection, AppearanceSection, InterfaceSection, ConfigSection, SystemSection

do
  local function PresetNames()
    local Names = {}

    for Name in pairs(ThemePresets) do Names[#Names + 1] = Name end

    table.sort(Names)

    return Names
  end

  function ApplyAccents(first, second)
    Theme.AccentA, Theme.AccentB = first, second
    Theme.Accent = Blend(first, second, Layout.ShimmerMix)
  end

  function ThemeSection(tab)
    local Look = tab:Section("Theme", "Left")
    local Choices = { "Default" }
    local Preset, First, Second

    for _, Name in ipairs(PresetNames()) do Choices[#Choices + 1] = Name end

    local function MarkCustom()
      if not State.Loading then Preset:Set({ "Custom" }) end
    end

    local function PickPreset(value)
      local Name = value[1]

      if Name == "Default" then
        local Shipped = State.Shipped

        ApplyAccents(Shipped.AccentA, Shipped.AccentB)

        Theme.Background, Theme.Text = Shipped.Background, Shipped.Text
        First.Value, Second.Value = Shipped.AccentA, Shipped.AccentB

        return
      end

      local Pair = ThemePresets[Name]
      if not Pair then return end

      ApplyAccents(Pair[1], Pair[2])

      Theme.Background = PresetBackground[Name] or DefaultBackground
      First.Value, Second.Value = Pair[1], Pair[2]
    end

    local function PickFirst(color)
      ApplyAccents(color, State.BaseAccentB)
      MarkCustom()
    end

    local function PickSecond(color)
      ApplyAccents(State.BaseAccentA, color)
      MarkCustom()
    end

    local function SetRainbow(on)
      if not on then ApplyAccents(State.BaseAccentA, State.BaseAccentB) end

      State.Rainbow = on
    end

    Preset = Look:Dropdown("Preset", { "Default" }, Choices, false, PickPreset, "Default = the look this script ships with; pick a preset, or a colour below for Custom", true)
    First = Look:Colorpicker("Color 1", Theme.AccentA, PickFirst)
    Second = Look:Colorpicker("Color 2", Theme.AccentB, PickSecond)

    Look:Toggle("Rainbow", State.Rainbow == true, SetRainbow)
    Look:Slider("Rainbow speed", 30, 1, 5, 200, "%", function(value) State.RainbowSpeed = value / Layout.Percent end)
end

  function AppearanceSection(tab)
    local Look = tab:Section("Appearance", "Left")

    local function SetBorder(value)
      Alpha.CardStroke = value / Layout.Percent
      Alpha.Hairline = value / Layout.Percent * Layout.BorderRatio
    end

    Look:Colorpicker("Background", Theme.Background, function(color) Theme.Background = color end, 1)
    Look:Colorpicker("Text color", Theme.Text, function(color) Theme.Text = color end, 1)
    Look:Slider("Card glow", 100, 5, 0, 200, "%", function(value) State.Glow = value / Layout.Percent end, "strength of the accent glow when you hover a section card")
    Look:Dropdown("Background FX", { State.Effect or "Off" }, EffectNames, false, function(value) InsUi:SetBackgroundEffect(value[1]) end, "decorative particles behind the menu (off by default)")
    Look:Colorpicker("FX colour", White, function(color) State.EffectColor = color end, 1):Tooltip("recolour the background particles; untouched = each effect's own colour")
    Look:Slider("Border", Layout.BorderAmount, Layout.BorderStep, Layout.BorderMin, Layout.BorderMax, "", SetBorder, "how visible the card / control outlines are")
    Look:Slider("Frost", Layout.FrostAmount, Layout.FrostStep, Layout.FrostMin, Layout.FrostMax, "", function(value) Alpha.Card = value / Layout.Percent end, "how milky the card fills are")
    Look:Slider("Corner radius", math.floor(RoundScale * Layout.Percent + 0.5), 5, 0, 250, "%", function(value) InsUi:SetRounding(value) end, "roundness of every corner; 100% = default, 0% = sharp")
    Look:Toggle("Performance mode", State.Lite == true, function(on) State.Lite = on end, "lite rendering for weak PCs: 60fps, no shadow / outer glow / animations, sidebar stays open")
    Look:Toggle("Smart FPS", State.SmartFps ~= false, function(on) State.SmartFps = on end, "drop to ~30fps when idle / minimized / closed and jump to full speed on activity, frees the CPU for the game")
  end

  function InterfaceSection(tab)
    local Panel = tab:Section("Interface", "Right")
    local Style = State.SearchStyle

    local function SetMenuKey(key)
      InsUi:SetMenuKey(key)
      InsUi:Notify("menu key", "set to " .. string.upper(key), 2)
    end

    local function SetFont(value)
      InsUi:SetFont(value[1])
      InsUi:Notify("ui", "font: " .. value[1], 2)
    end

    Panel:Keybind("Menu key", State.MenuKey, SetMenuKey, "the key that opens / closes this menu")
    Panel:Toggle("Keybind overlay", State.HotkeyShown ~= false, function(on) State.HotkeyShown = on end)
Panel:Toggle("Hover effects", State.HoverEffects ~= false, function(on) State.HoverEffects = on end)
Panel:Toggle("Checkbox style", State.CheckboxStyle == true, function(on) State.CheckboxStyle = on end, "Draw every toggle as a filling checkbox instead of a switch")
    Panel:Toggle("Collapse sidebar", not State.RailPinned, function(on) State.RailPinned = not on end, "on = the sidebar shrinks to an icon rail and expands on hover; off = it always stays open")
    Panel:Toggle("Inline dropdowns", State.DropdownInline == true, function(on) State.DropdownInline = on end, "put the dropdown box on the same row as its label instead of below it")
    Panel:Dropdown("Tab layout", { State.TabLayout == "top" and "Top" or "Sidebar" }, { "Sidebar", "Top" }, false, function(value) InsUi:SetLayout(value[1]) end, "tabs on the left rail or across the top")
    Panel:Dropdown("Search", { string.upper(string.sub(Style, 1, 1)) .. string.sub(Style, 2) }, { "Bar", "Icon", "Off" }, false, function(value) State.SearchStyle = string.lower(value[1]) end, "titlebar search: a bar, just an icon, or hidden (Ctrl+Space always works)")
    Panel:Dropdown("Font", { State.FontName or "Default" }, InsUi:FontChoices(), false, SetFont, "UI font, built-ins only (custom web fonts can't be loaded into Drawing)", true)
    Panel:Slider("Menu opacity", 98, 1, 40, 100, "%", function(value) State.Opacity = value / Layout.Percent end)
Panel:Toggle("Animations", State.NoAnim ~= true, function(on) State.NoAnim = not on end)
Panel:Slider("Notify time", 5, 1, 1, 15, "s", function(value) State.NoteDuration = value end)
end

  function ConfigSection(tab)
    local Panel = tab:Section("Configs", "Right")
    local NameBox = Panel:Textbox("Name", State.ConfigName, function(text) State.ConfigName = text ~= "" and text or "default" end)

local Saved, Auto

    NameBox.NoSave = true

    local function AutoChoices()
      local List = { "Off" }

      for _, Name in ipairs(InsUi:ListConfigs()) do List[#List + 1] = Name end

      return List
    end

    local function Refresh()
      Saved:UpdateChoices(InsUi:ListConfigs())
      Auto:UpdateChoices(AutoChoices())
    end

    local function SaveNow()
      InsUi:SaveConfig(State.ConfigName)
      Refresh()
      InsUi:Notify("config", "saved: " .. tostring(State.ConfigName), 4, "success")
    end

    local function LoadNow()
      for _, Name in ipairs(InsUi:ListConfigs()) do
        if Name == State.ConfigName then
          InsUi:LoadConfig(Name)
          InsUi:Notify("config", "loaded: " .. tostring(Name), 3)

          return
        end
      end

      InsUi:Notify("config", "no config named " .. tostring(State.ConfigName), 3, "warning")
    end

    local function DeleteNow()
      InsUi:DeleteConfig(State.ConfigName)
      Saved:Set({})
      Refresh()
      InsUi:Notify("config", "deleted", 3, "warning")
    end

    local function PickConfig(value)
      if not value[1] then return end

      State.ConfigName = value[1]

      NameBox:Set(value[1])
    end

    local function SetAutoSave(on)
      InsUi:SetAutoSave(on)
      WriteAutoSave(on)
      InsUi:Notify("config", on and "auto-save on" or "auto-save off", 2)
    end

    local function PickAutoload(value)
      local Pick = value[1]

      WriteAutoload(Pick ~= "Off" and Pick or nil)
      InsUi:Notify("config", Pick ~= "Off" and ("auto-load: " .. Pick) or "auto-load off", Pick ~= "Off" and 3 or 2)
    end

    Panel:Button("Save", SaveNow):AddButton("Load", LoadNow):AddButton("Delete", DeleteNow)

    Saved = Panel:Dropdown("Config", {}, InsUi:ListConfigs(), false, PickConfig, "pick a saved config, then Load or Delete it", true)
    Saved.NoSave = true

    local Wanted = ReadAutoSave()

    if Wanted ~= nil then State.AutoSave = Wanted end

    Panel:Toggle("Auto-save", State.AutoSave == true, SetAutoSave, "save changes to the current config automatically as you change things; off = nothing is written until you press Save").NoSave = true

    Auto = Panel:Dropdown("Auto-load", { ReadAutoload() or "Off" }, AutoChoices(), false, PickAutoload, "load a config every launch (Off = none); separate from Auto-save", true)
    Auto.NoSave = true
  end

  function SystemSection(tab)
    local Panel = tab:Section("System", "Right")

    local function Recenter()
      InsUi:Center()
      InsUi:Notify("ui", "re-centered", 2)
    end

    Panel:Button("Re-center window", Recenter)
    Panel:Button("Minimize", Minimize)
  end
end

function BuildSettingsTab(window, icon)
  EnsureFolder()

  local Tab = window:Tab("Settings", icon or "cog")

  State.Shipped = { AccentA = Theme.AccentA, AccentB = Theme.AccentB, Background = Theme.Background, Text = Theme.Text }
  State.BaseAccentA = Theme.AccentA
  State.BaseAccentB = Theme.AccentB

  ThemeSection(Tab)
  AppearanceSection(Tab)
  InterfaceSection(Tab)
  ConfigSection(Tab)
  SystemSection(Tab)

  return Tab
end

do
  local function EachSavedRow(visit)
    for _, Tab in ipairs(State.Tabs) do
      for _, Section in ipairs(Tab.Sections) do
        for _, Row in ipairs(Section.Rows) do
          if type(Row.Name) == "string" and not Row.NoSave and Row.Kind ~= "Button" then visit(Tab.Name .. "." .. Section.Name .. "." .. Row.Name, Row) end
        end
      end
    end
  end

  function PackConfig()
    local Data = { flags = {}, keybinds = {}, colors = {}, uiFont = State.FontName, layout = State.TabLayout, search = State.SearchStyle }

    EachSavedRow(function(key, row)
      if row.Kind == "Range" then
        Data.flags[key] = { row.Low, row.High }
      elseif row.Kind == "Color" then
        Data.flags[key] = { row.Value.R, row.Value.G, row.Value.B, row.Alpha or 1 }
      elseif row.Kind == "Dropdown" then
        Data.flags[key] = CopyList(row.Value)
      elseif row.Value ~= nil then
        Data.flags[key] = row.Value
      end

      if row.Swatch then Data.colors[key] = { row.Swatch.Value.R, row.Swatch.Value.G, row.Swatch.Value.B, row.Swatch.Alpha or 1 } end
      if row.Bind then Data.keybinds[key] = { row.Bind.Value, row.Bind.Mode } end
    end)

local AccentA = State.BaseAccentA or Theme.AccentA
    local AccentB = State.BaseAccentB or Theme.AccentB
    local Effect = State.EffectColor

    Data.settings = {
      accentA = { AccentA.R, AccentA.G, AccentA.B },
      accentB = { AccentB.R, AccentB.G, AccentB.B },
      bg = { Theme.Background.R, Theme.Background.G, Theme.Background.B },
      txt = { Theme.Text.R, Theme.Text.G, Theme.Text.B },
      rainbow = State.Rainbow == true,
      rainbowSpeed = State.RainbowSpeed,
      menuOpacity = State.Opacity,
      noAnim = State.NoAnim == true,
      notifyDur = State.NoteDuration,
      hoverEffects = State.HoverEffects ~= false,
      checkboxStyle = State.CheckboxStyle == true,
      hotkeyEnabled = State.HotkeyShown ~= false,
      menuKey = State.MenuKey,
      w = State.W,
      h = State.H,
      glowMul = State.Glow,
      cardStrk = Alpha.CardStroke,
      hairline = Alpha.Hairline,
      cardFill = Alpha.Card,
      lite = State.Lite == true,
      roundScale = RoundScale,
      smartFps = State.SmartFps ~= false,
      sidebarPinned = State.RailPinned == true,
      dropdownInline = State.DropdownInline == true,
      bgImg = State.BackdropSource,
      bgImgA = State.BackdropAlpha,
      bgFx = State.Effect,
      bgFxColor = Effect and { Effect.R, Effect.G, Effect.B } or nil,
      logo = State.LogoSource,
      icon = State.IconSource,
    }

    return Data
  end

  local function UnpackColor(parts)
    return Color3.new(parts[1], parts[2], parts[3])
  end

  local function SameList(first, second)
    if #first ~= #second then return false end

    for Index = 1, #first do
      if first[Index] ~= second[Index] then return false end
    end

    return true
  end

  local function ApplyRow(row, saved, bind, swatch)
    if row.Kind == "Range" then
      local Low, High = SnapValue(saved[1], row), SnapValue(saved[2], row)

      if Low > High then Low, High = High, Low end

      if Low ~= row.Low or High ~= row.High then
        row.Low, row.High = Low, High

        row.Callback(Low, High)
      end
    elseif row.Kind == "Color" then
      local Color = Color3.new(saved[1], saved[2], saved[3])
      local Shade = saved[4] or 1

      if Color ~= row.Value or Shade ~= row.Alpha then
        row.Value, row.Alpha = Color, Shade

        row.Callback(Color, Shade)
      end
    elseif row.Kind == "Dropdown" then
      if not SameList(saved, row.Value) then
        row.Value = CopyList(saved)

        row.Callback(row.Value)
      end
    elseif saved ~= row.Value then
      row.Value = saved

      row.Callback(saved)
    end

    if bind and row.Bind then row.Bind.Value, row.Bind.Mode = bind[1], bind[2] end
    if not swatch or not row.Swatch then return end

    row.Swatch.Value = Color3.new(swatch[1], swatch[2], swatch[3])
    row.Swatch.Alpha = swatch[4] or 1

    row.Swatch.Callback(row.Swatch.Value, row.Swatch.Alpha)
  end

  local SettingsMirror = {
    ["Performance mode"] = "Lite",
    ["Smart FPS"] = "SmartFps",
    ["Hover effects"] = "HoverEffects",
    ["Keybind overlay"] = "HotkeyShown",
    ["Inline dropdowns"] = "DropdownInline",
    ["Rainbow"] = "Rainbow",
    ["Checkbox style"] = "CheckboxStyle",
  }

  local function MirrorSettings()
    if not SettingsTab then return end

    for _, Section in ipairs(SettingsTab.Sections) do
      for _, Row in ipairs(Section.Rows) do
        local Field = SettingsMirror[Row.Name]

        if Row.Kind ~= "Toggle" then
        elseif Field then Row.Value = State[Field] == true
        elseif Row.Name == "Animations" then Row.Value = State.NoAnim ~= true
        elseif Row.Name == "Collapse sidebar" then Row.Value = not State.RailPinned end
      end
    end
  end

  function ApplyConfig(data)
    if not data then return end

    local Flags = data.flags or {}
    local Binds = data.keybinds or {}
    local Colors = data.colors or {}

    State.Loading = true

    if data.uiFont then InsUi:SetFont(data.uiFont) end
    if data.layout then State.TabLayout = data.layout end
    if data.search then State.SearchStyle = data.search end

    EachSavedRow(function(key, row)
      local Saved = Flags[key]

      if Saved ~= nil then ApplyRow(row, Saved, Binds[key], Colors[key]) end
    end)

local Settings = data.settings

    if Settings then
      local Rainbow = Settings.rainbow == true

      if Settings.accentA and Settings.accentB then
        State.BaseAccentA = UnpackColor(Settings.accentA)
        State.BaseAccentB = UnpackColor(Settings.accentB)

        if not Rainbow then ApplyAccents(State.BaseAccentA, State.BaseAccentB) end
      end

      if Settings.bg then Theme.Background = UnpackColor(Settings.bg) end
      if Settings.txt then Theme.Text = UnpackColor(Settings.txt) end
      if Settings.bgFxColor then State.EffectColor = UnpackColor(Settings.bgFxColor) end

      if Settings.rainbow ~= nil then State.Rainbow = Rainbow end
      if Settings.rainbowSpeed then State.RainbowSpeed = Settings.rainbowSpeed end
      if Settings.menuOpacity then State.Opacity = Settings.menuOpacity end
      if Settings.noAnim ~= nil then State.NoAnim = Settings.noAnim == true end
      if Settings.notifyDur then State.NoteDuration = Settings.notifyDur end
      if Settings.hoverEffects ~= nil then State.HoverEffects = Settings.hoverEffects ~= false end
      if Settings.checkboxStyle ~= nil then State.CheckboxStyle = Settings.checkboxStyle == true end
      if Settings.hotkeyEnabled ~= nil then State.HotkeyShown = Settings.hotkeyEnabled ~= false end
      if Settings.glowMul then State.Glow = Settings.glowMul end
      if Settings.lite ~= nil then State.Lite = Settings.lite == true end
      if Settings.smartFps ~= nil then State.SmartFps = Settings.smartFps ~= false end
      if Settings.sidebarPinned ~= nil then State.RailPinned = Settings.sidebarPinned == true end
      if Settings.dropdownInline ~= nil then State.DropdownInline = Settings.dropdownInline == true end
      if Settings.cardStrk then Alpha.CardStroke = Settings.cardStrk end
      if Settings.hairline then Alpha.Hairline = Settings.hairline end
      if Settings.cardFill then Alpha.Card = Settings.cardFill end
      if Settings.roundScale then RoundScale = math.min(math.max(tonumber(Settings.roundScale) or 1, 0), 2.5) end
      if Settings.menuKey then InsUi:SetMenuKey(Settings.menuKey) end
      if tonumber(Settings.w) and tonumber(Settings.h) then InsUi:SetSize(Settings.w, Settings.h) end
      if Settings.logo then InsUi:SetLogo(Settings.logo) end
      if Settings.icon then InsUi:SetIcon(Settings.icon) end
      if Settings.bgImg then InsUi:SetBackgroundImage(Settings.bgImg, Settings.bgImgA) end

      InsUi:SetBackgroundEffect(Settings.bgFx)
    end

    MirrorSettings()

    State.Loading = false
  end
end

local ArrowTabs

do
  local function StepTab(step)
    local Index = State.ActiveIndex

    repeat Index = Index + step until Index < 1 or Index > #State.Tabs or not State.Tabs[Index].Hidden

    if Index < 1 or Index > #State.Tabs then return end

    State.ActiveIndex = Index
    State.ActiveSub = nil
    State.ContentFade = 0
  end

  function ArrowTabs()
    if not State.Open or State.SpotlightOpen or State.Focus then return end
    if State.Dropdown or State.Picker or #State.Tabs == 0 then return end

    if Keys.Left.Click then StepTab(-1) end
    if Keys.Right.Click then StepTab(1) end
  end
end

local DrawBackgroundEffect

do
  local EffectCount = { Snow = 48, Rain = 80 }
  local EffectGlyphs = "01ABCDEFGHJKLMNPRSTUVXYZ#$%&@"

  local function EffectGlyph()
    local Index = 1 + math.floor(math.random() * #EffectGlyphs)

    return string.sub(EffectGlyphs, Index, Index)
  end

  local function SpawnEffect(name, width)
    local Parts = {}
    local Thin = State.Lite and 0.55 or 1

    if name == "Matrix" then
      local Columns = math.max(6, math.floor(width / 18 * Thin))

      for Index = 1, Columns do
        local Trail = 6 + math.floor(math.random() * 6)
        local Glyphs = {}

        for Step = 1, Trail do Glyphs[Step] = EffectGlyph() end

        Parts[Index] = { Column = (Index - 0.5) / Columns, Y = math.random() * 1.4 - 0.4, Speed = 0.25 + math.random() * 0.55, Trail = Trail, Glyphs = Glyphs }
      end

      return Parts
    end

    local Count = math.max(6, math.floor((EffectCount[name] or 80) * Thin))

    for Index = 1, Count do
      Parts[Index] = {
        X = math.random(),
        Y = math.random(),
        Phase = math.random() * 6.2832,
        Speed = 0.3 + math.random() * 0.9,
        Size = 1 + math.random() * 2.2,
        Alpha = 0.35 + math.random() * 0.6,
        Depth = math.random(),
        Sway = 0.005 + math.random() * 0.018,
        Flutter = 1.6 + math.random() * 1.8,
      }
    end

    return Parts
  end

  local function DrawSnow(parts, rx, ry, rw, rh, clock, delta, fade, tint)
    local Wind = math.sin(clock * 0.13) * 0.5 + math.sin(clock * 0.31 + 1.3) * 0.22 + math.sin(clock * 0.07) * 0.3

    for Index = 1, #parts do
      local Flake = parts[Index]
      local Depth = Flake.Depth

      Flake.Y = Flake.Y + (0.035 + Depth * 0.11) * delta

      if Flake.Y > 1.04 then Flake.Y, Flake.X = -0.04, math.random() end

      local Sway = math.sin(clock * Flake.Speed + Flake.Phase) * Flake.Sway + math.sin(clock * Flake.Speed * Flake.Flutter + Flake.Phase) * Flake.Sway * 0.45
      local Ax = rx + (Flake.X + Sway + Wind * (0.012 + Depth * 0.03)) * rw
      local Ay = ry + Flake.Y * rh
      local Radius = 2 + Depth * 4.5
      local Color = tint or Blend(Color3.fromRGB(215, 228, 255), White, Depth)
      local Edge = math.min(math.max((Ay - ry - Radius) / 6, 0), 1) * math.min(math.max((ry + rh - Ay - Radius * 1.4) / 8, 0), 1)
      local Shade = (0.3 + Depth * 0.5) * (0.85 + 0.15 * math.sin(clock * 2 + Flake.Phase)) * fade * Edge
      local Spin = clock * Flake.Speed * 0.3 + Flake.Phase

      if Depth > 0.55 then DrawCircle(Ax, Ay, Radius * 1.4, Color, 12, true, 1, 12, Shade * 0.08) end

      for Arm = 0, 2 do
        local Angle = Spin + Arm * 1.0472
        local Ux, Uy = math.cos(Angle) * Radius, math.sin(Angle) * Radius

        DrawLine(Ax - Ux, Ay - Uy, Ax + Ux, Ay + Uy, Color, 13, 1, Shade)
      end

      DrawCircle(Ax, Ay, math.max(1, Radius * 0.28), Color, 13, true, 1, 8, Shade)
    end
  end

  local function DrawRain(parts, rx, ry, rw, rh, delta, fade, tint)
    local Floor = ry + rh

    for Index = 1, #parts do
      local Drop = parts[Index]

      Drop.Y = Drop.Y + (0.85 + Drop.Size * 0.25) * delta

      if Drop.Y > 1.06 then Drop.Y, Drop.X = -0.05, math.random() end

      local Ax = rx + Drop.X * rw
      local TopY = ry + Drop.Y * rh
      local Length = 6 + Drop.Size * 5
      local Head = math.max(TopY, ry)
      local Tail = math.min(TopY + Length, Floor)
      local Shade = Drop.Alpha * fade * 0.5

      if Tail <= Head then Tail, Shade = Head, 0 end

      DrawLine(Ax + (Head - TopY) / Length * 2.5, Head, Ax + (Tail - TopY) / Length * 2.5, Tail, tint or Color3.fromRGB(170, 200, 255), 12, 1, Shade)
    end
  end

  local function DrawMatrix(parts, rx, ry, rw, rh, clock, delta, fade, tint)
    local Line = 14

    for Index = 1, #parts do
      local Column = parts[Index]

      Column.Y = Column.Y + Column.Speed * delta

      if Column.Y * rh - Column.Trail * Line > rh then
        Column.Y = -math.random() * 0.3

        for Step = 1, Column.Trail do Column.Glyphs[Step] = EffectGlyph() end
      end

      local Cx = rx + Column.Column * rw

      for Step = 1, Column.Trail do
        local Ay = ry + Column.Y * rh - (Step - 1) * Line
        local Falloff = 1 - (Step - 1) / Column.Trail
        local Shown = math.min(math.max((Ay - ry + 2) / 4, 0), 1) * math.min(math.max((ry + rh - Ay - Line + 2) / 4, 0), 1)
        local Head = tint and Blend(tint, White, 0.35) or Color3.fromRGB(205, 255, 215)
        local Body = tint and Blend(Black, tint, 0.3 + 0.5 * Falloff) or Color3.fromRGB(40 + 60 * Falloff, 200, 80 + 40 * Falloff)

        DrawText(Column.Glyphs[Step] or "0", Cx, Ay, Step == 1 and Head or Body, 13, SystemFont, 12, Falloff * fade * 0.9 * Shown)
      end

      if math.sin(clock * 3 + Column.Column * 30) > 0.985 then Column.Glyphs[1] = EffectGlyph() end
    end
  end

  function DrawBackgroundEffect()
    local Name = State.Effect

    if not Name or State.Lite or State.Visible <= 0.02 then
      State.Parts, State.PartsName = nil, nil

      return
    end

    local Rx, Ry = State.X + 2, State.Y + Layout.TopbarHeight + 2
    local Rw, Rh = State.W - 4, State.H - Layout.TopbarHeight - 4

    if Rw <= 12 or Rh <= 12 then return end

    if State.PartsName ~= Name then State.Parts, State.PartsName = SpawnEffect(Name, Rw), Name end

    local Clock = os.clock()
    local Delta = math.min(State.Delta, 0.1)
    local Fade = State.Visible
    local Tint = State.EffectColor

    if Name == "Snow" then
      DrawSnow(State.Parts, Rx, Ry, Rw, Rh, Clock, Delta, Fade, Tint)
    elseif Name == "Rain" then
      DrawRain(State.Parts, Rx, Ry, Rw, Rh, Delta, Fade, Tint)
    else
      DrawMatrix(State.Parts, Rx, Ry, Rw, Rh, Clock, Delta, Fade, Tint)
    end
  end
end

local HideWindowImages, FrameDelay

do
  local function HideIcon(owner, key)
    local Image = owner[key]

    if Image then Image.Visible = false end
  end

  function HideWindowImages()
    for _, Tab in ipairs(State.Tabs) do
      HideIcon(Tab, "Image")
      HideIcon(Tab, "ImageOn")

      for _, Sub in ipairs(Tab.Subs) do
        HideIcon(Sub, "Image")
        HideIcon(Sub, "ImageOn")
      end
    end

    HideIcon(State, "GearImage")
    HidePicture(State.Avatar)
    HidePicture(State.Logo)
    HidePicture(State.Icon)
    HidePicture(State.Backdrop)
  end

  function FrameDelay()
    local Full = State.Lite and Layout.LiteFrame or Layout.FullFrame
    if not State.SmartFps then return Full end

    local Moved = Input.X ~= State.LastX or Input.Y ~= State.LastY

    State.LastX, State.LastY = Input.X, Input.Y

    if Moved or Input.Down or Input.RightDown or State.Drag or State.Resize or State.BarDrag
      or State.Dropdown or State.Picker or State.Focus or State.Capture or State.SpotlightOpen then
      State.LastAct = os.clock()
    end

    local Busy = (State.Visible > 0.01 and State.Visible < 0.99)
      or (State.BubbleFade > 0.01 and State.BubbleFade < 0.99)
      or State.ContentFade < 0.99
      or (State.Rainbow and State.Open)

    if Busy then return Full end
    if State.Open and os.clock() - State.LastAct < Layout.IdleGrace then return Full end

    return Layout.IdleFrame
  end
end

local function StepTheme()
  if State.Rainbow then
    local Turn = os.clock() * State.RainbowSpeed * Layout.RainbowScale

    ApplyAccents(Color3.fromHSV(Turn % 1, 0.65, 1), Color3.fromHSV((Turn + Layout.RainbowSpread) % 1, 0.72, 1))
  end

  local Accent = Theme.Accent
  local Key = math.floor(Accent.R * Layout.ByteScale / Layout.IconBucket) * 65536
    + math.floor(Accent.G * Layout.ByteScale / Layout.IconBucket) * 256
    + math.floor(Accent.B * Layout.ByteScale / Layout.IconBucket)
  local Now = os.clock()

  if Key == IconKey then return end
  if Now - State.IconAt < Layout.IconRebuild then return end

  IconKey, IconTint, State.IconAt = Key, Accent, Now
end

do
  local function GameCaptures()
    if State.Dialog then return true end
    if not State.Open or State.Rolled then return false end
    if State.GameInput == "always" then return false end
    if State.GameInput ~= true then return true end
    if State.Dropdown or State.Picker or State.Menu or State.SpotlightOpen then return true end

    return IsMouseIn(State.X, State.Y, State.W, State.H)
  end

  function ApplyInputState(force)
    local ToGame = not GameCaptures()

    if not force and State.InputSent == ToGame then return end

    State.InputSent = ToGame

    setrobloxinput(ToGame)
  end
end

local function DrawMenu()
  local View = ActiveView()

  if View ~= State.SeenView then
    State.SeenView = View
    State.Dropdown = nil
    State.Picker = nil
    State.Menu = nil
    State.Focus = nil
  end

  ApplyDrag()
  ArrowTabs()

  local Rail = RailWidth()

  DrawFrame(Rail)

  if State.TabLayout == "top" then DrawGem() end

  DrawHeader(Rail)
  GrabWindow(Rail)

  if State.TabLayout == "top" then
    DrawTopStrip()
  else
    DrawRail(Rail, DrawBrand(Rail))
    DrawUserCard(Rail)
  end

  State.ContentFade = Approach(State.ContentFade, 1, 12)

  if State.ContentFade > 0.997 then State.ContentFade = 1 end

  DrawSections(Rail)
  DrawGrip()
  DrawDropdownList()
  DrawPicker()
  DrawKeyMenu()
  DrawTooltip()
end

task.spawn(function()
  while State.Alive do
    if _G[LibName .. "Instance"] ~= Instance then
      InsUi:Destroy()
      return
    end

    local Now = os.clock()

    State.Delta = math.min(Now - State.LastFrame, 0.05)
    State.LastFrame = Now
    State.Frame = State.Frame + 1

    ResetFrame()
    ReadInput()
    ReadKeys()
    StepTheme()

    if Input.Up then ReleaseDrags() end

    State.Visible = Approach(State.Visible, State.Open and 1 or 0, 12)

    if State.Visible > 0.997 then State.Visible = 1 end
    if State.Visible < 0.003 then State.Visible = 0 end

    if State.SpotlightEnabled and (Keys.Ctrl.Held or Keys.LeftCtrl.Held or Keys.RightCtrl.Held) and Keys.Space.Click then
      ShowSpotlight(not State.SpotlightOpen)

      Keys.Space.Click = false
    end

    local MenuKey = Keys[State.MenuKey]

    if MenuKey and MenuKey.Click and not State.Focus and not State.Capture then State.Open = not State.Open end

    local Editing = State.Focus

    if Editing and Editing.Kind == "Slider" then
      if Keys.Enter.Click or Keys.Escape.Click then
        if Keys.Enter.Click then
          local Wanted = SnapValue(tonumber(Editing.Typing) or Editing.Value, Editing)

          if Wanted ~= Editing.Value then
            Editing.Value = Wanted

            Editing.Callback(Wanted)
          end
        end

        Editing.Typing, Editing.Anchor, State.Focus = nil, nil, nil
        Keys.Enter.Click, Keys.Escape.Click = false, false
      else
        EditText(Editing, "Typing")
      end
    elseif Editing then
      EditText(Editing)
    end
    if State.Capture then CaptureKey(State.Capture) end
    RunKeybinds()

    local Over = State.SpotlightOpen or State.Dialog ~= nil
    local Click, Right, Down = Input.Click, Input.Right, Input.Down

    if Over then Input.Click, Input.Right, Input.Down = false, false, false end

    if State.Visible > 0 then
      DrawHotkeyOverlay()
      DrawBoxes()

      local Lift = (1 - State.Visible) * 14

      FrameFade = State.Visible
      State.Y = State.Y + Lift

      if State.BubbleFade < Layout.BubbleShown then
        DrawMenu()
      else
        HideWindowImages()
      end

      State.Y = State.Y - Lift
      FrameFade = 1
    else
      HideWindowImages()
      DrawBoxes()
      DrawHotkeyOverlay()
    end

    ApplyInputState(false)
    DrawMinBubble()

    Input.Click, Input.Right, Input.Down = Click, Right, Down

    DrawSpotlight()
    DrawNotifications()
    DrawDialog()
    DrawBackgroundEffect()
    HideUnused()

    task.wait(FrameDelay())
  end
end)
for _, Key in ipairs({ LibName, LibName .. "UI", "INSUI" }) do _G[Key] = InsUi end

return InsUi

end)()
local function note(msg, title)
    pcall(function() notify(msg, title or "lolcat", 3) end)
end

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
        face_camera   = false,

        face_hz       = 10,
        noclip        = true,
        world_noclip  = true,
        reset_mode    = false,

        auto_polar_quests  = false,
        polar_only         = false,
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

        nectar_farm   = false,
        nectar_repeat = true,
        nectar_extra  = false,
        nectar_mode   = "Growth %",
        nectar_collect_pct   = 100,
        nectar_collect_every = 1,

        nectar_slots  = { "Motivating", "Comforting", "Satisfying", "Refreshing", "Invigorating" },

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

    if not S.hybrid then S.travel_mode = "Tween" else S.travel_mode = "Pathfinding" end

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

    local function isOn()
        return S.farm_on == true and isAlive() and FeaturesActive
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
        if hum and not S.face.autoTried then
            S.face.autoTried = true
            local okA = pcall(function() hum.AutoRotate = false end)
S.face.autoOff = okA
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
        if S.face_balloons or S.face_bubbles or S.face_center then return end
        local hum = getHum()
        if hum then pcall(function() hum.AutoRotate = true end) end
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

    local flightSaves = nil
    local function flightNoclip(on)
        local character = lp and lp.Character
        if not character then return end
        if on then
            if flightSaves == nil then flightSaves = {} end
            local list = try(function() return character:GetDescendants() end)
if list then
                for _, part in ipairs(list) do
                    if isPart(part) and flightSaves[part] == nil then
                        local can = try(function() return part.CanCollide end)
flightSaves[part] = (can ~= false)
                        pcall(function() part.CanCollide = false end)
end
                end
            end
        elseif flightSaves then
            for part, val in pairs(flightSaves) do
                if part and part.Parent then
                    pcall(function() part.CanCollide = val end)
end
            end
            flightSaves = nil
        end
    end

    local function moveToVelocity(targetPos, speed, thr, modeLabel, noAnim)
        thr = thr or 3.5

        speed = tonumber(speed) or 110
        if speed ~= speed or speed < 1 then speed = 110 end
        if not targetPos then return false end

        local hrp = getHRP()
        local hum = getHum()
        if not hrp or not hum then return false end

        glideActive = true
        glideActiveSince = tick()
        lastMoveMode, lastMoveAt = modeLabel or "Glide", tick()

        pcall(function() keyrelease(0x57) end)
flightNoclip(true)

        local start = tick()
        local lastTick = start
        local noclipAt = start
        local accel = math.max(30, speed * 2.6)
        local brake = math.max(7, speed * 0.45)

        while tick() - start < 45 do
            if not isOn() then break end
            local curHrp = getHRP()
            if not curHrp or not isAlive() then break end

            local now = tick()
            local dt = clamp(now - lastTick, 0.001, 0.1)
            lastTick = now

            if now - noclipAt > 0.5 then

                noclipAt = now
                flightNoclip(true)
            end

            local pos   = curHrp.Position
            local delta = targetPos - pos
            local dist  = delta.Magnitude

            if dist <= thr then
                pcall(function()
                    curHrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    curHrp.Velocity = Vector3.new(0, 0, 0)
                end)
break
            end

            local want = speed
            if dist < brake then want = math.max(speed * 0.12, dist * 2.2) end
            want = math.min(want, dist / math.max(dt, 0.001))
            if glideSpeed < want then
                glideSpeed = math.min(want, glideSpeed + accel * dt)
            else
                glideSpeed = math.max(want, glideSpeed - accel * 1.4 * dt)
            end

            local dir  = delta.Unit
            local step = math.min(glideSpeed * dt, dist)
            local newPos = pos + dir * step

            local goal = facingTarget or (newPos + dir)
            local goalYaw = flatYaw(newPos, Vector3.new(goal.X, newPos.Y, goal.Z))

            local yaw = glideYaw or currentYaw(curHrp.CFrame)
            if goalYaw then
                yaw = yaw + clampYawDelta(goalYaw - yaw, math.max(0.5, dt * 22))
            end
            glideYaw = yaw

            pcall(function()

                local base = CFrame.new(newPos.X, newPos.Y, newPos.Z) * CFrame.Angles(0, glideYaw or 0, 0)
                curHrp.CFrame = base

                if not noAnim then
                    curHrp.AssemblyLinearVelocity = dir * glideSpeed
                    curHrp.Velocity = dir * glideSpeed
                end
            end)
task.wait(0.010)
        end

        glideActive = false
        pcall(function() keyrelease(0x57) end)

local done = getHRP()
        if done and done.Parent then
            pcall(function()
                done.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                done.Velocity = Vector3.new(0, 0, 0)
            end)
end
        if not isOn() then glideSpeed = 0 end
        flightNoclip(false)

        glideYaw = nil
        return true
    end

    local Nav = {}
    if _G then _G.__lolcatNav = Nav end

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
    local savedCollide = nil
    local savedCharacter = nil
    local driveInst, driveAttach = nil, nil

    local function restoreCollide()
        if not savedCollide then return end
        for part, value in pairs(savedCollide) do
            pcall(function() part.CanCollide = value end)
end
        savedCollide = nil
    end

    Nav.noclipTravel = function(on)
        if not on then
            restoreCollide()
            return
        end
        local character = lp and lp.Character
        if not character then return end
        if savedCollide then

            if savedCharacter == character then return end
            restoreCollide()
        end
        local list = try(function() return character:GetDescendants() end)
if not list then return end
        savedCharacter = character
        savedCollide = {}
        for _, part in ipairs(list) do
            if isPart(part) then
                local can = try(function() return part.CanCollide end)
savedCollide[part] = can ~= false
                pcall(function() part.CanCollide = false end)
end
        end
    end

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
            local animate = hum:FindFirstChild("Animate")
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
    Nav.stopRunAnim = stopRunAnim

    Nav.flyTo = function(targetPos, speed, thr, label, keepGoing)
        if not targetPos then return false end
        thr = thr or 4
        speed = tonumber(speed) or tonumber(S.glide_speed) or 110
        if speed <= 0 then speed = 110 end
        local hrp = getHRP()
        if not hrp then return false end

        ensureDrive(hrp)
        lastMoveMode, lastMoveAt = label or "Tween", tick()
        startRunAnim(speed)
        flightNoclip(true)

        local start = tick()
        local budget = math.min(120, ((targetPos - hrp.Position).Magnitude / speed) * 3 + 6)
        local bestDistance, bestAt = math.huge, start
        local noclipAt = start

        while tick() - start < budget do
            if not isOn() then break end
            hrp = getHRP()
            if not hrp or not isAlive() then break end

            if tick() - noclipAt > 0.5 then

                noclipAt = tick()
                flightNoclip(true)
            end

            local delta = targetPos - hrp.Position
            local distance = delta.Magnitude
            if distance <= thr then break end

            local flat = Vector3.new(delta.X, 0, delta.Z)
            local flatLength = flat.Magnitude
            local direction = flatLength > 0.001 and flat.Unit or Vector3.new(0, 0, 0)
            local want = speed
            if not keepGoing and distance < 10 then want = math.max(6, distance * 3) end
            local climb = clamp(delta.Y * 6, -50, 50)

            driveVelocity(Vector3.new(direction.X * want, climb, direction.Z * want))

            if distance < bestDistance - 0.4 then
                bestDistance, bestAt = distance, tick()
            elseif tick() - bestAt > 7 then
                status = "Tween stalled: " .. tostring(label or "")
                break
            end
            task.wait(0.01)
        end

        local current = getHRP()
        if not keepGoing then
            if current then
                pcall(function() current.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end)
end
            if driveInst then pcall(function() driveInst.VectorVelocity = Vector3.new(0, 0, 0) end) end

            stopRunAnim()
            flightNoclip(false)
        end
        return current ~= nil and (targetPos - current.Position).Magnitude <= thr + 2
    end

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
        if (not S.hybrid) and S.travel_mode == "Tween" then
            return Nav.tweenTravel(targetPos, speed, thr, label or "Travel")
        end
        S.travel_mode = "Pathfinding"
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
        for _, fn in ipairs(NECTAR_FIELDS[nectar] or {}) do
            if not usedFields[fn] and getField(fn) then return fn end
        end
        return nil
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
        local c = f.Position
        local target = Vector3.new(c.X, groundY(f) + 2, c.Z)
        N.status = "Placing " .. planter .. " in " .. fieldName
        Nav.go(target, S.glide_speed, 3, "Planter travel")

        local t0 = tick()
        while tick() - t0 < 3 do
            local hrp = getHRP()
            if hrp and (hrp.Position - target).Magnitude <= 10 then break end
            task.wait(0.1)
        end

        local here = getHRP()
        if not here or not inField(here.Position, f, 8) then
            Nav.walk(target, { arrive = 6, timeout = 10 })
            here = getHRP()
        end
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
        if p.model then
            local ok, par = pcall(function() return p.model.Parent end)
if ok and par == nil then return true end
        end
        local ok, list = pcall(scanPlanters)
        if ok and type(list) == "table" and #list < before then return true end
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
                    Nav.walk(Vector3.new(target.X, y, target.Z), { arrive = 6, timeout = math.min(2.5, left) })
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

        collectPlanterTokens(field, 3)
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

        if not p.mine then return false end
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
                if h and (Vector3.new(h.Position.X, target.Y, h.Position.Z) - target).Magnitude <= 6 then break end
                task.wait(0.1)
            end

            local h = getHRP()
            if h and (Vector3.new(h.Position.X, target.Y, h.Position.Z) - target).Magnitude > 6 then
                Nav.walk(Vector3.new(target.X, target.Y + 1.5, target.Z), { arrive = 5, timeout = 8 })
            end
        end

        if not nearestPlanterIsMine() then
            N.status = "Another player's planter is closer - skipped"
            N.harvestCooldown[p.name] = tick() + 20
            return false
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
                if d > 14 then break end
            end
            if holdField then touchCollectibles(holdField) end
            autoDigCursorFree()
            task.wait(0.25)
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

        local want = math.min(#list, 3, chosenCount)
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
                local pick = nil
                for _, nn in ipairs(list) do
                    if chooseNectarField(nn, usedFields) then pick = nn; break end
                end
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
        local ok, state = pcall(function() return hum:GetState() end)
if ok and state ~= nil then
            local n = tostring(state)
            if string.find(n, "Freefall", 1, true) or string.find(n, "Jumping", 1, true) then
                return true
            end
        end
        local okf, floor = pcall(function() return hum.FloorMaterial end)
if okf and floor ~= nil then
            local okm, air = pcall(function() return Enum.Material.Air end)
if okm and air ~= nil then return floor == air end
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
    local OFF_WALKSPEED  = 0x1C4

    local OFF_WALKSPEED_CHECK = 0x39C
    local OFF_JUMP       = 0x1CF

    local MemWalk = { on = false, dirX = 0, dirZ = 0, target = nil, conns = {} }

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
        if wbyte then
            pcall(function() wbyte(base + OFF_JUMP, 1) end)
later(0.12, function()
                local again = memBase()
                if again then pcall(function() wbyte(again + OFF_JUMP, 0) end) end
            end)
return
        end

        inputBridge()
        pcall(function() keypress(0x20) end)
later(0.08, function() pcall(function() keyrelease(0x20) end) end)
end

    local lastJumpAt = 0
    local function jumpNow()
        local now = tick()
        if now - lastJumpAt < 0.6 then return end

        if humanoidAirborne() then return end
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

    local function memGuardPoint() pcall(memWritePointNow) end
    local function memGuardDir() pcall(memWriteDirNow) end

    local function memHook()
        if not MemWalk.on or not MemWalk.base then return end
        memGuardDir()
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

    Nav.memWalkTo = function(targetPos, opts)
        opts = opts or {}
        if not targetPos then return false end
        if not memReady() then return false end
        if not memConnect() then return false end

        local arrive = opts.arrive or 4.5
        local timeout = opts.timeout or 20
        local label = opts.label or "Offsets walk"

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
        local reached = false
        local steerStage = 0
        local reboundUntil = 0
        local lastBaseAt = start
        local lastPointAt = start
        local startFlat = Vector3.new(targetPos.X - hrp.Position.X, 0, targetPos.Z - hrp.Position.Z)
        local startLen = math.max(startFlat.Magnitude, 0.001)
        MemWalk.dirX = startFlat.X / startLen
        MemWalk.dirZ = startFlat.Z / startLen
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

            if now > reboundUntil then
                local inv = 1 / math.max(distance, 0.001)
                MemWalk.dirX = flat.X * inv
                MemWalk.dirZ = flat.Z * inv
            end

            local stuckFor = now - bestAt
            local airborne = humanoidAirborne()
            if distance < best - 0.5 then
                best, bestAt = distance, now
                jumps, steerStage = 0, 0
                reboundUntil = 0
            elseif airborne then

                task.wait(0.04)
            elseif stuckFor > 4.5 then
                status = "Offsets stalled"
                break
            elseif stuckFor > 0.9 then
                local step = math.floor((stuckFor - 0.9) / 0.85) + 1
                if step > jumps then
                    jumps = step
                    bestAt = now
                    if step <= 3 then

                        jumpNow()
                    else

                        steerStage = steerStage + 1
                        local ang = math.rad(50) * ((steerStage % 2 == 0) and -1 or 1)
                        local ca, sa = math.cos(ang), math.sin(ang)
                        local dx, dz = MemWalk.dirX, MemWalk.dirZ
                        MemWalk.dirX = dx * ca - dz * sa
                        MemWalk.dirZ = dx * sa + dz * ca
                        reboundUntil = now + 1.2
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

        local index = 1
        local start = tick()
        local best = math.huge
        local bestAt = start
        local jumps, steerStage = 0, 0
        local done = false
        local lastPointAt = start

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

            if distance <= arrive then
                index = index + 1
                if index > #points then
                    done = true
                    break
                end
                local nextPos = getPoint(points[index])
                if nextPos then

                    setLeg(nextPos)
                    jumps, steerStage = 0, 0
                    best, bestAt = math.huge, tick()
                end
            else
                local inv = 1 / math.max(distance, 0.001)
                MemWalk.dirX = flat.X * inv
                MemWalk.dirZ = flat.Z * inv
                local stuckFor = tick() - bestAt
                local airborne = humanoidAirborne()
                if distance < best - 0.5 then
                    best, bestAt = distance, tick()
                    jumps, steerStage = 0, 0
                elseif airborne then
                    task.wait(0.05)
                else

                    if stuckFor > 4.5 then
                        break
                    elseif stuckFor > 0.9 then
                        local step = math.floor((stuckFor - 0.9) / 0.85) + 1
                        if step > jumps then
                            jumps = step
                            bestAt = tick()
                            if step <= 3 then
                                jumpNow()
                            else
                                steerStage = steerStage + 1
                                local ang = math.rad(45) * ((steerStage % 2 == 0) and -1 or 1)
                                local ca, sa = math.cos(ang), math.sin(ang)
                                local dx, dz = MemWalk.dirX, MemWalk.dirZ
                                MemWalk.dirX = dx * ca - dz * sa
                                MemWalk.dirZ = dx * sa + dz * ca
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

    local function claimOrAcceptPolarBearQuest(force)
        status = "Polar Bear: Soon"
        task.wait(0.2)
    end

    local function completePolarBearRoutine()
        status = "Polar Bear: Soon"
        task.wait(0.2)
        return
    end

    local tunnelBearCooldown, kingBeetleCooldown, crabCooldown = 0, 0, 0

Nav.findMonster = function(pattern)
    local pat = string.lower(tostring(pattern or ""))
    if pat == "" then return nil end
    local roots = {}
    local mon = Workspace:FindFirstChild("Monsters")
    if mon then roots[#roots + 1] = mon end
    local bees = Workspace:FindFirstChild("Bees")
    if bees then roots[#roots + 1] = bees end
    roots[#roots + 1] = Workspace
    for _, root in ipairs(roots) do
        local ok, kids = pcall(function() return root:GetChildren() end)
if ok and kids then
            for _, m in ipairs(kids) do
                local n = string.lower(tostring(m.Name or ""))
                local decor = string.find(n, "lair", 1, true) or string.find(n, "door", 1, true)
                    or string.find(n, "sign", 1, true) or string.find(n, "gate", 1, true)
                if not decor and string.find(n, pat, 1, true) and getPartPos(m) then return m end
            end
        end
    end
    return nil
end

    local function checkBossOnCooldown(bossName)
        local spawners = Workspace:FindFirstChild("MonsterSpawners")
        if spawners then
            for _, s in ipairs(spawners:GetChildren()) do
                if string.find(string.lower(s.Name), string.lower(bossName), 1, true) then
                    for _, desc in ipairs(s:GetDescendants()) do
                        if desc.ClassName == "TextLabel" then
                            local t = safeText(desc)

                            local num, unit = string.match(t, "(%d+)%s*([hms])")
                            if num and unit then
                                return true, t
                            end
                        end
                    end
                end
            end
        end
        return false, nil
    end

    local function killTunnelBear()
        if not getHRP() then return end
        if tick() < tunnelBearCooldown then return end

        status = "Combat: checking Tunnel Bear"
        local startPos = Vector3.new(380, 15, -45)
        local endPos   = Vector3.new(515, 15, -45)

        local tb = Nav.findMonster("tunnel")
        if not tb then
            local onCd, txt = checkBossOnCooldown("Tunnel")
            if onCd then
                status = "Tunnel Bear: " .. tostring(txt)
                tunnelBearCooldown = tick() + 60
                return
            end
            moveToVelocity(startPos, S.glide_speed, 4)
            task.wait(0.3)
            local tWait = tick()
            while isOn() and tick() - tWait < 4 do
                tb = Nav.findMonster("tunnel")
                if tb then break end
                task.wait(0.2)
            end
        end

        if not tb then tunnelBearCooldown = tick() + 45; return end

        status = "Combat: fighting Tunnel Bear"
        local dl = tick() + 120
        local lastSeen = tick()
        while isOn() and tick() < dl do
            local alive = false
            pcall(function() alive = tb.Parent ~= nil end)
if not alive then
                tb = Nav.findMonster("tunnel")
                if not tb then break end
            end
            local bp2 = getPartPos(tb)
            local hrp2 = getHRP()
            if bp2 then
                lastSeen = tick()
                if not hrp2 or (bp2 - hrp2.Position).Magnitude > 10 then
                    moveToVelocity(bp2 + Vector3.new(0, 6, 0), S.glide_speed, 3)
                end
                combatHit()
            end
            if tick() - lastSeen > 6 then break end
            task.wait(0.12)
        end

        status = "Looting Tunnel Bear"
        tunnelBearCooldown = tick() + 60
        local lootEnd = tick() + 8
        while isOn() and tick() < lootEnd do
            moveToVelocity(endPos, 85, 4)
            combatHit()
            local coll = Workspace:FindFirstChild("Collectibles")
            if coll then
                for _, tok in ipairs(coll:GetChildren()) do
                    local p = getPartPos(tok)
                    if p and p.X >= 360 and p.X <= 530 and math.abs(p.Z - (-45)) <= 30 then
                        moveToVelocity(Vector3.new(p.X, 15, p.Z), 95, 2)
                    end
                end
            end
            moveToVelocity(startPos, 85, 4)
            task.wait(0.1)
        end
    end

    local function killKingBeetle()
        if not getHRP() then return end
        if tick() < kingBeetleCooldown then return end

        status = "Combat: checking King Beetle"
        local entrance = Vector3.new(-220, 4, 200)

        local kb = Nav.findMonster("king beetle") or Nav.findMonster("king")
        if not kb then
            local onCd, txt = checkBossOnCooldown("King")
            if onCd then
                status = "King Beetle: " .. tostring(txt)
                kingBeetleCooldown = tick() + 60
                return
            end
            moveToVelocity(entrance, S.glide_speed, 4)
            task.wait(0.4)
            local tWait = tick()
            while isOn() and tick() - tWait < 4 do
                kb = Nav.findMonster("king beetle") or Nav.findMonster("king")
                if kb then break end
                task.wait(0.2)
            end
        end

        if not kb then kingBeetleCooldown = tick() + 45; return end

        status = "Combat: fighting King Beetle"
        local dl = tick() + 120
        local lastSeen = tick()
        while isOn() and tick() < dl do
            local alive = false
            pcall(function() alive = kb.Parent ~= nil end)
if not alive then
                kb = Nav.findMonster("king beetle") or Nav.findMonster("king")
                if not kb then break end
            end
            local bp2 = getPartPos(kb)
            local hrp2 = getHRP()
            if bp2 then
                lastSeen = tick()
                if not hrp2 or (bp2 - hrp2.Position).Magnitude > 10 then
                    moveToVelocity(bp2 + Vector3.new(0, 6, 0), S.glide_speed, 3)
                end
                combatHit()
            end
            if tick() - lastSeen > 6 then break end
            task.wait(0.12)
        end

        status = "Looting King Beetle"
        kingBeetleCooldown = tick() + 60
        local lootEnd = tick() + 7
        while isOn() and tick() < lootEnd do
            local coll = Workspace:FindFirstChild("Collectibles")
            if coll then
                for _, tok in ipairs(coll:GetChildren()) do
                    local p = getPartPos(tok)
                    if p and math.abs(p.X - (-220)) <= 40 and math.abs(p.Z - 200) <= 40 then
                        moveToVelocity(Vector3.new(p.X, 4, p.Z), 85, 2)
                    end
                end
            end
            moveToVelocity(entrance, 75, 3)
            task.wait(0.1)
        end
    end

    local function killCoconutCrab()
        if not getHRP() then return end
        if tick() < crabCooldown then return end

        local crab = nil
        local monsters = Workspace:FindFirstChild("Monsters")
        if monsters then
            for _, m in ipairs(monsters:GetChildren()) do
                if string.find(string.lower(m.Name), "coconut", 1, true) then crab = m; break end
            end
        end
        if not crab then crabCooldown = tick() + 120; return end

        local mp = getPartPos(crab)
        if not mp then return end

        status = "Combat: Coconut Crab"
        moveToVelocity(mp + Vector3.new(0, 4, 0), S.glide_speed, 4)

        local t0 = tick()
        while isOn() and tick() - t0 < 25 do
            if not (crab and crab.Parent) then break end
            local cur = getPartPos(crab)
            local ch = getHRP()
            if ch and cur and (cur - ch.Position).Magnitude > 14 then
                moveToVelocity(cur + Vector3.new(0, 4, 0), S.glide_speed, 4)
            end
            combatHit()
            task.wait(0.2)
        end
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
                        if not hrp2 or (mp - hrp2.Position).Magnitude > 12 then
                            moveToVelocity(mp + Vector3.new(0, 8, 0), S.glide_speed, 3)
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
            end
        end

        if S.kill_mondo and isOn() then
            if getField("Mountain Top Field") then
                local monsters = Workspace:FindFirstChild("Monsters")
                local mondo = monsters and monsters:FindFirstChild("Mondo Chick")
                if mondo and mondo:FindFirstChildWhichIsA("BasePart") then
                    status = "Combat: Mondo Chick"
                    local mp = mondo.PrimaryPart or mondo:FindFirstChildWhichIsA("BasePart")
                    local mpPos = getPartPos(mp)
                    if mpPos then
                        moveToVelocity(mpPos + Vector3.new(0, 15, 0), S.glide_speed, 4)
                        local t0 = tick()
                        while isOn() and tick() - t0 < 20 do
                            if not (mondo and mondo.Parent) then break end
                            combatHit()
                            task.wait(0.2)
                        end
                    end
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

        local target = nil
        for attempt = 1, 3 do
            if not pp then
                autoDetectHiveInstant()
                pad = myHive and HiveTool.pad(myHive)
                pp = padPos(pad)
            end
            if not pp then break end
            target = Vector3.new(pp.X, HiveTool.top(pad) + 1, pp.Z)
            Nav.nodeTravel(target, "Hive travel", 3)
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
                            Nav.nodeTravel(target, "Back to hive pad", 3)
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

                        local sig, still, lastLeft = nil, 0, bPollen
                        while isOn() and (tick() - bStart) < 15 do
                            local c, left = Nav.hiveBalloons(target, 35)
                            if c <= 0 then break end
                            if bPollen > 0 and left <= 0 then break end
                            lastLeft = left
                            local key = tostring(c) .. ":" .. tostring(math.floor(left))
                            if key == sig then
                                still = still + 1
                                if still >= 8 then break end
                            else
                                still = 0
                                sig = key
                            end
                            task.wait(0.5)
                        end
                        if (lastLeft or 0) > 0 then
                            status = string.format("Balloon left %.2fB - back to field in 5s", lastLeft / 1e9)
                        end
                    end
                end)
end
            if not string.find(tostring(status), "Balloon left", 1, true) then
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
        if not (S.face_balloons or S.face_bubbles or S.face_center) then
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
            task.wait(0.5)
        end
    end)
bg(function()
        while true do
            local okS, errS = pcall(function()
            lastBeat = tick()
            if not S.farm_on then
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

                    if (S.auto_polar_quests or S.polar_only) and isOn() then
                        status = "Routine: Polar Bear"
                        completePolarBearRoutine()
                    end

                    farmCycleStart = tick()
                    needSprinkler = true
                end

                if S.polar_only and isOn() then
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
                            status = "Polar: combat"
                            doBossCombat()
                        end

                        if S.nectar_farm and isOn() then
                            status = "Polar: nectars"
                            nectarStep()
                        end

                        completePolarBearRoutine()
                    end
                elseif S.auto_polar_quests and isOn() then
                    local pollen, cap = getPollenAndCap()
                    local isFull = forceReturn or (pollen and cap and cap > 0 and pollen >= cap * (S.full_pct / 100) and tick() >= (S.dig.convCooldown or 0))
                    if isFull then
                        forceReturn = false
                        collecting = false
                        if S.reset_mode then doReset() else convertAtHive() end
                    else
                        completePolarBearRoutine()
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

                    if S.nectar_farm and isOn() then

                        nectarStep()
                    end

                    local field = getField(S.field)
                    currentField = field

                    if not field then
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

                                local travelPoint = Vector3.new(c.X, groundY(field) + 5, c.Z)

                                if not inField(hrp.Position, field, 28) then
                                    status = "Returning to field"
                                    Nav.go(travelPoint, S.glide_speed, 3, "Return to field")
                                    local afterWalk = getHRP()
                                    if not afterWalk or not inField(afterWalk.Position, field, 28) then
                                        status = "Travel failed: " .. tostring(S.field)
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
                                    Nav.go(travelPoint, S.glide_speed, 4, "Go to field")
                                    local nearWalk = getHRP()
                                    if not nearWalk or not inField(nearWalk.Position, field, 10) then
                                        status = "Travel failed: " .. tostring(S.field)
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

            if not S.farm_on then
                S.farm_on = true
                needSprinkler = true
                if _G.__lolcatAutoFarmRow then
                    pcall(function() _G.__lolcatAutoFarmRow:Set(true) end)
end
            end
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
        if not S.farm_on then return "Off" end
        if not FeaturesActive then return "Paused (menu open)" end
        if not isAlive() then return "Waiting for character" end
        return status
    end

    Engine.hiveName = function() return myHive and myHive.Name or "None" end

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

    Engine.polarName = function()
        local q = getPolarBearQuest()
        if not q or not q.hasQuest then return "None detected" end
        return q.questName or q.title or "-"
    end

    Engine.polarStatus = function()
        local q = getPolarBearQuest()
        if not q or not q.hasQuest then return "Visit Polar Bear" end
        if q.allComplete then return "Ready to turn in!" end
        for _, t in ipairs(q.tasks) do
            if not t.complete then
                if t.type == "mob"    then return tostring(t.mob) .. " (" .. t.needed .. " left)" end
                if t.type == "petal"  then return tostring(t.petal or "") .. " petals (" .. t.needed .. " left)" end
                if t.type == "pollen" then return tostring(t.field or "Field") .. " (" .. t.needed .. " left)" end
            end
        end
        return "In progress"
    end

    Engine.execState = function()
        if lastBeat == 0 or (tick() - lastBeat) > 2 then return "Engine thread NOT running" end
        return (S.farm_on and isAlive()) and "Active" or "Idle"
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

        if not S.farm_on then
            S.farm_on = true
            needSprinkler = true
            if _G.__lolcatAutoFarmRow then
                pcall(function() _G.__lolcatAutoFarmRow:Set(true) end)
end
        end
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

    Engine.travelModes = function()
        if S.hybrid then return { "Pathfinding" } end
        return { "Tween", "Pathfinding" }
    end

    Engine.travelMode = function()
        if S.hybrid then return "Pathfinding" end
        if S.travel_mode == "Tween" then return "Tween" end
        return "Pathfinding"
    end

    Engine.setTravelMode = function(v)
        local name = type(v) == "table" and v[1] or tostring(v)
        if S.hybrid then
            S.travel_mode = "Pathfinding"
            status = "Travel mode: Pathfinding (hybrid)"
            return
        end
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
    Engine.claimQuest  = function() bg(function() pcall(claimOrAcceptPolarBearQuest, true) end) end

    Engine.shutdown = function()
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
    title    = "lol Cat",
    subtitle = "auto",
    size     = Vector2.new(860, 620),
    menuKey  = "f1",
    logoSize = 34,
    theme    = { accent = Color3.fromRGB(148, 0, 255) },
    accentA  = Color3.fromRGB(148, 0, 255),
    accentB  = Color3.fromRGB(199, 121, 255),
    font     = "Proxima",
    logo     = LOGO,
    opacity  = 0.98,
    checkboxStyle = true,
    backgroundEffect = "Snow",
    backgroundEffectColor = Color3.fromRGB(235, 240, 255),
    configName  = "lolcatbss",
    configFolder = "lolcatbss",
    autoSave = true,
    smartFps = false,
    gameInput = false,
    startOpen = true,
})

win:AddSettingsTab("gear")
task.delay(0.8, function()
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
task.delay(1, function()
    pcall(function() win:SetMenuKey("f1") end)
end)
Lib:Notify("lol Cat", "Press F1 to open the menu", 4, "info")

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
local nectarTab = win:Tab("Nectars", "leaf")
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
nm:Slider("Hours between collects", 1, 1, 1, 4, "h", function(v) Engine.S.nectar_collect_every = v end)
nm:Toggle("Fill extra planters (up to 3)", false, function(v) Engine.S.nectar_extra = v end)
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

if HYBRID_TABS then
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

local ex = combatTab:Section("Hazards & items", "Right")
ex:Toggle("Catch falling coconuts", false, function(v) Engine.S.catch_coconuts = v end)
ex:Toggle("Catch star showers", false, function(v) Engine.S.catch_stars = v end)
ex:Toggle("Farm active sprouts", false, function(v) Engine.S.farm_sprouts = v end)
ex:Toggle("Auto-collect loot tokens", false, function(v) Engine.S.collect_tokens = v end)
ex:Toggle("Convert when a balloon is near", false, function(v) Engine.S.convert_balloon = v end)
end

local hiveTab = win:Tab("Hive", "home")
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
travelModeRow = travelSec:Dropdown("Travel mode", { Engine.travelMode() }, Engine.travelModes(), false, function(v)
    Engine.setTravelMode(type(v) == "table" and v[1] or v)
end)
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
if HYBRID_TABS then
local polarTab = win:Tab("Polar (Soon)", "clock")
local pb = polarTab:Section("Polar Bear", "Left")
pb:Info("Polar Bear automation - Soon")
local prg = polarTab:Section("Progress", "Right")
prg:Label(function() return "Quest: " .. tostring(Engine.polarName()) end)
prg:Label(function() return "Objective: " .. tostring(Engine.polarStatus()) end)
end

local myCfg = win:SettingsSection("lol Cat", "Right")
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
    while _G.__lolcatBSS == INSTANCE do
        task.wait(20)
        pcall(function() win:SaveConfig("lolcatbss") end)
    end
end)
