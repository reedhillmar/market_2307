# ./lib/market.rb

class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name 
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    # require 'pry';binding.pry
    @vendors.find_all {|vendor| vendor.inventory.has_key?(item)}
  end

  def items_sold
    @vendors.flat_map {|vendor| vendor.inventory.keys}.uniq
  end

  def item_stock(item)
    @vendors.sum {|vendor| vendor.check_stock(item)}
  end

  def total_inventory
    items_sold.each_with_object({}) do |item, h|
      h[item] = {
        "quantity" => item_stock(item),
        "vendors" => vendors_that_sell(item)
      }
    end
  end

  def overstocked_items
    items_sold.find_all {|item| vendors_that_sell(item).count > 1 && item_stock(item) > 50}
  end

  def sorted_item_list
    items_sold.map {|item| item.name}.sort
  end
end