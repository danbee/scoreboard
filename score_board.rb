#!/usr/bin/env ruby

require 'dotenv'
Dotenv.load

require 'json'

require 'sinatra'
require 'pusher'

require './lib/match'
require './lib/player'

Pusher.url = "http://#{ENV['PUSHER_KEY']}:#{ENV['PUSHER_SECRET']}@api.pusherapp.com/apps/#{ENV['PUSHER_APP']}"

class ScoreBoard < Sinatra::Base

  @@match = Match.new(Player.new, Player.new)

  get '/' do
    erb :index, locals: { one: @@match.players[:one],
                          two: @@match.players[:two] }
  end

  put '/reset_scores' do
    @@match = Match.new(Player.new, Player.new)
    push_scores
  end

  put '/player1_scores' do
    @@match.add_point(:one)
    push_scores
  end

  put '/player2_scores' do
    @@match.add_point(:two)
    push_scores
  end

  get '/scores' do
    JSON @@match.scores
  end

  def push_scores
    Pusher['scores'].trigger('update_scores', @@match.scores.to_json)
  end

end
