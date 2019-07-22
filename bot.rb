require 'telegram/bot'

token = ENV['TOKEN'] # env var returning nil instead of str

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        command = message.text
        puts "@#{message.from.first_name}: #{command}"
        person_id = message.chat.id
        case command
        when '/help'
            reply = 
            "
            /start to start the bot\n/tiles to see all tiles, or to find tiles by suits\n/rules for rules in Mahjong, including ways to win
            "
            bot.api.send_message(chat_id: person_id, text: reply)
        when '/start', '/greet'
            reply = "Hello, #{message.from.first_name}."
            bot.api.send_message(chat_id: person_id, text: reply)
        when 'i hate mahjong'
            reply = "Get out >:("
            bot.api.send_message(chat_id: person_id, text: reply)
        when '/tiles'
            reply = "Here is a list of all the tiles in Mahjong! Choose what *suit(e)s* your interest!"
            # bot.api.send_photo(chat_id: message.chat.id, photo: 
            # Faraday::UploadIO.new('/Users/mandy/Repos/MahjongMaster/photos/tiles.jpg', 'image/jpeg'))
            options = Telegram::Bot::Types::ReplyKeyboardMarkup
            .new(keyboard: [%w(Tong(dots) Tiao/Suo(bamboos)), %w(Wan(characters) DaPai(honours))], one_time_keyboard: true)
            bot.api.send_message(chat_id: person_id, text: reply, reply_markup: options)
        when 'Tong', 'Dots'
            reply = "Here is a list of dotted tiles 筒子 in ascending order!"
            #bot.api.send_photo(chat_id: message.chat.id, photo: 
             #   Faraday::UploadIO.new('/Users/mandy/Repos/MahjongMaster/photos/dots.jpg', 'image/jpeg'))
            bot.api.send_message(chat_id: person_id, text: reply)
        when 'Tiao/Suo', 'Tiao', 'Suo', 'Bamboos'
            reply = "Here is a list of bamboo tiles 条子/ 索子 in ascending order!"
            #bot.api.send_photo(chat_id: message.chat.id, photo: 
             #   Faraday::UploadIO.new('/Users/mandy/Repos/MahjongMaster/photos/bamboos.jpg', 'image/jpeg'))
            bot.api.send_message(chat_id: person_id, text: reply)
        when 'Wan', 'Characters'
            reply = "Here is a list of character tiles 萬子 in ascending order!"
            #bot.api.send_photo(chat_id: message.chat.id, photo: 
             #   Faraday::UploadIO.new('/Users/mandy/Repos/MahjongMaster/photos/characters.jpg', 'image/jpeg'))
            bot.api.send_message(chat_id: person_id, text: reply)
        when 'DaPai', 'Honours'
            reply = "Here is a list of honour tiles 大牌 in no particular order!"
            #bot.api.send_photo(chat_id: message.chat.id, photo: 
             #   Faraday::UploadIO.new('/Users/mandy/Repos/MahjongMaster/photos/honours.jpg', 'image/jpeg'))
            bot.api.send_message(chat_id: person_id, text: reply)
        when '/play'
            reply = "Sorry I don't know how to play yet :/"
            bot.api.send_message(chat_id: person_id, text: reply)
        when '/rules'
            reply = 
            "
            In Mahjong, there are many ways to win. Some of the basic ones are:
            1) Ping Hu
            2) Peng Peng Hu
            3) Qing Yi Se
            4) Hun Yi Se \nWhich one do you want to know about?
            "
            options = Telegram::Bot::Types::ReplyKeyboardMarkup
            .new(keyboard: [%w(1 2), %w(3 4)], one_time_keyboard: true)
            bot.api.send_message(chat_id: person_id, text: reply, reply_markup: options)
        else
            reply = "I have no idea what #{command} means :("
            bot.api.send_message(chat_id: person_id, text: reply)
        end
        puts "sending '#{reply}' to @#{message.from.first_name}"
    end
end
