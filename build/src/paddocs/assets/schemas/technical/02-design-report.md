## Design Report

### Architecture Overview

- **Board**: Raspberry Pi 3B (ARMv8, 1GB RAM)
- **Storage**: 64GB SD card (boot/root), optional USB SSD for persistent storage
- **Power**: 5V micro-USB power adapter
- **Cooling**: Passive heatsink or low-noise fan
- **Networking**: Ethernet preferred; Wi-Fi fallback

### Technology Stack

- Git server via `git-shell` or `gitea`
- Documentation served via paddocs-generated HTML
- Network tools (ping, traceroute, nmap, etc.)
- Remote backup target via `rsync` or `restic`
- Flask/Python app testing for local development
- Jellyfin for media

### Data Flow
[How data moves through the system, with diagrams if needed]

### Bill of Materials

> Build Date: 2025-07-09  
> Designed for: `llama.cpp` (3B–7B CPU Inference), Arch Linux, Headless/Server Ready  
> Estimated Power: ~150W max (CPU-only), ~300W w/ GPU  
> Target Use: Local LLMs, PADS builder, dev server

#### Components

| Qty | Component | Model / Description | Price (USD) |
|-----|-----------|----------------------|--------------|
| 1   | **CPU**   | AMD Ryzen 5 5500 – 6-core, 12-thread Zen 3 (w/ Wraith Stealth Cooler) | $62.00 |
| 1   | **Motherboard** | MSI PRO B550M-VC WiFi (mATX, AM4, PCIe 4.0, WiFi 6E, BT 5.2) | $75.99 |
| 1   | **RAM**   | Crucial Pro 32GB (2×16GB) DDR4-3200 UDIMM | $74.99 |
| 1   | **NVMe SSD** | Crucial P3 Plus 1TB PCIe Gen4 (M.2 2280) | $61.90 |
| 1   | **HDD**   | Seagate Exos 7E8 4TB 7200RPM SATA (Renewed) | $64.88 |
| 1   | **Case**  | Cooler Master MasterBox Q300L (mATX, filtered, compact) | $39.99 |
| 1   | **PSU**   | ARESGAME AGV 500W 80+ Bronze, non-modular | $37.99 |
| 1   | **Case Fans** | DARKROCK 120mm x3, 3-pin, 1200 RPM, low-noise | $8.99 |

#### Total

**Estimated Total**: `$426.73`

> All prices are approximate from Amazon as of July 2025. Tax/shipping not included.


#### Optional (Not Included)

| Component       | Purpose                        |
|----------------|--------------------------------|
| 1–2x SATA cable | For HDD if none included       |
| HDMI/DP cable   | For external monitor output    |
| USB stick (8GB) | For initial Arch bootloader    |


#### BOM Metadata

```yaml
project: llama-arch-box
date: 2025-07-09
format: markdown
target_model: llama.cpp q4/q5 (3B–7B)
ram_min: 16GB
ram_recommended: 32GB
gpu_required: false
```

### Directory Structure
```plaintext
/mnt
├── media        # Jellyfin Server
│   ├── games
│   ├── movies
│   ├── music
│   ├── pics
│   └── shows
└── repo
    ├── archive  # Backups
    ├── code     # Libs used for RPi
    └── git      # Local Repo
```
### UI/UX Design

[Wireframes, mockups, or descriptions of user interactions]
### Security Considerations

- All remote access via SSH with key authentication
- Encrypted backups and secrets stored under `vault/`
- Minimal services exposed; firewall configured with `ufw`

### Scalability Plan

- Add Pi-hole, local DNS or DHCP
- Integrate ZeroTier or Tailscale for remote VPN
- Deploy model evaluation or inference client
- Expand with external SSD, NAS, or other SBCs
