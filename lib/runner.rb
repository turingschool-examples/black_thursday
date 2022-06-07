require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

merchant_repository = MerchantRepository.new
item_repository = ItemRepository.new
invoice_repository = InvoiceRepository.new

merchant_repository.find_by_id(source)
item_repository.find_by_id(source)
invoice_repository.find_by_id(source)

merchant_repository.find_by_name(source)
item_repository.find_by_name(source)
invoice_repository.find_by_name(source)

merchant_repository.delete(source)
item_repository.delete(source)
invoice_repository.delete(source)
