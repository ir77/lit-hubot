# Description
#   tiqav for hubot
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot tiqav <user>? <query>
#   ちくわ@<user> <query>
#
# Author:
#   hiroqn
module.exports = (robot) ->
  robot.hear /^ちくわ(@\S+) (.*)$/i, (msg) ->
    tiqavApi msg, msg.match[2], (url) ->
      msg.send "#{msg.match[1]} #{url}"
    msg.send 
  robot.respond /tiqav (@\S+ )?(.*)/i, (msg) ->
    tiqavApi msg, msg.match[2], (url) ->
      msg.send msg.match[1]+url

tiqavApi = (msg, query, cb) ->
  q = q: query
  msg.http('http://api.tiqav.com/search.json')
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      if images?.length > 0
        image  = msg.random images
        cb image.source_url
