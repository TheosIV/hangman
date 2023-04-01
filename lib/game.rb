require_relative 'colors'
require_relative 'display'
require_relative 'filesmanipulation'

## Game class is the base of hangman logic
class Game
  include Display
  include FilesManipulation
  attr_reader :word, :clues, :wrong_guesses, :used_letters, :player, :input
  def initialize
    @word = random_word_from_dictionary
    @clues = ''
    word.length.times {clues << '_'}
    @wrong_guesses = 0
    @used_letters = ''
    @input = nil
    new_game?
  end

  def player_input
    begin
      prompts(1)
      input = gets.chomp.downcase
      until input.between?('a', 'z')  && input.length == 1 || input == 'save'
        prompts(2)
        input = gets.chomp.downcase
      end
      raise prompts(9) if used_letters.include?(input.red) || used_letters.include?(input.green)
      input
    rescue  StandardError => e
      puts e
      retry
    end
  end

  def valid_letter
      valid = false
      @used_letters += "#{input.red} " 
      word.each_char.with_index do |letter, index|
        next unless letter == input

        valid = true
        @clues[index] = letter
        @used_letters = @used_letters.chomp("#{input.red} ")
        @used_letters += "#{input.green} " unless @used_letters.include?("#{input.green} ")
      end

      valid
  end

  def new_game?
    puts welcome + "\n"
    prompts(5)
    answer = gets.chomp
    until answer.between?('1', '2')
      prompts(6)
      answer = gets.chomp
    end

    answer == '1' ? play : load_game
  end

  def turns
    until wrong_guesses == 12
      puts "\nYou have #{12 - wrong_guesses} wrong guesses remaining."
      puts "used letters: #{used_letters}"
      @input = player_input
      if input == 'save'
        save_game
        break
      else
        valid = valid_letter
        @wrong_guesses += 1 unless valid
        puts clues
      end
      break if clues == word
    end
  end
  
  def winner?
    if input == 'save'
      puts "\nThe game has been saved!"
    elsif wrong_guesses == 12
      puts "\nYou Lose!"
    else
      puts "\nYou Win!"
    end
  end

  def play
    puts "\n\nThis the secret word placeholder: #{clues}.".blue
    turns
    puts "\nThe secret word is: #{word.blue}".yellow if input != 'save'
    winner?
  end
end