# Description:
#   Grey. Tribute to our mistress.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot grey - Sasha Grey (born Marina Ann Hantzis March 14, 1988) is an American actress, model, author, musician, and former pornographic actress.
#   hubot gotta love me - 50 shades of Sasha Grey

module.exports = (robot) ->

  robot.respond /grey/i, (msg) ->
      pool = [
       'http://memeblender.com/wp-content/uploads/2013/01/challenge-accepted-sasha-grey.jpg',
       'http://imgur.com/gkpHgKY',
       'https://pbs.twimg.com/media/B8gkXR4IAAANNeS.jpg'
       ]
      a = Math.floor(Math.random()*pool.length)
      msg.send pool[a]

  robot.respond /gotta love me/i, (msg) ->
      msg.send 'https://www.youtube.com/watch?v=-lzZrask5F0'
