require_relative '../lib/invoice'
require 'csv'

class InvoiceRepository

  attr_reader :csv, :all

  def initialize(path, sales_engine = nil)
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
      @all << Invoice.new({ :id => line[:id],
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
    matches = @all.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(id)
    return nil if id.nil?
    matches = []
    matches = @all.find_all do |invoice|
      invoice.customer_id == id
    end
    matches
  end

  def find_all_by_merchant_id(id)
    return nil if id.nil?
    matches = []
    matches = @all.find_all do |invoice|
      invoice.merchant_id == id
    end
    matches
  end

  def find_all_by_status(status)
    return nil if status.nil?
    matches = []
    matches = @all.find_all do |invoice|
      invoice.status == status
    end
    matches
  end

end
