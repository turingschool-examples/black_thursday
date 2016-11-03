require_relative '../lib/invoices'
require 'csv'

class InvoiceRepository

  attr_reader :csv, :all

  def initialize(path, sales_engine)
    csv_path(path)
    load_all
    @parent = sales_engine
  end

  def csv_path(path)
    @csv = CSV.open path, headers: true, header_converters: :symbol
  end

  def load_all
    @all = []
    @csv.each do |line|
      @all << Invoice.new({ :id => line[:id].to_i,
                            :customer_id => line[:customer_id],
                            :merchant_id => line[:merchant_id],
                            :status => line[:status],
                            :created_at => line[:created_at],
                            :updated_at => line[:updated_at]
                            }, self)
    end
    return @all
  end

  def find_by_id(id)
    return nil if id.nil?
    matches = @all.find do |invoice|
      invoice.id == id
    end
    matches
    #returns either nil or an instance of Invoice with a matchin ID
  end

  def find_all_by_customer_id(customer_id)
    #returns either [] of one of more matches which hace a matching customer ID
  end

  def find_all_by_merchant_id
    #returns either [] or one of more matches which have a matching merchant ID
  end

  def find_all_by_status
    #returns either [] or one or more matches which have a matching status
  end

end
