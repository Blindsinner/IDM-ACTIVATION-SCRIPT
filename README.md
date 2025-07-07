# IDM Activation Script (IAS)

**Final v1.4-Final** | Open-source tool to activate, freeze, reset, and firewall‑block [Internet Download Manager (IDM)](https://www.internetdownloadmanager.com/).

---

## 🚨 Disclaimer
This repository is a mirror and enhancement of the original batch/PowerShell script. I am not the original author. The project originated on the IDM forum and later moved to GitHub:

- Forum: https://www.nsaneforums.com/topic/371047--/?do=findComment^&comment=1578647
- Original GitHub: https://github.com/WindowsAddict/IDM-Activation-Script

All credit to the original researchers and contributors listed below.

---

## ✨ Features (v1.4-Final)

- **Activate IDM**: Registry key injection to simulate an activated state.
- **Freeze 30‑day Trial**: Lock trial expiry so it never decrements.
- **Reset Activation/Trial**: Completely clear all IDM registration keys.
- **Firewall Block & Update Bypass**: Prevent IDM from contacting servers and disable auto-checks.
- ✓ Persistence across IDM updates and reboots.
- ✓ Fully automated unattended mode with `/act`, `/frz`, `/res` flags.
- ✓ Transparent batch and PowerShell integration for robust execution.

---

## 🔖 Latest Release
**v1.4-Final** (07‑Jul‑2025)

Download: https://github.com/lstprjct/IDM-Activation-Script/releases/tag/v1.4-Final

---

## 📥 Installation & Usage

### Method 1 — PowerShell One‑Liner (Recommended)

1. Open **PowerShell** or **Windows Terminal** as Administrator.
2. Paste and run:
   ```powershell
   iex (irm is.gd/IDM_FIX)
   ```
3. Choose **Activate**, **Freeze Trial**, or **Reset** from the menu.

> This fetches and runs the v1.4-Final `IAS.cmd` automatically.


### Method 2 — Manual Batch

1. Download the zip archive:
   https://github.com/lstprjct/IDM-Activation-Script/archive/refs/heads/main.zip
2. Extract and locate `IAS.cmd`.
3. Right‑click **Run as administrator**.
4. Use the interactive menu to select the desired action.

---

## 📝 Command‑Line Options

| Switch | Action                 | Notes                                  |
|--------|------------------------|----------------------------------------|
| `/act` | Activate IDM           | Generate and lock registry keys.      |
| `/frz` | Freeze 30‑day Trial    | Lock trial registry, preserve forever.|
| `/res` | Reset Activation/Trial | Remove all IDM registry keys & unblocks.|


---

## 💡 How It Works

1. **Backup/Reset** removes all keys and unblocks firewall rules.
2. **Activate** or **Freeze** triggers IDM downloads to create required registry entries.
3. **Registry Scan** identifies those keys and either locks (denies write) or clears them.
4. **Firewall Rules** block IDM’s inbound/outbound traffic to prevent online checks.
5. **Update Bypass** sets `LastCheckQU` to a far‑future date.

---

## 🐞 Troubleshooting

- **Null Service Error**: Ensure the Windows Null service is running.
- **Admin Privileges**: Must run as Administrator.
- **Browser Integration**: See IDM docs:
  - Chrome: https://www.internetdownloadmanager.com/register/new_faq/bi9.html
  - Firefox: https://www.internetdownloadmanager.com/register/new_faq/bi4.html
- **Help Chat**: [Telegram @ModByPiash](https://t.me/ModByPiash)

---

## 📜 Changelog Highlights

**v1.4-Final** (07‑Jul‑2025)
- Added firewall block and update bypass.  
- Streamlined `/act`, `/frz`, `/res` flags.  
- Finalized PATH and re‑launch logic.

**v1.3**
- Fixed firewall rule quoting.  
- Improved install path detection.

**v1.2**
- Restored activation stub; recommended freeze trial.

*See above for full history.*

---

## 🏗️ Improvements & What's Changed

In **v1.4-Final** we have:

- **Fixed PATH setup** to correctly append existing system paths and include Sysnative when available.
- **Re-launch Logic Refined** for x64/ARM64 so the script always runs under the proper bitness.
- **Firewall Rule Quoting Fixed** to ensure `netsh advfirewall` commands execute without syntax errors.
- **Update‑Bypass Registry Write** standardized (setting `LastCheckQU` to `9999-99-99`) to disable auto‑updates reliably.
- **Admin Elevation** streamlined with a single-flags approach and clearer messaging.
- **IDMan Path Detection** improved by querying both Wow6432Node and standard registry hives, falling back to common install paths.
- **Unattended Mode** polished: `/act`, `/frz`, and `/res` now fully automated without prompts.
- **User‑facing Menu** cleaned up for clearer choices and consistent branding (`%iasver%`).

---

## 🙏 Credits & Acknowledgements

| Contributor    | Role                                                           |
|----------------|----------------------------------------------------------------|
| Dukun Cabul    | Original AutoIt researcher and trial reset logic               |
| AveYo (BAU)    | Registry permission snippet                                    |
| abbodi1406     | Quick‑edit disabling & conhost relaunch code                   |
| WindowsAddict  | First GitHub maintainer of IAS                                 |

Made with ❤️ by the community. Feel free to contribute!
