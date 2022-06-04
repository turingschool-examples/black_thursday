require 'helper'
require './lib/repository_methods_module'
require 'pry'

class InvoiceRepository
  include RepositoryMethods
  attr_reader :all

  def initialize(file_path)
    @all = make_repo(file_path)
  end

  def find_all_by_customer_id(id_number)
    @all.select {|invoice| invoice.customer_id == id_number}
  end

  def find_all_by_status(status)
    @all.select {|invoice| invoice.status == status}
  end

  def create(invoice_attributes)
    @all.push(Invoice.new({
      :id          => max_id + 1,
      :customer_id => invoice_attributes[:customer_id],
      :merchant_id => invoice_attributes[:merchant_id],
      :status      => invoice_attributes[:status],
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }))
  end

  def update(id, attribute)
    to_be_updated = find_by_id(id)
    to_be_updated.status = attribute
    to_be_updated.updated_at = (Time.now).strftime("%Y-%m-%d %H:%M")
  end

end
