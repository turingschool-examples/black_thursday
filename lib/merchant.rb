require 'time'
require 'pry'
require_relative 'traversal'
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
    traverse('merchant items', id)
  end

  def invoices
    traverse('merchant invoices', id)
  end

  def invoice_items
    invoices.map do |invoice|
      traverse('merchant invoice items', invoice.id)
    end.flatten
  end

  def customers
    traverse('merchant customers', id)
  end
end
