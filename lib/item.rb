class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,

  def initialize(data, repository)
    @repository   = repository
    @id           = data[:id]
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = data[:unit_price]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @merchant_id  = data[:merchant_id]
  end

  def merchant_name

  end

end
