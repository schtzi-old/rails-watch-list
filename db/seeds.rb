# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'open-uri'
require 'json'

puts 'Cleaning database...'

List.destroy_all
Bookmark.destroy_all
Movie.destroy_all

puts 'Creates movies...'
response = URI.open('https://tmdb.lewagon.com/movie/top_rated').read
result = JSON.parse(response)

result['results'].each do |movie|
  Movie.create(title: movie['original_title'], overview: movie['overview'], rating: rand(10), poster_url: "https://image.tmdb.org/t/p/original/#{movie['poster_path']}")
end

puts 'Done!'
