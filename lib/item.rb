require_relative './time_store_module'

class Item
  include TimeStoreable

  attr_accessor :name,
                :description,
                :unit_price

  attr_reader :id,
              :repository,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(data, repository)
    @repository   = repository
    @id           = data[:id].to_i
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = data[:unit_price].to_f
    @created_at   = time_store(data[:created_at])
    @updated_at   = time_store(data[:updated_at])
    @merchant_id  = data[:merchant_id].to_i
  end
end
