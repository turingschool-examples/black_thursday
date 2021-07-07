# Create a repository of Item objects
#   - makes all item objects
#   - uses finder & CRUD modules

require 'pry'
require_relative 'item'
require_relative 'csv_parse'
require './lib/invoice'

class InvoiceRepository
  include Finder

  attr_reader :all,
              :invoices

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @invoices = []
    make_invoices
    @all = invoices
  end

  def make_invoices
    @csv.each { |key, value|
      hash = make_hash(key, value)
      invoice = Invoice.new(hash)
      @invoices << invoice
    }
    @invoices.flatten!
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end

end


