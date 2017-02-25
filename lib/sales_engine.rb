require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'

class SalesEngine

  attr_accessor :items, :merchants, :invoices

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self) unless hash[:items].nil?
    @merchants = MerchantRepository.new(hash[:merchants], self) unless hash[:merchants].nil?
    @invoices = InvoiceRepository.new(hash[:invoices], self) unless hash[:invoices].nil?
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end
end


# se = SalesEngine.from_csv({
#   :items     => "./test/fixtures/item_fixture.csv",
#   :merchants => "./test/fixtures/merchant_fixture.csv",
# })
#
# require "pry"; binding.pry
# p ""
