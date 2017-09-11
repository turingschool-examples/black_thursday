class SalesEngine

  def from_csv(csv_hash)
    return "loaded"

  end

  def items
    ItemRepository.new
  end

  def merchants
    MerchantRepository.new 
  end

end
