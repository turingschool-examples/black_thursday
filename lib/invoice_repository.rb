# frozen_string_literal: true

require_relative './invoice'
require_relative './repository'
require 'pry'
# ./lib/invoice_repository.rb
class InvoiceRepository
  
  include Repository
  attr_reader :invoices
  def initialize
    @invoices = []
  end

  def all 
    @invoices
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"  
  end

  def find_all_by_status(search_status)
    @invoices.find_all do |invoice| 
      invoice.status.downcase == search_status.downcase
    end
  end

  def find_all_by_merchant_id(search_merchant_id)
    @invoices.find_all { |invoice| invoice.merchant_id == search_merchant_id }
  end

  def find_all_by_customer_id(search_customer_id)
    @invoices.find_all { |invoice| invoice.customer_id == search_customer_id }
  end

  def update(id, attributes)
    invoice_to_update = find_by_id(id)
    unless invoice_to_update.nil?
      invoice_to_update.status = attributes[:status] unless attributes[:status].nil?
      invoice_to_update.updated_at = Time.now

    end
  end

  def create(attributes)
    @invoices << Invoice.new(attributes)
  end
  
  def number_of_merchants
    group_invoices_by_merchant_id.keys.count
  end

  def group_invoices_by_merchant_id
    @invoices.group_by { |invoice| invoice.merchant_id }
  end

  def average_invoices_per_merchant
    (@invoices.size / number_of_merchants.to_f).round(2)
  end

end
