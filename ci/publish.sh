#!/bin/sh

# Set linker environment variables
export CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-linux-gnueabihf-gcc
export CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc
export CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=x86_64-w64-mingw32-gcc

targets=("x86_64-pc-windows-gnu" "x86_64-unknown-linux-gnu" "armv7-unknown-linux-gnueabihf" "aarch64-unknown-linux-gnu")
for trgt in ${targets[*]}
do
  cargo build --release --target $trgt --verbose
  if [ "$?" != "0" ]
  then
    exit 1
  fi
done

mkdir -p target/releases/
cp target/x86_64-pc-windows-gnu/release/k3d.exe target/releases/k3d.exe
cp target/x86_64-unknown-linux-gnu/release/k3d target/releases/k3d
cp target/armv7-unknown-linux-gnueabihf/release/k3d target/releases/k3d-armhf
cp target/aarch64-unknown-linux-gnu/release/k3d target/releases/k3d-arm64

find target/releases/ -type f -exec sha256sum {} \; > target/releases/sha256sum.txt