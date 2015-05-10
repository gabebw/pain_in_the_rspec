require "spec_helper"

describe PainInTheRspec::Pundit do
  context "#pun" do
    it "generates a pun" do
      original = "hello"
      pundit = described_class.new(original)
      allow(GirlsJustWantToHavePuns).to receive(:pun).and_call_original

      expect(pundit.pun).not_to eq original
    end

    it "uses Girls Just Want to Have Puns" do
      original = "hello"
      pundit = described_class.new(original)
      allow(GirlsJustWantToHavePuns).to receive(:pun).and_call_original

      pundit.pun

      expect(GirlsJustWantToHavePuns).to have_received(:pun)
    end
  end
end
