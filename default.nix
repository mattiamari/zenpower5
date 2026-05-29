{
  lib,
  stdenv,
  kernel,
}:

stdenv.mkDerivation {
  pname = "zenpower5";
  version = "0.5.0";

  src = ./.;

  hardeningDisable = [ "pic" ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [ "KERNEL_BUILD=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" ];

  installPhase = ''
    install -D zenpower.ko -t "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/hwmon/zenpower/"
  '';

  meta = {
    description = "Linux kernel driver for reading temperature, voltage(SVI2), current(SVI2) and power(SVI2) for AMD Zen family CPUs";
    homepage = "https://github.com/mattiamari/zenpower5";
    license = lib.licenses.gpl2Plus;
    platforms = [ "x86_64-linux" ];
    broken = lib.versionOlder kernel.version "4.14";
  };
}
