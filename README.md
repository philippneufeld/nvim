# Neovim config

The `neovim` config requires the version to be 0.9.0 or later.
A [Nerdfont](https://webinstall.dev/nerdfont/) has to be used to display all characters in `neovim` correctly.
Clone the repository to `~/AppData/Local/nvim` on Windows or `~/.config/nvim` on Linux.

## Installation of `neovim` on Ubuntu

1. Go to https://github.com/neovim/neovim/releases
2. Use the `wget` command to download the appropriate Debian package `nvim-linux64.deb`
3. Install using `sudo apt install ./nvim-linux64.deb`

## Installation of `neovim` on Windows behind corporate Proxy

Download latest version from [GitHub](https://github.com/neovim/neovim/releases/latest) and follow the installation instructions.
In order to get Mason to work behind the Bosch proxy, you need to change the `fetch` function in the Mason source code such that the
call to `iwr` uses the `-Proxy http://<proxy-url> -ProxyUseDefaultCredentials` option.
The file can be found at `~\AppData\Local\nvim-data\site\pack\packer\start\mason.nvim\lua\mason-core\fetch.lua`.

In order to install the LSPs, make sure to have a recent python installation active in the terminal in which `neovim` is started.

## Dependencies

1. [Ripgrep](https://github.com/BurntSushi/ripgrep/releases/latest)
2. [nodejs](https://nodejs.org/en)
3. [npm](https://www.npmjs.com/)
4. [python3](https://www.python.org/)
5. [Java JDK](https://www.oracle.com/java/technologies/downloads/) (version >= 11 - optional)

