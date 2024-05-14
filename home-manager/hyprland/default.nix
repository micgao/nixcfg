{ lib, inputs, pkgs, ... }:
{
  imports = [
    ./hyprpaper.nix
    ./hyprlock.nix
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    qt6.qtwayland
    qt6.qt5compat
    libsForQt5.breeze-qt5
    libsForQt5.breeze-gtk
    libsForQt5.breeze-icons
    hyprpaper
    inputs.hyprpicker.packages.${pkgs.hostPlatform.system}.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    extraConfig = ''
            # monitor=,preferred,auto,auto
            monitor=HDMI-A-1,1920x1080@144,0x0,1
            monitor=eDP-1,disable
            env=WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0
            env=XDG_SESSION_DESKTOP,Hyprland
            env=XDG_CURRENT_DESKTOP,Hyprland
            env=XDG_SESSION_TYPE,wayland
            env=WLR_RENDERER_ALLOW_SOFTWARE,1
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
            env=MOZ_DISABLE_RDD_SANDBOX,1
            # exec-once=hyprpaper
            exec-once=hyprctl setcursor qogir_hl
            exec-once=[workspace 1 silent] wezterm
            exec-once=[workspace 2 silent] firefox-nightly
            exec-once=[workspace 3 silent] emacs

            input {
                follow_mouse = 2
                sensitivity = -0.5
                accel_profile = flat
                repeat_rate = 45
                repeat_delay = 300
                float_switch_override_focus = 1
            }

            general {
                gaps_in = 2
                gaps_out = 2
                border_size = 2
                col.active_border = rgb(ffbb88) rgb(f58ee0) 90deg
                col.inactive_border = rgba(9898a6aa)
                layout = dwindle
            }

            cursor {
                no_warps = true
                enable_hyprcursor = true
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
                bezier = myBezier, 0.05, 0.9, 0.1, 1.05
                animation = windows, 1, 7, myBezier
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 10, default
                animation = borderangle, 1, 8, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default
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
                no_direct_scanout = true
                force_default_wallpaper = 0
                disable_autoreload = true
                disable_splash_rendering = true
                disable_hyprland_logo = true
                close_special_on_empty = false
                background_color = rgb(0f1014)
                focus_on_activate = true
                new_window_takes_over_fullscreen = 0
                initial_workspace_tracking = 2
            }

            xwayland {
                force_zero_scaling = true
            }

            opengl {
                nvidia_anti_flicker = true
                force_introspection = 0
            }

            layerrule = blur, notifications
            layerrule = ignorezero, notifications
            layerrule = blur, launcher
            layerrule = ignorezero, launcher

            windowrulev2 = workspace 9 silent, class:^(dota2)$
            windowrulev2 = suppressevent maximize, class:.*

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
  xdg.configFile."hypr/wallpaper.jpg".source = ./wallpaper.jpg;
}
