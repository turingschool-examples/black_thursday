require_relative './merchant_repository'
require_relative './item_repository'
require_relative './merchant'
require_relative './item'
require_relative './invoice_repository'
require_relative './sales_analyst'
require_relative './csv_reader'

class SalesEngine
  attr_reader :merchants, :items, :invoices

  def initialize(repositories)
    @merchants = repositories[:merchants] if repositories.has_key?(:merchants)
    @items = repositories[:items] if repositories.has_key?(:items)
    @invoices = repositories[:invoices] if repositories.has_key?(:invoices)
  end

  def self.from_csv(file_paths)
    if file_paths.has_key?(:merchants)
      mr = MerchantRepository.new
      merchants = CSVReader.parse_merchants(mr, file_paths[:merchants])
    end
    if file_paths.has_key?(:items)
      ir = ItemRepository.new
      items = CSVReader.parse_items(ir, file_paths[:items])
    end
    if file_paths.has_key?(:items)
      inr = InvoiceRepository.new
      invoices = CSVReader.parse_invoices(inr, file_path[:invoices])
    end

    SalesEngine.new({merchants: merchants, items: items, invoices: invoices})
  end

  def analyst
    SalesAnalyst.new({merchants: @merchants, items: @items, invoices: @invoices})
  end
end
