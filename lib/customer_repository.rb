require_relative 'repository'
require_relative 'customer'


class CustomerRepository < Repository

  def record_class
    Customer
  end

  def find_all_by_first_name(substring)
    find_all do |customer|
      customer.first_name.downcase.include? substring.downcase
    end
  end

  def find_all_by_last_name(substring)
    find_all do |customer|
      customer.last_name.downcase.include? substring.downcase
    end
  end

end
