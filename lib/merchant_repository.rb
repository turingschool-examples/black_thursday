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

  def find_by_name(name)
    downcased_name = name.downcase
    @merchants.find do |merchant|
      merchant.name.downcase == downcased_name
    end
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

  def create_id
    sorted_merchants = @merchants.sort_by do |merchant|
      merchant.id
    end
    last_merchant = sorted_merchants.last
    (last_merchant.id.to_i + 1).to_s
  end

  def update(id, new_name)
    if find_by_id(id) != nil
      find_by_id(id).name = new_name[:name]
    else
      nil
    end
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.MerchantRepository} #{@merchants.size} rows>"
  end
end
