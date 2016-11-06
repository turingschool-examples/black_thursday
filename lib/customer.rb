require_relative '../lib/customer_repo'
require 'csv'
require 'pry'

class Customer

  attr_reader :parent,
              :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
              
  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @first_name = data[:first_name]
      @last_name = data[:last_name]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end
end