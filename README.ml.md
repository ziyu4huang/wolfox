install WSLg

  Could not resolve keysym XF86FullScreen


 sudo apt install mesa-utils

glxinfo -B


sudo add-apt-repository ppa:kisak/kisak-mesa
sudo apt-get update
sudo apt install libegl-mesa0



To check for the currently used graphics driver execute:

sudo lshw -c video


$ lspci -nn | grep -E 'VGA|Display'
OR
$ sudo lshw -c video


export MESA_D3D12_DEFAULT_ADAPTER_NAME="RADEON" 



