class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(csv_data)
    make_merchant_repo(csv_data)
    make_item_repo(csv_data)
  end

  def find_merchant_by_merchant_id(id)
    merchants.find_by_id(id)
  end

  def find_items_by_id(id)
    items.find_all_by_merchant_id(id)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def self.from_csv(csv_data)
    SalesEngine.new(csv_data)
  end

  def make_merchant_repo(csv_data)
    @merchants = MerchantRepo.new(csv_data[:merchants], self)
  end

  def make_item_repo(csv_data)
    @items = ItemRepo.new(csv_data[:items], self)
  end
end
