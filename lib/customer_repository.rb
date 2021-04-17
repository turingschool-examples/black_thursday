require 'csv'
require 'time'
require_relative 'customer'
require_relative 'repository'

class CustomerRepository < Repository

  def initialize(location_hash, engine)
    super(location_hash, engine)
    all_customers
  end

  def all_customers
    @csv_array = []
    CSV.parse(File.read(@location_hash[:customers]), headers: true).each do |customer|
      @csv_array << Customer.new(id: customer[0],
                                 first_name: customer[1],
                                 last_name: customer[2],
                                 created_at: Time.parse(customer[3]),
                                 updated_at: Time.parse(customer[4]),
                                 repository: self)
    end
  end

  def find_all_by_first_name(name)
    @csv_array.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @csv_array.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    new = Customer.new(id: max_id_number_new,
                       first_name: attributes[:first_name],
                       last_name: attributes[:last_name],
                       created_at: Time.now,
                       updated_at: Time.now,
                       repository: self)
    @csv_array << new
    new
  end

  def update(id, attribute)
    new = find_by_id(id)

    if new.nil?
      nil
    else
      if !attribute[:first_name].nil?
        new.first_name = attribute[:first_name]
        new.updated_at = Time.now
      end
      if !attribute[:last_name].nil?
        new.last_name = attribute[:last_name]
        new.updated_at = Time.now
      end
    end
  end
end
