require "spec_helper"

describe PainInTheRspec::Pundit do
  context "#pun" do
    it "generates a pun" do
      original = "hello"
      pundit = described_class.new(original)

      expect(pundit.pun).not_to eq original
    end

    it "uses Girls Just Want to Have Puns" do
      original = "hello"
      pundit = described_class.new(original)
      stub_pun

      pundit.pun

      expect(GirlsJustWantToHavePuns).to have_received(:pun)
    end

    context "filtering" do
      %w(should can and).each do |word|
        it "filters out '#{word}'" do
          original = "hello"
          pundit = described_class.new("#{word} #{original} #{word}")
          stub_pun

          pundit.pun

          expect(GirlsJustWantToHavePuns).to have_received(:pun).with(original)
        end
      end
    end
  end

  def stub_pun
    allow(GirlsJustWantToHavePuns).to receive(:pun).and_call_original
  end
end
