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

def register(name)
  @players[name] = 0
  saveplayerjson(@players)
end

def registercheck(name)
  if @players.include?(name)
    if @inv.include?(name)
      return true
    end
  end
  return false
end




bot.message(with_text: '!store') do |event|
  event.respond 'amulet of richness:1000, amulet of jeff bezos:1000000, doggy
doodoo:10, blyat ender:100, airpods:200, yacht:500, 1kg cocaine:700, uno reverse card:20'
end

bot.message(with_text: '!help') do |event|
  event.respond '!register: do this one first, !store: lists\'s available items, !buy: buy an item from the store,
!go mining: mine for diamonds, !query: check your acount, !inv:check your inven
tory, !gamble: gamble your savings away'
end

bot.message(with_text: '!buy amulet of richness') do |event|
  if registercheck(event.user.id.to_s)
    if buy(event.user.id.to_s, 'amulet of richness', 1000)
      event.respond 'bought'
    else
      event.respond 'you don\'t have enough money'
    end
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end

bot.message(with_text: '!buy amulet of jeff bezos') do |event|
  if registercheck(event.user.id.to_s)
    if buy(event.user.id.to_s, 'amulet of jeff bezos', 1000000)
      event.respond 'bought'
    else
      event.respond 'you don\'t have enough money'
    end
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end

bot.message(with_text: '!buy doggy doodoo') do |event|
  if registercheck(event.user.id.to_s)
    if buy(event.user.id.to_s, 'doggy dooodoo', 10)
      event.respond 'bought'
    else
      event.respond 'you don\'t have enough money'
    end
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end

bot.message(with_text: '!buy blyat ender') do |event|
  if registercheck(event.user.id.to_s)
    if buy(event.user.id.to_s, 'blyat ender', 100)
      event.respond 'bought'
    else
      event.respond 'you don\'t have enough money'
    end
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end

bot.message(with_text: '!buy airpods') do |event|
  if registercheck(event.user.id.to_s)
    if buy(event.user.id.to_s, 'airpods', 200)
      event.respond 'bought'
    else
      event.respond 'you don\'t have enough money'
    end
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end

bot.message(with_text: '!buy yacht') do |event|
  if registercheck(event.user.id.to_s)
    if buy(event.user.id.to_s, 'yacht', 500)
      event.respond 'bought'
    else
      event.respond 'you don\'t have enough money'
    end
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end

bot.message(with_text: '!buy 1kg cocaine') do |event|
  if registercheck(event.user.id.to_s)
    if buy(event.user.id.to_s, '1kg cocaine', 700)
      event.respond 'bought'
    else
      event.respond 'you don\'t have enough money'
    end
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end

bot.message(with_text: '!buy uno reverse card') do |event|
  if registercheck(event.user.id.to_s)
    if buy(event.user.id.to_s, 'uno reverse card', 20)
      event.respond 'bought'
    else
      event.respond 'you don\'t have enough money'
    end
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end

bot.message(with_text: '!go mining') do |event|
  if registercheck(event.user.id.to_s)
    i = rand(1..15)
    x = rand(1..5)
    if x > 3
      event.respond 'your pickaxe broke! oh well...'
    else
      if @players[event.user.id.to_s] += i
        saveplayerjson(@players)
        event.respond 'you found ' + i.to_s + ' diamonds!'
      end
    end
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end


bot.message(with_text: '!gamble') do |event|
  if registercheck(event.user.id.to_s)
    i = rand(-7..5)
    @players[event.user.id.to_s] += i
    if i.zero?
      event.respond('you broke even')

    elsif i > 0 then event.respond('you won ' + i.to_s + ' Diamonds')

    elsif i < 0 then event.respond('you lost ' + (i * -1).to_s + ' Diamonds')

    end
  saveplayerjson(@players)
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end

bot.message(with_text: '!query') do |event|
  if registercheck(event.user.id.to_s)
    i = @players[event.user.id.to_s]
    event.respond ('you have ' + i.to_s + ' Diamonds')
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
  end
end

bot.message(with_text: '!inv') do |event|
  if registercheck(event.user.id.to_s)
  i = @inv[event.user.id.to_s]

  event.respond ('you have: ' + i.join(", "))
  else
    register(event.user.id.to_s)
    invregister(event.user.id.to_s)
    event.respond 'registered new user'
    end
end

bot.message(with_text: '!register') do |event|
  @players = playerjson
  if !registercheck(event.user.id.to_s)
    register(event.user.id.to_s)
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

  event.respond 'you tested ' + i + ' for covid!'
  end
end

bot.message(with_text: 'creeper') do |event|
  event.respond 'Awww man'
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


bot.message(with_text: 'ping') do |event|
  event.respond 'Pong!'
end


bot.run
