class SalesEngine
  attr_reader :item_repository, :merchant_repository

  def initialize
    @item_repository = ItemRepository.new(self)
    @merchant_repository = MerchantRepository.new
  end

  def merchant(id)
    @merchant_repository.find_by_id(id)
  end

end

class MerchantRepository
  attr_reader :merchants, :sales_engine
  def initialize
    @merchants = []
  end
  def find_by_id(id)
    @merchants.detect{|merchant| merchant_id == id}
  end

  def create_merchant(data)
    my_reference = self
    @merchants << Merchant.new(data, my_reference)
  end

end

class Merchant
  attr_reader :name,
              :repository,
              :id

    def initialize(data, parent)
      @name = data[:name]
      @id = data[:id]
      @repository = parent
    end

end

class ItemRepository
  attr_reader :items, :sales_engine, :merchant

  def initialize(parent)
    @items = []
    @sales_engine = parent
  end

  def count
    @items.count
  end

  def create_item(data)
    my_reference = self
    @items << Item.new(data, my_reference)
  end

  def merchant(id)
    @sales_engine.merchant(id)
  end

end

class Item
attr_reader :name,
            :repository,
            :merchant_id

  def initialize(data, parent)
    @name = data[:name]
    @merchant_id = data[:merchant_id]
    @repository = parent
  end

  def merchant
    @repository.merchant(merchant_id)
    # binding.pry
  end

end
