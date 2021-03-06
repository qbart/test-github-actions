# frozen_string_literal: true

require 'rack/test'
require 'rspec'

require File.expand_path '../main.rb', __dir__

ENV['RACK_ENV'] ||= 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
end

RSpec.configure { |c| c.include RSpecMixin }
