{ pkgs, lib, config, ... }:
{
  imports = [
    ../common.nix
    ../../programs/non-free.nix
    ../../programs/hyprland
  ];
  home.username = "dylan";
  home.homeDirectory = lib.mkDefault "/home/dylan";

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.macchiatoPink;
    name = "catppuccin-macchiato-pink-cursors";
    size = 32;
    x11.enable = true;
    gtk.enable = true;
  };
  home.packages = with pkgs; [
    rofi-wayland
    swww
    waypaper
    qt5ct
    networkmanagerapplet
    libsForQt5.kpat
    hyprcursor
    hyfetch
    vscode
  ];
  programs.firefox.enable = true;
  programs.firefox.package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
      ExtensionSettings = {};
    };
  };
  programs.vscode.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      exec-once = "swww init & waybar & dunst";
      env = [
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "HYPRCURSOR_THEME,catppuccin-macchiato-pink-cursors"
        "HYPRCURSOR_SIZE,32"
      ];
      monitor = [
        "DP-1,3440x1440@144,0x0,1"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        mouse_refocus = false;
        sensitivity = 0;
      };
      general = {
        gaps_in = 4;
        gaps_out = 4; 
        "col.active_border" = "rgba(f5bde6ff) rgba(f5bde6ff) 45deg";
        "col.inactive_border" = "rgba(363a4fff)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 12;
        blur = {
          enabled = true;
          size = 16;
          passes = 4;
          ignore_opacity = true;
        };
        inactive_opacity = 0.8;
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aff)";
      };
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier, slide"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = "yes";
        preserve_split = true;
      };
      gestures = {
        workspace_swipe = "on";
      };
      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
      ];

      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, C, killactive," 
        "$mainMod, Escape, exit," 
        "$mainMod, E, exec, nautilus"
        "$mainMod, F, exec, firefox"
        "$mainMod, V, togglefloating,"
        "$mainMod, Space, exec, rofi -show drun -show-icons"
        "$mainMod, P, pseudo,"
        "$mainMod, R, togglesplit,"
        ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"

        # Move focus with mainMod + arrow keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"
        "$mainMod CTRL, H, resizeactive, -64 0"
        "$mainMod CTRL, L, resizeactive, 64 0"
        "$mainMod CTRL, K, resizeactive, 0 -64"
        "$mainMod CTRL, J, resizeactive, 0 64"


        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ] ++ builtins.concatLists (
        builtins.genList (
          x:
            let ws  = toString (if x == 0 then 10 else x);
                key = toString x;
            in
            [
              "$mainMod, ${key}, workspace, ${ws}"
              "$mainMod SHIFT, ${key}, movetoworkspace, ${ws}"
            ]
          ) 10
      );
      
      bindle = [
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ", XF86Search, exec, launchpad"
      ];
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause # the stupid key is called play , but it toggles "
        ", XF86AudioNext, exec, playerctl next "
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      bindm = [
        " $mainMod, mouse:272, movewindow"
        " $mainMod, mouse:273, resizewindow"
      ];
    };
  };

  programs.waybar = {
    enable = true;
    style = ''
    * {
      font-family: "CascadiaCode";
      font-size: 18;
    }
    window#waybar {
      opacity: 0.9;
      border-radius: 24;
      background: #24273a;
      color: #cad3f5;
    }
    .modules-right {
      padding: 4px;
    }
    .modules-right > * {
      background: #181926;
      border-radius: 6px;
    }
    .modules-right > * > * {
      padding: 0em 1em 0em 0.5em;
      margin: 2px;
    }
    .modules-right > *:first-child{
      border-radius: 20px 6px 6px 20px;
    }
    .modules-right > *:last-child {
      border-radius: 6px 20px 20px 6px;
    }
    #custom-rofi {
      background: #f5bde6;
      color: #24273a;
      border-radius: 24px;
      border-color: #24273a;
      border: 4px solid;
      padding: 0 1em 0 0.5em;
      font-size: 30;
    }
    #workspaces button {
      color: #cad3f5;
    }
    #workspaces button.active, #taskbar button.active {
      background: #f5bde6;
      color: #24273a;
      border-radius: 12px;
      border-color: #24273a;
      border: 4px solid;
    }

    '';
    settings =  {
      mainBar = {
        layer = "top";
        position = "bottom";
        margin = "4px";
        height = 48;
        spacing = 2;
        modules-left = [ "custom/rofi" "hyprland/workspaces" "wlr/taskbar"];
        modules-center = [ "hyprland/window" "mpris" ];
        modules-right = [  "network" "clock"  ];
        "hyprland/workspaces" = {
          format = "{icon}";
        };
        "wlr/taskbar" = {
          on-click = "activate";
          icon-size = 18;
        };
        "custom/rofi" = {
          format = "";
          on-click = "rofi -show run";
        };
        clock = {
          format = "{:%H.%M}";
          tooltip = true;
          tooltip-format = "{:%Y-%m-%d}";
          timezone = "America/New_York";
        };
        network = {
          on-click = "nm-connection-editor";
          format-icons = ["󰤯" "󰤯" "󰤟" "󰤢" "󰤨"];
          tooltip-format-wifi = "{essid}";
          format-wifi = "{icon}";
          format-disconnected = "󰤮";
          format-ethernet = "󰛳";
          format-linked = "󰲊";
        };
      };
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Macchiato";
    font = {
      name = "CascadiaCode";
    };
    extraConfig = ''
    confirm_os_window_close 0
    '';
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-macchiato-pink-compact+rimless";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "pink";
      };
      name = "Papirus-Dark";
    };
  };

  xdg.configFile."rofi" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ../../programs/rofi;
  };
}
