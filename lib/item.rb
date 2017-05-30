class Item

  attr_reader   :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at
  attr_accessor :id,
                :merchant_id

  def initialize(params = {}, id = nil, merchant_id = nil)
    @id          = id
    @merchant_id = merchant_id
    @name        = params.fetch(:name, "")
    @description = params.fetch(:description, "")
    @unit_price  = params.fetch(:unit_price, "")
    @created_at  = params.fetch(:created_at, "")
    @updated_at  = params.fetch(:updated_at, "")
  end

end
