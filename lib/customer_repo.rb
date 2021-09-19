require 'csv'
require_relative '../lib/customer'
require_relative '../lib/repo_module'


class CustomerRepo
  include Repo
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def create_array_of_objects
    @things.map do | customer |
      Customer.new(customer)
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

  def create(attributes)
    id = find_highest_id + 1
    info = {
      id: id,
      first_name: attributes[:first_name],
      last_name: attributes[:last_name],
      created_at: attributes[:created_at].to_s,
      updated_at: attributes[:updated_at].to_s
      }
    @all << Customer.new(info)
  end

  def update(id, attributes)
    if attributes[:first_name] != nil
      find_by_id(id).change_first_name(attributes[:first_name])
    end
    if attributes[:last_name] != nil
      find_by_id(id).change_last_name(attributes[:last_name])
    end
  end
end
