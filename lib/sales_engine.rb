

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(file_path)
    # @items = items
    make_merchant_repo(file_path)
    make_item_repo(file_path)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def self.from_csv(file_path)
    SalesEngine.new(file_path)
  end

  def make_merchant_repo(file_path)
    @merchants = MerchantRepo.new(file_path[:merchants], self)
  end

  def make_item_repo(file_path)
    @items = ItemRepo.new(file_path[:items], self)
  end

  def find_item_by_id(id)
    @items.find_by_id(id)
  end

  def grab_merchant(id)
    @merchants.find_by_id(id)
  end

end
