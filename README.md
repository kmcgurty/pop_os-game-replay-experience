# Game Replay Experience

The goal of this project is to mimic Nvidia's Shadowplay "Instant Replay" feature on Pop_OS. That is, when you press the save replay button, it moves the clip saved into a folder with the name of the game. This will work with other distributions that support OBS, but the hotkey and startup steps will breakdown.

See a video of this script in action:



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

3. In OBS, go to File > Settings > Output > under recording, set the folder you want the replays to save to, **set Recording Format to mp4**, `Encoder to Hardware (NVENC)`, and check `Enable Replay Buffer` (**most important!**)

<p align="center"><image src="https://user-images.githubusercontent.com/5951498/143692788-82a12934-8e5f-445d-a081-f309f6765369.png" width="500" ></img></p>

4. Clone this repo with
`git clone https://github.com/kmcgurty/pop_os-game-replay-experience.git`

5. Move 2 .sh scripts to home dir with
`cd pop_os-game-replay-experience && mv start-obs.sh save-replay-obs.sh ~/`

6. Go to https://steamcommunity.com/dev/apikey to register an API key with Steam

7. Go to https://www.steamidfinder.com/ to get your Steam ID number (you want `steamID64 (Dec)`)

8. Edit the script with `nano ~/save-replay-obs.sh` > fill in the script to match the above details > press `ctrl+o` > press enter when finished

<p align="center"><image src="https://user-images.githubusercontent.com/5951498/143693149-eb65d60c-0c65-4890-8dbe-1fcb6b1cd329.png" width="650" ></img></p>

9. In Pop_OS, go to `Startup Applications` > click `Add` > fill out info match the image below. The important part is `bash ~/start-obs.sh` as the command. You can verify that this command actually works by entering the command into a terminal window.

<p align="center"><image src="https://user-images.githubusercontent.com/5951498/143700682-7c115d9b-fdd0-4ac8-a5a8-bf4dc4485429.png" width="350" ></img></p>

10. In Pop_OS, go to `Settings` > `Keyboard` > `Customize Shortcuts` > `Custom Shortcuts` > `Add Shortcut` > match image below (important part is `bash ~/save-replay-obs.sh`, same deal with step #6)

<p align="center"><image src="https://user-images.githubusercontent.com/5951498/143699298-a7972124-ed0a-4ea6-a606-ab5521fd1a95.png" width="350" ></img></p>

11. Optional: You can also start recording on demand by adding `obs-cli StartStopRecording`

<p align="center"><image src="https://user-images.githubusercontent.com/5951498/143703123-dbb3edfd-759a-4c22-b60e-1ad277fbeb41.png" width="350" ></img></p>

# Usage

Pretty simple: press the hotkey after you launch a game, it should create a folder with the name of a game, and move the most recent game clip into that folder.
