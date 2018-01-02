require_relative "./lib/merchant_repo"

class SalesEngine
  attr_reader :merchants

  def self.from_csv(directory)
    SalesEngine.new(directory)
  end

  def initialize
    @merchants = MerchantRepo.new(self, directory[:merchants])
    @items     = ItemRepo.new(self, directory[:items])
  end

  se = SalesEngine.from_csv({
    :items         => "./data/items.csv",
    :merchants     => "./data/merchants.csv",
    :invoices      => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions  => "./data/transactions.csv",
    :customers     => "./data/customers.csv"
  })
end
