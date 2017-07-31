require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id,
              :status, :created_at, :updated_at, :repo,
              :parent

  def initialize(params, repo=nil)
    @id          = params[:id].to_i
    @customer_id = params[:customer_id].to_i
    @merchant_id = params[:merchant_id].to_i
    @status      = params[:status].to_sym
    @created_at  = Time.parse(params[:created_at].to_s)
    @updated_at  = Time.parse(params[:updated_at].to_s)
    @parent      = repo
  end

  def merchant
    parent.merchant_invoice(merchant_id)
  end

  def items
    parent.items_from_invoice(id)
  end

  def transactions
    parent.invoice_transactions(id)
  end

  def customer
    parent.customer_invocies(customer_id)
  end

  def is_paid_in_full?
    transactions.any? {|transaction| transaction.result == "success"}
  end

  def total
    parent.total(id)
  end
end
