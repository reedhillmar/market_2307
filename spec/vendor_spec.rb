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
end