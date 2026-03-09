# update-discord
## Discord Update Script

I've seen some absolutely horrific examples of scripts to solve this problem so this solves that problem, as well as the original one to automatically update Discord.

So, here it is: a simple script to use with `cron` to automatically update Discord on a schedule, using the apt package manager to not mess up config files on your Debian system.

## How to Use

1. Open the cron config file with the command `crontab -e`. If this is the first time running the command, follow the prompt to select your favorite editor.

2. Add the following line to the crontab file, substituting the frequency for the timer you want the update script to be run on:

    ```*/30 * * * * ~/scripts/update-discord.sh >/dev/null 2>&1```

## TODO:
    - Update script for other versions of Linux
