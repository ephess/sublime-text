sublime-text Cookbook
=====================
This cookbook is used to install and configure Sublime Text and plugins.

Requirements
------------
Tested on Ubuntu Linux (12.10).

Usage
-----

#### sublime-text::default

This cookbook installs sublime-text system wide.

#### sublime-text::user

This cookbook is for configuring a particular users sublime-text environment.

e.g.
Just include `sublime-text::user` and any packages you want installed in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[sublime-text::user]"
  ],
  "user_installs": [
    {
      "user": "jordan",
      "packages": [
        {"name": "Package Control", "uri": "https://github.com/wbond/sublime_package_control.git", "vcs": "git"},
      ],
      "user_config_files": [
        {"filename": "Preferences.sublime-settings", "data": {
          "ignored_packages": [],
          "vintage_start_in_command_mode": true,
        }},
        {"filename": "Custom.sublime-commands", "data": [
            { "caption": ":q - Close", "command": "close" }
        ]}
      ]
    }
  ]
}
```

License and Authors
-------------------
Authors:
Jordan (ephess) Hagan
