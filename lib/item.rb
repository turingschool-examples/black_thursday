require 'bigdecimal'

class Item
  attr_reader :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(params)
    #will need id and merchant id
    @name        = params[:name]
    @description = params[:description]
    @unit_price  = params[:unit_price]
    @created_at  = params[:created_at]
    @updated_at  = params[:updated_at]
  end


end
