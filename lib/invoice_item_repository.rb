require_relative 'reposable'
require_relative './invoice_item'

class InvoiceItemRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_by_id(id)
    all.find do |invoice_item|
      id == invoice_item.id
    end
  end

  def find_all_by_item_id(item_id)
    all.find_all do |invoice_item|
      item_id == invoice_item.item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |invoice_item|
      invoice_id == invoice_item.invoice_id
    end
  end

  def create(attributes)
    all << InvoiceItem.new({  
      :id           => next_id,
      :item_id      => attributes[:item_id],
      :invoice_id   => attributes[:invoice_id],
      :quantity     => attributes[:quantity],
      :unit_price   => attributes[:unit_price],
      :created_at   => Time.parse(attributes[:created_at].to_s),
      :updated_at   => Time.parse(attributes[:updated_at].to_s)
    })
  end

  def inspect
    "#<#{self.class} #{@internal_list.size} rows>"
  end
end