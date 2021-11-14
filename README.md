# Win11EP
This tool allows to install/uninstall/update an ExplorerPatcher (dxgi.dll or ep_setup.exe) - a wonderful tool from Valentin-Gabriel Radu available at https://github.com/valinet/ExplorerPatcher

Works with both x64 and x32.

You can check the source in Win11EP.bat (yes, I am so dumb and lazy that I make this tool as command-line batch) or simply use compiled Win11EP.exe.

# The syntax is as follows:

Win11EP -i installs or updates ExplorerPatcher. If dxgi.dll or ep_setup.exe exists in the same folder - it will be used otherwise the latest version will be downloaded automatically.

Win11EP -u uninstalls ExplorerPatcher.

# Why it's better than original ep_setup.exe installer:

Because it does not restart explorer.exe process! Cons: you have to reboot to make changes active. Pros: no interruption in copying, no lost icons in tray etc.

# Greetings and credits to:
Valentin-Gabriel Radu for ExplorerPatcher

Mark Russinovich for MoveFile tool

Daniel Stenberg for cURL tool

Angus Johnson for Resource Hacker
