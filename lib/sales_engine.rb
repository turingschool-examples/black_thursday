require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

class SalesEngine

  def initialize(paths)
    @item_repo = ItemRepository.new(paths[:items], self)
    @merchant_repo = MerchantRepository.new(paths[:merchants], self)
    @invoice_repo = InvoiceRepository.new(paths[:invoices], self)
  end

  def self.from_csv(paths)
    new(paths)
  end

  def items
    @item_repo
  end

  def merchants
    @merchant_repo
  end

  def invoices
    @invoice_repo
  end

  def analyst
    SalesAnalyst.new(@item_repo, @merchant_repo, @invoice_repo, self)
  end

end
