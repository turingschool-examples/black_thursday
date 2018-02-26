require 'time'
require_relative 'traversal'
# this is a customer class
class Customer
  include Traversal

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end

  def merchants
    traverse('customer merchants', id)
  end

  def fully_paid_invoices
    traverse('fully paid invoices', id)
  end

  def all_invoices
    traverse('all invoices', id)
  end

  def items
    fully_paid_invoices.map(&:items).flatten
  end

  def fully_paid_invoice_items
    fully_paid_invoices.map(&:invoice_items).flatten
  end

  def all_invoice_items
    all_invoices.map(&:invoice_items).flatten
  end
end
