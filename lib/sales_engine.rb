# frozen_string_literal: true

require_relative 'file_loader.rb'
require_relative 'sales_analyst.rb'
require_relative 'item_repository.rb'
require_relative 'merchant_repository.rb'
require_relative 'connections.rb'
require_relative 'invoice_repository.rb'
require_relative 'invoice_item_repository.rb'
require_relative 'transaction_repository.rb'
require_relative 'customer_repository.rb'
# require_relative '../data/items.csv'
# require_relative '../data/merchants.csv'

# This class is the heart of the project. It contains references to the item and
# merchant repositories, which contain the references to the items and
# merchants.
class SalesEngine
  include FileLoader
  include Connections

  attr_reader :load_path
  def initialize(load_path)
    @load_path = load_path
  end

  def analyst
    SalesAnalyst.new(self)
  end

  # Here we create a new SalesEngine object with the load paths specified in the
  # spec, or any other load path we want. We load from CSV files, hence the
  # name. The paths will be sent as a hash, which will be hadled by the
  # load_path method form the FileLoader module. The new SalesEngine object
  # is instantiated this way
  def self.from_csv(load_path)
    new(load_path)
  end

  # This conditional checks to see if @items has been defined as a new
  # repository and if it has not been defined it runs the load_file method
  # from the FileLoader module that loads in the CSV.
  def items
    @items ||= ItemRepository.new(load_file(load_path[:items]), self)
  end

  def merchants
    @merchants ||= MerchantRepository.new(
      load_file(load_path[:merchants]), self
    )
  end

  def invoices
    @invoices ||= InvoiceRepository.new(load_file(load_path[:invoices]), self)
    require "pry"; binding.pry
  end

  def transactions
    @transactions ||= TransactionRepository.new(
      load_file(load_path[:transactions]), self
    )
  end

  def customers
    @customers ||= CustomerRepository.new(
      load_file(load_path[:customers]), self
    )
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(
      load_file(load_path[:invoice_items]), self
    )
  end
end
