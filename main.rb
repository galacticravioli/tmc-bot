require 'discordrb'
require 'json'

bot = Discordrb::Bot.new token: 'token'

def playerjson
  json = File.read('Players.json')
  return JSON.parse(json)
end

def saveplayerjson(playerhash)
  File.open('players.json', 'w') do |f|
    f.write(playerhash.to_json)
  end
end

@players = playerjson

bot.message(with_text: 'ping') do |event|
  event.respond 'Pong!'
end

bot.message(with_text: '!go mining') do |event|
  i = rand(1..15)
  @players[event.user.id.to_s] += i
  saveplayerjson(@players)
  event.respond 'you found ' + i.to_s + ' diamonds!'
end

bot.message(with_text: '!query') do |event|
  i = @players[event.user.id.to_s]
 # puts @players
 # puts event.user.id
 # puts i.to_s
  event.respond ('you have ' + i.to_s + " Diamonds")
end

bot.message(with_text: '!register') do |event|
  @players = playerjson
  if !@players.include?(event.user.id.to_s)
    @players[event.user.id.to_s] = 0
    saveplayerjson(@players)
    event.respond 'player registered'

  else
    event.respond 'you\'re already registered!'
  end
end

bot.message(with_text: '!reload') do |event|
  if event.user.id.to_s == "273551864027676675"
    @players = playerjson
    event.respond 'Reloaded!'

  else event.respond 'your not Ted'
  end
end


bot.run
