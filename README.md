# Dotfiles

A repo to store all my dotfiles along with other scripts for configuration and setup of my everyday tools. With this repo I can easily clone and run the ansible setup script to setup a fresh install with my typical desktop environment.

#### Files: 
   |  File            | Description                                                   |
   |------------------|---------------------------------------------------------------|
   | `.config`        | user config files for applications such as `gtk` and `compton`|
   | `.i3`            | i3 config folder                                              |
   | `.vim`           | vim config folder where `.vimrc` is stored as well as plugins |
   | `ansible`        | stores ansible scripts for installing `.dotfiles`             |
   | `configs`        | configuration files for various software                      |
   | `gdbinit`        | gdb dotfile                                                   |
   | `scripts`        | stores common scrips i use in my desktop env                  |
   | `.bash_profile`  | alias and color exports                                       |
   | `.bashrc`        | includes configuration for powerline                          |
   | `.bashrc_mac`    | bashrc for MacBook                                            |
   | `.conkyrc`       | conky config file used to get info for the i3 status bar      |
   | `.gitconfig`     | git config file for username                                  |
   | `.gtkrc-2.0`     | gtk config file for setting icons and look of thunar          |
   | `.tmux.conf`     | tmux config file                                              |

### Installing
To install `.dotfiles` 
* `cd` into the ansible directory
* install ansible using `sudo apt install ansible`
* after ansible is installed to run complete install run `./run.sh`
   - to only install components use ansible tags with the comand `ansible-playbook -i hosts <playbook>.yml --tags 'tag1,tag1'`
