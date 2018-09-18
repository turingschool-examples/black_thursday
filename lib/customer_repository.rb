require 'pry'

require_relative 'finderclass'

require_relative 'customer'

require_relative 'crud'

class CustomerRepository
  include CRUD

  attr_reader :all

  def initialize(data)
    @data = data
    @customers = []
    make_customers
    @all = @customers
  end

  def make_customers(data = @data)
    data.each { |key, value|
      hash = make_hash(key, value)
      customer = Customer.new(hash)
      @customers << customer
    }
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end

  def find_by_id(id)
    FinderClass.find_by(all, :id, id)
  end

  def find_all_by_first_name(name)
    FinderClass.find_by_fragment(all, :first_name, name)
  end

  def find_all_by_last_name(name)
    FinderClass.find_by_fragment(all, :last_name, name)
  end

  def create(attributes)
    id = make_id(all, :id)
    data = {id => attributes} 
    make_customers(data)
  end

  def update(id, attributes)
    update_entry(@customers, id, attributes)
  end

  def delete(id)
    delete_entry(@customers, id)
  end

end
