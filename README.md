# Game Replay Experience

See a video of this script in action. The goal of this project is to mimic nVidia's Shadowplay "Instant Replay" feature on Pop_OS. This will work with other distributions that support OBS, but the hotkey and startup steps will breakdown.



This assumes you are using Steam to play your games. It uses Steam's API to grab the name of the game you are playing.

# Installation

I haven't tested this from start to finish (11/27), but will make changes if anyone has trouble (please open an issue).
As a general overview: OBS needs to be setup to start the replay buffer on boot, system-wide hotkeys need to be setup so you can save a replay, and you need to generate an API key from Steam.

1. Install dependencies (press `win+t` to open terminal)

```
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install obs-studio

sudo apt install snapd jq -y

*close terminal and re-open*

snap install obs-cli
```

2. Setup OBS scene to capture your screen and sound (see [here](https://www.alphr.com/record-screen-obs/))

3. In OBS, go to File > Settings > Output > under recording, set the folder you want the replays to save to, **set Recording Format to mp4**, and `Encoder to Hardware (NVENC)`

4. Clone this repo with
`git clone https://github.com/kmcgurty/pop_os-game-replay-experience.git`

5. Move 2 .sh scripts to home dir with
`cd pop_os-game-replay-experience && mv start-obs.sh save-replay-obs.sh ~/`

6. Go to https://steamcommunity.com/dev/apikey to register an API key with Steam

7. Go to https://www.steamidfinder.com/ to get your Steam ID number

7. Edit the script with `nano ~/save-replay-obs.sh` > fill in the script to match the above details

6. In Pop_OS, go to `Startup Applications` > click Add > fill out info match the image below. The important part is `bash ~/start-obs.sh` as the command. You can verify that this command actually works by entering the command into a terminal window.

7. In Pop_OS, go to `Settings` > Keyboard > Customize Shortcuts > Custom Shortcuts > Add Shortcut > match image below (important part is `bash ~/save-replay-obs.sh`, same deal with step #6)

8. Optional: You can also start recording on demand by adding `obs-cli StartStopRecording`

# Usage

Pretty simple, just press the hotkey after you launch a game, and it should create a folder with the name of a game, and move the most recent game clip into that folder.