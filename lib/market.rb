# ./lib/market.rb

class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name 
    @vendors = []
  end
end