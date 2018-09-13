require_relative '../lib/repo_module'
require_relative '../lib/customer'
require 'time'

class CustomerRepository
  include RepoModule

  def initialize
    @data = []
  end

  def create(attributes)
    #all incoming data must be formatted as String datatype
    if attributes[:id] != nil
      #Coming From CSV
      hash = {
        id: attributes[:id].to_i,
        first_name: attributes[:first_name],
        last_name: attributes[:last_name],
        updated_at: Time.parse(attributes[:updated_at]),
        created_at: Time.parse(attributes[:created_at]),
        }
      @data << Customer.new(hash)
    else
      #Generated on the fly
      hash = {
        id: find_next_id,
        first_name: attributes[:first_name],
        last_name: attributes[:last_name],
        updated_at: Time.parse(attributes[:updated_at]),
        created_at: Time.parse(attributes[:created_at]),
        }
      @data << Customer.new(hash)
    end
  end

  def find_all_by_first_name(search_first_name)
    @data.find_all do |element|
      element.first_name == search_first_name
    end
  end

  def find_all_by_last_name(search_last_name)
    @data.find_all do |element|
      element.last_name == search_last_name
    end
  end

end
