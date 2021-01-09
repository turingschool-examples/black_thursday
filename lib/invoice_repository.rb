require 'time'
require './lib/invoice'
require 'csv'
require 'pry'

class InvoiceRepository
  include TimeStoreable

  attr_reader :all
  
  def initialize(data, engine)
    @all    = []
    @engine = engine


     CSV.foreach(data, headers: true, header_converters: :symbol) do |row|
      @all << convert_to_invoice(row)
    end
  end

  def convert_to_invoice(row)
    row = Invoice.new({id: row[:id],                    
                    customer_id: row[:customer_id],
                    merchant_id: row[:merchant_id],
                    status: row[:status],
                    created_at: row[:created_at],
                    updated_at: row[:updated_at]
                   }, self)
  end

  def find_by_id(id)
    @all.find do |invoice|
     invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    @all.find_all do |invoice|
     invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @all.find_all do |invoice|
     invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
     invoice.status.downcase == status
    end
  end

  def new_highest_id
    all.max_by do |instance|
      instance.id
    end.id + 1
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @all << Invoice.new(attributes, self)
  end

  def update(id, attributes)
    if find_by_id(id) != nil && check_status_is_valid(attributes)
      new_status = attributes[:status]
      update_invoice = all.find { |invoice| invoice.id == id }
      update_invoice.status = new_status
      update_invoice.updated_at = Time.now
    end
  end

  def check_status_is_valid(attributes)
   if attributes.class == Hash
      statuses = [:pending, :returned, :shipped, :sold, :success]
      status = attributes[:status]
      statuses.include?(status)
    end
  end

  def delete(id)
    remove = find_by_id(id)
    @all.delete(remove)
  end

end