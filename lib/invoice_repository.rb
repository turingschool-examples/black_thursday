# frozen_string_literal: true

require_relative 'invoice.rb'
# This is the invoice repository.
class InvoiceRepository
  include RepositoryHelper
  attr_reader :repository,
              :customer_id,
              :id,
              :merchant_id,
              :created_at,
              :updated_at
  def initialize(invoices, parent)
    @repository = invoices.map { |invoice| Invoice.new(invoice, self) }
    @parent = parent
    build_hash_table
    build_status_hash_table
  end

  def build_hash_table
    @id = @repository.group_by(&:id)
    @customer_id = @repository.group_by(&:customer_id)
    @merchant_id = @repository.group_by(&:merchant_id)
    @created_at = @repository.group_by(&:created_at)
    @updated_at = @repository.group_by(&:updated_at)
  end

  def build_status_hash_table
    @successful_status = @repository.group_by(&:is_paid_in_full?)
    @failed_status = @repository.group_by do |invoice|
      !invoice.is_paid_in_full?
    end
  end

  def find_all_by_status(invoice_status)
    @repository.find_all do |invoice|
      invoice.status == invoice_status
    end
  end

  def create(attributes)
    attributes[:id] = (@id.keys.last + 1).to_s
    @repository << Invoice.new(attributes, self)
    build_hash_table
  end

  def delete(id)
    invoice_to_delete = find_by_id(id)
    @repository.delete(invoice_to_delete)
    build_hash_table
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    unchangeable_keys = %i[id created_at]
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      if invoice.invoice_specs.keys.include?(key)
        invoice.invoice_specs[key] = value
        invoice.invoice_specs[:updated_at] = Time.now
      end
    end
    build_hash_table
  end

  def sort_by_invoice_totals
    @repository.sort_by(&:total)
  end

  def find_merchant_by_merchant_id(merchant_id)
    @parent.find_merchant_by_merchant_id(merchant_id)
  end

  def find_transaction_by_invoice_id(invoice_id)
    @parent.find_transaction_by_invoice_id(invoice_id)
  end

  def find_all_items_by_merchant_id(merchant_id)
    @parent.find_all_items_by_merchant_id(merchant_id)
  end

  def find_customer_by_customer_id(customer_id)
    @parent.find_customer_by_customer_id(customer_id)
  end

  def find_all_items_by_invoice_id(invoice_id)
    @parent.find_all_items_by_invoice_id(invoice_id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    @parent.find_all_invoice_items_by_invoice_id(id)
  end

  def find_all_transactions_by_invoice_id(invoice_id)
    @parent.find_all_transactions_by_invoice_id(invoice_id)
  end

  def inspect
    "<#{self.class} #{@repository.size} rows>"
  end
end
