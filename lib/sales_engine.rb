# require_relative "../data/items"
# require "/data/merchants"
require_relative "item_repository"
require "csv"

class SalesEngine

  def items
    ItemRepository.new
  end

  

  def from_csv(input_hash)
    contents = CSV.open "data/items.csv"       #headers: true, header_converters: :symbol
    output = "#{:id},#{:name},#{:description},#{:unit_price},#{:merchant_id},#{:created_at},#{:updated_at}"
  end


end

