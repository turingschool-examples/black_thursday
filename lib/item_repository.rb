require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Item.new(row)
    end
  end

  def find_by_id(id)
    @all.find { |item| item.id == id }
  end

  def find_by_name(name)
    @all.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description)
    @all.find_all { |item| item.description.downcase.include?(description.downcase) }
  end

  def find_all_by_price(price)
    @all.find_all { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    range_array = []
    @all.each do |item|
      if item.unit_price.to_i >= range.first && item.unit_price.to_i <= range.last
        range_array << item
      end
    end
    range_array
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all { |item| item.merchant_id == merchant_id }
  end

  def create(attributes)
    attributes[:id] = @all.max_by { |item| item.id }.id + 1
    @all << Item.new(attributes)
    @all.last
  end

  def update(id, attributes)
    if find_by_id(id)
      find_by_id(id).update(attributes)
    end
  end

 def delete(id)
   @all.delete_if { |item| item.id == id }
 end

 def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
