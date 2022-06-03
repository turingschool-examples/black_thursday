require 'csv'
require 'BigDecimal'
require_relative './enumerable'

class ItemRepository
  include Enumerable
  attr_accessor :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new({
        id: row[:id].to_i, name: row[:name], description: row[:description], unit_price: BigDecimal(row[:unit_price].to_i * 0.01, 4), merchant_id: row[:merchant_id].to_i, created_at: row[:created_at], updated_at: row[:updated_at]})
    end
  end

  # def find_by_name(name)
  #   @all.find {|row| row.name.downcase == name.downcase}
  # end

  def find_all_with_description(description)
    @all.find_all {|row| row.description.include?(description)}
  end

  def find_all_by_price(price)
    @all.find_all {|row| row.unit_price_to_dollars == price}
  end

  def find_all_by_price_in_range(range)
    @all.find_all {|row| range.include?(row.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all {|row| row.merchant_id == merchant_id}
  end

  def create(item)
    i = Item.new({
      id: @all.last.id + 1,
      name: item[:name],
      description: item[:description],
      unit_price: item[:unit_price],
      created_at: item[:created_at],
      updated_at: item[:updated_at],
      merchant_id: item[:merchant_id]
      })
    @all.append(i)
    i
  end

  def update(id, attributes)
    key = attributes.keys[0]
    value = attributes.values[0]
    find_by_id(id).change(key, value)
  end

  # def delete(id)
  #   item_index = @all.find_index(find_by_id(id))
  #   @all.delete_at(item_index)
  # end

end
