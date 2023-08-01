{ inputs, lib, config, pkgs, ... }: {
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
    libsForQt5.qt5ct
    libsForQt5.breeze-qt5
    libsForQt5.qtstyleplugins
    libsForQt5.qt5.qtwayland
    libsForQt5.polkit-kde-agent
    hyprpaper
    hyprpicker
    imv
    wlay
    wtype
    wl-clipboard
    wl-clipboard-x11
    wlprop
    ydotool
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    systemdIntegration = true;
    disableAutoreload = true;
    nvidiaPatches = true;
    recommendedEnvironment = true;
    extraConfig = ''
      source=~/.config/hypr/mocha.conf
      monitor=,preferred,0x0,1,bitdepth,10
      monitor=DP-3,preferred,0x0,1,mirror,eDP-1

      env=XCURSOR_SIZE,24
      env=XDG_SESSION_TYPE,wayland
      env=XDG_SESSION_DESKTOP,Hyprland
      env=XDG_CURRENT_DESKTOP,Hyprland
      env=_JAVA_AWT_WM_NONREPARENTING,1
      env=LIBVA_DRIVER_NAME,nvidia
      env=GBM_BACKEND,nvidia-drm
      env=__GLX_VENDOR_LIBRARY_NAME,nvidia
      env=WLR_NO_HARDWARE_CURSORS,1
      env=QT_QPA_PLATFORM,wayland;xcb
      env=QT_QPA_PLATFORMTHEME,qt5ct
      env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env=GDK_BACKEND,wayland,x11

      exec-once=/home/micgao/.nix-profile/libexec/polkit-kde-authentication-agent-1
      exec-once=wezterm start --always-new-process
      exec-once=hyprpaper

      xwayland {
        force_zero_scaling = true
      }

      input {
          kb_layout = us
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
          col.active_border = $mauve $teal 45deg
          col.inactive_border = $surface0 $surface2 45deg
          col.group_border = $peach
          col.group_border_active = $sky
          layout = dwindle
      }

      decoration {
          rounding = 8
          multisample_edges = true
          active_opacity = 1.0
          inactive_opacity = 0.9
          fullscreen_opacity = 1.0
          blur = true
          blur_size = 3
          blur_passes = 3
          blur_new_optimizations = true
          blur_xray = true
          drop_shadow = true
          shadow_range = 25
          shadow_render_power = 3
          shadow_ignore_window = true
          col.shadow = 0x66000000
          col.shadow_inactive = 0x66000000
          shadow_offset = [0 5]
          shadow_scale = 1.0
          dim_inactive = true
      }

       animations {
          enabled=true
          bezier=easein,0.11, 0, 0.5, 0
          bezier=easeout,0.5, 1, 0.89, 1
          bezier=easeinback,0.36, 0, 0.66, -0.56
          bezier=easeoutback,0.34, 1.56, 0.64, 1
          animation=windowsIn,1,3,easeoutback,slide
          animation=windowsOut,1,3,easeinback,slide
          animation=windowsMove,1,3,easeoutback
          animation=workspaces,1,2,easeoutback,slide
          animation=fadeIn,1,3,easeout
          animation=fadeOut,1,3,easein
          animation=fadeSwitch,1,3,easeout
          animation=fadeShadow,1,3,easeout
          animation=fadeDim,1,3,easeout
          animation=border,1,3,easeout
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
          layers_hog_keyboard_focus = true
          animate_manual_resizes = false
          render_titles_in_groupbar = false
          groupbar_titles_font_size = 10
          groupbar_gradients = false
          groupbar_text_color = true
      }

      $mainMod = SUPER

      bind = $mainMod, return, exec, wezterm start --always-new-process
      bind = $mainMod, T, exec, alacritty
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
    '';
  };
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/mocha.conf".source = ./mocha.conf;
}
