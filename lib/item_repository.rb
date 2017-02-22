require_relative 'item'

class ItemRepository
  attr_reader :item_contents

  def initialize(item_contents)
    @item_contents  = item_contents
    
  end

  def find_by_name(name)

  end

  # def from_csv(input_hash)
  #   # contents = CSV.open "data/items.csv"       #headers: true, header_converters: :symbol
  #   # output = "#{:id},#{:name},#{:description},#{:unit_price},#{:merchant_id},#{:created_at},#{:updated_at}"
  #   @items = ItemRepository.new(item_path)
  #   @merchants = MerchantRepository.new
end
