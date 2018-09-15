require 'CSV'
require_relative 'repo_module'

class CustomerRepository
  include RepoModule

  attr_reader :repo
  def initialize(file_path)
    @repo = []
    load_items(file_path)
  end

  def load_items(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @repo << Customer.new(row)
    end
  end

  def find_all_by_first_name(name)
    @repo.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @repo.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = @repo[-1].id + 1
    @repo << Customer.new(attributes)
  end

  def update(id, attributes)
    customer = find_by_id(id)
    customer.first_name = attributes[:first_name] unless attributes[:first_name].nil?
    customer.last_name = attributes[:last_name] unless attributes[:last_name].nil?
    customer.updated_at = Time.now unless (attributes[:first_name].nil? && attributes[:last_name].nil?)
  end

end
