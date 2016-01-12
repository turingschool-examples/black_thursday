class SalesEngine
attr_reader :items_file, :merchants_file, :items_data

  def initialize(list_of_csv_files)
    @items_file = list_of_csv_files[:items]
    @merchants_file = list_of_csv_files[:merchants]
  end

  def self.from_csv(list_of_csv_files)
    SalesEngine.new(list_of_csv_files)
  end

  def items
    ItemRepository.new(items_file)
  end

  def merchants
    MerchantRepository.new(merchants_file)
  end
end
