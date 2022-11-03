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
 
  def update(id,attributes)
    if find_by_id(id) == nil 
      return
    else
    find_by_id(id).updated_at = Time.now
    attributes.each do |att,val|
      case att
      when :name
        find_by_id(id).name = val
      when :description
        find_by_id(id).description = val
      when :unit_price
        find_by_id(id).unit_price = val
      when :status
        find_by_id(id).status = val
      end
    end
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end