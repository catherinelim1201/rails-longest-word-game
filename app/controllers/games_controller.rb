require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  # def score
  #   # create params, store it in variable
  #   # raise
  #   # @letters are not in string form. need to convert to array of strings
  #   @letters = params[:letters] # "P O M G H" --> "["P",]"
  #   grid = @letters.chars

  #   @guessed_word = params[:answer]
  #   uppercase_letters = @guessed_word.upcase.chars
  #   # user_guessed_word = @guessed_word.chars
  #   # raise
  #   # get the url
  #   url = "https://wagon-dictionary.herokuapp.com/#{@guessed_word}"
  #   user_serialized = URI.open(url).read
  #   response = JSON.parse(user_serialized)

  #   # check if the word exist, if yes -> uppercase all letters
  #   @word = response["word"].upcase         # uppercase the word
  #   @word_found = response["found"]      #false   # return true or false
  #   @is_english_word = true

  #   if @word_found == false
  #     # @is_english_word = false
  #     @message = "Sorry. #{@word} does not seem to be a valid English word..."

  #   elsif @word_found == true
  #     uppercase_letters.each do |letter|
  #       # letter.chars
  #       if grid.include?(letter)
  #         index = grid.index(letter)
  #         grid.delete_at(index)
  #         @is_english_word = true
  #       else
  #         raise
  #         @is_english_word = false
  #       end
  #     end
  #   end

  #   # raise

  #   if @is_english_word
  #     @message = " #{@word} This a valid English word..."

  #   elsif @is_english_word = false
  #     @message = "#{@word} This a not part of the grid"
  #   end

  #   # if @word_found
  #   #   @message = "#{@word} This a not part of the grid"
  #   # end
  # end

  def score
    @letters = params[:letters].chars # Convert letters string to an array of strings
    @guessed_word = params[:answer].upcase
    # Create a hidden field in your form to send the letters through the POST request

    url = "https://wagon-dictionary.herokuapp.com/#{@guessed_word}"
    response_serialized = URI.open(url).read
    response = JSON.parse(response_serialized)

    @upcase_response = response['word'].upcase
    @response_found = response['found']       #false
    @is_english_word = true

    if @response_found == false
      @message = "Sorry. #{@upcase_response} does not seem to be a valid English word..."
    elsif @response_found == true
      @guessed_word.chars.each do |letter|
        if @letters.include?(letter)
          index = @letters.index(letter)
          @letters.delete_at(index)
          @is_english_word = true
        else
          @is_english_word = false
        end
      end

      if @is_english_word == true
        @message = "#{@upcase_response} seem to be a valid English word..."

      elsif @is_english_word == false
        @message = "#{@upcase_response} is not from the grid..."
        # raise
      end
    end
  end
end
