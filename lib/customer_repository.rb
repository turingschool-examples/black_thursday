require_relative "customer"
require_relative "sales_engine"
require "csv"

class CustomerRepository

  attr_reader :all, :customers, :sales_engine

  def initialize(sales_engine, item_csv)
    @all = []
    @sales_engine = sales_engine
    CSV.foreach(item_csv, headers: true, header_converters: :symbol) do |row|
      all << Customer.new(self, row)
    end
  end

  def find_by_id(id)
    all.each do |customer|
      return customer if customer.id.to_i == id
    end
    nil
  end

  def find_all_by_first_name(first_name)
    all.select do |customer|
      customer.first_name.downcase.include? first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    all.select do |customer|
      customer.last_name.downcase.include? last_name.downcase
    end
  end

  def inspect
    "#<#{self.class} #{:customers.size} rows>"
  end
end
