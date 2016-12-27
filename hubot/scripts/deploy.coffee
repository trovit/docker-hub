# Description:
#   Deploy from Jenkins CI
#
# TODO smart defaults: --user hadoop --conf /etc/deployment/configuration.properties --do-tests --do-deploy --skip-checks --real
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot deploy <module> <branch> <preprod|prod> - Branch name in origin (without origin prefix)

querystring = require 'querystring'

JOB = 'deployment'
JENKINS_URL = 'http://ci.services'
# Auth should be in the "user:password" format.
AUTH = 'sasha:sasha'

jenkinsBuild = (msg) ->
    module = msg.match[1]
    branch = msg.match[2]
    env = msg.match[3]
    extra = msg.match[4] ? "none"

    # defaults different than in jenkins
    checks = if extra.match /do checks/i then '--do-checks' else '--skip-checks'
    # USER?

    query =
      PROJECT: module
      BRANCH: branch
      ENVIRON: env
      SKIPCHECKS: checks

    # optional params, default is the opposite showed here
    tests = optionalParam if extra.match /skip tests/i then SKIPTESTS: '--skip-tests'
    simulate = optionalParam if extra.match /simulate/i then SIMULATE: '--simulate'
    deploy = optionalParam if extra.match /skip deploy/i then DEPLOY: '--skip-deploy'

    params = "#{querystring.stringify query}#{tests}#{simulate}#{deploy}"

    msg.reply "Configuring deployment build with params #{JSON.stringify querystring.parse params}"

    path = "#{JENKINS_URL}/job/#{JOB}/buildWithParameters?#{params}"

    req = msg.http(path)

    auth = new Buffer(AUTH).toString('base64')
    req.headers Authorization: "Basic #{auth}"

    req.headers 'Content-type': 'application/json'
    req.header('Content-Length', 0)
    req.post() (err, res, body) ->
        if err
          msg.reply "Jenkins says: #{err}"
        else if 200 <= res.statusCode < 400 # Or, not an error code.
          msg.reply "(#{res.statusCode}) Build started for #{JOB} #{JENKINS_URL}/job/#{JOB}"
        else
          msg.reply "Jenkins says: Status #{res.statusCode} #{body}"

optionalParam = (obj) ->
  if obj? then "&#{querystring.stringify obj}" else ''

module.exports = (robot) ->
  robot.respond /d(?:eploy)? ([\w\.\-_ ]+) ([\w\.\-_ ]+) (prod|preprod)(.*)?/i, (msg) ->
    jenkinsBuild(msg, false)
