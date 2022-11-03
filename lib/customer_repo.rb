require './lib/general_repo'

class CustomerRepo < GeneralRepo
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
  def initialize(customer_data)
    super('Customer', customer_data)
  end

  def find_all_by_first_name(first_name)
    @repository.select{ |customer| customer.first_name.casecmp?(first_name) }
  end

  def find_all_by_last_name(last_name)
    @repository.select{ |customer| customer.last_name.downcase.include? last_name.downcase }
  end
end