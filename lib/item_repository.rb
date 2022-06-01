require 'csv'
require 'BigDecimal'

class ItemRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new({
        id: row[:id].to_i, name: row[:name], description: row[:description], unit_price: BigDecimal(row[:unit_price].to_i * 0.01, 4), merchant_id: row[:merchant_id].to_i, created_at: row[:created_at], updated_at: row[:updated_at]})
    end
  end

  def find_by_id(id)
    @all.find {|row| row.id == id}
  end

  def find_by_name(name)
    @all.find {|row| row.name.downcase == name.downcase}
  end

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
    @all.find_all do |row|
      row.merchant_id == merchant_id
    end
  end

end
