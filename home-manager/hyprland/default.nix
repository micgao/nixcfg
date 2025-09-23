{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./hyprpaper.nix
    ./hyprlock.nix
  ];

  home.packages = [
    inputs.hyprpolkitagent.packages.${pkgs.hostPlatform.system}.hyprpolkitagent
    inputs.hyprpicker.packages.${pkgs.hostPlatform.system}.hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd = {
      enable = false;
    };
    extraConfig = ''
            monitor=,preferred,auto,auto
            monitor=eDP-1,disable
            # monitor=DP-3,1920x1080@144,0x0,1
            env=LIBVA_DRIVER_NAME,nvidia
            env=GTK_THEME,sequoia
            env=GTK_THEME_VARIANT,dark
            env=QT_AUTO_SCREEN_SCALE_FACTOR,1
            env=QT_QPA_PLATFORM,wayland;xcb
            env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1
            env=_JAVA_AWT_WM_NONREPARENTING,1
            env=GDK_BACKEND,wayland,x11,*
            env=__GLX_VENDOR_LIBRARY_NAME,nvidia
            env=GBM_BACKEND,nvidia-drm
            env=NVD_BACKEND,direct
            env=MOZ_DISABLE_RDD_SANDBOX=1

            # monitorv2 {
            #     output = DP-3
            #     mode = 1920x1080@144
            #     position = 0x0
            #     scale = 1
            #     # bitdepth = 10
            #     # supports_hdr = 1
            #     # supports_wide_color = 1
            #     cm = auto
            # }

            input {
                kb_layout = us,ca
                follow_mouse = 1
                sensitivity = -0.7
                accel_profile = flat
                repeat_rate = 25
                repeat_delay = 500
                float_switch_override_focus = 1
            }

            general {
                gaps_in = 2
                gaps_out = 2
                border_size = 2
                col.active_border = rgb(ffbb88) rgb(f58ee0) 90deg
                col.inactive_border = rgba(9898a6aa)
                layout = dwindle
                snap {
                    enabled = true
                }
            }

            cursor {
                no_hardware_cursors = 1
                no_warps = true
                sync_gsettings_theme = true
                inactive_timeout = 5
            }

            decoration {
                rounding = 4
                rounding_power = 3
                active_opacity = 1
                inactive_opacity = 0.9
      	        blur {
      	            enabled = true
      	            ignore_opacity = true
      	            new_optimizations = true
      	            xray = true
      	            special = true
                    popups = true
      	        }
                dim_inactive = true
                dim_strength = 0.1
            }

             animations {
                enabled = true
                bezier = easeOutQuint,0.23,1,0.32,1
                bezier = easeInOutCubic,0.65,0.05,0.36,1
                bezier = linear,0,0,1,1
                bezier = almostLinear,0.5,0.5,0.75,1.0
                bezier = quick,0.15,0,0.1,1
                animation = global, 1, 10, default
                animation = border, 1, 5.39, easeOutQuint
                animation = windows, 1, 4.79, easeOutQuint
                animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
                animation = windowsOut, 1, 1.49, linear, popin 87%
                animation = fadeIn, 1, 1.73, almostLinear
                animation = fadeOut, 1, 1.46, almostLinear
                animation = fade, 1, 3.03, quick
                animation = layers, 1, 3.81, easeOutQuint
                animation = layersIn, 1, 4, easeOutQuint, fade
                animation = layersOut, 1, 1.5, linear, fade
                animation = fadeLayersIn, 1, 1.79, almostLinear
                animation = fadeLayersOut, 1, 1.39, almostLinear
                animation = workspaces, 1, 1.94, almostLinear, fade
                animation = workspacesIn, 1, 1.21, almostLinear, fade
                animation = workspacesOut, 1, 1.94, almostLinear, fade
             }

            dwindle {
                pseudotile = true
            }

            binds {
                pass_mouse_when_bound = false
                focus_preferred_method = 1
                allow_workspace_cycles = true
                workspace_back_and_forth = true
            }

            render {
                direct_scanout = 0
                cm_fs_passthrough = 0
                cm_enabled = true
                new_render_scheduling = true
                cm_auto_hdr = 1
                send_content_type = true
            }
            
            misc {
                vfr = true
                vrr = 1
                font_family = Iosevka SS04
                force_default_wallpaper = 0
                disable_autoreload = true
                disable_splash_rendering = true
                disable_hyprland_logo = true
                close_special_on_empty = false
                layers_hog_keyboard_focus = true
                background_color = rgb(0f1014)
                focus_on_activate = true
                new_window_takes_over_fullscreen = 1
                animate_manual_resizes = true
                animate_mouse_windowdragging = true
            }

            xwayland {
                enabled = true
                force_zero_scaling = true
            }

            group {
                merge_floated_into_tiled_on_groupbar = true
                groupbar {
                    render_titles = false
                    scrolling = false
                    col.active = rgba(111216aa)
                    col.inactive = rgba(131317aa)
                    col.locked_active = rgba(111216aa)
                    col.locked_inactive = rgba(131317aa)
                }
            }

            experimental {
                xx_color_management_v4 = true
            }

            layerrule = blur, notifications
            layerrule = blur, waybar
            layerrule = ignorezero, notifications
            layerrule = blur, launcher
            layerrule = ignorezero, launcher

            windowrule = workspace 9 silent, class:^(dota2)$
            windowrule = suppressevent maximize, class:.*
            workspace = w[tv1], gapsout:0, gapsin:0
            workspace = f[1], gapsout:0, gapsin:0
            windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
            windowrule = rounding 0, floating:0, onworkspace:w[tv1]
            windowrule = bordersize 0, floating:0, onworkspace:f[1]
            windowrule = rounding 0, floating:0, onworkspace:f[1]
            windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

            workspace = special:scratchpad

            $mainMod = SUPER

            bind = $mainMod,M,submap,clean
            submap = clean
            bind = $mainMod,M,submap,reset
            submap = reset

            bind = $mainMod, return, exec, uwsm-app -- wezterm
            bind = $mainMod CTRL, return, exec, uwsm-app -- kitty
            bind = $mainMod, space, exec, fuzzel --launch-prefix='uwsm-app --'
            bind = $mainMod, F, fullscreen,
            bind = $mainMod, G, togglegroup,
            bind = $mainMod, Q, killactive,
            bind = $mainMod, V, togglefloating,
            bind = $mainMod, X, togglesplit,
            bind = $mainMod, P, pseudo,
            bind = $mainMod CTRL, =, exec, loginctl terminate-user ""
            # bindl= , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            # bindl= , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
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
  xdg.configFile."hypr/wallpaper.png".source = ./wallpaper.png;
}
