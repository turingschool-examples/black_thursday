# frozen_string_literal: true

require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require 'pry'

# sales engine
class SalesEngine
  def self.from_csv(path = nil)
    new(path).tap(&:populate_repositories)
  end

  def initialize(path)
    @path = path
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def populate_repositories
    items.populate
    merchants.populate
    invoices.populate
  end

  def items
    @items ||= ItemRepository.new(data_for(:items), self)
  end

  def merchants
    @merchants ||= MerchantRepository.new(data_for(:merchants), self)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(data_for(:invoices), self)
  end

  def path
    @path || filepath
  end

  def filepath
    {
      items:     './data/items.csv',
      merchants: './data/merchants.csv',
      invoices:  './data/invoices.csv',
    }
  end

  def data_for(type)
    CSV.read(path.fetch(type), headers: true, header_converters: :symbol)
  end

  def pass_item_id_to_item_repo(id)
    @items.find_all_by_merchant_id(id)
  end
end
