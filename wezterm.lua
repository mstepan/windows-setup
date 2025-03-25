---
-- Copied from https://mayberoot.medium.com/the-perfect-windows-11-dev-environment-setup-with-wezterm-wsl2-and-neovim-d73ab1202703
--
-- These are the basic's for using wezterm.
-- Mux is the mutliplexes for windows etc inside of the terminal
-- Action is to perform actions on the terminal
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- These are vars to put things in later (i dont use em all yet)
local config = {}

-- This is for newer wezterm vertions to use the config builder 
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Default config settings
-- These are the default config settins needed to use Wezterm
-- Just add this and return config and that's all the basics you need

-- Color scheme, Wezterm has 100s of them you can see here:
-- https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'nord'

-- This is my chosen font, we will get into installing fonts on windows later
-- Get Nerd Fonts from https://www.nerdfonts.com/font-downloads
config.font = wezterm.font('0xProto Nerd Font')
config.font_size = 11
config.launch_menu = {}

-- Don't promp for closing terminal
config.window_close_confirmation = 'NeverPrompt'


-- increase terminal initeal width and height
config.initial_rows = 40
config.initial_cols = 140


-- makes my cursor blink 
config.default_cursor_style = 'BlinkingBar'
config.disable_default_key_bindings = true

-- this adds the ability to use 'ctrl+c' and 'ctrl+v' to copy/paste from system clipboard 
config.keys = {
  { key = 'c', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard'},
  { key = "t", mods = "CTRL", action = wezterm.action.SpawnTab "CurrentPaneDomain"},
  { key = "q", mods = "CTRL", action = wezterm.action.CloseCurrentTab { confirm = false } },
}

-- There are mouse binding to mimc Windows Terminal and let you copy
-- To copy just highlight something and right click. Simple
config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
 {
  event = { Down = { streak = 1, button = "Right" } },
  mods = "NONE",
  action = wezterm.action_callback(function(window, pane)
   local has_selection = window:get_selection_text_for_pane(pane) ~= ""
   if has_selection then
    window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
    window:perform_action(act.ClearSelection, pane)
   else
    window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
   end
  end),
 },
}


-- This is used to make my foreground (text, etc) brighter than my background
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.2,
  brightness = 1.5,
}

-- This is used to set an image as my background 
-- config.background = {
--     {
--         source = { File = {path = 'C:/Users/maksym/.config/wezterm/background.gif', speed = 0.2}},
--  opacity = 1,
--  width = "100%",
--  hsb = {brightness = 0.5},
--     }
-- }


config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "--login" }


return config
