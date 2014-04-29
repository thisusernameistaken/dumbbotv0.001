# Description:
#   SOME THINGS(I WAS BORED)
#
# Commands:
#   !slap <person> - Slaps a person however you want
#   !eat <food> - Eats what ever you want
#   !give <person> - Gives a person what ever you want
#   !throws <thing> - Throws Something
#	!joke - Finds a Chuck Norris Joke for you
#	!quote - Gives a quote
#   !google <query> - Googles query, shows first link
#	!youtube <query> - youtube search, shows first link to video
#	!img <query> - Shows link to first google image
#   !ntrivia - Askes a number based trivia question, answer with !ntriviaAnswer
#   !nAnswer=<question> - Answers Number Based Trivia question
# 	!Weather <Location> - Will print the Days Highs and lows for the given location
#	!md5><string> - returns the hexdigest of the md5 hash

crypto = require('crypto');

module.exports = (robot) ->
#TODO: CHECK IF INPUT = NULL
  robot.respond /slap(.*)/i, (msg) ->
    msg.emote "slaps"+msg.match[1]
    
  robot.respond /eat(.*)/i, (msg) ->
    msg.emote "eats"+msg.match[1]
    
  robot.respond /give(.*)/i, (msg) ->
    msg.emote "gives"+msg.match[1]
    
  robot.respond /throw(.*)/i, (msg) ->
    msg.emote "throws"+msg.match[1]

  robot.respond /quote/i, (msg) ->
  	robot.http("http://www.iheartquotes.com/api/v1/random")
  		.get() (err,res,body) ->
  			msg.send body
  			
  robot.respond /taco/i, (msg) ->
  	msg.emote "blub"
  
  robot.respond /joke/i, (msg) ->
     robot.http("http://api.icndb.com/jokes/random?limitTo=[nerdy]")
     	.header('Accept', 'application/json')
     	.get() (err,res,body) ->
     		data = JSON.parse(body)
     		msg.send data.value.joke
  
  robot.respond /google(.*)/i, (msg) ->
  	robot.http("http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q="+msg.match[1]+"&rsz=8")
  		.header('Accept', 'application/json')
        .get() (err,res,body) ->
        	data = JSON.parse(body);
        	msg.send data.responseData.results[0].url
     		
  robot.respond /img(.*)/i, (msg) ->
     robot.http("http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q="+msg.match[1]+"&rsz=8")
     	.header('Accept', 'application/json')
        .get() (err,res,body) ->
        	data = JSON.parse(body);
        	msg.send data.responseData.results[0].url
 
  robot.respond /youtube(.*)/i, (msg) ->
     robot.http("http://ajax.googleapis.com/ajax/services/search/video?v=1.0&q="+msg.match[1]+"&rsz=8")
     	.header('Accept', 'application/json')
        .get() (err,res,body) ->
        	data = JSON.parse(body);
        	msg.send data.responseData.results[0].url
        	
        	
  robot.respond /ntrivia/i, (msg) ->
   	 robot.http("http://numbersapi.com/random/trivia")
   		.get() (err,res, body) ->
   	  		body = body.split(" ")
   	  		answer = body[0]
   	  		robot.brain.set 'number_answer', answer
   	  		question = "BLANK "+body[1..].join(" ")
   	  		msg.send question
   	  	
   robot.respond /nAnswer=(.*)/i, (msg) ->
   	 ans =  msg.match[1]
   	 robot.brain.set 'your_nanswer', ans
   	 if robot.brain.get('number_answer') is robot.brain.get('your_nanswer') then msg.send "Correct!" else msg.send "wrong :( The right answer was " + robot.brain.get('number_answer')
   	  		
   robot.respond /weather(.*)/i, (msg) ->
  	 robot.http("https://george-vustrey-weather.p.mashape.com/api.php?location="+ msg.match[1])
  	    .header("X-Mashape-Authorization", "PfCarFJvraMv6Kpuw4OiUpxOtGOyxUHE")
  		.get() (err,res,body) ->
  			data = JSON.parse(body)
  			msg.send "Weather in#{msg.match[1]} for #{data[0].day_of_week}day is High of #{data[0].high} and Low of #{data[0].low}"

   robot.respond /md5>(.*)/i, (msg) ->
   		msg.send md5hash1 = crypto.createHash('md5').update(msg.match[1]).digest("hex")
   	  		
   	  		
   	  		