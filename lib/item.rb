class Item

attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price].to_i
    @merchant_id = data[:merchant_id]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def self.create_item(data)
    CSV.parse(File.read(data), headers: true, header_converters: :symbol).map do |row|
       Item.new(row)
     end
  end

end
