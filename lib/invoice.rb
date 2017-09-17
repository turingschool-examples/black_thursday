require 'time'

class Invoice
  attr_reader :invoice, :invoice_item_repo

  def initialize(invoice, invoice_item_repo)
    @invoice = invoice
    @invoice_item_repo = invoice_item_repo
  end

  def id
    invoice.fectch(:id).to_i
  end

  def customer_id
    invoice.fectch(:customer_id).to_i
  end

  def merchant_id
    invoice.fectch(:merchant_id).to_i
  end

  def status
    invoice.fetch(:status)
  end

  def created_at
    Time.parse(item.fetch(:created_at))
  end

  def updated_at
    Time.parse(item.fetch(:updated_at))
  end
