
require 'csv'
require_relative 'customer'
class CustomerRepository
  attr_reader :file_path
  attr_accessor :all
  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Customer.new({
        :id => row[:id],
        :first_name => row[:first_name],
        :last_name => row[:last_name],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        })
      end
   end

   def find_by_id(customer_id)
      @all.find { |customer| customer.id.to_i == customer_id}
   end

   def find_all_by_first_name(name)
     @all.find_all { |customer| customer.first_name.downcase.include?(name.downcase)}
   end

   def find_all_by_last_name(name)
     @all.find_all { |customer| customer.last_name.downcase.include?(name.downcase)}
   end




end
