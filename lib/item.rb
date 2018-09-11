class Item
  attr_reader   :created_at,
                :merchant_id

  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(params)
    @id = params[:id].to_i
    @name = params[:name]
    @description = params[:description]
    @unit_price = params[:unit_price].to_f/100
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
    @merchant_id = params[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
