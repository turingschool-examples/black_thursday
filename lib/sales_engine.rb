require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require 'pry'
require 'csv'


class SalesEngine
  # attr_reader :csv_repo

  def initialize(csv_repo)
    @csv_repo = csv_repo
  end

  def self.from_csv(file_path)
    @csv_files = {}
    file_path.each do |key, value|
      csv_file_object = CSV.open value, headers: true, header_converters: :symbol
      @csv_files[key] = csv_file_object.map { |row| row.to_h }
    end
    SalesEngine.new(@csv_files)
  end

  def merchants
    # save as an ivar?
    MerchantRepository.new(@csv_repo[:merchants])
  end

  def items
    ItemRepository.new(@csv_repo[:items])
  end

  def invoices
    InvoiceRepository.new(@csv_repo[:invoices])
  end
end

if __FILE__ == $0
sales_engine = SalesEngine.from_csv({:merchants => './data/merchants.csv',
                                     :items     => './data/items.csv',
                                     :invoices  => './data/invoices.csv'})
merch_repo = sales_engine.merchants
merchant = merch_repo.find_by_name("CJsDecor")
puts merchant

item_repo = sales_engine.items
item = item_repo.find_by_name("510+ RealPush Icon Set")
puts item

invoice_repo = sales_engine.invoices
invoice = invoice_repo.find_by_id(1)
puts invoice
end
