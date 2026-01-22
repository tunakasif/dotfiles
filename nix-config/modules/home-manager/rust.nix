{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs; [
      cargo
      cargo-nextest
      cargo-watch
      clippy
      lldb
      rust-analyzer
      rustc
      rustfmt
    ];
  };
}
