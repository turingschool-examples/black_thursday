require_relative 'reposable'
require_relative './invoice.rb'

class InvoiceRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |invoice|
      customer_id == invoice.customer_id
    end
  end
  
  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |invoice|
      merchant_id == invoice.merchant_id
    end
  end

  def find_all_by_status(invoice_status)
    @all.find_all do |invoice|
      invoice.status == invoice_status
    end
  end

  def create(attributes)
    all << Invoice.new({ :id            => next_id,
                          :customer_id  => attributes[:customer_id],
                          :merchant_id  => attributes[:merchant_id],
                          :created_at   => attributes[:created_at],
                          :updated_at   => attributes[:updated_at],
                          :status       => attributes[:status]
                      })    
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end