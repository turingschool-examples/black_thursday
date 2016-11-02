require_relative 'merchant_repository'
require 'csv'
require_relative 'item_repository'
require 'pry'

class SalesEngine
  attr_reader   :merchant_repository,
                :item_repository
                
  def initialize(all_file_paths)
    @merchant_data = SalesEngine.read_csv(all_file_paths[:merchants])
    @item_data     = SalesEngine.read_csv(all_file_paths[:items])
    @merchant_repository = MerchantRepository.new(@merchant_data, self)
    @item_repository     = ItemRepository.new(@item_data, self)
  end

  def find_all_items_by_merchant_id(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

  def self.from_csv(all_file_paths)
    SalesEngine.new(all_file_paths)
  end
  
  def read_csv(file_path)
    contents = CSV.read file_path, headers: true, header_converters: :symbol
    #add a way to deal with nil
  end

  def items(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id).map { |item| item["name"]}
  end


  def merchant(name)
    merch_ids = item_repository.find_all_by_name(name).map { |item| item["merchant_id"] }
    merchants = merch_ids.map { |merch_id| merchant_repository.find_by_id(merch_id)["name"] }
    merchants
  end

end

# se = SalesEngine.new
# # binding.pry
# merch_test = se.merchant_repository.find_by_id("12334105")
# binding.pry