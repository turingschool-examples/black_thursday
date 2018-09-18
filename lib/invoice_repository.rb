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

  def make_invoices
    @data.each { |key, value|
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
    "#<#{self.class} #{@merchants.size} rows>"
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


end
