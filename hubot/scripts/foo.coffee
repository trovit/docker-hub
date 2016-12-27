# Description:
#   Utility commands for foo.
#
# Commands:
#   hubot foo - Reply with bar

module.exports = (robot) ->
  robot.respond /FOO/i, (msg) ->
    msg.send "bar"
