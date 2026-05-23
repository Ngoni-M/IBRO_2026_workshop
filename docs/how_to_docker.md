# How to Install Docker Desktop

This short guide gets the Docker app installed on Windows or macOS, then adds Docker tools in Visual Studio Code.

## 1. Install Docker Desktop

Docker Desktop is the easiest way to install Docker on a personal Windows or macOS computer.

### Windows

1. Go to the Docker Desktop for Windows install page:
   <https://docs.docker.com/desktop/setup/install/windows-install/>
2. Download Docker Desktop for Windows.
3. Run the installer.
4. Restart your computer if prompted.
5. Open Docker Desktop and wait until it says Docker is running.

### macOS

1. Go to the Docker Desktop download page:
   <https://docs.docker.com/get-started/introduction/get-docker-desktop/>
2. Choose the correct download for your Mac:
   - Apple Silicon for M1, M2, M3, or newer Macs
   - Intel for older Intel Macs
3. Open the downloaded `.dmg` file.
4. Drag Docker into the Applications folder.
5. Open Docker Desktop and wait until it says Docker is running.

## 2. Check Docker Works

Open a terminal and run:

```sh
docker run hello-world
```

If Docker is installed correctly, it will download and run a small test container.

## 3. Add Docker Tools to Visual Studio Code

1. Open Visual Studio Code.
2. Open the Extensions view with `Ctrl+Shift+X`.
3. Search for `Container Tools`.
4. Install Microsoft's **Dev Containers** extension.
5. Restart VS Code if prompted.

You should now see Docker-related actions in VS Code, including tools for viewing images, containers, Dockerfiles, and Compose files.

## Creating and Launching a VS Code Dev Container

A **Dev Container** lets us open this folder inside a Docker-based Linux environment. The project files stay on our computer, but the tools run inside the container.

### 1. Add Dev Container configuration files

In VS Code, open the Command Palette:

```text
Ctrl + Shift + P
```

Search for:

```text
Dev Containers: Add Dev Container Configuration Files...
```

For now choose **Ubuntu** as your base.

This will create a folder like:

```text
.devcontainer/
  devcontainer.json
```

### 2. Basic Dockerfile

Create an example `.devcontainer/Dockerfile`:

```Dockerfile
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    curl \
    nano \
    && rm -rf /var/lib/apt/lists/*
```

This starts from Ubuntu and installs a few useful tools.

### 3. Basic devcontainer.json

Example `.devcontainer/devcontainer.json`:

```json
{
  "name": "Teaching Ubuntu Container",
  "build": {
    "dockerfile": "Dockerfile"
  }
}
```

### 4. Launch the container

Open the Command Palette again:

```text
Ctrl + Shift + P
```

Run:

```text
Dev Containers: Reopen in Container
```

VS Code will build the image and open the workspace inside the container.

### 5. Check that it worked

Open a terminal in VS Code and run:

```bash
cat /etc/os-release
python3 --version
```

You should now be working inside the Docker container.

## References

- Docker Desktop: <https://docs.docker.com/desktop/>
- Docker Desktop for Windows: <https://docs.docker.com/desktop/setup/install/windows-install/>
- VS Code containers documentation: <https://code.visualstudio.com/docs/containers/overview>
