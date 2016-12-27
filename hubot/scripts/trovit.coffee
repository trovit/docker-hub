#
# Description:
#   Prints how many ads we have in trovit
#
# Commands:
#   hubot what's in <country> <vertical> - Returns how many ads we have for the given country/vertical

getNumDocs = (msg, country, vertical) ->
  country = country ? msg.match[2]
  vertical = vertical ? msg.match[3]
  try
    msg.http("http://solr-bo-01.backend:8080/trovit_solr/search_#{vertical}_#{country}/admin/luke?wt=json")
      .get() (err, res, body) ->
        try
          results = JSON.parse(body)
          msg.send "We have #{results.index.numDocs} ads in #{country} #{vertical}"
        catch error
          msg.send "I couldn't find anything for #{country} #{vertical}"
  catch error
    msg.send "I couldn't find anything for #{country} #{vertical}"

module.exports = (robot) ->
  robot.respond /what(')?s in (.*) (.*)/i, (msg) ->
    getNumDocs(msg)
