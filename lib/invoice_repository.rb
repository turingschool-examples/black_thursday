require 'csv'
require './lib/invoice'
require './lib/repository_aide'
require './lib/time_helper'

class InvoiceRepository
  include RepositoryAide
  include TimeHelper
  attr_reader :repository, :merchant_ids

  def initialize(file)
    @repository = read_csv(file).map do |invoice|
          Invoice.new({
            :id => invoice[:id].to_i,
            :customer_id => invoice[:customer_id],
            :merchant_id => invoice[:merchant_id],
            :status => invoice[:status],
            :created_at => create_time(invoice[:created_at]),
            :updated_at => invoice[:updated_at]
            })
          end
    group
  end

  def group
    @ids = @repository.group_by {|invoice| invoice.id}
    @customer_ids = @repository.group_by {|invoice| invoice.customer_id}
    @merchant_ids = @repository.group_by {|invoice| invoice.merchant_id}
    @invoice_status = @repository.group_by {|invoice| invoice.status}
    @day_invoices = @repository.group_by {|invoice| invoice.created_at.wday}
  end

  def find_all_by_customer_id(id)
    find(@customer_ids, id)
  end

  def find_all_by_merchant_id(id)
    find(@merchant_ids, id)
  end

  def find_all_by_status(status)
    find(@invoice_status, status)
  end

  def create(attributes)
    invoice = Invoice.new(create_attribute_hash(attributes))
    @repository << invoice
    invoice
  end

  def update(id, attribute)
    invoice = find_by_id(id)
    invoice.status = attribute
    invoice.updated_at = Time.now
  end
end
