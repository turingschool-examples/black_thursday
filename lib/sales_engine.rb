require_relative 'mathematics'

class SalesEngine
  include Math
  include Mathematics

  attr_reader :merchants,
              :items,
              :invoices

  def initialize(csv_data)
    routes(csv_data)
  end

  def find_merchant_by_merchant_id(id)
    @merchants.find_by_id(id)
  end

  def find_items_by_id(id)
    items.find_all_by_merchant_id(id)
  end

  def routes(csv_data)
    csv_data.each_key do |key|
      case
      when key == :invoices
        make_invoice_repo(csv_data)
      when key == :merchants
        make_merchant_repo(csv_data)
      when key == :items
        make_item_repo(csv_data)
      end
    end
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def self.from_csv(csv_data)
    SalesEngine.new(csv_data)
  end

  def make_invoice_repo(csv_data)
    @invoices = InvoiceRepo.new(csv_data[:invoices], self)
  end

  def make_merchant_repo(csv_data)
    @merchants = MerchantRepo.new(csv_data[:merchants], self)
  end

  def make_item_repo(csv_data)
    @items = ItemRepo.new(csv_data[:items], self)
  end
end
