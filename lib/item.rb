class Item
attr_reader :id,
            :name,
            :description,
            :created_at,
            :updated_at,
            :unit_price,
            :merchant_id

  def initialize(data_hash)
    @id = data_hash[:id]
    @name = data_hash[:name]
    @description = data_hash[:description]
    @created_at = data_hash[:created_at]
    @updated_at = data_hash[:updated_at]
    @unit_price = data_hash[:unit_price]
    @merchant_id = data_hash[:merchant_id]
  end
end
