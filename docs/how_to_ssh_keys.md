# Quick README: SSH Public/Private Keys with `ssh-keygen`

This guide shows how to create an SSH key pair for logging in to another machine without typing your account password each time.

Important: this workshop version uses **no passphrase**. When `ssh-keygen` asks for a passphrase, press **Enter**, then **Enter** again.

## What You Create

SSH key setup creates two files:

```sh
~/.ssh/id_ed25519
~/.ssh/id_ed25519.pub
```

- `id_ed25519` is your **private key**. Keep this secret.
- `id_ed25519.pub` is your **public key**. This can be copied to servers.

## Step 1: Create the SSH Key

Run:

```sh
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
```

When prompted:

```text
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

Press:

```text
Enter
Enter
```

Do not type a passphrase.

## Step 2: Check That the Key Files Exist

Run:

```sh
ls -l ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
```

You should see both files.

## Step 3: Copy the Public Key to the Remote Server

Use `ssh-copy-id` if it is available:

```sh
ssh-copy-id -i ~/.ssh/id_ed25519.pub <yourusername>@lengau.chpc.ac.za
```

Replace:

- `<yourusername>` with your CHPC username

Alternative CHPC host:

```sh
ssh-copy-id -i ~/.ssh/id_ed25519.pub <yourusername>@scp.chpc.ac.za
```

You may need to type your remote account password once.

### If `ssh-copy-id` Is Missing

Check whether `ssh-copy-id` is installed:

```sh
command -v ssh-copy-id
```

If nothing is printed, install it using the command for your system.

On Ubuntu or Ubuntu on WSL:

```sh
sudo apt update
sudo apt install openssh-client
```

On macOS with Homebrew:

```sh
brew install ssh-copy-id
```

If you cannot install software on the machine, use the manual method below.

## Step 4: Test SSH Login

Run:

```sh
ssh <yourusername>@lengau.chpc.ac.za
```

If the key was installed correctly, SSH should log in using the key.

## If `ssh-copy-id` Is Not Available

Print your public key:

```sh
cat ~/.ssh/id_ed25519.pub
```

Copy the full line and add it to this file on the remote server:

```sh
~/.ssh/authorized_keys
```

The public key line usually starts with:

```text
ssh-ed25519
```

## Safety Notes

- Never share `~/.ssh/id_ed25519`.
- It is safe to share `~/.ssh/id_ed25519.pub`.
- If you already have an SSH key, do not overwrite it unless you are sure.
- To avoid overwriting an existing key, choose another filename, for example:

```sh
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_chpc
```

Then copy that public key:

```sh
ssh-copy-id -i ~/.ssh/id_ed25519_chpc.pub <yourusername>@lengau.chpc.ac.za
```
