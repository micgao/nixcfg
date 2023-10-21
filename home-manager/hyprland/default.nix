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
    libsForQt5.breeze-gtk
    libsForQt5.breeze-icons
    libsForQt5.qtstyleplugins
    libsForQt5.qt5.qtwayland
    libsForQt5.polkit-kde-agent
    gsettings-desktop-schemas
    hyprpaper
    hyprpicker
    wlay
    wtype
    wl-clipboard
    wl-clipboard-x11
    wlprop
    wlr-randr
    ydotool
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    systemdIntegration = true;
    disableAutoreload = true;
    enableNvidiaPatches = true;
    recommendedEnvironment = true;
    extraConfig = ''
      monitor=HDMI-A-1,1920x1080@144,0x0,1
      monitor=eDP-1,disable
      env=WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0
      env=WLR_DRM_NO_ATOMIC,1
      env=XDG_SESSION_DESKTOP,Hyprland
      env=XDG_CURRENT_DESKTOP,Hyprland
      env=XDG_SESSION_TYPE,wayland
      env=WLR_RENDERER_ALLOW_SOFTWARE,1
      env=WLR_RENDERER,vulkan
      env=WLR_NO_HARDWARE_CURSORS,1
      env=EGL_PLATFORM,wayland
      env=NIXOS_OZONE_WL,1
      env=XCURSOR_SIZE,24
      env=LIBVA_DRIVER_NAME,nvidia
      env=__GLX_VENDOR_LIBRARY_NAME,nvidia
      env=__GL_VRR_ALLOWED,1
      # env=GBM_BACKEND,nvidia-drm
      env=GTK_THEME,sequoia
      env=QT_AUTO_SCREEN_SCALE_FACTOR,1
      env=QT_QPA_PLATFORM,wayland;xcb
      env=QT_QPA_PLATFORMTHEME,qt5ct
      env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env=_JAVA_AWT_WM_NONREPARENTING,1
      env=GDK_BACKEND,wayland,x11
      env=MOZ_DISABLE_RDD_SANDBOX,1
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
          sensitivity = -0.3
          accel_profile = flat
      }

      general {
          gaps_in = 2
          gaps_out = 2
          border_size = 2
          col.active_border = rgb(ffbb88) rgb(f58ee0) 90deg
          col.inactive_border = rgba(9898a6aa)
          layout = dwindle
          no_cursor_warps = true
          allow_tearing = true
      }

      decoration {
          rounding = 8
          active_opacity = 1.0
          inactive_opacity = 0.9
	        blur {
	            enabled = true
	            size = 10
	            passes = 3
	            new_optimizations = true
	            xray = true
	            brightness = 1.0
	            noise = 0.02
	        }
          drop_shadow = false
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
          pass_mouse_when_bound = false
      }

      misc {
          vfr = true
          disable_autoreload = true
          disable_splash_rendering = true
          disable_hyprland_logo = true
          animate_manual_resizes = false
      }

      xwayland {
          force_zero_scaling = true
      }

      layerrule = blur, waybar

      windowrulev2 = fullscreen, class:(dota2)
      windowrulev2 = workspace 9 silent, class:(dota2)
      windowrulev2 = immediate, class:^(dota2)$

      $mainMod = SUPER

      bind = $mainMod, return, exec, wezterm
      bind = $mainMod, space, exec, fuzzel
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, G, togglegroup,
      bind = $mainMod, P, exec, gopass ls --flat | fuzzel --dmenu | xargs --no-run-if-empty gopass show -c
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exec, wlogout -p layer-shell
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, S, pseudo,
      bindl= , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindl= , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindl= , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d
      ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mainMod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mainMod CTRL, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}
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
