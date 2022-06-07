require 'csv'
require_relative '../lib/invoice_item'
require './repositable'

class InvoiceItemRepository
  include Repositable
  attr_reader :file_path, :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

      if @file_path
        CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
        @all << InvoiceItem.new({
          :id => row[:id],
          :item_id => row[:item_id],
          :invoice_id => row[:invoice_id],
          :quantity => row[:quantity],
          :unit_price => row[:unit_price],
          :created_at => row[:created_at],
          :updated_at => row[:updated_at]
          })
      end
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |item|
      item.item_id.to_i == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |item|
      item.invoice_id.to_i == invoice_id
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    @all << InvoiceItem.new({
      :id => attributes[:id],
      :item_id => attributes[:item_id],
      :invoice_id => attributes[:invoice_id],
      :quantity => attributes[:quantity],
      :unit_price => attributes[:unit_price],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]
      })
  end
end
