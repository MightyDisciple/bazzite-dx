# MightyDisciple Bazzite DX

Personal workstation image based on the regular NVIDIA GNOME variant,
`ghcr.io/ublue-os/bazzite-gnome-nvidia:stable`.

It adds the workstation, development, virtualization, and recovery tools used
across MightyDisciple machines while keeping user data outside the image.

## Included software

Native packages and integrations:

- Zed instead of Visual Studio Code
- Niri and Noctalia
- Labwc for testing a stable nested-compositor replacement for Mutterbox
- Mutterbox for running troublesome X11 applications in nested Mutter
- Looking Glass B7 for Wayland and PipeWire
- Docker CE with Buildx and Compose
- Bazzite DX's QEMU/libvirt, VFIO, KVMFR, OVMF, and guestfs tooling
- OpenRGB 1.0 RC3 with the Effects plugin
- CoolerControl and liquidctl
- BorgBackup and Vorta
- Blender and mise

Additional default Flatpaks are installed automatically when networking becomes
available:

- Bitwarden
- Vivaldi
- Obsidian
- LibreOffice

Bazzite's own Flatpak selection remains untouched. The personal list lives in
`system_files/usr/share/mightydisciple/flatpaks.list`; applications are added
or updated but never removed automatically.

## X11 compatibility with Mutterbox

Some multi-window X11 applications do not work correctly through Niri's
Xwayland integration. Open **Mutterbox** from the application launcher and
choose an installed application, or start a command directly:

```bash
mutterbox COMMAND [ARGUMENTS...]
mutterbox --desktop DESKTOP-ID
```

The application runs inside one nested Mutter window. Mutterbox automatically
removes the duplicate title bar from a large X11 main window and fits it to the
nested display, while retaining the title bars of dialogs and tool windows.
Every Mutterbox receives an isolated runtime directory so its portals and
display sockets cannot interfere with the main desktop session.

Labwc is included initially as an experimental building block. Mutterbox stays
available as the known-working fallback until a Labwc-based wrapper matches its
application isolation, window handling, audio, portal, and host-bridge behavior.

Open **Unity (Mutterbox)** from the application launcher to choose a project
known by Unity Hub. The launcher reads the project's required Editor version
and starts the matching installation automatically. When Rider is the selected
external script editor, Unity uses the Mutterbox host bridge so Rider opens as
a separate Niri window instead of inside the nested display. It can also be
used from a terminal:

```bash
mutterbox-unity
mutterbox-unity /path/to/project
mutterbox-unity --list
```

## Backup and recovery

Vorta manages normal Borg backups, schedules, archives, and file restores.
BorgWarehouse on TrueNAS stores the encrypted repositories.

Use the single recovery menu for SSH-key setup and complete-home recovery:

```bash
ujust backup
```

Creating the BorgWarehouse key also adds a narrowly scoped SSH rule for
`10.40.0.10:2223`. This makes the repository URL copied from BorgWarehouse
work directly in Vorta without Bitwarden offering unrelated keys. Forgejo on
port `2222` is unaffected.

Recommended Vorta exclusions:

- `.cache`
- `.local/share/Trash`
- `.local/share/Steam/steamapps/common`
- `.local/share/Steam/steamapps/shadercache`
- `.var/app/*/cache`
- `.ssh/borgwarehouse`
- `.ssh/borgwarehouse.pub`

For complete recovery, install this image with the same username, assign the new
machine's public key to the existing BorgWarehouse repository, log out of the
desktop, switch to a TTY, and select complete-home recovery under
`ujust backup`. Keep the repository URL and encryption passphrase in
Bitwarden.

## Virtualization

Open the workstation virtualization menu:

```bash
ujust workstation-virtualization
```

It manages RTX 5080 VFIO binding, status, Bazzite virtualization setup, and the
KVMFR module required by Looking Glass. RTX binding changes require a reboot.

## Install or switch

The published image is:

```text
ghcr.io/mightydisciple/bazzite-dx:latest
```

Switch an existing bootc system with:

```bash
sudo bootc switch ghcr.io/mightydisciple/bazzite-dx:latest
```

GitHub Actions builds the image on changes and daily for upstream Bazzite
updates. Chunkah splits the image into update-friendly layers before it is
published and signed with the repository's Cosign key.

The disk-image workflow can be started manually to generate a QCOW2 disk or
GNOME Anaconda ISO.

## Repository layout

- `Containerfile`: multistage image definition
- `build_files/build.sh`: package installation and image validation
- `ghcr.io/mightydisciple/looking-glass-client-artifact:b7-fedora44`: daily prebuilt
  Looking Glass artifact from the separate `looking-glass-client` repository
- `system_files/`: files copied into the image
- `disk_config/`: QCOW2 and GNOME ISO configuration
- `.github/workflows/`: image and installer builds
