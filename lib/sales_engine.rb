require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'csv_parser'

class SalesEngine

  extend CSV_parser

  def self.from_csv(files)
    @merchant_repo = create_merchant_repository(files)
    @item_repo = create_item_repository(files)
    @invoice_repo = create_invoice_repository(files)
    self
  end

  def self.create_item_repository(files)
    if files.include?(:items)
      ItemRepository.new(item_csv_parse(files[:items]))
    end
  end

  def self.items
    @item_repo
  end

  def self.create_merchant_repository(files)
    if files.include?(:merchants)
      MerchantRepository.new(merchant_csv_parse(files[:merchants]))
    end
  end

  def self.merchants
    @merchant_repo
  end

  def self.create_invoice_repository(files)
    if files.include?(:invoices)
      InvoiceRepository.new(invoice_csv_parse(files[:invoices]))
    end
  end

  def self.invoices
    @invoice_repo
  end

end