require 'CSV'
require_relative './cleaner.rb'
require_relative './invoice.rb'


class InvoiceRepository
  attr_reader :invoices

  def initialize(file = './data/invoices.csv', engine)
    @engine = engine
    @file = file
    @invoices = []
    @data = CSV.open(@file, headers: true, header_converters: :symbol)
    build_invoices
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def build_invoices
    @data.each do |invoice|
      @invoices << Invoice.new({:id => invoice[:id].to_i,
                :customer_id  => invoice[:customer_id],
                :mercahnt_id  => invoice[:merchant_id],
                :status => invoice[:status],
                :created_at  => Time.now,
                :updated_at  => Time.now}, self)
    end
    @invoices
  end
end
