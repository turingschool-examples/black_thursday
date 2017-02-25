require_relative 'invoice'
require 'csv'
require 'pry'
require 'bigdecimal'
require 'time'

class InvoiceRepository
	attr_reader :file, :invoices, :sales_engine_instance
	def initialize(file, sales_engine_instance)
		@file = file
		@sales_engine_instance = sales_engine_instance
		@invoices = Hash.new(0)
		invoice_maker
	end

	def open_contents
		CSV.open(file, headers: true, header_converters: :symbol)
	end

	def invoice_maker
		open_contents.each do |row|
    id = row[:id].to_i
		invoices[id] = Invoice.new({:id => id, :customer_id => row[:customer_id].to_i, :status => row[:status].to_sym,
		:created_at => Time.parse(row[:created_at].to_s), :updated_at => Time.parse(row[:updated_at]), :merchant_id => row[:merchant_id].to_i}, self)
		end
	end

	def all
		invoices.values
	end

	def find_by_id(id)
		invoices.has_key?(id) ? invoices[id] : nil
	end

  def find_all_by_customer_id
  end


  def find_all_by_merchant_id(id)
    merchant = all.find_all do |item|
      item.merchant_id == id
    end
    merchant
  end

	def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
