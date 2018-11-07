module Hangman
  class Game
    attr_reader :chances, :word, :wrong_tries, :guess

    def initialize
      @chances = 5
      @wrong_tries = 0
      @guess = ""
      @word = Dictionary.random
    end

    Signal.trap ("SIGINT") do
      Graphics.clear_screen
      puts "Giving up? So soon? SMH..."
      exit
    end

    def play
      Graphics.clear_screen
      puts 'Guess this word: ' + Graphics.obfuscate_word(word, '')

      while true
        print "[#{chances - wrong_tries} chances left]: "

        char = gets.chomp
        Graphics.clear_screen

        if char.nil? || char == ""
          puts 'Seriously? You gotta type a letter!'
          puts 'Try again: ' + Graphics.obfuscate_word(word, guess)
          next
        end

        if !(/[[:alpha:]]/.match char)
          puts 'Dude! You gotta type a letter!'
          puts 'Try again: ' + Graphics.obfuscate_word(word, guess)
          next
        end

        if word.include? char

          if guess.include? char
            puts "You already entered '#{char}'. Yes, it is still correct.. 🙄"
            puts 'Try again: ' + Graphics.obfuscate_word(word, guess)
          else
            guess << char
            placeholder = Graphics.obfuscate_word(word, guess)
            puts 'Whoop Whoop!! ' + placeholder
          end


            unless placeholder.include? Graphics::OBFUSCATION_CHAR
            Graphics.clear_screen
            puts Graphics::ALIVE
            sleep 1
            puts "\n\nWELL DONE!! YOU SURVIVED"
            break
          end

         else

          if guess.include? char
            puts "You already entered '#{char}'. Duh, it's still totally wrong.. 🙄"
          else
            guess << char
            placeholder = Graphics.obfuscate_word(word, guess)
            puts "OH NOES! The word doesn't contain '#{char}'"
            @wrong_tries = @wrong_tries + 1
          end

          if wrong_tries == chances
            puts Graphics::DEAD
            puts "\nARRRRGGGGGGGGGGG YOU LOST! 😭  😵  ☠️"
            break
          else
            puts 'Try another: ' + Graphics.obfuscate_word(word, guess)
          end
        end
      end
    end
  end
end
