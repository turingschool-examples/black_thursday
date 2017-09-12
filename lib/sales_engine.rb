class SalesEngine

  def initialize(csv_hash)
    # @ir = ItemRepository.new(item_file)
  end



  def self.from_csv(csv_hash)
    @item_file = csv_hash[:items]
    @merchant_file = csv_hash[:merchants]

    #creates instance of self...and actually happens before the initialize method.
    SalesEngine.new(csv_hash)
  end



  def items

  end

  def merchants
    MerchantRepository.new(merchant_file)
  end

end
