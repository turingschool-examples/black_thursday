require_relative '../lib/customer'
require 'csv'
require 'pry'

class CustomerRepo
  attr_reader :all,
              :name,
              :id,
              :description,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(file, sales_engine)
    @parent = sales_engine
    @all = []
    file_reader(file)
  end

 def file_reader(file)
    contents = CSV.open(file, headers:true, header_converters: :symbol)
    contents.each do |item|
       @all << Customer.new(item, self)
    end
  end

  def find_by_id(desired_id)
    @all.find do |customer|
      customer.id == desired_id
    end
  end

  def find_by_first_name(desired_name)
    c = @all.find do |customer|
      customer.first_name == desired_name
    end
    c.id
  end
  
  def find_by_last_name(desired_name)
    c = @all.find do |customer|
      customer.last_name == desired_name
    end
    c.id
  end
end
