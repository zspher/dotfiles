{ ... }:
{
  services.kanata = {
    enable = true;
    keyboards.main = {
      extraDefCfg = ''
        process-unmapped-keys yes
      '';
      config = ''
        ;; homerow mod, swapscape
        (defvar
          tap-timeout   200
          hold-timeout  160
          tt $tap-timeout
          ht $hold-timeout

          left-hand-keys (
            a s d f g
          )
          right-hand-keys (
            h j k l ;
          )
        )

        (deffakekeys
          to-base (layer-switch base)
        )

        (defalias
          tap (multi
            (layer-switch nomods)
            (on-idle-fakekey to-base tap 20)
          )

          ha (tap-hold-release-keys $tt $ht (multi a @tap) lmet $left-hand-keys)
          hs (tap-hold-release-keys $tt $ht (multi s @tap) lalt $left-hand-keys)
          hd (tap-hold-release-keys $tt $ht (multi d @tap) lctl $left-hand-keys)
          hf (tap-hold-release-keys $tt $ht (multi f @tap) lsft $left-hand-keys)

          hj (tap-hold-release-keys $tt $ht (multi j @tap) rsft $right-hand-keys)
          hk (tap-hold-release-keys $tt $ht (multi k @tap) rctl $right-hand-keys)
          hl (tap-hold-release-keys $tt $ht (multi l @tap) ralt $right-hand-keys)
          h; (tap-hold-release-keys $tt $ht (multi ; @tap) rmet $right-hand-keys)

          vu (switch (lalt) (mwheel-up 50 120) break () volu break)
          vd (switch (lalt) (mwheel-down 50 120) break () voldwn break)
        )
        (deftemplate switch-mode (mode)
          (tap-hold 200 200 grv (layer-switch $mode))
        )
        (defsrc
          caps esc grv
          a s d f
          j k l ;
          volu voldwn
        )

        (deflayer base
          esc caps (t! switch-mode nomods)
          @ha @hs @hd @hf
          @hj @hk @hl @h;
          @vu @vd
        )

        (deflayer nomods
          esc caps (t! switch-mode base)
          a s d f
          j k l ;
          @vu @vd
        )
      '';
    };
  };
}
