# Description:
#   Topo. You always need a topo in your life
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot topo - Where's the Topo?

module.exports = (robot) ->

  robot.respond /topo/i, (msg) ->
    # rsz = results
    random = Math.floor(Math.random() * 5)
    q = v: '1.0', q: 'mole OR topo', rsz: '8', start: random
    msg.http("http://ajax.googleapis.com/ajax/services/search/images")
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData?.results
      if images?.length > 0
        image  = msg.random images
        msg.send image.unescapedUrl