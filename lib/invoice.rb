require 'time'

class Invoice

  def initialize(sales_engine, invoice_info_hash)
    @sales_engine = sales_engine
    @id = invoice_info_hash[:id]
    @customer_id = invoice_info_hash[:customer_id]
    @merchant_id = invoice_info_hash[:merchant_id]
    @status = invoice_info_hash[:status]
    @created_at = invoice_info_hash[:created_at]
    @updated_at = invoice_info_hash[:updated_at]
  end

  def id
    @id.nil? ? nil : @id.to_i
  end

  def customer_id
    @customer_id.nil? ? @customer_id : @customer_id.to_i
  end

  def merchant_id
    @merchant_id.nil? ? @merchant_id : @merchant_id.to_i
  end

  def status
    @status.nil? ? @status : @status.to_sym
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchant
    @sales_engine.merchants.find_by_id(merchant_id)
  end

  def inspect
    "  id: #{id}
    customer id: #{customer_id}
    merchant id: #{merchant_id}
    status: #{status}
    created at: #{@created_at}
    updated at: #{@updated_at}"
  end

end
