require './lib/searching'

class ItemRepository
  include Searching

  def initialize(file_path)
    @file_path = file_path
  end

  def all
    data.map {|row| Item.new(row)}
  end

  def find_all_with_description(fragment)
    all.find_all do |obj|
      obj.description.include?(fragment)
    end
  end

  def find_all_by_price(price)
    all.find_all {|obj| obj.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    all.find_all do |obj|
      range.include?(obj.unit_price.to_i / 100)
    end
  end
end
