require "spec_helper"

describe Vendor do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @vendor = Vendor.new("Rocky Mountain Fresh")
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

  describe "#potential_revenue" do
    it "can return the potential revenue of a vendor based on their inventory" do
      @item1 = Item.new({name: 'Peach', price: "$0.75"})
      @item2 = Item.new({name: 'Tomato', price: '$0.50'})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @vendor1 = Vendor.new("Rocky Mountain Fresh")
      @vendor2 = Vendor.new("Ba-Nom-a-Nom")
      @vendor3 = Vendor.new("Palisade Peach Shack")
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      expect(@vendor1.potential_revenue).to be 29.75
      expect(@vendor2.potential_revenue).to be 345.00
      expect(@vendor3.potential_revenue).to be 48.75
    end
  end
end