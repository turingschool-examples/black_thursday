require 'CSV'
require './lib/item_repository'

class SalesEngine

  def self.from_csv(hash)
    ir = load_items(hash[:items])
    puts ir
    # MerchantRepository.new
    # load_merchants(hash[:merchants])
    se = SalesEngine.new
  end

  def self.load_items(items_file_path)
    ir = ItemRepository.new
    contents = CSV.open items_file_path,
               headers: true,
               header_converters: :symbol
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      item = Item.new(id, name, description, unit_price, created_at, updated_at)
      # require 'pry'; binding.pry
      ir.array << item
    end
    ir
  end

end


# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
