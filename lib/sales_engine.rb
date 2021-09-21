# frozen_string_literal: true

require 'csv'
require_relative './item_repository'
require_relative './merchant_repository'
require_relative './items'
require_relative './merchants'
require_relative './invoice_repo'
require_relative './invoices'
require_relative './invoice_item'
require_relative './invoice_item_repo'
class SalesEngine
  attr_accessor :items,
                :merchants,
                :invoices,
                :invoice_items,

  def self.from_csv(paths)
    data = {}
    data[:items]     = create_obj_csv(paths[:items], Item)
    data[:merchants] = create_obj_csv(paths[:merchants], Merchant)
    data[:invoices]  = create_obj_csv(paths[:invoices], Invoice)
    data[:invoice_items] = create_obj_csv(paths[:invoice_items], InvoiceItem)
    SalesEngine.new(data)
  end

  def initialize(data)
    @items     = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    @invoices  = InvoiceRepository.new(data[:invoices])
    @invoice_items = InvoiceItemRepository.new(data[:invoice_items])
  end

  def self.create_obj_csv(locations, obj_type)
    objects = []
    CSV.foreach(locations, headers: true, header_converters: :symbol,
                           quote_char: '"', liberal_parsing: true) do |row|
      object = obj_type.new(row)
      objects << object
    end
    objects
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items)
  end
end
