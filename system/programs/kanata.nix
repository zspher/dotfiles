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
        (defalias
          vu (switch (lalt) (mwheel-up 50 120) break () volu break)
          vd (switch (lalt) (mwheel-down 50 120) break () voldwn break)
        )
        (defsrc
          caps esc
          volu voldwn
        )

        (deflayer base
          esc caps
          @vu @vd
        )

        (deflayer nomods
          esc caps
          @vu @vd
        )
      '';
    };
  };
}
