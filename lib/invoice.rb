require 'bigdecimal'
require 'pry'
require 'time'

class Invoice
attr_reader :invoice_info, :inv_parent
	def initialize(invoice_info, inv_parent)
		@invoice_info = invoice_info
		@inv_parent = inv_parent
	end

	def id
		invoice_info[:id]
	end

  def customer_id
    invoice_info[:customer_id]
  end

  def status
    invoice_info[:status]
  end

	def created_at
		invoice_info[:created_at]
	end

	def updated_at
		invoice_info[:updated_at]
	end

	def merchant_id
		invoice_info[:merchant_id]
	end

  def merchant
    inv_parent.sales_engine_instance.merchants.find_by_id(merchant_id)
  end
end
