// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // Choose either "stable" for receiving highly polished,
    // or "canary" for less polished but more frequent updates
    updateChannel: 'stable',

    // default font size in pixels for all tabs
    fontSize: 17,

    // font family with optional fallbacks
    fontFamily: '"Ubuntu Mono", "Inconsolata"',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: '#FFA500',

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BLOCK',

    // set to true for blinking cursor
    cursorBlink: true,

    // color of the text
    foregroundColor: '#eee',

    // terminal background color
    backgroundColor: '#292929',

    // border color (window, tabs)
    borderColor: '#333',

    // custom css to embed in the main window
    css: '',

    // custom css to embed in the terminal window
    termCSS: '',

    // set to `true` (without backticks) if you're using a Linux setup that doesn't show native menus
    // default: `false` on Linux, `true` on Windows (ignored on macOS)
    showHamburgerMenu: true,

    // set to `false` if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` on windows and Linux (ignored on macOS)
    showWindowControls: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '12px 14px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#000000',
      red: '#cc0000',
      green: '#4E9A06',
      yellow: '#C4A000',
      blue: '#3465A4',
      magenta: '#75507B',
      cyan: '#06989A',
      white: '#D3D7CF',
      lightBlack: '#555753',
      lightRed: '#EF2929',
      lightGreen: '#8AE234',
      lightYellow: '#FCE94F',
      lightBlue: '#729FCF',
      lightMagenta: '#AD7FA8',
      lightCyan: '#34E2E2',
      lightWhite: '#EEEEEC'
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // Powershell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    shell: '',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to false for no bell
    bell: 'SOUND',

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: true

    // if true, on right click selected text will be copied or pasted if no
    // selection is present (true by default on Windows)
    // quickEdit: true

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'hyper-statusline',
    'hypercwd',
    'hyperterm-paste',
    'hyperterm-alternatescroll',
    'hyperterm-dibdabs',
    'hyperterm-tabs',
    'hyper-tabs-enhanced',
    'hyperlinks',
    'hyper-search',
    //'hyper-solarized-light'
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    "window:devtools": "f12",
    "window:reload": "",
    "window:reloadFull": "ctrl+shift+r",
    "window:preferences": "ctrl+p",
    "zoom:reset": "ctrl+0",
    "zoom:in": "ctrl+plus",
    "zoom:out": "ctrl+-",
    "window:new": "ctrl+n",
    "window:minimize": "",
    "window:zoom": "",
    "window:toggleFullScreen": "f11",
    "window:close": "ctrl+shift+w",
    "tab:new": "ctrl+t",
    "tab:next": "alt+right",
    "tab:prev": "alt+left",
    "pane:next": "",
    "pane:prev": "",
    "pane:splitVertical": "ctrl+o",
    "pane:splitHorizontal": "ctrl+h",
    "pane:close": "ctrl+w",
    "editor:undo": "ctrl+z",
    "editor:redo": "ctrl+y",
    "editor:cut": "",
    "editor:copy": "ctrl+v",
    "editor:paste": "ctrl+b",
    "editor:selectAll": "ctrl+a",
    "editor:clearBuffer": "ctrl+k",
    "plugins:update": ""
  }
};
