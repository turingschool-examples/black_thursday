require_relative './repo_module'
require_relative './customer'

class CustomerRepository
  include RepoModule

  attr_reader :all

  def initialize(file_path)
    @class_name = Customer
    @all = from_csv(file_path)
  end

  def find_all_by_first_name(first_name)
    @all.find_all do |name|
      name.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @all.find_all do |name|
      name.last_name.downcase.include?(last_name.downcase)
    end
  end
end
