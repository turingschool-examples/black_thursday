require 'csv'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative './customer_repository'
require_relative './transaction_repository'
require_relative './item'
require_relative './merchant'
require_relative './invoice'
require_relative './invoice_item'
require_relative './customer'
require_relative './transaction'

class SalesEngine
  attr_reader :items, 
              :merchants,
              :invoices, 
              :invoice_items,
              :customers,
              :transactions

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
    repo_child_class(type).new(row)
  end

  def repo_list
    ["merchants","items","invoices","invoice_items","customers","transactions"]
  end

  def repo_child_class(repo)
    repo = repo.to_s.split("_").map { |word| word.capitalize }.join
    Object.const_get(repo.chomp('s'))
  end

  def repo_class(repo)
    repo = repo.to_s.split("_").map { |word| word.capitalize }.join
    class_string = repo.chomp('s') + 'Repository'
    Object.const_get(class_string)
  end

  def analyst
    SalesAnalyst.new(@merchants,@items,@invoices,@customers,@transactions,@invoice_items)
  end
end