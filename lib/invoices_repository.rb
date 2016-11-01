require_relative '../lib/invoices'
require 'csv'

class InvoiceRepository

  attr_reader :csv, :all

  def initialize(path)
    csv_load(path)
  end

  def csv_path(path)
    @csv = CSV.open path, headers: true, header_converters: :symbol
  end

  def all
    @all = []
    @all = @csv.collect { |line| Invoices.new(line) }
    return @all
  end

  def find_by_id
    #returns either nil or an instance of Invoice with a matchin ID
  end

  def find_all_by_customer_id
    #returns either [] of one of more matches which hace a matching customer ID
  end

  def find_all_by_merchant_id
    #returns either [] or one of more matches which have a matching merchant ID
  end

  def find_all_by_status
    #returns either [] or one or more matches which have a matching status
  end

end
