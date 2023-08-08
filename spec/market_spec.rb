require "spec_helper"

describe Market do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @market = Market.new("South Pearl Street Farmers Market")
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@market).to be_a Market
      expect(@market.name).to eq("South Pearl Street Farmers Market")
      expect(@market.vendors).to be_an Array
      expect(@market.vendors.empty?).to be true
    end
  end
end