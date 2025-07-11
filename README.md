
# Windows Update Automation Script

-----

## Description

This repository contains a PowerShell script designed to automate the process of finding, downloading, and installing Windows updates and related Microsoft products. It leverages the `PSWindowsUpdate` module for simplified system update management.

The script allows you to:

  - Check for and automatically install the `PSWindowsUpdate` module if needed.
  - Search for available updates for Windows and other Microsoft products (like Office, SQL Server, etc.).
  - Download and install these updates.
  - Manage automatic system reboots if a restart is required after updates are installed.

-----

## Prerequisites

For this script to function correctly, you need:

  - **Windows PowerShell 5.1 or newer** (usually included by default on recent Windows versions).
  - An active **internet connection** to download updates and the `PSWindowsUpdate` module.
  - **Administrator rights** to run the script, as it performs system operations and may install modules.

-----

## Usage

You have a few options to use this script:

### Option 1: Download and Run the Script Directly from PowerShell (Recommended for Automation)

This method is handy for quick execution or for integrating into automated tasks. **However, it requires an understanding of security risks.** Directly running scripts from the internet can be dangerous if the source isn't trustworthy. **Always ensure you trust the script and its origin before using this method.**

1.  **Raw Script URL:**
    The `Update-Windows.ps1` script is available at the following raw URL:
    `https://raw.githubusercontent.com/cthonney/Powershell-WindowsUpdate/refs/heads/master/Update-Windows.ps1`

2.  **Run the Command in PowerShell (as Administrator):**

    Open PowerShell **as an administrator** and run the following command:

    ```powershell
    # Define the script URL
    # IMPORTANT: Ensure this URL is copied EXACTLY as shown above,
    # without any extra brackets [ ] or parentheses ( ) from formatted text.
    $scriptUrl = "https://raw.githubusercontent.com/cthonney/Powershell-WindowsUpdate/refs/heads/master/Update-Windows.ps1"

    # Download the script and execute it directly in memory
    # WARNING: Using Invoke-Expression (iex) runs the downloaded code.
    # Only use this method with trusted sources.
    Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing | Invoke-Expression
    ```

    **Alternative (single command with execution policy handling):**

    ```powershell
    # Define the script URL
    $scriptUrl = "https://raw.githubusercontent.com/cthonney/Powershell-WindowsUpdate/refs/heads/master/Update-Windows.ps1"

    # Launch a new PowerShell instance, bypasses the execution policy for this session,
    # then downloads and executes the script.
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& {Invoke-WebRequest -Uri '$scriptUrl' -UseBasicParsing | Invoke-Expression}"
    ```

### Option 2: Download the Repository as a ZIP

This method is simple and doesn't require Git.

1.  **Download the script:**
    Go to the main page of this GitHub repository: [https://github.com/cthonney/Powershell-WindowsUpdate](https://github.com/cthonney/Powershell-WindowsUpdate)
    Click the green **"Code"** button, then select **"Download ZIP"**.
    Once the ZIP file is downloaded, extract its contents to a folder of your choice (e.g., `C:\Scripts\WindowsUpdate`).

2.  **Run the script as Administrator:**
    Open PowerShell as an administrator (right-click PowerShell icon \> "Run as administrator"), navigate to the directory where you saved the script, then run it:

    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force # May be necessary if not already done
    .\Update-Windows.ps1
    ```

### Option 3: Clone the Repository with Git

If you use Git, this is the recommended method to keep the script up to date.

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/cthonney/Powershell-WindowsUpdate.git
    cd Powershell-WindowsUpdate
    ```

2.  **Run the script as Administrator:**

    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force # May be necessary if not already done
    .\Update-Windows.ps1
    ```

-----

### Script Configuration Options

You can change the script's behavior by adjusting the following variables at the beginning of the `Update-Windows.ps1` file:

  - `$AutoReboot = $true`: Determines if the system should automatically reboot after updates if a restart is required. Change to `$false` to disable automatic reboot.
  - `$IncludeMicrosoftProducts = $true`: Includes updates for other Microsoft products (like Office). Change to `$false` to install only Windows OS updates.

-----

## Automation with Windows Task Scheduler

To automate the execution of this script at regular intervals, you can use **Windows Task Scheduler**:

1.  Open **Task Scheduler** (search for `taskschd.msc`).

2.  In the "Actions" pane on the right, click **"Create Basic Task..."**.

3.  **Name**: Give it a descriptive name (e.g., `Automatic Windows Updates`).

4.  **Trigger**: Choose the desired frequency (e.g., `Weekly`, `Monthly`).

5.  **Action**: Select **"Start a program"**.

6.  **Program/script**: Enter `powershell.exe`.

7.  **Add arguments (optional)**: Paste the following line, adjusting the script path if you chose Option 2 or 3. If you use Option 1 (direct download), you can adapt the arguments to include the `Invoke-WebRequest | Invoke-Expression` command instead of the file path.

    ```
    -NoProfile -ExecutionPolicy Bypass -File "C:\Path\To\Your\Script\Update-Windows.ps1"
    ```

    (Replace `C:\Path\To\Your\Script\Update-Windows.ps1` with the actual path to your local script).

8.  Click `Next`, then `Finish`.

9.  **Very Important:** Double-click the task you just created, go to the **"General"** tab, and check the box **"Run with highest privileges"** to ensure the script has the necessary permissions.

-----

## Contribution

Contributions are welcome\! If you have suggestions for improvements, bug fixes, or new features, feel free to open an issue or submit a Pull Request.

-----

## License

This project is licensed under the MIT License. See the [LICENSE](https://www.google.com/search?q=LICENSE) file for more details.
