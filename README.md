# Pop_OS Game Replay Experience

The goal of this project is to mimic Nvidia's Shadowplay "Instant Replay" feature on Pop_OS. That is, when you press the save replay button, it moves the clip saved into a folder with the name of the game. This will work with other distributions that support OBS, but the hotkey and startup steps will breakdown. The install is (unfortunately) a very manual process, but could possibly be automated if there is enough support for it.

See a video of this script in action:



This entire project assumes you are using Steam to play your games. It uses Steam's API to grab the name of the game you are playing. If you aren't playing a Steam game, it will default to the "Desktop" folder.

# Installation

I've tested these steps and ammended them where possible, but there are likely still problems. Please open an issue if it does not work for you.
As a general overview: OBS needs to be setup to start the replay buffer on boot, system-wide hotkeys need to be setup so you can save a replay, and you need to generate an API key from Steam.

1. Install dependencies (press `win+t` to open terminal)

```console
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install obs-studio

sudo apt install snapd jq -y

snap install obs-cli
```

2. Start OBS from your applications. If you get a prompt about a password, click no (see step 4.ii.).

    <p align="center"><image src="https://user-images.githubusercontent.com/5951498/143719391-e4c67df9-5406-41ea-a6cf-7613914bc838.png" width="400" ></img></p>

3. Setup OBS scene to capture your screen and sound (see [here](https://www.alphr.com/record-screen-obs/))

4. In OBS, go to File > Settings > Output > under recording, set the folder you want the replays to save to, **set Recording Format to mp4**, `Encoder to Hardware (NVENC)`, and check `Enable Replay Buffer` (**most important!**)

    <p align="center"><image src="https://user-images.githubusercontent.com/5951498/143692788-82a12934-8e5f-445d-a081-f309f6765369.png" width="500" ></img></p>

    1. Go to General inside OBS and check `Minimize to system tray when started` and `Always minimize to system tray instead of task bar`

    <p align="center"><image src="https://user-images.githubusercontent.com/5951498/143718838-a681bc4f-e134-4831-a272-6a7f1b229b1b.png" width="650" ></img></p>

    2. Back out of the settings > click Tools > click Websockets Server Settings > uncheck `Enable authentication`. You can enable authentication later, but the script is setup to not take a password and will have to be edited.

5. Clone this repo and move shell scripts to the home directory with

```console
cd ~/ && git clone https://github.com/kmcgurty/pop_os-game-replay-experience.git && cd pop_os-game-replay-experience && mv start-obs.sh save-replay-obs.sh ~/ && cd .. && rm -rf pop_os-game-replay-experience/
```

6. Go to https://steamcommunity.com/dev/apikey to register an API key with Steam

7. Go to https://www.steamidfinder.com/ to get your Steam ID number (you want `steamID64 (Dec)`)

8. Edit the script with `nano ~/save-replay-obs.sh` > fill in the script to match the above details > press `ctrl+o` > press enter when finished

    <p align="center"><image src="https://user-images.githubusercontent.com/5951498/143693149-eb65d60c-0c65-4890-8dbe-1fcb6b1cd329.png" width="650" ></img></p>

9. Run `whoami` in terminal to see your username. You need it in the next steps.

10. In Pop_OS, go to `Startup Applications` > click `Add` > fill out info match the image below. The important part is `bash /home/<username>/start-obs.sh` as the command. You can verify that this command actually works by entering the command into a terminal window.

    <p align="center"><image src="https://user-images.githubusercontent.com/5951498/143720138-377bda27-152c-4e0d-b64c-63d7c0956036.png" width="350" ></img></p>

11. In Pop_OS, go to `Settings` > `Keyboard` > `Customize Shortcuts` > `Custom Shortcuts` > `Add Shortcut` > match image below (important part is `bash /home/<username>/save-replay-obs.sh`, same deal with step #6)

    <p align="center"><image src="https://user-images.githubusercontent.com/5951498/143720123-638b865f-954d-4f18-93c8-da1e887f0a13.png" width="350" ></img></p>

12. Optional: You can also start recording on demand by adding `obs-cli StartStopRecording`

    <p align="center"><image src="https://user-images.githubusercontent.com/5951498/143703123-dbb3edfd-759a-4c22-b60e-1ad277fbeb41.png" width="350" ></img></p>

13. Run `bash ~/start-obs.sh` to restart OBS. You can also accomplish this by restarting your machine.

# Usage

Pretty simple: press the hotkey after you launch a game, it should create a folder with the name of a game, and move the most recent game clip into that folder.
