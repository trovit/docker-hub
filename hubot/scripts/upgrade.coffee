# Description:
#   Upgrades the robot to the latest version from git and dies.
#   It should be restarted with the daemon.
#
# Commands:
#   hubot upgrade - Upgrades Hubot to the latest version (from git) and dies.

exec = require("child_process").exec

module.exports = (robot) ->
  robot.respond /upgrade/i, (msg) ->
    msg.send "Ok. Trying to upgrade myself. Looking for changes..."
    exec "git pull", (err, out) ->
      if err?
        msg.send "Something pretty bad happened, can't pull changes. Error = #{err}"
      else if out.match /Already up-to-date./i
        msg.send "No changes found. Did you forget to push them?"
      else
        msg.send """
                Changes found:
                  #{out}
                Time to die.
                """
        setTimeout () ->
          process.exit 0
        , 3000
