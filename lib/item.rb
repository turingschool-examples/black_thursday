require_relative './time_store_module'

class Item
  include TimeStoreable
  attr_reader :id,
              :repository,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(data, repository)
    @repository   = repository
    @id           = data[:id]
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = data[:unit_price]
    @created_at   = time_store(data[:created_at])
    @updated_at   = time_store(data[:updated_at])
    @merchant_id  = data[:merchant_id]
  end

end
