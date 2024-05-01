# HCDrill - Telegram version
Telegram bot for on-demand HTTP Custom configuration file decryptions

# Installation instructions
- Download Node.JS [Download Here](https://nodejs.org/en/download/ "Node.JS Download")
- Once installed, execute "install-dep" .sh/.bat script depending on your platform, or...
- ... execute `npm update --save` in the same folder as the script.

# Usage
This script supports arguments to avoid editing the file and exposing your Telegram bot token. Instead, you need to pass it as an argument at each bot startup, like so:

`node index.js -bt (your bot token)`


You can also change the "storage" folder, (where the files from Telegram will be downloaded) using the -d argument

`node index.js -bt (your bot token here) -d (physical path where the incoming files should be stored)`

The bot automatically deletes incoming files at the end of each decryption call once the final data is returned.

If for some reason you want to keep the files, you can pass the -c argument and the bot will avoid deleting every downloaded file.

`node index.js -bt (your token) -d (temp dir path) -c`

# Argument summary

```
-bt, --botToken    Start the bot with the desired token
-d, --dir          Set up an custom temporary directory path where all files from Telegram should be downloaded
-c, --conserve     Conserve files and not delete them after each requested task is done
```
