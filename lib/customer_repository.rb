require 'csv'
require_relative 'customer'

class CustomerRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Customer.new({
        :id => row[:id].to_i,
        :first_name => row[:first_name],
        :last_name => row[:last_name],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        })
    end
  end

  def find_by_id(id_search)
    @all.find do |customer|
      customer.id == id_search
    end
  end

  def find_all_by_first_name(first_name_search)
    @all.find_all do |customer|
      customer.first_name == first_name_search
    end
  end

  def find_all_by_last_name(last_name_search)
    @all.find_all do |customer|
      customer.last_name == last_name_search
    end
  end

  def create(attributes)
    new_id = 0
    @all.each do |customer|
      if customer.id.to_i >= new_id
        new_id = customer.id.to_i + 1
      end
    end
    @all << Customer.new( {
      :id => new_id.to_s,
      :first_name => attributes[:first_name],
      :last_name => attributes[:last_name],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]
      } )
  end

  def update(customer_id_search, new_first_name, new_last_name)
    @all.find do |customer|
      if customer.id == customer_id_search
        customer.first_name = new_first_name
        customer.last_name = new_last_name
        customer.updated_at = Time.now
      end
    end
  end

  def delete(customer_id_search)
    @all.find do |customer|
      customer.id == customer_id_search
      @all.delete(customer)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
