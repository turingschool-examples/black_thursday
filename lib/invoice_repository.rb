require 'helper'

class InvoiceRepository
  attr_reader :all

  def initialize(file_path)
    @all = make_repo(file_path)
  end

  def make_repo(file_path)
    repo = Array.new
    CSV.foreach(file_path, headers: true, header_converters: :symbol){|row| repo.push(Invoice.new(row))}
    repo
  end

  def find_by_id(id_number)
    @all.find {|invoice| invoice.id == id_number}
  end

  def find_all_by_customer_id(id_number)
    @all.select {|invoice| invoice.customer_id == id_number}
  end

  def find_all_by_merchant_id(id_number)
    @all.select {|invoice| invoice.merchant_id == id_number}
  end

  def find_all_by_status(status)
    @all.select {|invoice| invoice.status == status}
  end

  def max_id
    (@all.max_by {|invoice| invoice.id}).id
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

  def delete(id)
    to_be_dropped = find_by_id(id)
    @all.delete(to_be_dropped)
    @all.find_by_id(id) == nil ? 'Deletion complete!' : '...something went wrong'
  end
end
