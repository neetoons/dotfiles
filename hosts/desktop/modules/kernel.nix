{inputs, pkgs, ...}:
{
    nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
    #boot.kernelPackagef = pkgs.linuxPackages_latest;
    boot.kernelPackages = pkgs.linuxKernel.packagesFor pkgs.cachyosKernels.linux-cachyos-latest-x86_64-v3;
    boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ "i915" ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.kernelParams = [ "i915.enable_fbc=1" "i915.enable_guc=2" ];
    #zramSwap.enable = true;
    #zramSwap.memoryPercent = 60; # Limita el uso de RAM física para swap comprimido
    swapDevices = [{
        device = "/swapfile";
        size = 10 * 1024; # 10GB
    }];



    nix.settings = {
        substituters = [ "https://attic.xuyh0120.win/lantian" ];
        trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
    };

    #boot.kernel.sysctl = {
    #"vm.swappiness" = 180; # Un valor alto es mejor para zram
    #"vm.watermark_boost_factor" = 0;
    #"vm.watermark_scale_factor" = 125;
    #"vm.page-cluster" = 0;
    #  };

}
