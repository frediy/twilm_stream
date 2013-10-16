# require 'twilm_stream/version'
require 'rubygems'
require 'time'
require 'tweetstream'
require 'mongo'

TweetStream.configure do |config|
	config.consumer_key = 'abcdefghij'
	config.consumer_secret = '0123456789'
	config.oauth_token = 'abcdefghij'
	config.oauth_token_secret = '0123456789'
	config.auth_method = :oauth
end

TweetStream::Client.new.on_error do |message|
  p message
end.track("movie") do |status|
  p status.text
end