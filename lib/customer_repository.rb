require_relative './repo_module'
require_relative './customer'

class CustomerRepository
  include RepoModule

  attr_reader :all

  def initialize(file_path)
    @class_name = Customer
    @all = from_csv(file_path)
  end
end
