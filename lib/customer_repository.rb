require_relative 'customer'
require_relative 'repository_assistant'

class CustomerRespository
  include RepositoryAssistant

  def initialize(data_file)
    @repository = data_file.map {|item| Customer.new(item)}
  end

  def create(attributes)
    attributes[:id] = create_new_id_number
    @repository << Customer.new(attributes)
  end

  def find_all_by_first_name(first_name)
    @repository.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @repository.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
