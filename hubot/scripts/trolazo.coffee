# Description:
#   Trolazo.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot trolazo : Mi nombre es I-van y soy un trolaaaaaazzzzooooooo

module.exports = (robot) ->

  robot.respond /trolazo/i, (msg) ->
      msg.send 'https://www.youtube.com/watch?v=qYDLyNDcz7s'

  robot.respond /is Trovit Pets deployed/i, (msg) ->
      msg.send 'nope'

  robot.respond /is Trovit Fashion deployed/i, (msg) ->
      msg.send 'nope'

  robot.respond /is Trovit Products deployed/i, (msg) ->
      msg.send 'YES'

  robot.respond /is Pipeline a blocker?/i, (msg) ->
      msg.send 'YES'

  robot.respond /is I2C deployed?/i, (msg) ->
      msg.send 'YES :tada:'

  robot.respond /(cecilia|fernando|designer) at work/i, (msg) ->
      msg.send 'http://38.media.tumblr.com/1674b04d242e1aa413c9ef49c3d976c1/tumblr_inline_n3ctpsxxqw1sx7dqz.gif'

  robot.respond /what time is it/i, (msg) ->
      Number::pad = (digits, signed) ->
        s = Math.abs(@).toString()
        s = "0" + s while s.length < digits
        (if @ < 0 then "-" else (if signed then "+" else "")) + s

      now = new Date()
      now.setHours now.getHours() - 1
      now.setMinutes now.getMinutes() - 30
      hour = now.getHours().pad(2)
      minute = now.getMinutes().pad(2)
      time = ":alarm_clock: #{hour}:#{minute} CST (Cecilia Standard Time)"
      msg.reply time
