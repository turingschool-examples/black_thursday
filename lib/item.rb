class Item

  attr_reader   :id,
                :merchant_id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at

  def initialize(params = {})
    @id          = params.fetch(:id, "")
    @merchant_id = params.fetch(:merchant_id, "")
    @name        = params.fetch(:name, "")
    @description = params.fetch(:description, "")
    @unit_price  = params.fetch(:unit_price, "")
    @created_at  = params.fetch(:created_at, "")
    @updated_at  = params.fetch(:updated_at, "")
  end

end
