class SalesEngine

  def self.from_csv(file_names)
    @item_file = file_names[:items]
    @merchant_file = file_names[:merchants]
    SalesEngine.new(@item_file, @merchant_file)
  end

  def initialize(item, merchant)
    ItemRepository.new(item)
    MerchantRepository.new(merchant)
  end

end
