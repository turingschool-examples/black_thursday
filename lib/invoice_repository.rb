require 'CSV'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require_relative 'invoice'
require_relative 'crud.rb'

class InvoiceRepository
include Crud

  attr_reader :collection,
              :changeable_attributes

  def initialize(filepath, parent)
    @collection = []
    loader(filepath)
    @parent = parent
    @changeable_attributes = [:name]
  end

  def create(attributes)
    if @collection != []
      largest = (@collection.max_by {|element| element.id})
      attributes[:id] = (largest.id + 1)
    else
      attributes[:id] = 1
    end
    invoice = Invoice.new(attributes, self)
    @collection << invoice
  end

  def find_all_by_name(string)
    find_all_by(("id"), string.downcase)
  end

  def all
    @collection
  end

  def loader(filepath)
    invoice_table = load(filepath)
    invoice_table.map do |invoice|
      invoice[:id] = invoice[:id].to_i
      invoice[:updated_at] = Time.parse(invoice[:updated_at])
      invoice[:created_at] = Time.parse(invoice[:created_at])
      @collection << Invoice.new(invoice, @parent)
    end
  end

  def update(id, attributes)
    if @changeable_attributes + attributes.keys != []
      it = collection.find { |element| element.id == id }
      attributes.map do |attribute|
        it.name = attribute[1]
      end
    else
      []
    end
  end

  def find_all_by_customer_id(customer_id)
    @collection.find_all do |element|
      element.customer_id == (customer_id)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @collection.find_all do |element|
      element.merchant_id == (merchant_id)
    end
  end

  def find_all_by_status(status)
    @collection.find_all do |element|
      element.status == (status)
    end
  end
  
  def create(attributes)
    if @collection != []
      largest = (@collection.max_by {|element| element.id})
      attributes[:id] = (largest.id + 1)
    else
      attributes[:id] = 1
    end
    i = Invoice.new(attributes, self)
    @collection << i
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      it = collection.find { |element| element.id == id }
        it.status = attributes[:status]
        it.updated_at = Time.now
    else
      []
    end
  end

  def find_all_by_day(day)
    days = @collection.find_all do |invoice|
      invoice.created_at.strftime('%A') == day.to_s
    end
  end

  def find_all_by_status(status)
    @collection.find_all do |invoice|
      invoice.status.to_sym == status.to_sym
    end
  end
end
