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
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@market).to be_a Market
      expect(@market.name).to eq("South Pearl Street Farmers Market")
      expect(@market.vendors).to be_an Array
      expect(@market.vendors.empty?).to be true
    end

    it "has a date that defaults to the date it is initialized" do
      expect(@market.date).to eq ("08/08/2023")
    end

    xit "can have a different date" do
      allow(Date.today).to receive(:strftime).and_return("24/02/2023")

      expect(@market.date).to eq("24/02/2023")
    end
  end

  describe "#add_vendor" do
    it "can add vendors to the market" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendors). to eq([@vendor1, @vendor2, @vendor3])
    end 
  end

  context "#vendor info" do
    before(:each) do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
    end

    describe "#vendor_names" do
      it "can return the names of vendors at the market" do
        expect(@market.vendor_names). to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
      end
    end

    describe "#vendors_that_sell" do
      it "can return the vendors that sell a given item" do
        expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
        expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
      end
    end

    describe "#items_sold" do
      it "can return all items sold at the market" do
        expect(@market.items_sold).to eq([@item1, @item2, @item4, @item3])
      end
    end

    describe "#item_stock" do
      it "can return the stock of all items sold at the market" do
        expect(@market.item_stock(@item1)).to be 100
      end
    end

    describe "#total_inventory" do
      it "can return the quantity of all items sold at the market" do
        expect(@market.total_inventory).to eq({@item1 => {"quantity" => 100, "vendors" => [@vendor1, @vendor3]}, @item2 => {"quantity" => 7, "vendors" => [@vendor1]}, @item3 => {"quantity" => 25, "vendors" => [@vendor2]}, @item4 => {"quantity" => 50, "vendors" => [@vendor2]}})
      end
    end

    describe "#overstocked_items" do
      it "can return items that are sold by more than 1 vendor and the total quantity is greater than 50" do
        expect(@market.overstocked_items).to eq([@item1])

        @vendor3.stock(@item4, 50)

        expect(@market.overstocked_items).to eq([@item1, @item4])
      end
    end

    describe "#sorted_item_list" do
      it "can return a list of items in stock sorted alphabetically by name" do
        expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
      end
    end
  end
end