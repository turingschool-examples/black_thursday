require 'csv'
require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository

  attr_reader :klass, :data

  def initialize(sales_engine, path)
    super(sales_engine, path, Merchant)
  end

  def all
    data
  end

  def count
    data.count
  end

  def find_by_name(name)
    data.select {|item| item.name.downcase == name.downcase }.first
  end

  def find_by_id(id)
    data.select {|item| item.id == id }.first
  end

  def find_all_by_name(fragment)
    data.find_all do |item|
      /#{Regexp.quote(fragment.downcase)}/ =~ item.name.downcase
    end
  end


end
