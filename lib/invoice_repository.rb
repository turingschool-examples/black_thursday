require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'csv'
require 'pry'
require_relative '../lib/invoice'

class InvoiceRepository

  attr_reader :file_path,
              :contents

  def initialize(file_path, parent)
    @file_path = file_path
    @parent    = parent
    @contents  = load_library
  end

  def load_library
    library = {}
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      h = Hash[row]
      d = h[:id]
      library[d.to_i] = Invoice.new(h, self)
    end
    @contents = library
  end

  def all
    invoices = contents.map { |k,v| v }
  end

  def find_by_id(id)
    i = contents.keys.find { |k| k == id }
    x = contents[i]
  end

  def find_all_by_customer_id(c_id)
    ci = contents.values.find_all { |v| v.customer_id == c_id }
  end

  def find_all_by_merchant_id(m_id)
    mi = contents.values.find_all { |v| v.merchant_id == m_id }
  end

  def find_all_by_status(i_status)
    s = contents.values.find_all { |v| v.status == i_status }
  end

end
