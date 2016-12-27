#
# Description:
#   Prints something on the videowall
#
# Commands:
#   hubot screen <text> - Writes something on the videowall

TOKEN = "FE7718B8-153F-442C-A964-130833E147C0"

screen = (msg, text) ->
  text = text ? msg.match[1]
  msg.http("http://vm-test-parsing-01.backend:8081/")
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .scope("put/notify", (client) ->
      params = "name=message&type=text&content=#{text}&token=#{TOKEN}"
      client.post(params) (err, res, body) ->
        msg.send "I wrote this on the videowall"
     )

module.exports = (robot) ->
  robot.respond /screen (.*)/i, (msg) ->
    screen(msg)
