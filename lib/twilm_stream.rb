# require 'twilm_stream/version'
require 'rubygems'
require 'time'
require 'tweetstream'
require 'mongo'

module TwilmStream
	class Twilm
		def initialize
			TweetStream.configure do |config|
				config.consumer_key = '1234'
				config.consumer_secret = 'abcd'
				config.oauth_token = '1234'
				config.oauth_token_secret = 'abcd'
				config.auth_method = :oauth
			end

			@mongo_client = Mongo::MongoClient.new('localhost', 27017)
			@netflix_mongo_db = @mongo_client['netflix']

			@movies_by_year = Hash.new{ |hash, key| hash[key] = [] }
			@netflix_mongo_db['movies'].find().each do |row|
				@movies_by_year[row['year']] << row['title'].split(' ')
			end

			p @movies_by_year

			@years_to_track = (1896..2005).to_a.join(", ")

			@experiment_begins_at_time = Time.now
			@experiment_ends_at_time = @experiment_begins_at_time + 10.seconds

			TweetStream::Client.new.on_error do |message|
				p message
			end.track(@years_to_track) do |tweet|
				puts "\n-------- MOVIE MATCH FOUND! --------\n" if tweet_contains_movie?(tweet)
				p tweet.text
			end
		end

		def tweet_contains_movie?(tweet)
			tweet_words = tweet.text.split(' ')
			tweet_words.each do |tweet_word|
				if @movies_by_year.has_key?(tweet_word)
					year = tweet_word
					@movies_by_year[year].each do |movie_title_words|
						current_movie_matches_tweet = true
						movie_title_words.each do |movie_title_word|
							if !tweet_word.include?(movie_title_word)
								current_movie_matches_tweet = false
								break
							end
						end
						return true if current_movie_matches_tweet
					end
				end
			end
			return false
		end
	end
end

TweetStream::Client.new.on_error do |message|
  p message
end.track("movie") do |status|
  p status.text
end
