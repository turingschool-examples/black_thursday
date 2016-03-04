require_relative '../lib/merchant'
require 'csv'
require 'pry'


class MerchantRepository
  attr_accessor :repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @repository = []
  end

  def all
    @repository
  end

  def find_by_id(number)
    @repository.find do |merchant|
      merchant.id == number
    end
  end

  def find_by_name(name)
    @repository.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    found = @repository.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def inspect
  end
end
