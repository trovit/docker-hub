# Sasha bot
Sasha is a chat bot, based in [Hubot](https://github.com/github/hubot). She's pretty cool. 
She's [extendable with scrips](http://hubot.github.com/docs/#scripts) and can work on slack chat 
and other many different chat services.

Slack is a very popular chat service, free and customizable with funny options. However, it has some
limitations witch you can skip getting a no-free account. For more details you can review the 
[pricing page](https://slack.com/pricing).

## Prerequisites
 
Once you have [created your new team](https://slack.com/create#email) in Slack, you can [get a api bot](https://slack.com/apps/new/A0F7YS25R-bots).
This token is necessary because Sasha needs it for her integration with slack.

Then copy/paste *docker-compose.yml.dist* and set the new api key here:

`cp docker-compose.yml.dist docker-compose.yml`

`sed -i 's/HUBOT_SLACK_TOKEN=${SLACK_TOKEN}/HUBOT_SLACK_TOKEN=[SASHA_TOKEN]/g' docker-compose.yml`

If you don't have Docker in your system read the [get started with Docker](https://docs.docker.com/engine/getstarted/) and install it.

## Starting
Now you can move Sasha to live:

`docker-compose up -d` 

and talk with her in any channel of your slack team. Write `sasha ping` and she'll return `PONG`.

Enjoy!

## Scripts
In the [scripts](https://github.com/trovit/docker-hub/tree/master/hubot/scripts) folder you can find a collection of 
scripts courtesy of the Trovit Team. Of course, you can add new files writing or updating scripts (with coffesscript) 
and send us a PR to this repository. 

## Contributing
See the LICENSE [file](https://github.com/github/hubot/blob/master/LICENSE.md) for license rights and limitations (MIT).
