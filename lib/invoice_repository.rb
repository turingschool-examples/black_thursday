# frozen_string_literal: true

require 'csv'
require 'time'
require_relative 'invoice'
require_relative 'csv_readable'

class InvoiceRepository
  include CSV_readable

  attr_reader :all

  def initialize(path)
    @all = generate(path)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def generate(path)
    rows = read_csv(path)

    rows.map do |row|
      Invoice.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |row|
      row.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |row|
      row.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |row|
      row.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |row|
      row.status == status
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @all << Invoice.new(attributes)
  end

  def update(id, attributes)
    invoice_to_update = find_by_id(id)
    if attributes[:status] != nil
      invoice_to_update.update_status(attributes[:status].to_sym)
      invoice_to_update.update_updated_at
    end
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end
