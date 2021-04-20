require 'bigdecimal'
require 'time'

class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :created_at,
                :invoice_repo

  attr_accessor :status,
                :updated_at

  def initialize(row, invoice_repo)
    @id = (row[:id]).to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = (row[:merchant_id]).to_i
    @status = (row[:status]).to_sym
    @created_at = Time.parse(row[:created_at].to_s)
    @updated_at = Time.parse(row[:updated_at].to_s)
    @invoice_repo = invoice_repo
  end

  def update_time_stamp
    @updated_at = Time.now
  end

  def day_created
    @created_at.strftime('%A').capitalize
  end
#####ZT here
  def total_value
    @invoice_items.each_with_object([]) do |invoice_item, array|
      if invoice_item.invoice_id == invoice_id
        array << invoice_item.quantity * invoice_item.unit_price
      end
    end.sum
  end
## OR ##
  def invoice_total_hash
    @invoice_items.each_with_object(Hash.new(0)) do |invoice_item, hash|
      hash[invoice_item.invoice_id] += invoice_item.quantity * invoice_item.unit_price
    end
  end
## I dont think this one will work.
  def all_invoice_items
    @invoice_items.each_with_object([]) do |invoice_item, array|
      if invoice_item.invoice_id == invoice_item.invoice_id
        array << invoice_item.id 
      end
    end
  end

  def paid_in_full_invoices
    @transactions.each_with_object([]) do |transaction, array|
      if transaction.result == :success
        array << invoice.id
      end
    end
  end

  #total_value
  #items
  #paid_in_fill?

end
