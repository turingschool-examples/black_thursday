require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class RepoBuilder
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def build_repos(arry_objects)
    [ MerchantRepository.new(arry_objects[:merchant], @sales_engine),
      ItemRepository.new(arry_objects[:item], @sales_engine),
      InvoiceRepository.new(arry_objects[:invoice], @sales_engine),
      InvoiceItemRepository.new(arry_objects[:invoice_item], @sales_engine),
      TransactionRepository.new(arry_objects[:transaction], @sales_engine),
      CustomerRepository.new(arry_objects[:customer], @sales_engine) ]
  end
end
