require 'pry'
require 'csv'
require_relative 'transaction'
require_relative 'customer'
require_relative 'repositable'


class CustomerRepository
  include Repositable
  attr_reader :all, :file_path

  def initialize(file_path)
    @file_path = file_path
    @all = []

    if @file_path
        CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
        @all << Customer.new({:id => row[:id].to_i, :first_name => row[:first_name], :last_name => row[:last_name], :created_at => row[:created_at], :updated_at => row[:updated_at]})
      end
    end
  end

  def find_all_by_first_name(first_name)
    @all.find_all do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    @all.find_all do |customer|
      customer.last_name == last_name
    end
  end
  #

  #
  def create(attributes)
    new_id = attributes[:id] = @all.last.id + 1
    @all << Customer.new({:id => new_id, :first_name => attributes[:first_name].upcase, :last_name => attributes[:last_name].upcase, :created_at => attributes[:created_at], :updated_at => attributes[:updated_at]})
  end
  #
  def update(id, attributes)
    customer = find_by_id(id)
    customer.first_name = attributes[:first_name] if attributes[:first_name] !=nil
    customer.last_name = attributes[:last_name] if attributes[:last_name] != nil

  end
  #
  def inspect
    "#<#{self.class} #{@customers.all} rows>"
  end
end
