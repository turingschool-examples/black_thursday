require 'csv'

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at
  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def self.read_file(csv)
    item_rows = CSV.read(csv, headers: true, header_converters: :symbol)
    item_rows.map do |row|
      new(row)
    end
    #each row is a hash
  end

  def unit_price_to_dollars
    price_to_dollars = @unit_price.to_f
  end
end
