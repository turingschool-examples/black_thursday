require_relative'invoice_item_repository'
require_relative'transaction_repository'
require_relative'merchant_repository'
require_relative'customer_repository'
require_relative'invoice_repository'
require_relative'item_repository'
require_relative'inspect'

class SalesEngine
	include Inspect

	def self.from_csv(data_paths)
    @items = ItemRepository.new(data_paths[:items], self)
    @merchants = MerchantRepository.new(data_paths[:merchants], self)
		@invoices = InvoiceRepository.new(data_paths[:invoices], self)
		@invoice_items = InvoiceItemRepository.new(data_paths[:invoice_items], self)
		@transactions = TransactionRepository.new(data_paths[:transactions], self)
		@customers = CustomerRepository.new(data_paths[:customers], self)
		self
	end

	def self.items
		@items
	end

	def self.merchants
		@merchants
	end

	def self.invoices
		@invoices
	end

	def self.invoice_items
		@invoice_items
	end

	def self.transactions
		@transactions
	end

	def self.customers
		@customers
	end

end