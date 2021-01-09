require_relative './merchant_repo'
require_relative './item_repo'
require_relative './invoice_repo'
require_relative './sales_analyst'


class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :sales_analyst

  def initialize(data)
    process_data(data)
  end

  def self.from_csv(data)
    new(data)
  end

  def process_data(data)
    data.each do |key, value|
      if key == :merchants
        @merchants = MerchantRepository.new(data[:merchants], self)
      elsif key == :items
        @items = ItemRepository.new(data[:items], self)
      elsif key == :invoices
        @invoices = InvoiceRepository.new(data[:invoices], self)
      end
    end
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def merchant_items(merchant_id)
    @items.find_by_merchant_id(merchant_id)
  end
end
