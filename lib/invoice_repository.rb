require 'pry'

require_relative 'finderclass'

require_relative 'invoice'


class InvoiceRepository

  attr_reader :all

  def initialize(data)
    @data = data
    @invoices = []
    make_invoices
    @all = @invoices
  end

  def make_invoices(data = @data)
    data.each { |key, value|
      hash = make_hash(key, value)
      invoice = Invoice.new(hash)
      @invoices << invoice
    }
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end


  # --- Spec Harness Requirement ---

  # TO DO - TEST ME
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end


  # --- Find By ---

  def find_by_id(id)
    FinderClass.find_by(all, :id, id)
  end

  def find_all_by_customer_id(customer_id)
    FinderClass.find_all_by(all, :customer_id, customer_id)
  end

  def find_all_by_merchant_id(merchant_id)
    FinderClass.find_all_by(all, :merchant_id, merchant_id)
  end

  def find_all_by_status(status)
    FinderClass.find_all_by(all, :status, status)
  end


  # --- CRUD ---

  def create(hash)
    last = FinderClass.find_max(all, :id)
    new_id = last.id + 1
    hash[:id] = new_id
    invoice = Invoice.new(hash)
    @invoices << invoice
    return invoice
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    invoice.make_updates(attributes) if invoice
  end

  def delete(id)
    @invoices.delete_if{ |invoice| invoice.id == id }
  end




end
