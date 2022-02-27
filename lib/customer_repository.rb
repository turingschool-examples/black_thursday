require_relative '../lib/findable.rb'
require_relative '../lib/customer.rb'

class CustomerRepository
  include Findable
  attr_reader :all

  def initialize(customer_array)
    @all = customer_array
  end

  def find_all_by_first_name(first_name)
    @all.find_all do |object|
      object.first_name.downcase == first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    @all.find_all do |customer|
      customer.last_name.downcase == last_name.downcase
    end
  end

  def create(attributes)
    new_id = all.max_by {|customer| customer.id }.id + 1
    attributes[:id] = new_id
    all << Customer.new(attributes)
  end 

  def delete(id)
    customer = find_by_id(id)
    all.delete(customer)
  end

  # def populate_repository(path)
  #   CSV.read(path, headers: true, header_converters: :symbol) do |row|
  #     info_hash = {
  #       id: row[:id].to_i,
  #       first_name: row[:first_name],
  #       last_name: row[:last_name],
  #       created_at: Time.parse(row[:created_at]),
  #       updated_at: Time.parse(row[:updated_at])
  #     }
  #     @all << Customer.new(info_hash)
  #   end
  # end
end
