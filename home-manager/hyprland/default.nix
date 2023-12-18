{ inputs, config, pkgs, ... }: 
let pointer = config.home.pointerCursor;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  nixpkgs.overlays = [
    inputs.nixpkgs-wayland.overlay
  ];

  home.packages = with pkgs; [
    qt6.qtwayland
    qt6.qt5compat
    qt6.qmake
    libsForQt5.qt5ct
    libsForQt5.breeze-qt5
    libsForQt5.breeze-gtk
    libsForQt5.breeze-icons
    libsForQt5.qtstyleplugins
    libsForQt5.qt5.qtwayland
    libsForQt5.polkit-kde-agent
    gsettings-desktop-schemas
    egl-wayland
    hyprpaper
    hyprpicker
    wlay
    wtype
    wl-clipboard
    wl-clipboard-x11
    wlr-randr
    ydotool
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
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
      env=WLR_DRM_NO_ATOMIC,1
      env=WLR_NO_HARDWARE_CURSORS,1
      env=EGL_PLATFORM,wayland
      env=NIXOS_OZONE_WL,1
      env=XCURSOR_SIZE,24
      env=LIBVA_DRIVER_NAME,nvidia
      env=GTK_THEME,sequoia
      env=GTK_THEME_VARIANT,dark
      env=QT_AUTO_SCREEN_SCALE_FACTOR,1
      env=QT_QPA_PLATFORM,wayland;xcb
      env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env=_JAVA_AWT_WM_NONREPARENTING,1
      env=GDK_BACKEND,wayland,x11
      env=MOZ_DISABLE_RDD_SANDBOX,1
      env=NVD_BACKEND,direct
      env=__GLX_VENDOR_LIBRARY_NAME,nvidia
      env=VDPAU_DRIVER,nvidia
      # env=GBM_BACKEND,nvidia-drm
      exec-once=${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1
      exec-once=hyprpaper
      exec-once=waybar
      exec-once=hyprctl setcursor ${pointer.name} ${toString pointer.size}
      exec-once=[workspace 1 silent] wezterm
      exec-once=[workspace 2 silent] librewolf
      exec-once=[workspace 3 silent] emacs

      input {
          follow_mouse = 2
          touchpad {
              natural_scroll = false
          }
          sensitivity = -0.1
          accel_profile = flat
          float_switch_override_focus = 0
      }

      general {
          allow_tearing = true
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
	            size = 9
	            passes = 3
	            ignore_opacity = true
	            new_optimizations = true
	            xray = true
	            special = true
	        }
          drop_shadow = true
          shadow_range = 20
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
          pass_mouse_when_bound = true
      }

      misc {
          vfr = true
          no_direct_scanout = true
          disable_autoreload = true
          disable_splash_rendering = true
          animate_manual_resizes = false
      }

      xwayland {
          force_zero_scaling = true
      }

      layerrule = blur, waybar
      layerrule = blur, launcher

      windowrulev2 = fullscreen, class:^(dota2)$
      windowrulev2 = immediate, class:^(dota2)$
      windowrulev2 = workspace 9 silent, class:^(dota2)$
      windowrulev2 = nomaximizerequest, class:.*

      workspace = 9, gapsin:0, gapsout:0, bordersize:0, border:false, shadow:false, rounding:false, decorate:false
      workspace = special:scratchpad

      $mainMod = SUPER

      bind = $mainMod, return, exec, wezterm start
      bind = $mainMod, space, exec, fuzzel
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, G, togglegroup,
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exec, wlogout -p layer-shell
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
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic
      bind = $mainMod, mouse_down, workspace, m+1
      bind = $mainMod, mouse_up, workspace, m-1
      bind = $mainMod CTRL, x, workspace, m+1
      bind = $mainMod CTRL, z, workspace, m-1
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/wallpaper.jpg".source = ./wallpaper.jpg;
}
