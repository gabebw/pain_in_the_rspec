require "girls_just_want_to_have_puns"

module PainInTheRspec
  class Pundit
    BANNED_WORDS = %w(should can and)

    def initialize(original)
      @original = original
    end

    def pun
      if found_pun?
        found_pun.new_phrase + " " + filtered[1..-1].join(" ")
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
      @found_pun ||= GirlsJustWantToHavePuns.pun(filtered.first)
    end

    def filtered
      original.split(" ") - BANNED_WORDS
    end
  end
end
