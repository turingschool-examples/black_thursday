require_relative '../lib/findable.rb'
require_relative '../lib/invoice.rb'
require_relative '../lib/crudable.rb'
require 'pry'

class InvoiceRepository
  include Findable
  include Crudable
  attr_reader :all

  def initialize(invoice_array)
    @all = invoice_array
    @new_object = Invoice
  end

  def find_all_by_customer_id(id_integer)
    @all.find_all { |invoice| invoice.customer_id == id_integer }
  end

  def find_all_by_merchant_id(id_integer)
    @all.find_all { |invoice| invoice.merchant_id == id_integer }
  end

  def find_all_by_status(status_symbol)
    @all.find_all { |invoice| invoice.status == status_symbol }
  end

  # def create (info_hash)
  #   new_id = (@all.max{ |invoice_a, invoice_b| invoice_a.id <=> invoice_b.id}).id + 1
  #   info_hash[:id] = new_id
  #   info_hash[:created_at] = Time.now.getutc.to_s
  #   info_hash[:updated_at] = Time.now.getutc.to_s
  #   new_invoice = Invoice.new(info_hash)
  #   @all << new_invoice
  # end

  # def update (id_integer, status_symbol)
  #   target_invoice = find_by_id(id_integer)
  #   target_invoice.status = status_symbol
  #   target_invoice.updated_at = Time.now.getutc.to_s
  # end
  #
  # def delete (id_integer)
  #   target_index = @all.rindex{ |invoice| invoice.id == id_integer}
  #   @all.delete_at(target_index)
  # end
end
