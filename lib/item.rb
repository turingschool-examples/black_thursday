require 'bigdecimal'

class Item

attr_reader :id, :merchant_id, :created_at, :unit_price_to_dollars
attr_accessor :name, :description, :unit_price, :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal(data[:unit_price],4)
    @merchant_id = data[:merchant_id].to_i
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @unit_price_to_dollars = data[:unit_price].to_f
  end

  def self.create_item(data)
    CSV.parse(File.read(data), headers: true, header_converters: :symbol).map do |row|
       Item.new(row)
     end
  end

end
