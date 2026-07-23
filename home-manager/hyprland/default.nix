{ inputs, pkgs, config, lib, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./hyprpaper.nix
    # ./hyprlock.nix
  ];

  home.packages = [
    inputs.hyprpicker.packages.${pkgs.stdenv.hostPlatform.system}.hyprpicker
    inputs.hyprqt6engine.packages.${pkgs.stdenv.hostPlatform.system}.hyprqt6engine
  ];

  programs.hyprland-qt-support.enable = true;

  services.hyprpolkitagent = {
    enable = true;
    package = inputs.hyprpolkitagent.packages.${pkgs.stdenv.hostPlatform.system}.hyprpolkitagent;
  };

  # services.hypridle = {
  #   enable = true;
  #   package = inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.hypridle;
  #   settings = {
  #     general = {
  #       lock_cmd = "${lib.getExe config.programs.hyprlock.package}";
  #     };
  #   };
  # };

  services.hyprlauncher = {
    enable = true;
    package = inputs.hyprlauncher.packages.${pkgs.stdenv.hostPlatform.system}.hyprlauncher;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = [
        "--all"
      ];
      enableXdgAutostart = true;
    };
    extraConfig = ''
            env=LIBVA_DRIVER_NAME,nvidia
            # env=GTK_THEME,sequoia
            env=GTK_THEME_VARIANT,dark
            env=QT_AUTO_SCREEN_SCALE_FACTOR,1
            env=QT_QPA_PLATFORM,wayland;x11
            env=QT_QPA_PLATFORMTHEME,hyprqt6engine
            env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1
            env=_JAVA_AWT_WM_NONREPARENTING,1
            env=GDK_BACKEND,wayland,x11,*
            env=GBM_BACKEND,nvidia-drm
            env=NVD_BACKEND,direct
            env=MOZ_DISABLE_RDD_SANDBOX,1
            env=__GLX_VENDOR_LIBRARY_NAME,nvidia
            env=__GL_GSYNC_ALLOWED,1
            env=CUDA_DISABLE_PERF_BOOST,1
            env=XDG_SESSION_DESKTOP,Hyprland

            exec-once=hyprctl setcursor rose-pine-hyprcursor 24

            monitorv2 {
                output = DP-3
                mode = 1920x1080@144
                scale = 1
                position = 0x0
                supports_wide_color = 1
                supports_hdr = 1
                cm = auto
                vrr = 0
            }

            monitorv2 {
                output = eDP-1
                disabled = true
            }

            input {
                kb_layout = us,ca
                follow_mouse = 1
                sensitivity = 0
                accel_profile = flat
                repeat_rate = 30
                repeat_delay = 400
                float_switch_override_focus = 1
            }

            general {
                gaps_in = 2
                gaps_out = 2
                border_size = 2
                col.active_border = rgb(ffbb88) rgb(f58ee0) 90deg
                col.inactive_border = rgba(9898a6aa)
                layout = scrolling
                allow_tearing = true
            }

            scrolling {
                column_width = 0.5
            }

            cursor {
                sync_gsettings_theme = true
                no_warps = true
            }

            decoration {
                rounding = 4
                rounding_power = 3
                active_opacity = 1
      	        blur {
      	            enabled = false
      	        }
      	        shadow {
      	            enabled = false
      	        }
                dim_inactive = true
                dim_strength = 0.1
            }

             animations {
                enabled = false
             }

            binds {
                pass_mouse_when_bound = false
                focus_preferred_method = 1
                allow_workspace_cycles = true
                workspace_back_and_forth = true
            }

            render {
                direct_scanout = 1
            }
            
            quirks {
                skip_non_kms_dmabuf_formats = true
            }
            
            opengl {
                nvidia_anti_flicker = true
            }
            
            misc {
                vrr = 0
                font_family = Inter
                force_default_wallpaper = 0
                disable_autoreload = true
                disable_splash_rendering = true
                disable_hyprland_logo = true
                close_special_on_empty = false
                background_color = rgb(0f1014)
                focus_on_activate = true
                mouse_move_enables_dpms = true
                key_press_enables_dpms = true
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

            debug {
                full_cm_proto = true
            }

            windowrule {
                name = dota
                match:class = dota2
                immediate = true
                workspace = 9
                render_unfocused = true
                confine_pointer = true
            }

            windowrule {
                name = fix-xwayland-drags
                match:class = ^$
                match:title = ^$
                match:xwayland = true
                match:float = true
                match:fullscreen = false
                match:pin = false
                no_focus = true
            }

            windowrule {
                name = suppress-maximize-events
                match:class = .*
                suppress_event = maximize
            }

            workspace = special:scratchpad

            $mainMod = SUPER

            bind = $mainMod,M,submap,clean
            submap = clean
            bind = $mainMod,M,submap,reset
            submap = reset

            bind = $mainMod, return, exec, wezterm
            bind = $mainMod CTRL, return, exec, kitty
            bind = $mainMod, space, exec, hyprlauncher
            bind = $mainMod, F, fullscreen,
            bind = $mainMod, G, togglegroup,
            bind = $mainMod, Q, killactive,
            bind = $mainMod, V, togglefloating,
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
  xdg.configFile."hypr/hyprqt6engine.conf".source = ./hyprqt6engine.conf;
  xdg.configFile."hypr/hyprtoolkit.conf".source = ./hyprtoolkit.conf;
}
