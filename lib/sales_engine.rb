require 'csv'
require 'pry'
require 'time'
require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'
require_relative './transaction_repository'
require_relative './invoice_item_repository'
# require_relative './customer_repository'

class SalesEngine

  attr_reader :merchants,
              :items,
              :invoices,
              :transactions,
              :invoice_items
              # :customers

  def initialize(data)
    @items = ItemRepository.new(self)
    @merchants = MerchantRepository.new(self)
    @invoices = InvoiceRepository.new(self)
    @transactions = TransactionRepository.new(self)
    @invoice_items = InvoiceItemRepository.new(self)
    # @customers = CustomerRepository.new(self)
  end


  def self.from_csv(input)
    created = SalesEngine.new(input)
    input.each_pair do |key, value|
      row = CSV.open value, headers: true, header_converters: :symbol
      case key
      when :items
        row.each do |data|
          created.items.add_data(data.to_hash)
        end
      when  :merchants
        row.each do |data|
          created.merchants.add_data(data.to_hash)
        end
      when :invoices
        row.each do |data|
          created.invoices.add_data(data.to_hash)
        end
      # when :transactions
      #   row.each do |data|
      #     created.transactions.add_data(data.to_hash)
      #   end
      # when :invoice_items
      #   row.each do |data|
      #     created.invoice_items.add_data(data.to_hash)
      #   end
      # when :customers
      #   row.each do |data|
      #     created.customers.add_data(data.to_hash)
      #   end
      end
    end
    created
  end

end
