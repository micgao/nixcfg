{ lib, inputs, config, pkgs, ... }:
let pointer = config.home.pointerCursor;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.hyprlock.homeManagerModules.default
  ];

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit.Description = "polkit-gnome-authentication-agent-1";

    Install = {
      WantedBy = ["graphical-session.target"];
      Wants = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # nixpkgs.overlays = [
  #   inputs.nixpkgs-wayland.overlay
  # ];

  home.packages = with pkgs; [
    qt6.qtwayland
    qt6.qt5compat
    libsForQt5.breeze-qt5
    libsForQt5.breeze-gtk
    libsForQt5.breeze-icons
    libsForQt5.qt5.qtwayland
    hyprpaper
    inputs.hyprpicker.packages.${pkgs.hostPlatform.system}.default
  ];


  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
    extraConfig = ''
            # monitor=,preferred,auto,auto
            monitor=HDMI-A-1,1920x1080@144,0x0,1,bitdepth,10
            monitor=eDP-1,disable
            env=WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0
            env=XDG_SESSION_DESKTOP,Hyprland
            env=XDG_CURRENT_DESKTOP,Hyprland
            env=XDG_SESSION_TYPE,wayland
            env=WLR_RENDERER_ALLOW_SOFTWARE,1
            env=WLR_RENDERER,vulkan
            env=WLR_NO_HARDWARE_CURSORS,1
            env=EGL_PLATFORM,wayland
            env=HYPRCURSOR_THEME,qogir_hl
            env=HYPRCURSOR_SIZE,24
            env=XCURSOR_SIZE,24
            env=LIBVA_DRIVER_NAME,nvidia
            env=GTK_THEME,sequoia
            env=GTK_THEME_VARIANT,dark
            env=QT_AUTO_SCREEN_SCALE_FACTOR,1
            env=QT_QPA_PLATFORM,wayland;xcb
            env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1
            env=_JAVA_AWT_WM_NONREPARENTING,1
            env=GDK_BACKEND,wayland,x11
            env=__GLX_VENDOR_LIBRARY_NAME,nvidia
            env=VDPAU_DRIVER,nvidia
            env=GBM_BACKEND,nvidia-drm
            env=NVD_BACKEND,direct
            env=ELECTRON_OZONE_PLATFORM_HINT,auto
            exec-once=hyprpaper
            exec-once=waybar
            exec-once=hyprctl setcursor qogir_hl
            exec-once=[workspace 1 silent] wezterm
            exec-once=[workspace 2 silent] firefox-nightly
            exec-once=[workspace 3 silent] emacs

            input {
                follow_mouse = 2
                sensitivity = -0.4
                accel_profile = flat
                repeat_rate = 40
                repeat_delay = 350
            }

            general {
                gaps_in = 2
                gaps_out = 2
                border_size = 2
                col.active_border = rgb(ffbb88) rgb(f58ee0) 90deg
                col.inactive_border = rgba(9898a6aa)
                layout = dwindle
                no_cursor_warps = true
            }

            decoration {
                rounding = 6
                active_opacity = 1.0
                inactive_opacity = 0.9
      	        blur {
      	            enabled = true
      	            size = 10
      	            passes = 3
      	            ignore_opacity = true
      	            new_optimizations = true
      	            xray = true
      	            special = true
                    popups = true
                    brightness = 1.0
                    contrast = 1.0
                    noise = 0.02
      	        }
                drop_shadow = true
                shadow_range = 20
                shadow_render_power = 3
                shadow_ignore_window = true
                col.shadow = rgba(1E202966)
                shadow_offset = 0 2
                shadow_scale = 1.0
                dim_inactive = true
                dim_strength = 0.2
            }

             animations {
                enabled = true
                first_launch_animation = true
                animation = border, 1, 2, default
                animation = fade, 1, 4, default
                animation = windows, 1, 3, default, popin 80%
                animation = workspaces, 1, 2, default, slide
             }

            dwindle {
                pseudotile = true
                special_scale_factor = 0.8
                split_width_multiplier = 1.0
                use_active_for_splits = true
            }

            binds {
                pass_mouse_when_bound = false
                focus_preferred_method = 1
                allow_workspace_cycles = true
                workspace_back_and_forth = true
            }

            misc {
                vfr = true
                vrr = 2
                no_direct_scanout = true
                force_default_wallpaper = 0
                disable_autoreload = true
                disable_splash_rendering = true
                disable_hyprland_logo = true
                close_special_on_empty = false
                background_color = rgb(0f1014)
                focus_on_activate = true
                enable_hyprcursor = true
                hide_cursor_on_key_press = false
                new_window_takes_over_fullscreen = 0
            }

            xwayland {
                force_zero_scaling = true
            }

            opengl {
                nvidia_anti_flicker = true
            }

            layerrule = blur, waybar
            layerrule = blur, notifications
            layerrule = ignorezero, notifications
            layerrule = blur, launcher
            layerrule = ignorezero, launcher

            windowrulev2 = workspace 9 silent, class:^(dota2)$
            windowrulev2 = stayfocused, title:^()$,class:^(steam)$
            windowrulev2 = minsize 1 1, title:^()$,class:^(steam)$

            workspace = special:scratchpad

            $mainMod = SUPER

            bind = $mainMod,K,submap,clean
            submap = clean
            bind = $mainMod,K,submap,reset
            submap = reset

            bind = $mainMod, return, exec, wezterm
            bind = $mainMod, space, exec, fuzzel
            bind = $mainMod, F, fullscreen,
            bind = $mainMod, G, togglegroup,
            bind = $mainMod, Q, killactive,
            bind = $mainMod, V, togglefloating,
            bind = $mainMod, X, togglesplit,
            bind = $mainMod, P, pseudo,
            bindl= , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            bindl= , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
            bindl= , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            bind = $mainMod, H, movefocus, l
            bind = $mainMod, L, movefocus, r
            bind = $mainMod, K, movefocus, u
            bind = $mainMod, J, movefocus, d
            bind = $mainMod, 1, workspace, 1
            bind = $mainMod, 2, workspace, 2
            bind = $mainMod, 3, workspace, 3
            bind = $mainMod, 4, workspace, 4
            bind = $mainMod, 5, workspace, 5
            bind = $mainMod, 6, workspace, 6
            bind = $mainMod, 7, workspace, 7
            bind = $mainMod, 8, workspace, 8
            bind = $mainMod, 9, workspace, 9
            bind = $mainMod, 0, workspace, 10
            bind = $mainMod CTRL, 1, movetoworkspace, 1
            bind = $mainMod CTRL, 2, movetoworkspace, 2
            bind = $mainMod CTRL, 3, movetoworkspace, 3
            bind = $mainMod CTRL, 4, movetoworkspace, 4
            bind = $mainMod CTRL, 5, movetoworkspace, 5
            bind = $mainMod CTRL, 6, movetoworkspace, 6
            bind = $mainMod CTRL, 7, movetoworkspace, 7
            bind = $mainMod CTRL, 8, movetoworkspace, 8
            bind = $mainMod CTRL, 9, movetoworkspace, 9
            bind = $mainMod CTRL, 0, movetoworkspace, 10
            bind = $mainMod, S, togglespecialworkspace, magic
            bind = $mainMod CTRL, S, movetoworkspace, special:magic
            bind = $mainMod CTRL, x, workspace, m+1
            bind = $mainMod CTRL, z, workspace, m-1
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow
    '';
  };

  programs.hyprlock = {
    enable = true;
    general = {
      hide_cursor = false;
    };
    input-fields = [
      {
        monitor = "";
        fade_on_empty = false;
        hide_input = true;
      }
    ];
    labels = [
      {
        monitor = "";
        text = "$TIME";
        valign = "center";
        halign = "center";
      }
    ];
  };

  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/wallpaper.jpg".source = ./wallpaper.jpg;
}
