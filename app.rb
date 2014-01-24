require 'sinatra'
require 'sinatra/cross_origin'
require 'open-uri'
require 'nokogiri'
require 'json'

get '/' do
  cross_origin
  page = open("https://kindle.amazon.com/profile/Mehul-Kar/4275127/reading")
  nokogiri = Nokogiri::HTML(page)
  bookElements = nokogiri.css('#profilePage ul .profileBookEntry')

  books = bookElements.map do |el|
    author  = el.css('.author').text
    title   = el.css('.title').text
    { author: author, title: title }
  end
  return {books: books}.to_json
end