require 'csv'
require_relative '../lib/customer'
require_relative '../lib/modules/findable'
require_relative '../lib/modules/crudable'

class CustomerRepository
  include Findable
  include Crudable
  attr_reader :all

  def initialize(path)
    @all = []
    create_items(path)
  end

  def create_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      customer = Customer.new(row)
      @all << customer
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def find_all_by_first_name(name)
    @all.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @all.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    create_new(attributes, Customer)
  end

  def update(id, attributes)
    update_new(id, attributes)
  end

  def delete(id)
    delete_new(id)
  end
end
