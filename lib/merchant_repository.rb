require 'csv'
require_relative '../lib/merchant.rb'
require_relative '../lib/repo_method_helper.rb'
require 'pry'

class MerchantRepository
  attr_reader :merchants
  include RepoMethodHelper

  def initialize(merchant_location)
    @merchant_location = merchant_location
    @merchants = []
    from_sales_engine
  end

  def from_sales_engine
    CSV.foreach(@merchant_location, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
  end

  def all
    @merchants
  end

  def find_all_by_name(name)
    downcased_name = name.downcase
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(downcased_name)
    end
  end

  def create(merchant_name)
    @merchants << Merchant.new({name: merchant_name[:name], id: create_id, created_at: Time.now, updated_at: Time.now})
  end

  def update(id, attributes)
    find_by_id(id).name = attributes[:name] unless attributes[:name].nil?
  end

  def inspect
    "#<#{self.MerchantRepository} #{@merchants.size} rows>"
  end
end
