class LinebotController < ApplicationController
     require "line/bot"  # gem "line-bot-api"
 
     # callbackアクションのCSRFトークン認証を無効
     protect_from_forgery :except => [:callback]
 
     def client
       @client ||= Line::Bot::Client.new { |config|
         config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
         config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
       }
     end
     
     def callback
         @post=Quote.offset( rand(Quote.count) ).first
       body = request.body.read
   
       signature = request.env["HTTP_X_LINE_SIGNATURE"]
       unless client.validate_signature(body, signature)
         error 400 do "Bad Request" end
       end
   
       events = client.parse_events_from(body)
   
       events.each { |event|
         case event
         when Line::Bot::Event::Message
           case event.type
           when Line::Bot::Event::MessageType::Text
               if event.message['text']=="名言ちょうだい"
             message = [
              { 
                  type: "text",
                  text: @post.quote
              },
              {
                 type:"image",
                 originalContentUrl:@post.image_url,
                 previewImageUrl:@post.image_url
              }
             ]
             client.reply_message(event["replyToken"], message)
               end
               else if event.message['text']=="調子乗りまくり卍！！！！"
                message = 
              { 
                  type: "text",
                  text: "自分を見つめ直して、勤勉になりなさい。"
              }   
           else if event.message['text']=="もうやだ、なんもしたくない…"
                message = 
              { 
                  type: "text",
                  text: "少しでもいいから一歩ずつ前に進んでみたら？"
              }   
          else
              { 
                  type: "text",
                  text: "今日も一日お疲れ様(*´з`)"
              }   
           when Line::Bot::Event::MessageType::Location
             message = {
               type: "location",
               title: "あなたはここにいますか？",
               address: event.message["address"],
               latitude: event.message["latitude"],
               longitude: event.message["longitude"]
             }
             client.reply_message(event["replyToken"], message)
           end
         end
       }
   
       head :ok
     end
 end