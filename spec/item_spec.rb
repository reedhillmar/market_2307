require "spec_helper"

describe Item do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@item1).to be_an Item
      expect(@item1.name).to eq("Peach")
      expect(@item1.price).to be 0.75
      expect(@item2.name).to eq("Tomato")
      expect(@item2.price).to be 0.5
    end
  end
end