require 'csv'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(items_contents, merchants_contents)
    @item_repository = ItemRepository.new(items_contents)
    @merchant_repository = MerchantRepository.new(merchant_repository)
  end

  def self.from_csv(csv_hash)
    items_contents = CSV.open(csv_hash[:items], headers: true, header_converters: :symbol)
    merchants_contents = CSV.open(csv_hash[:merchants], headers: true, header_converters: :symbol)
    sales_engine = SalesEngine.new(items_contents, merchants_contents)
    # this is just raw data from CSV but we have to use the data to initialize new 
    # merchant repo and item repo objects (lines 6-9)

    # next in the ItemRepo we need to use the data to initialize specific individual item objects
    # by iterating through the item repo collection (which is an array)

    # same thing for MerchantRepo 
    # refer to spec harness for for guidance
    #did we install spec harness?
  end

  def items
    item_repository
  end
  
  # def merchants
  #   mr = MerchantRepository.new
  #   @merchants.each do |merchant|
  #     mr.add({id: merchant[:id], name: merchant[:name]})
  #   end
  #   mr
  # end
end