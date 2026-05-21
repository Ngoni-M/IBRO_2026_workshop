# Installing WSL and VSCODE for the Workshop

This guide is for **Windows users** who need to install WSL before the workshop.

WSL lets you run a Linux environment, such as Ubuntu, inside Windows. Although MAC users dont need to install WSL, as their built in terminal is sufficent, it is recommended that they also use VSCODE for the workshop. Unless they are super familiar with another editor.

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

## VS Code and WSL

### 1. Install the VS Code extensions

Open **VS Code**.

Click the **Extensions** button on the left side.

Search for and install:

- **WSL**

The **WSL** extension lets VS Code connect to Ubuntu.

---

### 2. Make a Shell profile

VS Code profiles let you keep workshop settings separate from your normal VS Code setup.

In VS Code, click:

```text
Manage → Profiles → Create Profile
```

You can name it:

```text
Shell
```

Then use this profile during the workshop.

---

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

### 4. Open a folder in Ubuntu

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

### 5. Pin VS Code to the taskbar

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
