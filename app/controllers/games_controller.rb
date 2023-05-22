class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10).join(' ')
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @result = @word.chars.all? do |letter|
      @letters.count(letter) >= @word.chars.count(letter)
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionnary = URI.open(url).read
    dictionnary_hash = JSON.parse(dictionnary)

    if @result == true
      if dictionnary_hash["found"] == true
        @answer = "You win!"
      else
        @answer = "Sorry but #{@word} is not an english word"
      end
    else
      @answer = "Sorry but #{@word} can't be built out of #{@letters}"
    end
  end
end
