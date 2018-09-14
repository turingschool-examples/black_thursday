require 'pry'
require_relative './repository_module'

class InvoiceRepository
  include RepoMethods

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []

   split(filepath) if filepath != nil
  end

  def all
    @all
  end

  def add_individual_invoice(individual_invoice)
    @all << individual_invoice
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |object|
     object.customer_id == customer_id
   end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |object|
     object.merchant_id == merchant_id
   end
  end

  def find_all_by_status(status)
    @all.find_all do |object|
     object.status == status
   end
  end

  def create(attributes)
    is_included = @all.any? do |item|
     attributes[:id] == item.id
    end
    is_included = false if @all == []
     has_id = attributes[:id] != nil
    if has_id && !is_included
      @all << Invoice.new(attributes)
    elsif @all == []
     new_id = 1
     attributes[:id] = new_id
    @all << Invoice.new(attributes)
    else
     highest_id = @all.max_by do |item|
     item.id
    end.id
     new_id = highest_id + 1
     attributes[:id] = new_id
     @all << Invoice.new(attributes)
    end
  end

  def update(id, attributes)
    return nil if attributes == {}
    object = find_by_id(id)
    if attributes[:status] != nil
      object.status = attributes[:status]
    end
    # if object.updated_at != nil
    #    object.updated_at = Time.now
    # end
  end


  def split(filepath)
    objects = CSV.open(filepath, headers: true, header_converters: :symbol)
    attributes_array = []
    objects.map do |object|
      object[:id] = object[:id]

      object[:customer_id] = object[:customer_id]

      object[:merchant_id] = object[:merchant_id]

      object[:status] = object[:status]

      object[:created_at] = Time.parse(object[:created_at])

      object[:updated_at] = Time.parse(object[:updated_at])
      attributes_array << object.to_h
      end
      attributes_array.each do |hash|
      create(hash)
      end
    end
    

end
