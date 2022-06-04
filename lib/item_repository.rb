require 'time'
require 'CSV'
require_relative 'item'

class ItemRepository

  attr_reader :all

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end

  def initialize(file_path)
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
       @all << Item.new({id: row[:id], name: row[:name], description: row[:description], unit_price: row[:unit_price], merchant_id: row[:merchant_id], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
  end

  def find_by_id (input_id)
    @all.find {|item| item.id == input_id}
  end

  def find_all_by_price(price)
    @all.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    items_range = []
    @all.each {|item| items_range << item if range.member?(item.unit_price)}
    items_range
  end

  def find_by_name(name)
    @all.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_by_merchant_id(input_id)
    @all.find_all {|item| item.merchant_id == input_id}
  end

  def find_all_with_description(description)
    @all.find_all {|item| item.description.downcase.include?(description.downcase)}
  end

  def create(attributes)
  attributes[:id]= find_max_id + 1
  @all << Item.new(attributes)
  end

  def find_max_id
    id_max = []
    @all.each {|item| id_max << item.id}
    id_max.max
  end

  def update(input_id, attributes)
    attributes.each do |attribute, value|
      if attribute.to_sym == :name
        find_by_id(input_id).name = value
      elsif attribute.to_sym == :description
        find_by_id(input_id).description = value
      elsif attribute.to_sym == :unit_price
        find_by_id(input_id).unit_price = BigDecimal(value,4)
      end
    end
    find_by_id(input_id).updated_at = Time.now if find_by_id(input_id).class == Item
  end

  def delete(input_id)
    @all.delete(find_by_id(input_id))
  end
end
