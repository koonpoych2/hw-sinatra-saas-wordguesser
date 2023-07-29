class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)

    # Raise error when string empty or nil or not alphabet
    if letter.nil? 
      raise ArgumentError, 'Argument should not empty '
    elsif letter.empty?
      raise ArgumentError, 'Argument should not a nil value'
    elsif !letter.match?(/[[:alpha:]]/)
      raise ArgumentError, 'Argument should be an alphabet'
    end

    letter = letter.downcase # Convert the letter to lowercase for case insensitivity

    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      # If the letter has already been guessed (correctly or incorrectly), return false
      return false
    elsif @word.include?(letter)
      # If the letter is in the word and has not been guessed yet, add it to the correct guesses list
      @guesses += letter
      return true
    else
      # If the letter is not in the word and has not been guessed yet, add it to the wrong guesses list
      @wrong_guesses += letter
      return true
    end

 

  end 
  
  def word_with_guesses()
    result = ''
    # Show correct guesses letter
    @word.each_char { |letter| 
      if @guesses.include?(letter)
        result += letter
      else
        result += '-'
      end
      }
      return result
  end

  def check_win_or_lose()
    # Win when all letters guessed
      if @guesses.chars.sort == @word.chars.sort
        return :win
    # Lose after worng 7 guesses
      elsif @wrong_guesses.length == 7 
        return :lose
    # Continue play if neither win or lose
      else
        return :play
      end

  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
