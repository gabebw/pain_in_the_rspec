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

    it "only puns on the first non-filtered word" do
      original = "hello there how are you"
      pundit = described_class.new(original)
      stub_pun_with("yellow")

      result = pundit.pun

      expect(result).to eq "yellow there how are you"
    end

    it "uses [pun of X] when there is no pun" do
      stub_no_pun_result
      original = "hello"
      pundit = described_class.new(original)

      expect(pundit.pun).to eq "[pun of #{original}]"
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

  def stub_pun_with(result)
    pun = GirlsJustWantToHavePuns::Pun.new(
      result,
      "whatever",
      "some category"
    )

    allow(GirlsJustWantToHavePuns).to receive(:pun).and_return(pun)
  end

  def stub_no_pun_result
    allow(GirlsJustWantToHavePuns).to receive(:pun).and_return(nil)
  end
end
