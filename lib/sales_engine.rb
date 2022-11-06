require 'csv'
require_relative './merchant'
require_relative './merchant_repository'
require_relative './item'
require_relative './item_repository'
require_relative './invoice'
require_relative './invoice_repository'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(merchant_repo, item_repo, invoice_repo)
    @merchants = merchant_repo
    @items = item_repo
    @invoices = invoice_repo
  end

  def self.generate_and_add_to_repo(class_to_create, repo, csv_data)
    CSV.foreach(csv_data, headers: true, header_converters: :symbol) do |row|
      repo.add_to_repo(class_to_create.new(row))
    end
  end

  def self.from_csv(data)
    mr = MerchantRepository.new
    ir = ItemRepository.new
    invr = InvoiceRepository.new

    generate_and_add_to_repo(Item, ir, data[:items])
    generate_and_add_to_repo(Merchant, mr, data[:merchants])
    generate_and_add_to_repo(Invoice, invr, data[:invoices])

    SalesEngine.new(mr, ir, invr)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices)
  end

end
