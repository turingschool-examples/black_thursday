require 'csv'
require_relative '../lib/customer'
require_relative 'repoable'

class CustomerRepository
  include Repoable
  attr_reader :file_path

  attr_accessor :all,
                :first_name,
                :last_name

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

   def find_all_by_first_name(name)
     @all.find_all { |customer| customer.first_name.downcase.include?(name.downcase)}
   end

   def find_all_by_last_name(name)
     @all.find_all { |customer| customer.last_name.downcase.include?(name.downcase)}
   end

   def create(data_hash)
     id = (@all.last.id.to_i + 1)
     @all << Customer.new({
       :id => data_hash[:id],
       :first_name => data_hash[:first_name],
       :last_name => data_hash[:last_name],
       :created_at => data_hash[:created_at],
       :updated_at => data_hash[:updated_at]
       })
   end

   def update(id, attribute)
    find_by_id(id).first_name = attribute[:first_name]
    find_by_id(id).last_name = attribute[:last_name]
    find_by_id(id).updated_at = Time.now
   end

   def delete(id)
     @all.delete(find_by_id(id))
   end

   def inspect
     "#<#{self.class} #{@all.size} rows>"
   end
end
