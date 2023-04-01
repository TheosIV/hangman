# frozen_string_literal: true

require_relative 'display'
require 'yaml'

# Contains methods to save or load a game
module FilesManipulation
  include Display
  def random_word_from_dictionary
    word = nil
    File.open('dictionary.txt') do |file|
      lines = file.readlines
      word = lines[rand(lines.size)].chomp
      word = lines[rand(lines.size)].chomp until word.length >= 5 && word.length <= 12
    end

    word
  end

  def save_game
    Dir.mkdir('saved') unless Dir.exist?('saved')
    filename = "saved/#{name_file}.yaml"

    dump = YAML.dump(
      word: @word,
      clues: @clues,
      wrong_guesses: @wrong_guesses,
      used_letters: @used_letters
    )

    File.open(filename, 'w') do |file|
      file.puts dump
    end
  end

  def name_file
    filenames = Dir.entries('saved') { |f| File.file?(f) }
    prompts(4)
    filename = gets.chomp
    raise "#{filename} already exists." if filenames.include?("#{filename}.yaml")

    filename
  rescue StandardError => e
    puts e
    retry
  end

  def load_game
    filenames = []
    Dir.entries('saved').each { |f| filenames << f unless f =~ /^..?$/ }
    puts filenames
    prompts(7)
    filename = "#{gets.chomp}.yaml"
    until filenames.include?(filename)
      prompts(8)
      filename = "#{gets.chomp}.yaml"
    end

    game = YAML.unsafe_load(File.read("saved/#{filename}"))
    @word = game[:word]
    @clues = game[:clues]
    @wrong_guesses = game[:wrong_guesses]
    @used_letters = game[:used_letters]

    play
  end
end
