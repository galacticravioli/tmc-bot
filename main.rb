require 'discordrb'
require 'json'

bot = Discordrb::Bot.new token: 'token'

def playerjson
  json = File.read('Players.json')
  JSON.parse(json)
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
  break = rand(1..5)
  if break > 3
    event.respond 'your pickaxe broke! oh well...'
  else
    @players[event.user.id.to_s] += i
    saveplayerjson(@players)
    event.respond 'you found ' + i.to_s + ' diamonds!'
  end  
end

bot.message(with_text: '!gamble') do |event|
  i = rand(-7..5)
  x = ''
  @players[event.user.id.to_s] += i
  if i == 0
    event.respond 'you broke even'

    elsif i > 0 then event.respond 'you won ' + i.to_s + ' Diamonds'

  elsif i < 0 then event.respond 'you lost ' + (i*-1).to_s + ' Diamonds'

  end
  saveplayerjson(@players)
end

bot.message(with_text: '!query') do |event|
  i = @players[event.user.id.to_s]
  # puts @players
  # puts event.user.id
  # puts i.to_s
  event.respond ('you have ' + i.to_s + ' Diamonds')
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
  if event.user.id.to_s == '273551864027676675'
    @players = playerjson
    event.respond 'Reloaded!'

  else event.respond 'your not Ted'
  end
end

bot.message(with_text: 'name jeff') do |event|
  event.respond 'no my name jeff'
end

bot.message(with_text: 'shut the fuck up') do |event|
  event.respond 'no'
end

bot.run
