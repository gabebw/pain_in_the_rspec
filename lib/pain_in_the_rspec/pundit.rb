require "girls_just_want_to_have_puns"

module PainInTheRspec
  class Pundit
    BANNED_WORDS = %w(should can and)

    def initialize(original)
      @original = original
    end

    def pun
      if found_pun?
        [found_pun.new_phrase, rest_of_phrase].join(" ").strip
      else
        "[pun of #{original}]"
      end
    end

    private

    attr_reader :original

    def found_pun?
      !found_pun.nil?
    end

    def found_pun
      @found_pun ||= GirlsJustWantToHavePuns.pun(pun_word) ||
        GirlsJustWantToHavePuns.pun(singular_pun_word) ||
        GirlsJustWantToHavePuns.pun(other_singular_pun_word)
    end

    def pun_word
      filtered.first
    end

    def singular_pun_word
      pun_word.sub(/s$/, "")
    end

    def other_singular_pun_word
      pun_word.sub(/es$/, "")
    end

    def filtered
      original.split(" ") - BANNED_WORDS
    end

    def rest_of_phrase
      if filtered.size > 0
        filtered[1..-1].join(" ")
      else
        ""
      end
    end
  end
end
