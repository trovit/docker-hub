# Description:
#   Invading Poland. Because yes.
#
# Commands:
#   hubot invade poland - Send panzers.

module.exports = (robot) ->
  robot.respond /invade poland/i, (msg) ->
    msg.send "BLITZKRIEG!"
    msg.send "http://www.dw.com/image/0,,17881034_303,00.jpg"
