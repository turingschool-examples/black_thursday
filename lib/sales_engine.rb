require_relative 'merchant_repository'
require_relative 'item_repository'
require 'csv'
require 'pry'

class SalesEngine
  attr_reader   :merchants,
                :items,
                :raw_data
                
  def initialize(all_file_paths)
    read_csv(all_file_paths)
    @merchants = MerchantRepository.new(@raw_data[:merchants], self)
    @items     = ItemRepository.new(@raw_data[:items], self)
  end

  def find_all_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)

  end

  def self.from_csv(all_file_paths)
    SalesEngine.new(all_file_paths)
  end
  
  def read_csv(file_path)
    @raw_data = {}
    if file_path != nil
      file_path.map do |key, value|
        @raw_data[key] = CSV.read value, headers: true, header_converters: :symbol
      end
    else 
      raise ArgumentError
    end
    #add a way to deal with nil
  end

  # def items(merchant_id = nil)
  #   items.find_all_by_merchant_id(merchant_id).map { |item| item["name"]}
  # end


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