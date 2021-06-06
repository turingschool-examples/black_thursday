require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'

class SalesEngine

  def initialize(paths)
    @item_repo = ItemRepository.new(paths[:items], self)
    @merchant_repo = MerchantRepository.new(paths[:merchants], self)
    @invoice_repo = InvoiceRepository.new(paths[:invoices], self)
    @invoice_item_repo = InvoiceItemRepository.new(paths[:invoice_items], self)
    @transaction_repo = TransactionRepository.new(paths[:transactions], self)
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

  def invoice_items
    @invoice_item_repo
  end

  def transactions
    @transaction_repo
  end

  def analyst
    SalesAnalyst.new(@item_repo, @merchant_repo, @invoice_repo, self)
  end

end
