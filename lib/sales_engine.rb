require 'csv'
require 'pry'
require 'time'
require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'

class SalesEngine

  attr_reader :merchants,
              :items,
              :invoices

  def initialize(data)
    @items = ItemRepository.new(self)
    @merchants = MerchantRepository.new(self)
    @invoices = InvoiceRepository.new(self)
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
      end
    end
    created
  end

end
