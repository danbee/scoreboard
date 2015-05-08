#!/usr/bin/env ruby

require 'dotenv'
Dotenv.load

require 'sinatra'
require 'pusher'

Pusher.url = "http://#{ENV['PUSHER_KEY']}:#{ENV['PUSHER_SECRET']}@api.pusherapp.com/apps/#{ENV['PUSHER_APP']}"

put '/player1_scores' do
  Pusher['scores'].trigger('player1_scores', {
    message: 'Player 1 scores'
  })
end

put '/player2_scores' do
  Pusher['scores'].trigger('player2_scores', {
    message: 'Player 2 scores'
  })
end
