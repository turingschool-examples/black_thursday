class SalesEngine

  def self.from_csv(csv_hash)
    @item_file = csv_hash[:items]
    @merchant_file = csv_hash[:merchants]
    SalesEngine.new
  end

  def items
    ItemRepository.new(@item_file)
  end

  def merchants
    MerchantRepository.new(@merchant_file)
  end

end
