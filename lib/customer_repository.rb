require 'csv'
require_relative '../lib/customer'

class CustomerRepository
  attr_reader :all,
              :parent

  def initialize(file_path, parent)
    contents = CSV.open(file_path, headers: true, header_converters: :symbol)
    @all = contents.map do |row|
      Customer.new({:id        => row[:id],
                   :first_name => row[:first_name],
                   :last_name  => row[:last_name],
                   :created_at => row[:created_at],
                   :updated_at => row[:updated_at]},
                   self)
    end
    @parent = parent
  end

  def find_by_id(id)
    all.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name_fragment)
    all.select do |customer|
      customer.first_name.downcase.include?(first_name_fragment.downcase)
    end
  end

  def find_all_by_last_name(last_name_fragment)
    all.select do |customer|
      customer.last_name.downcase.include?(last_name_fragment.downcase)
    end
  end

  def call_merchants_from_customer_id(customer_id)
    parent.get_merchants_from_customer_id(customer_id)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end
