require 'sinatra'
require 'sinatra/cross_origin'
require 'open-uri'
require 'nokogiri'
require 'json'

KINDLE_URL = "https://kindle.amazon.com/profile/Mehul-Kar/4275127/reading"

get '/' do
  cross_origin
  nokogiri      = Nokogiri::HTML(open(KINDLE_URL))
  book_elements = nokogiri.css('#profilePage ul .profileBookEntry')

  books = book_elements.map do |el|
    author  = el.css('.author').text
    title   = el.css('.title').text
    { author: author, title: title }
  end
  return {books: books}.to_json
end