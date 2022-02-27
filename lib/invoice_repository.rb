require 'csv'
require 'date'
require_relative 'invoice'
require_relative 'item'
require_relative 'sales_module'

class InvoiceRepository
  attr_reader :all, :invoice
  def initialize(csv)
    @all = Invoice.read_file(csv)
  end

  def find_by_id(id)
    @all.find{|invoice| invoice.id == id}
  end

  def find_all_by_merchant_id(merchant_id)
    found = []
    found << @all.find_all{|item| item.merchant_id == merchant_id}
    found.flatten
  end

  def find_all_by_customer_id(customer_id)
    found = []
    found << @all.find_all{|item| item.customer_id == customer_id}
    found.flatten
  end

  def find_all_by_status(status)
    found = []
    found << @all.find_all{|item| item.status == status}
    found.flatten
  end

  def create(data)
    new_item = Invoice.new({
      id: (@all[-1].id + 1),
      customer_id: data[:customer_id],
      merchant_id: data[:merchant_id],
      status: data[:status],
      created_at: Date.today.to_s,
      updated_at: Date.today.to_s})
      @all << new_item
  end

  def update(id, status)
    updated_item = @all.find{|item| item.id == id}
    updated_item.status = status
    updated_item.updated_at = Date.today.to_s
  end



  include SalesModule


end
