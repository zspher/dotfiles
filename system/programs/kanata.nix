{ ... }:
{
  services.kanata = {
    enable = true;
    keyboards.main = {
      config = ''
        (defsrc
          caps
          esc
        )

        (deflayermap (default-layer)
          ;; swapscape
          caps esc
          esc caps
        )
      '';
    };
  };
}
