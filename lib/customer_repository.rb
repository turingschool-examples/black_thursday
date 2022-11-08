require_relative './customer'
require_relative 'repository'

class CustomerRepository < Repository

  def new_obj(attributes)  
    new_obj_class(attributes, Customer)
  end

  def find_all_by_first_name(name)
    repo.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    repo.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end
end