require 'discordrb'

bot = Discordrb::Bot.new token: 'NTgyOTczMDE2NTE4OTUwOTU5.XphgXw.6Dv0zHASyijc9JyPwXfTfaTMFSo'

@spasst = "bot "



bot.message(with_text: @spasst + 'fick dich') do |event|
  event.respond 'fig dig my friend!'
end


bot.message(with_text: @spasst + 'ping') do |event|
  event.respond 'Pong!'
end



bot.run