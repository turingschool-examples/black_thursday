require 'csv'

class Item
  attr_reader :id, :merchant_id, :created_at
  attr_accessor :name, :description, :unit_price, :updated_at
  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @merchant_id = data[:merchant_id].to_i
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
