require_relative 'invoice'
require 'pry'

class InvoiceRepository
  attr_reader   :invoice,
                :parent,
                :all

  def initialize(invoice_data, parent = nil)
    @parent = parent
    @all = []
    populate(invoice_data)
  end

  def populate(invoice_data)
    invoice_data.each do |invoice|
      @all << Invoice.new(invoice, self)
    end
  end

  def find_by_id(id)
    @all.find { |invoice| invoice.id.eql?(id) }
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all { |invoice| invoice.customer_id.eql?(merchant_id) }
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all { |invoice| invoice.merchant_id.eql?(merchant_id) }
  end 

  def find_all_by_status(status)
    @all.find_all { |invoice| invoice.status.eql?(status) }
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end