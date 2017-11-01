require './lib/item_repository'
require './lib/merchant_repository'
# require './lib/merchant_repo'

class SalesEngine

  attr_reader :item_repository, :merchant_repository

  def initialize(items_file, merchants_file)
    @item_repository = ItemRepository.new(items_file, self)
    @merchant_repository = MerchantRepository.new(merchants_file, self)
    @invoice_repository = InvoiceRepository.new(invoice_file, self)
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
    merchant_repository.find_by_id(id)
  end

end
