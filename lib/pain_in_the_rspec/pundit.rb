require "girls_just_want_to_have_puns"

module PainInTheRspec
  class Pundit
    def initialize(original)
      @original = original
    end

    def pun
      GirlsJustWantToHavePuns.pun(original).new_phrase
    end

    private

    attr_reader :original
  end
end
