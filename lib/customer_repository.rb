require_relative 'repository'
require_relative 'customer'


class CustomerRepository < Repository

  def record_class
    Customer
  end

  def find_all_by_first_name(first_name)
    find_all do |customer|
      customer.first_name.downcase.include? first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    find_all do |customer|
      customer.last_name.downcase.include? last_name.downcase
    end
  end

end
