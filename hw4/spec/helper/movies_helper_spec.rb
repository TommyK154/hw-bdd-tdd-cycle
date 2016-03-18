require 'rails_helper'

describe MoviesHelper, :type => :helper do 
  describe "#oddness" do
    it "should return odd for an odd number" do
      odd_num = 1
      expect(oddness(odd_num)).to eq("odd")
    end
    it "should return even for an even number" do
      even_num = 2
      expect(oddness(even_num)).to eq("even")
    end
  end
end