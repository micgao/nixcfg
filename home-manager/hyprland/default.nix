{ inputs, config, pkgs, ... }: 
let pointer = config.home.pointerCursor;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  nixpkgs.overlays = [
    inputs.nixpkgs-wayland.overlay
    inputs.hyprpaper.overlays.default
    inputs.hyprpicker.overlays.default
  ];

  home.packages = with pkgs; [
    qt6.qtwayland
    qt6.qt5compat
    qt6.qmake
    libsForQt5.qt5ct
    libsForQt5.breeze-qt5
    libsForQt5.qtstyleplugins
    libsForQt5.qt5.qtwayland
    libsForQt5.polkit-kde-agent
    gsettings-desktop-schemas
    hyprpaper
    hyprpicker
    imv
    wlay
    wtype
    wl-clipboard
    wl-clipboard-x11
    wlprop
    wlr-randr
    ydotool
j ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    systemdIntegration = true;
    disableAutoreload = true;
    enableNvidiaPatches = true;
    recommendedEnvironment = true;
    extraConfig = ''
      monitor=DP-3,1920x1080@144,0x0,1
      monitor=eDP-1,disable
      env=GTK_THEME,Catppuccin-Mocha-Compact-Mauve-dark
      env=XCURSOR_SIZE,24
      env=XDG_SESSION_TYPE,wayland
      env=XDG_SESSION_DESKTOP,Hyprland
      env=XDG_CURRENT_DESKTOP,Hyprland
      env=LIBVA_DRIVER_NAME,nvidia
      env=GBM_BACKEND,nvidia-drm
      env=__GLX_VENDOR_LIBRARY_NAME,nvidia
      env=WLR_NO_HARDWARE_CURSORS,1
      env=QT_QPA_PLATFORM,wayland;xcb
      env=QT_QPA_PLATFORMTHEME,qt5ct
      env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env=GDK_BACKEND,wayland,x11
      env=VDPAU_DRIVER,nvidia

      exec-once=/home/micgao/.nix-profile/libexec/polkit-kde-authentication-agent-1
      exec-once=hyprctl setcursor ${pointer.name} ${toString pointer.size}
      exec-once=hyprpaper
      exec-once=waybar
      exec-once=[workspace 1 silent] wezterm start --always-new-process
      exec-once=[workspace 2 silent] librewolf

      xwayland {
        force_zero_scaling = true
      }

      input {
          follow_mouse = 2
          touchpad {
              natural_scroll = false
          }
          sensitivity = -0.3
          accel_profile = flat
      }

      general {
          gaps_in = 2
          gaps_out = 2
          border_size = 2
          col.active_border = rgb(44475a) rgb(bd93f9) 90deg
          col.inactive_border = rgba(44475aaa)
          col.group_border = rgba(282a36dd)
          col.group_border_active = rgb(bd93f9) rgb(44475a) 90deg
          layout = dwindle
      }

      decoration {
          rounding = 8
          multisample_edges = true
          active_opacity = 1.0
          inactive_opacity = 0.8
          fullscreen_opacity = 1.0
	        blur {
	            enabled = true
	            size = 3
	            passes = 3
	            new_optimizations = true
	            xray = true
	            brightness = 1.0
	            noise = 0.02
	        }
          drop_shadow = false
          shadow_range = 30
          shadow_render_power = 3
          shadow_ignore_window = true
          col.shadow = rgba(1E202966)
          shadow_offset = 0 2
          shadow_scale = 1.0
          dim_inactive = true
      }

       animations {
          enabled = true
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

      master {
          new_is_master = false
          special_scale_factor = 0.8
          new_on_top = false
          no_gaps_when_only = false
          inherit_fullscreen = true
      }

      binds {
          focus_preferred_method = 1
          allow_workspace_cycles = true
          workspace_back_and_forth = true
          scroll_event_delay = 300
          pass_mouse_when_bound = false
      }

      misc {
          vfr = true
          vrr = 1
          no_direct_scanout = true
          disable_splash_rendering = true
          disable_hyprland_logo = true
          layers_hog_keyboard_focus = true
          animate_manual_resizes = false
          groupbar_gradients = true
          groupbar_text_color = true
      }

      windowrulev2 = bordercolor rgb(ff5555),xwayland:1

      $mainMod = SUPER

      bind = $mainMod, return, exec, wezterm start --always-new-process
      bind = $mainMod, F, exec, alacritty -e joshuto
      bind = $mainMod, E, exec, emacs
      bind = $mainMod, C, exec, hyprpicker
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exec, wlogout,
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, P, pseudo,
      bind = $mainMod, space, exec, fuzzel
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
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      bind = $mainMod CTRL, z, workspace, e-1
      bind = $mainMod CTRL, x, workspace, e+1
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      workspace = 4, gapsin:0, gapsout:0, bordersize:1, shadow:false, rounding:false, decorate:false
    '';
  };
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/wallpaper.jpg".source = ./wallpaper.jpg;
}
