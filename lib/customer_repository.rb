require 'csv'
require_relative 'customer'
require_relative 'csv_loader'
require_relative 'search'


class CustomerRepository
  include CsvLoader
  include Search

  attr_reader :customers

  def initialize(csv_file_path, engine)
    @customers = create_items(csv_file_path, engine)
    @engine = engine
    return self
  end

  def create_items(csv_file_path, engine)
    create_instances(csv_file_path, 'Customer', engine)
  end

  def all
    @customers
  end

  def find_by_id(id_number)
    find_instance_by_id(@customers, id_number)
  end

  def find_all_by_first_name(search_name)
    search_name = search_name.downcase
    @customers.find_all do |customer|
      customer_first_name = customer.first_name.downcase
      customer_first_name.include?(search_name)
    end
  end

  def find_all_by_last_name(search_name)
    search_name = search_name.downcase
    @customers.find_all do |customer|
      customer_last_name = customer.last_name.downcase
      customer_last_name.include?(search_name)
    end
  end

end
