require 'csv'

class SalesEngine

  attr_reader :item_file,
              :merchant_file,
              :items,
              :merchants

  def initialize(merchant_file, item_file)
    @merchant_file = merchant_file
    @item_file = item_file
  end

  def self.from_csv(hash)
    @merchants = MerchantRepo.new(hash[:merchants])  #test me.
    #@items = ItemRepository.new
    @items_csv = CSV.open(hash[:items], headers: true, header_converters: :symbol)
    #@items = ItemRepository.new
  end

end
