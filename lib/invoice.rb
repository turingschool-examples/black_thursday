require 'pry'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(column, parent = nil)
    @id = column.fetch(:id).to_i
    @customer_id = column.fetch(:customer_id).to_i
    @merchant_id = column.fetch(:merchant_id).to_i
    @status = column.fetch(:status).to_sym
    @created_at = Time.parse(column.fetch(:created_at))
    @updated_at = Time.parse(column.fetch(:updated_at))
    @invoice_repo = parent
  end

  def merchant
    merchant_id = self.merchant_id
    @invoice_repo.find_merchant_by_invoice_merch_id(merchant_id)
  end
end
