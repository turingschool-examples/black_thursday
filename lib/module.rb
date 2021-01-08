require 'time'
require 'bigdecimal/util'
require 'bigdecimal'
module Methods

  def initialize(data, engine)
    @data = data
    @collections = populate_collection
    @engine = engine
  end

  def all
    @collections
  end

  def find_by_id (id)
    all.values.find do |value|
      value.id == id
    end
  end

  def find_by_price (price)
    all.values.find_all{|value| value.unit_price == price}
  end

  def find_by_name(name)
  	all.values.find do |value|
  		value.name == name
  	end
  end

  def find_all_by_name(search_string)
    all.values.find_all do |value|
      value.name.downcase.include?(search_string.downcase)
    end
  end

  def find_all_by_merchant_id(id)
    all.values.find_all do |value|
      value.merchant_id == id
    end
  end

  def find_all_by_customer_id(id)
    all.values.find_all do |value|
      value.customer_id == id
    end
  end

  def find_all_by_invoice_id(id)
    all.values.find_all do |value|
      value.invoice_id == id
    end
  end

  def find_all_by_status(status)
    all.values.find_all do |value|
      value.status == status
    end
  end

  def update (update)
    id = update[:id]
    id = find_by_id(id)
    id.update_attributes(update)
  end

  def max_id
    max_id = (all.values.max_by{|item| item.id.to_i}).id.to_i
  end

  def new_id
    max_id + 1
  end

  def delete(arg_id)
  	index = arg_id.to_s
  	all.delete_if do |key, item|
  		item.id == index
  	end
  end
end
