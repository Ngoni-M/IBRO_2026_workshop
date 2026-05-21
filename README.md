# IBRO 2026 Workshop

Welcome to the IBRO 2026 Workshop. These are the principles we will follow throughout the workshop:

![IBRO 2026 Workshop Principles](IBRO%202026%20Workshop%20Principles.png)

---

# BEFORE THE WORKSHOP

---

# Installing WSL and VSCODE for the Workshop

This guide is for **Windows users** who need to install WSL before the workshop.

WSL lets you run a Linux environment, such as Ubuntu, inside Windows. 

### MAC users:

Although MAC users dont need to install WSL, as their built in terminal is sufficent, it is recommended that they also use VSCODE for the workshop. Unless they are super familiar with another editor.

---

## Quick install

Open **PowerShell** or **Windows Terminal** as **Administrator**.

Then run:

```powershell
wsl --install
```

Restart your computer when prompted.

After restarting, open **Ubuntu** from the Start Menu.

Ubuntu will ask you to create a Linux username and password.

## Username Setup
<span style="color: red;"><strong>HUGE NB: Pay attention when you setup your WSL username and password !!!</strong></span> 

This is not your normal Windows username and password. This is a new Ubuntu username and password.

This will have a huge impact on the ease of use of WSL/terminal

Use a username that is simple and easy to type. Use only lowercase letters. For example:

> ```text
> stefan
> ```

<span style="color: red;"><strong>Do not use spaces, capital letters, or special characters in the username.</strong></span>

Use a password you will remember. For this workshop, avoid special characters in the password. Use letters and numbers only.

You will not see anything on screen while typing the password. This is normal. Type the password and press Enter.

Ubuntu may ask you to type the same password again. Type the same password again and press Enter.

---

## Check that WSL is working

Open PowerShell or Windows Terminal and run:

```powershell
wsl --status
```

You can also check installed Linux distributions with:

```powershell
wsl --list --verbose
```

Ideally, Ubuntu should be listed and should use **WSL version 2**.

---

## Common problems

### 1. Old Windows version

Some older Windows 10 versions do not support the simple install command.

Check your Windows version by pressing **Start**, typing:

```text
winver
```

and pressing Enter.

You should ideally have **Windows 10 build 19041 or later**, or Windows 11.

---

### 2. Not running as Administrator

If installation fails, make sure you opened PowerShell or Windows Terminal as **Administrator**.

Right-click the Start button and choose:

```text
Terminal (Admin)
```

or:

```text
Windows PowerShell (Admin)
```

---

### 3. Virtualization is disabled

WSL2 requires virtualization to be enabled.

Check this in:

```text
Task Manager → Performance → CPU → Virtualization
```

It should say:

```text
Enabled
```

If it says **Disabled**, the setting may need to be changed in BIOS/UEFI. This may require help from IT.

---

### 4. Virtual Machine Platform is missing

If WSL complains about the Virtual Machine Platform, run PowerShell as Administrator and use:

