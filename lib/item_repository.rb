require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader   :all,
                :parent

  def initialize(item_data, parent = nil)
    @parent = parent
    populate(item_data)
  end

  def populate(item_data)
    @all = item_data.map { |item| Item.new(item, self) }
  end

  def find_by_id(id)
    @all.find { |item| item.id.eql?(id) }
  end 

  def find_all_by_merchant_id(merchant_id)
    @all.find_all { |item| item.merchant_id.eql?(merchant_id) }
  end

  def find_all_with_description(fragment)
    @all.find_all do |item|
      item.description.downcase.include?(fragment.downcase)
    end
  end

  def find_all_by_price_in_range(price_range)
    @all.find_all do |item|
      price_range.include?(item.unit_price)
    end
  end

  def find_all_by_price(price)
    @all.find_all { |item| item.unit_price.eql?(price) }
  end


  def find_by_name(name)
    @all.find { |item| item.name.downcase.eql?(name.downcase) }
  end

  def find_all_by_name(fragment)
    @all.find_all do |item|
      item.name.downcase.include?(fragment.downcase)
    end
  end

  def inspect 
    "#<#{self.class} #{@all.size} rows>"
  end

end
