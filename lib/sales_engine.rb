require "csv"
require "merchant"
require "item"
require "invoice"
require "customer"
require "sales_analyst"
require "pry"

class SalesEngine
  attr_reader :merchants_repo, :items_repo, :invoices_repo, :customers_repo, :analyst
  def initialize(data)
    @items_repo = ItemRepository.new(data[:items])
    @merchants_repo = MerchantRepository.new(data[:merchants])
    @invoices_repo = InvoiceRepository.new(data[:invoices])
    @customers_repo = CustomerRepository.new(data[:customers])
    # @merchants_instances_array = []
    # @items_instances_array = []
    # @invoices_instances_array = []
    @analyst = SalesAnalyst.new(@items_repo, @merchants_repo, @invoices_repo, @customers_repo)

  end

  def self.from_csv(argument)
    # items =     ItemRepository.new(argument[:items])
    # merchants = MerchantRepository.new(argument[:merchants])
    # invoices = CSV.read(argument[:invoices], headers: true, header_converters: :symbol)
    SalesEngine.new(argument)
    # SalesAnalyst.new(items, merchants, invoices)
  end

  # def analyst
  #   SalesAnalyst.new(items_instanciator, merchants_instanciator, invoices_instanciator)
  # end
  #
  # def items
  #   @items_data
  # end
  #
  # def merchants
  #   @merchants_data
  # end
  #
  # def invoices
  #   @invoices_data
  # end
  #
  # def items_instanciator
  #   items_instances_array = []
  #   items.by_row!.each do |row|
  #     items_instances_array << Item.new(row)
  #   end
  #   ItemRepository.new(items_instances_array)
  # end

  # def merchants_instanciator
  #   merchants.by_row!.each do |row|
  #     merchants_instances_array << Merchant.new(row)
  #   end
  #   MerchantRepository.new(merchants_instances_array)
  # end

  # def invoices_instanciator
  #   invoices.by_row!.each do |row|
  #     invoices_instances_array << Invoice.new(row)
  #   end
  #   InvoiceRepository.new(invoices_instances_array)
  # end

end
