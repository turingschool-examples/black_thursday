require_relative '../lib/customer_repo'
require 'csv'
require 'pry'
require 'time'

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
      @first_name = data[:first_name].to_s
      @last_name = data[:last_name].to_s
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end
end