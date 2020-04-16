require 'discordrb'
require 'json'

bot = Discordrb::Bot.new token: 'token lol'

@playerjson = File.read('Players.json')


players = :readplayers
puts players

bot.message(with_text: 'ping') do |event|
  event.respond 'Pong!'
end

bot.message(with_text: '!go mining') do |event|
  i = rand(1..15)
  event.respond 'you found ' + i.to_s + ' diamonds!'
  event.user.id

end

bot.message(with_text: '!mineregister') do |event|
  temphash = { event.user.id => 0 }
  # puts(temphash.to_json)
  #
  if @playerjson.include?(event.user.id.to_s) == false
     File.open('players.json', 'w') {|f|
       f.write(temphash.to_json)
       event.respond 'sucssesfully registered JSON'
     }

  else event.respond 'you\'re already registered!'
 end
end

bot.run
