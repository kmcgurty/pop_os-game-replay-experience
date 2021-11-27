#!/bin/bash

saveDir="" # match to the setting inside OBS (step 3 of the install guide)
apiKey=""  # get from https://steamcommunity.com/dev/apikey
steamID="" # get from https://www.steamidfinder.com/ (input your steam username in the website)

#########################################

obs-cli SaveReplayBuffer > /dev/null 2>&1

sleep 1

URL="https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=""$apiKey""&steamids=""$steamID"
res=$(curl -s $URL)

gameName=$(jq -r ".response.players[0].gameextrainfo" <<< "${res}")

if [[ "$gameName" == "null" ]]; then
	gameName="Desktop"
fi

saveLocation=$saveDir/$gameName

mkdir "$saveLocation" > /dev/null 2>&1

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

for file in `find "$saveDir" -maxdepth 1 -name "*.mp4"`  
do
    echo "Moving $file to $saveLocation"
    mv "$file" "$saveLocation"
done

IFS=$SAVEIFS
