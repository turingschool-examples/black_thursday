require 'csv'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
# require_relative './customer_repository'
require_relative './item'
require_relative './merchant'
require_relative './invoice'
require_relative './customer'

class SalesEngine
  # repo_list = ["merchants","items","invoices","customers"]
  # repo_list.each { |repo| attr_reader repo.to_sym }
  attr_reader :items, :merchants, :invoices, :customers

  def initialize(data)
    repo_list.each do |repo|
      repo_creation(data[repo.to_sym], repo.to_sym)
    end
  end

  def self.from_csv(data)
    new(data)
  end

  def repo_creation(input_data, repo_type)
    instance_variable_set("@#{repo_type.to_s}", repo_class(repo_type).new(thing_creation(input_data, repo_type)))
  end

  def thing_creation(second_data, second_type)
    data = CSV.open second_data, headers: true, header_converters: :symbol
      data.map do |row|
      thing_type(second_type, row)
    end
  end

  def thing_type(type, row)
    repo_child_class(type.to_s).new(row)
  end

  def repo_list
    ["merchants","items","invoices"]
  end

  def repo_child_class(repo)
    Object.const_get(repo.capitalize.chomp('s'))
  end

  def repo_class(repo)
    class_string = repo.to_s.capitalize.chomp('s') + 'Repository'
    Object.const_get(class_string)
  end

  def analyst
    SalesAnalyst.new(@merchants,@items,@invoices)
  end
end