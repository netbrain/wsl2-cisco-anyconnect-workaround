## WSL2Workaround for Cisco Anyconnect

The following steps will enable your system to run a script everytime the cisco anyclient is connected to the vpn.
The script will alter the priority of the vpn interface to enable wsl2 to use it, and it will configure the wsl instance
to use the dns servers configured in the vpn interface.

1. Copy the wsl2workaround.ps1 script to C:\dev
2. Open scheduled tasks and import wsl2workaround-start.xml and wsl2workaround-stop.xml
3. Disable creation of resolv.conf in your WSL2 instance by creating the `/etc/wsl.conf` with the following contents
```
[network]
generateResolvConf = false
```
4. Remove (if present) the /etc/resolv.conf file
5. Create a new symlink with `ln -s /mnt/c/dev/wsl2workaround-resolv.conf /etc/resolv.conf`

### Gotcha's

1. You need to launch your wsl instance prior to connecting to VPN for this to work.
