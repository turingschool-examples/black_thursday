require 'csv'

class SalesEngine
  attr_reader :item_repository,
              :from_csv,
              :merchant_repository,
              :items,
              :merchants,
              :items_store
  def initialize
    @item_repository = ItemRepository.new(self)
    @merchant_repository = MerchantRepository.new
  end

  def from_csv(data)
    @items_store = []
    @items = data[:items]
    contents = CSV.foreach @items, headers: true, header_converters: :symbol do |row|
      @items_store << row
    end
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
    @merchants.detect{|merchant| merchant.id == id}
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
    @items_store = []
    @sales_engine = parent
  end

  def count
    @items_store.count
  end

  def create_item(data)
    my_reference = self
    @items_store << Item.new(data, my_reference)
  end

  def merchant(id)
    @sales_engine.merchant(id)
  end

end

class Item
attr_reader :id,
            :name,
            :description,
            :unit_price,
            :created_at,
            :updated_at,
            :repository,
            :unit_price_to_dollars,
            :merchant_id

  def initialize(data, parent)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @unit_price_to_dollars = data[:unit_price_to_dollars]
    @merchant_id = data[:merchant_id]
    @repository = parent
  end

  def merchant
    @repository.merchant(merchant_id)
    # binding.pry
  end

end
