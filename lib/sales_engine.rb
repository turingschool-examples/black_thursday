class SalesEngine
  attr_reader :items, :merchants, :merchants_data, :items_data

  def self.from_csv(csv_content)
    @items = csv_content[:items]
    @merchants = csv_content[:merchants]
    @items_data = CsvParser.new.items(items)
    @merchants_data = CsvParser.new.merchants(merchants)
  end

  def items
    ItemRepository.new(items_data)
  end

  def merchants
    MerchantRepository.new(merchants_data)
  end

end
