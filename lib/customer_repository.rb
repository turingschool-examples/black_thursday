require_relative './reposable'
require_relative './customer'

class CustomerRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_all_by_first_name(first_name)
    all.select do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    all.select do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end