require './lib/entry'
class SalesEngine

  attr_reader :item_repository, :merchant_repository

  def initialize(items_path = nil,
                 merchants_path = nil,
                 invoices_path = nil,
                 invoice_items_path = nil,
                 customer_path = nil,
                 transaction_path = nil)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new (merchants_path)
    @invoice_path = InvoicesPath.ew (invoice_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants])
  end

  def analyst
    SalesAnalyst.new(item_repository, merchant_repository)
  end

end
