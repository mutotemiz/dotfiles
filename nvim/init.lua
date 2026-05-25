{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "source": "debian",
    "padding": { "top": 2 }
  },
  "display": {
    "separator": ".......... ",
    "key": {
      "color": "38;5;161",
      "width": 12
    }
  },
  "modules": [
    "break",
    "title",
    "separator",
    { "type": "os", "key": "OS" },
    { "type": "kernel", "key": "Kernel" },
    { "type": "uptime", "key": "Uptime" },
    { "type": "packages", "key": "Packages" },
    "break",
    { "type": "de", "key": "DE" },
    { "type": "shell", "key": "Shell" },
    { "type": "terminal", "key": "Terminal" },
    { "type": "display", "key": "Display" },
    "break",
    { 
      "type": "cpu", 
      "key": "CPU", 
      "format": "{1} ({5}) @ {7}"
    },
    { "type": "gpu", "key": "GPU", "format": "{1} {2}" },
    { "type": "memory", "key": "Memory", "format": "{1} / {2} ({3})" },
    { "type": "swap", "key": "Swap", "format": "{1} / {2} ({3})" },
    { "type": "disk", "key": "Disk", "folders": "/", "format": "{1} / {2} ({3})" },
    "break",
    { "type": "terminalfont", "key": "Font" },
    "break",
    "colors"
  ]
}
