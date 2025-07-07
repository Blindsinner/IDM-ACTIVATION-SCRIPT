# IDM Activation Script (IAS)

**Final v1.4-Final** | Open-source tool to activate, freeze, reset, and firewall‑block [Internet Download Manager (IDM)](https://www.internetdownloadmanager.com/).

---

## 🚨 Disclaimer
This repository is a mirror and enhancement of the original batch/PowerShell script. I am not the original author. The project originated on the IDM forum and later moved to GitHub:

- Forum: https://www.nsaneforums.com/topic/371047--/?do=findComment^&comment=1578647
- Original GitHub: https://github.com/WindowsAddict/IDM-Activation-Script

All credit to the original researchers and contributors listed below.
---
If your Internet Download Manager (IDM) trial has expired, you can use the **IDM Activation Script (IAS) v1.4** via the PowerShell one-liner method to reset, freeze, activate, and block updates for IDM. If the firewall blocks file downloads, you’ll need to reset it manually first. Below is a clear, concise guide based on your instructions, detailing the PowerShell method and the subsequent steps to handle an expired IDM trial, including retries for activation and firewall troubleshooting.

---

## How to Reset, Freeze, Activate, and Block Updates for IDM Using PowerShell

Follow these steps to use the **IDM Activation Script (IAS) v1.4** to manage an expired IDM trial. The process involves running the script via PowerShell as Administrator, resetting the firewall if downloads fail, and retrying activation if needed.

### Prerequisites
- **IDM Installed**: Ensure IDM is installed (download from [www.internetdownloadmanager.com](https://www.internetdownloadmanager.com) if needed).
- **PowerShell Access**: You need PowerShell (available by default on Windows 7/8/8.1/10/11).
- **Administrator Privileges**: PowerShell must be run as Administrator to modify registry and firewall settings.

### Step-by-Step Instructions

#### Step 1: Run PowerShell as Administrator
1. Press `Windows key + S`, type **PowerShell**, right-click **Windows PowerShell**, and select **Run as administrator**.
2. Alternatively, open **Windows Terminal** as Administrator and switch to the PowerShell tab.

#### Step 2: Execute the IAS Script
1. In the PowerShell window, paste and run the following command:
   ```powershell
   iex (irm is.gd/IDMFIX)
   ```
2. This downloads and executes the `IAS.cmd` script (v1.4) from the GitHub repository.
3. A command prompt window will open displaying the IAS menu:
   ```
   IDM Activation Script 1.4
   ___________________________________________________
   Telegram: @ModByPiash
   Github: https://github.com/lstprjct
   ___________________________________________________
   [1] Activate
   [2] Freeze Trial
   [3] Reset Activation / Trial
   [4] Block IDM Updates
   [5] Unblock IDM Updates
   [6] Download IDM
   [7] Help
   [0] Exit
   ___________________________________________________
   Enter a menu option in the Keyboard [1,2,3,4,5,6,7,0]
   ```

#### Step 3: Reset IDM Activation/Trial
1. In the menu, type **3** and press Enter to select **Reset Activation / Trial**.
2. **What Happens**:
   - The script backs up CLSID registry keys to `%SystemRoot%\Temp` (e.g., `_Backup_HKCU_CLSID_[timestamp].reg`).
   - It deletes IDM registry keys (e.g., `HKCU\Software\DownloadManager`, `HKLM\Software\Internet Download Manager`) like `FName`, `LName`, `Email`, `Serial`, etc.
   - Output will confirm: `The IDM reset process has been completed.`
3. The script returns to the main menu after completion.

#### Step 4: Check for Firewall Issues
The script downloads small PNG files (e.g., `idm_box_min.png`) from `www.internetdownloadmanager.com` to create registry keys for freezing or activation. If these downloads fail due to firewall restrictions, you’ll see:
```
Error: Unable to download files with IDM.
Ensure firewall allows IDMan.exe. Check https://github.com/lstprjct/IDM-Activation-Script/wiki/IAS-Help#troubleshoot
```
If this happens, manually reset the firewall before proceeding.

#### Step 5: Manually Reset Firewall (If Downloads Fail)
If the PNG downloads fail, reset the firewall to clear any rules blocking `IDMan.exe`:
1. **Open Windows Defender Firewall**:
   - Press `Windows key + S`, search for **Windows Defender Firewall**, and select **Windows Defender Firewall with Advanced Security**.
   - Click **Restore Default Policy** in the right pane (under "Actions").
   - Confirm the reset. **Note**: This clears all custom firewall rules, so you may need to reconfigure other apps later.
2. **Add IDM to Firewall Exceptions**:
   - Go to **Windows Defender Firewall** > **Allow an app or feature through Windows Defender Firewall** > **Change settings** (requires admin rights).
   - Click **Allow another app** > **Browse** > Select `IDMan.exe` (typically in `C:\Program Files (x86)\Internet Download Manager\IDMan.exe`).
   - Ensure both **Private** and **Public** are checked, then click **Add** and **OK**.
3. **Disable Third-Party Firewalls** (if applicable):
   - Temporarily disable or uninstall third-party security software (e.g., Kaspersky, Bitdefender, Adguard).
   - For Kaspersky, set `IDMan.exe` to **Trusted** in **Smart Firewall** > **Program Control**.
   - For Bitdefender, disable **Online Threat Defense** temporarily.
4. **Test Connectivity**:
   - Open IDM and try downloading a test file (e.g., `https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png`).
   - If it works, proceed to the next steps.

#### Step 6: Reset IDM Again (After Firewall Reset)
If you reset the firewall, repeat the IDM reset to ensure a clean state:
1. In the IAS menu, type **3** and press Enter to select **Reset Activation / Trial**.
2. Confirm the reset is complete: `The IDM reset process has been completed.`

#### Step 7: Freeze IDM Trial
1. In the IAS menu, type **2** and press Enter to select **Freeze Trial**.
2. **What Happens**:
   - The script triggers IDM to download PNG files to generate registry keys (unless `/skip_png` was used).
   - It locks CLSID keys (e.g., `HKCU\Software\Classes\Wow6432Node\CLSID`) to freeze the trial period.
   - Output will confirm: `The IDM 30 days trial period is successfully freezed for Lifetime.`
   - **Note**: If a registration popup appears, reinstall IDM and retry.
3. The script returns to the main menu.

#### Step 8: Activate IDM
1. In the IAS menu, type **1** and press Enter to select **Activate**.
2. **What Happens**:
   - The script downloads PNG files to create registry keys (if not skipped).
   - It generates and injects fake registration details (e.g., `FName`, `LName`, `Email`, `Serial`) and locks them.
   - Output will confirm: `The IDM Activation process has been completed.`
   - **Warning**: If a fake serial nag screen appears, activation may have failed.

#### Step 9: Retry Freeze and Activate (If Activation Fails)
If activation fails (e.g., fake serial popup or IDM still shows as expired):
1. **Repeat Freeze Trial**:
   - In the IAS menu, type **2** and press Enter to select **Freeze Trial**.
2. **Repeat Activate**:
   - Type **1** and press Enter to select **Activate**.
3. **Retry 2-3 Times**:
   - Repeat the **Freeze Trial** (option 2) and **Activate** (option 1) steps 2-3 times. This often resolves issues by ensuring registry keys are correctly set and locked.
   - If it still fails after 3 tries, reinstall IDM, reset again (Step 6), and repeat Steps 7-8.

#### Step 10: Block IDM Updates
To prevent IDM from contacting its servers and potentially undoing the activation or trial freeze:
1. In the IAS menu, type **4** and press Enter to select **Block IDM Updates**.
2. **What Happens**:
   - The script adds entries to the hosts file (`%SystemRoot%\System32\drivers\etc\hosts`) to block IDM domains (e.g., `127.0.0.1 internetdownloadmanager.com`).
   - This prevents update and activation checks while allowing downloads from other sites.
   - Output will confirm: `IDM updates have been blocked.`
3. **Verify**:
   - Open IDM > **Help** > **Check for updates**. It should fail to connect.

#### Step 11: Test IDM
- Open IDM and try downloading a file from a non-IDM site (e.g., `https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png`).
- Check if the trial is frozen (no expiry popup) or if IDM shows as registered (no fake serial nag).

---

### Important Notes
- **PNG Downloads**: The script downloads safe PNG files from `www.internetdownloadmanager.com` to create registry keys. These are deleted after use and are not malware. Verify by downloading manually in a browser (e.g., `https://www.internetdownloadmanager.com/images/idm_box_min.png`).
- **Firewall Reset**: The script automatically adds firewall rules for `IDMan.exe`, but if PNG downloads fail, manually reset the firewall (Step 5) to clear any blocks.
- **Activation Issues**: If activation fails after 2-3 retries, stick with the **Freeze Trial** option, as it’s more reliable. Reinstall IDM if popups persist.
- **Update Block**: Block updates **last** to avoid interfering with PNG downloads, which require access to `internetdownloadmanager.com`.
- **Troubleshooting**:
  - Check the GitHub wiki: https://github.com/lstprjct/IDM-Activation-Script/wiki/IAS-Help#troubleshoot
  - Join the Telegram group: [t.me/ModByPiash](https://t.me/ModByPiash)

---

### Example Workflow
1. Run PowerShell as Administrator, execute `iex (irm is.gd/IDMFIX)`.
2. In the IAS menu, select **3) Reset Activation / Trial**.
3. Try **2) Freeze Trial**. If it fails with a download error, reset the firewall (Step 5).
4. After firewall reset, select **3) Reset**, **2) Freeze Trial**, then **1) Activate**.
5. If activation fails, repeat **2) Freeze Trial** and **1) Activate** 2-3 times.
6. Select **4) Block IDM Updates** to finish.

---
