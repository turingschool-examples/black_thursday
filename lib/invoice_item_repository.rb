require_relative 'reposable'
require_relative './invoice_item'

class InvoiceItemRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_all_by_item_id(item_id)
    all.find_all do |invoice_item|
      item_id.to_i == invoice_item.item_id.to_i
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |invoice_item|
      invoice_id.to_i == invoice_item.invoice_id.to_i
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

  def update(id,attributes)
    if find_by_id(id) == nil 
      return
    else
    find_by_id(id).updated_at = Time.now
    attributes.each do |att,val|
      case att
      when :quantity
        find_by_id(id).quantity = val
      when :unit_price
        find_by_id(id).unit_price = val
      end
    end
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end