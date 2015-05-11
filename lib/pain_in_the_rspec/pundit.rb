require "girls_just_want_to_have_puns"

module PainInTheRspec
  class Pundit
    BANNED_WORDS = %w(should can and)

    def initialize(original)
      @original = original
    end

    def pun
      GirlsJustWantToHavePuns.pun(filtered.first).new_phrase
    end

    private

    attr_reader :original

    def filtered
      original.split(" ") - BANNED_WORDS
    end
  end
end
