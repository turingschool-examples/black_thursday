class Item
  attr_reader :id,
              :created_at,
              :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at].to_s
    @updated_at = data[:updated_at].to_s
    @merchant_id = data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def created_at
    if @created_at != nil
      Time.parse(@created_at)
    end
  end

  def updated_at
    if @updated_at != nil
      Time.parse(@updated_at)
    end
  end
end
