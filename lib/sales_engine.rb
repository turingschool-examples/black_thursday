require 'csv'
require_relative './merchant'
require_relative './merchant_repository'
require_relative './item'
require_relative './item_repository'
require_relative './invoice'
require_relative './invoice_repository'
require_relative './customer'
require_relative './customer_repository'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :customers

  def initialize(merchants, items, invoices, customers)
    @merchants = merchants
    @items = items
    @invoices = invoices
    @customers = customers 
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
    cr = CustomerRepository.new

    generate_and_add_to_repo(Item, ir, data[:items])
    generate_and_add_to_repo(Merchant, mr, data[:merchants])
    generate_and_add_to_repo(Invoice, invr, data[:invoices])
    generate_and_add_to_repo(Customer, cr, data[:customers])

    SalesEngine.new(mr, ir, invr, cr)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @customers)
  end
end
