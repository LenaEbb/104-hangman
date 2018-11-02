module Hangman
  module Dictionary
    WORDS = File.readlines ('linuxwords')
      def self.random
      word = WORDS.sample
      if word.split.count < 5
      word = WORDS.sample.chomp
     end
    end
  end
end
