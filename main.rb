# frozen_string_literal: true

require 'sinatra'

get '/' do
  "#{ENV['RACK_ENV']}: Hello there! My secret is #{ENV['MY_SECRET']}"
end
