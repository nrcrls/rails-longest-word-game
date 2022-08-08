require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    grid_letters = @grid.each { |letter| puts letter, '' }
    if !letter_in_grid
      @result = "Sorry, but #{@answer.downcase} can’t be built out of #{grid_letters}."
    elsif letter_in_grid && !english_word
      @result = "Sorry but #{@answer.downcase} does not seem to be an English word."
    else
      @result = "Congratulations! #{@answer.downcase} is a valid English word."
    end
    raise
  end
end
