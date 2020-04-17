
require 'discordrb'
require 'json'

bot = Discordrb::Bot.new token: 'token'

def playerjson
  json = File.read('players.json')
  JSON.parse(json)
end

def saveplayerjson(playerhash)
  File.open('players.json', 'w') do |f|
    f.write(playerhash.to_json)
  end
end

@players = playerjson

def invjson
  json = File.read('inventories.json')
  JSON.parse(json)
end

def saveinvjson(invhash)
  File.open('inventories.json', 'w') do |f|
    f.write(invhash.to_json)
  end
end

@inv = invjson

def buy(name, item, price)
  if @players[name] - price >= 0
    @players[name] -= price
    @inv[name] << item
    saveinvjson(@inv)
    saveplayerjson(@players)
    return(true)
  else
    return(false)
  end
end

def invregister(name)
  @inv[name] = []
  saveinvjson(@inv)
end

bot.message(with_text: '!store') do |event|
  event.respond 'amulet of richness:1000d'
end


bot.message(with_text: '!buy amulet of richness') do |event|
  if buy(event.user.id.to_s, 'amulet of richness', 1000)
    event.respond 'bought'
  else
    event.respond 'you don\'t have enough money'
  end
end

bot.message(with_text: 'ping') do |event|
  event.respond 'Pong!'
end

bot.message(with_text: '!go mining') do |event|
  i = rand(1..15)
  x = rand(1..5)
  if x > 3
    event.respond 'your pickaxe broke! oh well...'
  else
    @players[event.user.id.to_s] += i
    saveplayerjson(@players)
    event.respond 'you found ' + i.to_s + ' diamonds!'
  end
end

bot.message(with_text: '!gamble') do |event|
  i = rand(-7..5)
  @players[event.user.id.to_s] += i
  if i.zero
    event.respond 'you broke even'

  elsif i > 0 then event.respond 'you won ' + i.to_s + ' Diamonds'

  elsif i < 0 then event.respond 'you lost ' + (i * -1).to_s + ' Diamonds'

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

bot.message(with_text: '!inv') do |event|
  i = @inv[event.user.id.to_s]

  event.respond ('you have: ' + i.join(", "))
  end

bot.message(with_text: 'name jeff') do |event|
  event.respond 'no my name jeff'
end

bot.message(with_text: 'shut the fuck up') do |event|
  event.respond 'no'
end

bot.message(with_text: 'sex') do |event|
  event.respond 'kinky'
end

bot.message(with_text: 'anal suitcase') do |event|
  event.respond 'good job hiding the drugs'
end

bot.message(with_text: '!register') do |event|
  @players = playerjson
  if !@players.include?(event.user.id.to_s)
    @players[event.user.id.to_s] = 0
    saveplayerjson(@players)
    invregister(event.user.id.to_s)
    event.respond 'player registered'
  else
    event.respond 'you\'re already registered!'
  end
end

bot.message(with_text: '!reload') do |event|
  if event.user.id.to_s == '273551864027676675'
    @players = playerjson
    @inv = invjson
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

bot.message(with_text: 'sex') do |event|
  event.respond 'kinky'
end

bot.message(with_text: '!covid test') do |event|
  x = rand(1..2)
  i = if x > 1
        'positve'
      else
        'negative'
      end

  event.respond 'you tested ' + i + ' for covid!'
end

bot.message(with_text: 'creeper') do |event|
  event.respond 'Awww man'
end

bot.run
