# frozen_string_literal: true

require_relative 'colors'

# Contains methods that display text
module Display
  def welcome
    <<~INSTRUCTIONS
      #{'Welcome to Hangman'.bold.cyan}

      Hangman is a guessing game typically played by two or more players.

      #{'Rules:'.bold}

      The computer randomly selects a word from a predetermined list of words.

      The computer displays the number of letters in the word using underscores or dashes.

      The player (the "guesser") attempts to guess the word by suggesting letters that might appear in it.

      If the guesser suggests a letter that appears in the word, the computer reveals all instances of that letter in the appropriate positions in the word.

      If the guesser suggests a letter that does not appear in the word, the computer draws one part of a "hangman" figure (usually starting with the head).

      The guesser continues to suggest letters until they either successfully guess the word -WINNER- or he run out of guesses -LOSER-.
    INSTRUCTIONS
  end

  def prompts(type)
    case type
    when 1
      print "Enter one letter - 'a' to 'z' - or type 'save' to save the game: ".yellow
    when 2
      print "Please enter one letter a time, and only letters - a to z - or type 'save' to save this game: ".red
    when 4
      print 'Choose a name for your saved game: '.yellow
    when 5
      print <<~PROMPT
        Would you like to:#{' '}
        [1] Start a new game.
        [2] Load an existing game.

        #{"Please Enter '1' or '2' to choose: ".yellow}
      PROMPT
    when 6
      print "Invalid choice, please enter '1' or '2': ".red
    when 7
      print 'Enter the name of a saved game from the above (without .yaml): '.yellow
    when 8
      print 'This saved game does not exist, please try again: '.red
    when 9
      "You've already guessed this letter".red
    end
  end
end