```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

Then restart your computer.

---

### 5. WSL feature is missing

If you see an error such as:

```text
WslRegisterDistribution failed with error: 0x8007019e
```

run PowerShell as Administrator and use:

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

Then restart your computer.

---

## Workshop advice

Please install WSL **before the workshop**.

Installation can be delayed by:

- slow internet
- blocked Microsoft Store access
- missing admin rights
- disabled virtualization
- university or workplace laptop restrictions

If you get an error mentioning **virtualization**, **BIOS**, or **Virtual Machine Platform**, please contact the workshop team before the workshop day.

---

## Plan B for Windows: Cygwin

If WSL setup is blocked or unreliable, Windows users can use **Cygwin** as a fallback Unix-like terminal.

1. Go to the official Cygwin website and download the Windows installer: <https://www.cygwin.com/>
2. Note where the installer was downloaded and keep it somewhere easy to find, such as your **Downloads** folder. You will use this same installer again later if you need to add Cygwin features.
3. Run the installer and accept the default setup options.
4. When you reach the package selection screen, search for:

```text
rsync
```

5. In the **rsync** row, click the value in the **New** column until it changes from **Skip** to a version number.
6. Continue through the installer and finish the setup.
7. Open the **Cygwin Terminal** from the Start menu and use that terminal for workshop commands if WSL is not working.

No other extra Cygwin packages are needed at this point. If you get stuck during installation, read the instructions on the Cygwin landing page first, because they explain the installer steps and common setup choices.

---

## VS Code and WSL

### 1. Install the VS Code extensions

Open **VS Code**.

Click the **Extensions** button on the left side.

Search for and install:

- **WSL**

The **WSL** extension lets VS Code connect to Ubuntu.

---

### 2. Make a Shell profile (OPTIONAL but nice to have!)

VS Code profiles let you keep workshop settings separate from your normal VS Code setup.

You can either create a new profile yourself, or import the example profile included in this repository.

To create a new profile yourself, click:

```text
Manage → Profiles → Create Profile
```

You can name it:

```text
Shell
```

Then use this profile during the workshop.

To import the example profile, first download or open this repository folder. Then, in VS Code, click:

```text
Manage → Profiles → Import Profile...
```

Choose:

```text
Select File...
```

Then select:

```text
vscode_examples/Shell.code-profile
```

This profile is provided as an **example**, not as a profile everyone should use unchanged. It was created on the instructor's machine, so it includes settings and extensions for that setup, including Codex from ChatGPT.

After importing it:

1. Review the extensions VS Code wants to install or enable.
2. Keep the shell, WSL, terminal, and font-size settings if they are useful. (MAC users: remove WSL as it is not needed)
3. Change or remove any AI assistant settings that do not match your own setup.
4. If you use a different assistant, install and configure that assistant instead.
5. Save the adapted profile under your own name, such as (Keep it short!):

```text
Shell
```

The important idea is to use `vscode_examples/Shell.code-profile` as a starting point for a workshop-friendly shell setup, then adjust it before relying on it.

### 3. Connect VS Code to Ubuntu

In VS Code, click the green or blue button in the bottom-left corner.

Choose:

```text
Connect to WSL
```

or:

```text
Connect to WSL using Distro...
```

Then choose **Ubuntu**.

VS Code should open a new window. The bottom-left corner should say something like:

```text
WSL: Ubuntu
```

This means VS Code is using Ubuntu as the main environment.
---
### 4. Getting the code from github

For now, keep the workshop code in your Ubuntu home folder. This matters because it keeps the paths simple and makes it much easier to follow the workshop instructions.

Your Ubuntu home folder usually looks like this:

```text
/home/your-username
```

For example:

```text
/home/stefan
```

#### Simplest option: download the ZIP file

1. Go to the GitHub page:

```text
https://github.com/stefandup/IBRO_2026_workshop
```

2. Click the green **Code** button.
3. Click **Download ZIP**.
4. Move the ZIP file into your Ubuntu home folder.
5. Unzip it there.

After unzipping, check from the command line that the folder is in your home folder:

```bash
cd ~/IBRO_2026_workshop
pwd
ls
```

`pwd` should show your Ubuntu home folder, and `ls` should show the unzipped workshop folder. Make sure it is not in a nested folder, else you will make this harder for yourself.

#### Better option: use git clone

If you have `git` available, this is cleaner:

```bash
cd ~
git clone https://github.com/stefandup/IBRO_2026_workshop.git
```

Check that it worked:

```bash
pwd
ls
ls IBRO_2026_workshop
```

You should see the workshop repository inside your Ubuntu home folder.

After this, open the workshop folder in VS Code using the next section.

---

### 5. Open a folder in Ubuntu

In VS Code, click:

```text
File → Open Folder
```

Choose a folder inside your **Ubuntu home folder**.

This uses the Ubuntu username you created when you first set up WSL (See above).

This usually looks like:

```text
/home/your-username
```

For example, if your Ubuntu username is `stefan`, your Ubuntu home folder is:

```text
/home/stefan
```

Do **not** choose your normal Windows folders, such as:

```text
C:\Users\your-name
```

or:

```text
/mnt/c/Users/your-name
```

For this workshop, keep your files inside Ubuntu.

A **VS Code workspace** is simply the folder you have opened in VS Code. It tells VS Code, "this is the project I am working in."

---

### 6. Pin VS Code to the taskbar (OPTIONAL but nice!)

It can be helpful to pin VS Code to the Windows taskbar.

Right-click the VS Code icon and choose:

```text
Pin to taskbar
```

This makes it easier to open VS Code again during the workshop.

---

## Learning with AI assistants

This repository includes an `AGENTS.md` file. It gives AI coding assistants instructions for this workshop: keep answers short, teach one step at a time, ask before changing files or suggesting commands, and use shell-focused examples.

The goal is to help you learn by doing. Without instructions like these, an AI assistant may solve the whole task for you before you have had a chance to practise.

---

# THIS CAN BE DONE DURING THE WORKSHOP

---

## How to generate dummy data for use in the workshop

The dummy DICOM data is generated locally because the copied scan folder is too large for GitHub. The source example scan is based on my own brain data, and I give permission for it to be used for this workshop.

Create and activate a Python virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Your terminal should display something like this, to show that your virtual environment is active.:

```bash
(.venv) yourUsername:ThisFolder$ 
```

Install the Python package needed to edit DICOM headers:

```bash
pip install pydicom
```

Generate the dummy subject folder while you are in the workspace folder:

```bash
python helper_scripts/make_dummy_dicom_subjects.py
```

This creates `dummy_data/` with 10 copied subjects named `subject1`, `subject2`, and so on. The generated folder is ignored by Git.

---
