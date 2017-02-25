require 'csv'
require 'time'
require_relative './invoice'

class InvoiceRepository
  attr_accessor :invoices_array
  attr_reader :contents, :engine

  def initialize(path, engine = '')
    @invoices_path = path
    @invoices_array = []
    @engine = engine
    pull_csv
    parse_csv
  end

  def pull_csv
    @contents = CSV.open @invoices_path, headers: true, header_converters: :symbol
  end

  def parse_csv
    @contents.each do |row|
      invoices_array << Invoice.new({
      :id          => row[:id].to_i,
      :customer_id => row[:customer_id].to_i,
      :merchant_id => row[:merchant_id].to_i,
      :status      => row[:status].to_sym,
      :created_at  => Time.parse(row[:created_at]),
      :updated_at  => Time.parse(row[:updated_at])
      }, self)
    end
  end

  def all
    invoices_array
  end

  def find_by_id(find_id)
    invoices_array.find do |instance|
      instance.id == find_id
    end
  end

  def find_all_by_customer_id(find_id)
    invoices_array.find_all do |instance|
      instance.customer_id == find_id
    end
  end

  def find_all_by_merchant_id(find_id)
    invoices_array.find_all do |instance|
      instance.merchant_id == find_id
    end
  end

  def find_all_by_status(find_status)
    invoices_array.find_all do |instance|
      instance.status.downcase == find_status.downcase
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
