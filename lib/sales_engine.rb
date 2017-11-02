require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'

class SalesEngine


  attr_reader :items, :merchants, :invoices

  def initialize(items_file, merchants_file, invoice_file)
    @items = ItemRepository.new(items_file, self)
    @merchants = MerchantRepository.new(merchants_file, self)
    @invoices = InvoiceRepository.new(invoice_file, self)
  end

  def self.from_csv(files)
    items_file = create_elements(files[:items])
    merchants_file = create_elements(files[:merchants])
    invoice_file = create_elements(files[:invoices])
      SalesEngine.new(items_file, merchants_file, invoice_file)
  end

  def self.create_elements(file)
    CSV.readlines(file, headers: true, header_converters: :symbol) do |row|
      row
    end
  end

  def merchant(id)
    merchants.find_by_id(id)
  end

  def find_item(id)
    items.find_by_id(id)
  end

end
