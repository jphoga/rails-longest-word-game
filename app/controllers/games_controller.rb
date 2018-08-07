require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    @test_word = params[:word].upcase
    @sample_arr = params[:letters]
    test_arr = @test_word.split("")
    test_arr.each do |char|
      if !@sample_arr.include? char
        @result = "The word '#{@test_word}' can't be built out of the original grid"
      elsif test_in_api(test_arr.join(""))
        @result = "Alles super, schoenes englisches Wort."
      else
        @result = "Passt, aber kein englisches Wort. Nochmal bitte."
      end
    end
  end

  def test_in_api(word)
    api_url = "https://wagon-dictionary.herokuapp.com/#{word}"
    found = false
    open(api_url) do |stream|
      quote = JSON.parse(stream.read)
      found = quote['found']
    end
    return found
  end

end

