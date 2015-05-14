#!/usr/bin/env ruby

require 'dotenv'
Dotenv.load

require 'json'

require 'sinatra/base'
require 'pusher'

require 'redis'
require 'redis-objects'

require 'connection_pool'
redis_url = ENV['REDIS_URL']
Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) { Redis.new(url: redis_url) }

require './lib/match'
require './lib/player'

Pusher.url = "http://#{ENV['PUSHER_KEY']}:#{ENV['PUSHER_SECRET']}@api.pusherapp.com/apps/#{ENV['PUSHER_APP']}"

class Scoreboard < Sinatra::Base

  get '/' do
    erb :index, locals: { scores: match.scores }
  end

  post '/new_game' do
    @match = Match.new(params[:one], params[:two])
    @match.reset_scores
    @match.reset_games
    push_scores
    JSON match.scores
  end

  put '/reset_scores' do
    match.reset_scores
    match.reset_games
    push_scores
  end

  put '/red_scores' do
    match.add_point(:red)
    push_scores
  end

  put '/blue_scores' do
    match.add_point(:blue)
    push_scores
  end

  put '/red_undo' do
    match.undo_point(:red)
    push_scores
  end

  put '/blue_undo' do
    match.undo_point(:blue)
    push_scores
  end

  get '/scores' do
    JSON match.scores
  end

  def push_scores
    Pusher['scores'].trigger('update_scores', match.scores.to_json)
  end

  private

  def match
    @match ||= Match.new
  end

end
