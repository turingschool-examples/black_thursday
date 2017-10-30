class ItemRepository

  def initialize()

  end

  def from_csv(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      @id = row[:id]
      @name = row[:name]
      @description = row[:description]
      @unit_price = row[:unit_price]
      @merchant_id = row[:merchant_id]
      @created_at = row[:created_at]
      @updated_at = row[:updated_at]
    end
  end 

end
