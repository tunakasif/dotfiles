{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      cargo
      cargo-nextest
      clippy
      lldb
      rust-analyzer
      rustc
      rustfmt
    ];
  };
}
