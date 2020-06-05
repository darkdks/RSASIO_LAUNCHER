# What it is?
Just a small tool, to start Rocksmith 2014 with RS_ASIO project in single player or multiplayer.

In background that edits the RS_ASIO.ini file of the [RS_ASIO project](https://github.com/mdias/rs_asio) to choose whether to start the game with only one enabled interface (single player) or the two enabled inputs (multiplayer) and start the game.
Just few lines of code.

# how to use

- Download [RSASIO_LAUNCHER.zip](https://github.com/darkdks/RSASIO_LAUNCHER/releases/tag/1) and extract it to Rocksmith2014 game folder
- Edit the RSASIO_Launcher.ini file and specify in "DRIVERNAME =" the name of your interface used in RS_ASIO
- If the interface to be enabled and disabled is [Asio.Input.1], keep as is(INPUTSWAP=[Asio.Input.1]), otherwise edit the entry
- Just launch RSASIO_LAUNCHER.exe to open in single or multiplayer, you can make a shortcut in your desktop or replace the existing one (that is what i did for me)
