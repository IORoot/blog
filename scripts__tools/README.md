# Scripts and Tools

This is a very simple BASH based puppet-esque installer for your personal programs, environments, scripts, etc...

## How to run

`./install.sh`

## Profiles Folder

Within the `/profiles` folder there is a simple file with the name of your host. To create a new one, simply type `hostname` on your commandline and create a new file with that name.

Each profile lists all of the things you wish to install.

Example:

    ```
    install "homebrew"
    install "ohmyzsh"
    install "powerlevel10k"
    install "zshrc"
    install "aliases"
    install "env_vars"
    install "paths"
    install "hb-jq"
    install "scripts"
    install "fonts"
    ```

Each one of these runs a script called `install_$SCRIPT.sh` in the `/installers` folder

## Installers Folder

The installer will detect which architecture and operating system you are using from:
- MacOS
- Ubuntu
- CentOS

It will then run the corresponding install scripts from that installer folder `/installers/macos`

## Scripts Folder

The `/scripts` folder is where all of the extra files to reference and use during installation.

## Install Scripts

Each install script `/installers/$OS/install_$SCRIPT.sh` will run if it is referenced in the profile.

When writing a new script, add a few things:

1. A check for a file/path/folder/link to see if it's already run.

```
if [ -L ~/.paths ]; then
    ...
else
    ...
fi
```

2. The 'Already Installed' message

```
if [ -L ~/.paths ]; then
    printf "Already Installed\n"
else
    ...
fi
```

3. The 'Done' message.

```
if [ -L ~/.paths ]; then
    printf "Already Installed\n"
else
    printf "DONE\n"
fi
```

## Changelog


v1.0.0
First instance.