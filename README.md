# libvirt on M1

This repo helps you to install and run `libvirt` and `virt-manager` natively on macOS on Apple Silicon Macs.

```bash
# Add my repo to Homebrew
brew tap Menci/libvirt-m1

# Remove any old version installed
brew uninstall --force --ignore-dependencies libvirt virt-{manager,viewer} gtk-vnc

# Install my patched version of the packages
brew install --build-from-source Menci/libvirt-m1/virt-manager \
             --build-from-source Menci/libvirt-m1/virt-viewer \
             --build-from-source Menci/libvirt-m1/gtk-vnc
brew install --head Menci/libvirt-m1/libvirt # Skip this if you don't need to run VMs locally

# Install QEMU (skip if already installed)
brew install qemu

# Disable QEMU security features in libvirtd's config
echo 'security_driver = "none"' >> /opt/homebrew/etc/libvirt/qemu.conf
echo "dynamic_ownership = 0" >> /opt/homebrew/etc/libvirt/qemu.conf
echo "remember_owner = 0" >> /opt/homebrew/etc/libvirt/qemu.conf

# Start libvirtd
brew services start libvirt

# Start virt-manager
virt-manager --debug --no-fork
```

# References

* [jeffreywildman/homebrew-virt-manager#184 (comment)](https://github.com/jeffreywildman/homebrew-virt-manager/issues/184#issuecomment-992374401) to for `gtk-vnc` patch.
* [Damenly/homebrew-virt-manager](https://github.com/Damenly/homebrew-virt-manager) for `virt-manager` and `virt-viewer` formulaes.
* [ARM64 VM on macOS with libvirt + QEMU](https://www.naut.ca/blog/2021/12/09/arm64-vm-on-macos-with-libvirt-qemu/) for disabling QEMU security features and enabling HVF.
* [gitlab.com/Menci/libvirt@3a70188e](https://gitlab.com/Menci/libvirt/-/commit/3a70188ea343d3665f94466193e0a65ffec2df05) my patch to get `libvirtd` working.
