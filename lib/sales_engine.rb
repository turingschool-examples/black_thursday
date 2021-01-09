require_relative './merchant_repo'
require_relative './item_repo'
require_relative './invoice_repo'


class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(data)
    # @merchants = MerchantRepository.new(data[:merchants], self)
    # @items = ItemRepository.new(data[:items], self)
    # @invoices = InvoiceRepository.new(data[:invoices], self)
    data_check(data)
  end

  def self.from_csv(data)
    new(data)
  end

  def data_check(data)
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
end
