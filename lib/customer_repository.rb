require 'csv'
require './lib/customer'
require './lib/repository_aide'

class CustomerRepository
  include RepositoryAide
  attr_reader :repository

  def initialize(file)
    @repository = read_csv(file).map do |customer|
        Customer.new({
          :id => customer[:id],
          :first_name => customer[:first_name],
          :last_name => customer[:last_name],
          :created_at => customer[:created_at],
          :updated_at => customer[:updated_at]
          })
        end
    group
  end


  def group
    @ids = @repository.group_by {|customer| customer.id}
    @first_names = @repository.group_by {|customer| customer.first_name}
    @last_names = @repository.group_by {|customer| customer.last_name}
  end

  def find_all_by_first_name(name)
    find(@first_names, name)
    # @repository.select do |customer|
    #   customer.first_name == name
    # end
  end

  def find_all_by_last_name(name)
    find(@last_names, name)
    # @repository.select do |customer|
    #   customer.last_name == name
    # end
  end

  def create(attributes)
    customer = Customer.new({
      :id => new_id.to_s,
      :first_name => attributes[:first_name],
      :last_name => attributes[:last_name],
      :created_at => Time.now,
      :updated_at => Time.now
      })
    @repository << customer
    customer
  end

  def update(id, attributes)
    customer = find_by_id(id)
    customer.first_name = attributes[:first_name]
    customer.last_name = attributes[:last_name]
    customer.updated_at = Time.now
  end
end
