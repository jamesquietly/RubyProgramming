require_relative '../lib/caesar_cipher.rb'
describe "#caesar_cipher" do
    it "shift What a string! by 5" do
        expect(caesar_cipher("What a string!", 5)).to eql("Bmfy f xywnsl!")
    end
end