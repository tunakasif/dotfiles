# Zathura Notes

## Notes for macOS native integration

### Installing

Assuming you want to install Zathura with `synctex` support, we have the following:

```stdout
brew tap zegervdv/zathura
brew install zathura --HEAD --synctex
brew install zathura-pdf-poppler
brew install girara --HEAD
mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib
```

### Chores

We need to make sure `dbus` address is valid, and the `dbus` service is running. Keep in mind that you need to reboot your device to take effect.

```stdout
brew reinstall dbus
echo 'export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"' >> ~/.zshrc
brew services start dbus
```
