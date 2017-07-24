require 'CSV'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  def self.from_csv(hash)
    load_items(hash[:items])
    load_merchants(hash[:merchants])
    SalesEngine.new
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
      ir.array << item
      # require 'pry'; binding.pry
    end
    # ir
  end

  def self.load_merchants(merchants_file_path)
    mr = MerchantRepository.new
    contents = CSV.open merchants_file_path,
               headers: true,
               header_converters: :symbol
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      merchant = Merchant.new(id, name, created_at, updated_at)
      mr.array << merchant
    end
    # mr
  end

end
