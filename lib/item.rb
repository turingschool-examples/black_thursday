class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :updated_at

  attr_reader :created_at,
              :merchant_id

  def initialize(info, repo)
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id]
    @repo = repo
  end

  def unit_price_to_dollars
    "$#{@unit_price.to_f}"
  end
end
