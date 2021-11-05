# Win11EP
This tool allows to install/uninstall/update an ExplorerPatcher (dxgi.dll) - a wonderful tool from Valentin-Gabriel Radu available at https://github.com/valinet/ExplorerPatcher

Works with both x64 and x32.

You can check the source in Win11EP.bat (yes, I am so dumb and lazy that I make this tool as command-line batch) or simply use compiled and upxed Win11EP.exe.

# Does not need any syntax, the logic is as follows:

* 1. If you will start Win11EP WITH dxgi.dll at the same folder - if ExplorerPatcher IS already installed in the system - it will be overwritten with dxgi.dll from the folder ("updated"). You just need to reboot manually to finish the process.

* 2. If you will start Win11EP WITH dxgi.dll at the same folder - if ExplorerPatcher IS NOT already installed in the system - it will be installed. You just need to reboot manually to finish the process.

* 3. If you will start Win11EP WITHOUT dxgi.dll at the same folder - if ExplorerPatcher IS already installed in the system - it will be uninstalled. You just need to reboot manually to finish the process.

* 4. If you will start Win11EP WITHOUT dxgi.dll at the same folder - if ExplorerPatcher IS NOT already installed in the system - nothing will happen (obvious, isn't it?)

# Greetings and credits to:
Valentin-Gabriel Radu for ExplorerPatcher and Mark Russinovich for MoveFile tool

