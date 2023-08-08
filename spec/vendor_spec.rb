require "spec_helper"

describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@vendor).to be_a Vendor
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
      expect(@vendor.inventory).to be_a Hash
      expect(@vendor.inventory.empty?).to be true
    end
  end

  describe "#check_stock" do
    it "can check the stock of an item" do
      expect(@vendor.check_stock(@item1)).to be 0
    end
  end

  describe "#stock" do
    it "can add to the stock of an item" do
      @vendor.stock(@item1, 30)

      expect(@vendor.inventory).to eq({@item1 => 30})
      expect(@vendor.check_stock(@item1)).to be 30

      @vendor.stock(@item1, 25)

      expect(@vendor.check_stock(@item1)).to be 55

      @vendor.stock(@item2, 12)

      expect(@vendor.inventory).to eq({@item1 => 55, @item2 => 12})
    end
  end
end