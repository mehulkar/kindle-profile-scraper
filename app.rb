require 'sinatra'
require 'sinatra/cross_origin'
require 'open-uri'
require 'nokogiri'

get '/' do
  cross_origin
  page = open("https://kindle.amazon.com/profile/Mehul-Kar/4275127/reading")
  nokogiri = Nokogiri::HTML(page)
  book = nokogiri.css('#profilePage ul .profileBookEntry .title')[0].text
  book
end