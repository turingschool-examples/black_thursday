require 'time'
require 'pry'
require_relative '../modules/traversal'
# This is the merchant class
class Merchant
  include Traversal

  attr_reader :id, :name, :parent, :created_at
  def initialize(hash, parent = nil)
    @id         = hash[:id].to_i
    @name       = hash[:name]
    @created_at = Time.parse(hash[:created_at])
    @parent     = parent
  end

  def items
    traverse('find_items_by_merchant_id', id)
  end

  def invoices
    traverse('find_invoices_by_merchant_id', id)
  end

  def invoice_items
    invoices.map do |invoice|
      traverse('find_invoice_items', invoice.id)
    end.flatten
  end

  def customers
    traverse('find_customers_by_merchant_id', id)
  end
end
