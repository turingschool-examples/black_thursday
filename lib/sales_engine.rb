require 'csv'

class SalesEngine
  
  # attr_reader :items, :merchants

  ### from_csv will do '.new' things
  def initialize#(items_contents, merchants_contents)
    # @item_repository = ItemRepository.new(items_contents)
    # @merchant_repository = MerchantRepository.new(merchant_contents)
  end

  def items
    ItemRepository.new(from_csv[:items])
  end

  def merchants
    MerchantRepository.new(from_csv[:merchants])
  end
  def self.from_csv
    {
    :items      => create_items,
    :merchants  => create_merchants}

  end

  def self.csv_hash
    {
    :items      => './data/items.csv',
    :merchants  => './data/merchants.csv'
    }
  end

 
  
  # def merchants
  #   contents = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
  #   merchants = []
  #   contents.each do |row|
  #   info = {:id => row[:id], :name => row[:name]}
  #     merchants << Merchant.new(info)
  #   end
  # end
end
##### Leftover notes
    # items_contents = CSV.open(csv_hash[:items], headers: true, header_converters: :symbol)
    # merchants_contents = CSV.open(csv_hash[:merchants], headers: true, header_converters: :symbol)
    # sales_engine = SalesEngine.new(items_contents, merchants_contents)

    # this is just raw data from CSV but we have to use the data to initialize new 
    # merchant repo and item repo objects (lines 6-9)

    # next in the ItemRepo we need to use the data to initialize specific individual item objects
    # by iterating through the item repo collection (which is an array)

    # same thing for MerchantRepo 
    # refer to spec harness for for guidance
    #did we install spec harness?