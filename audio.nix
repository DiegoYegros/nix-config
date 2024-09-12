{ config, pkgs, ... }:

{
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Intel HDA driver configuration
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=auto
    options snd-hda-intel dmic_detect=0
    options snd-hda-intel probe_mask=1
    options snd-intel-dspcfg dsp_driver=1
  '';

  boot.kernelModules = [ "snd-hda-intel" "kvm-intel" "fuse" ];
  boot.supportedFilesystems = [ "fuse" ];
}
