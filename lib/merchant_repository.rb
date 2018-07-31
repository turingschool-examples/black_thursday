require_relative '../lib/merchant.rb'
require_relative '../lib/repo_method_helper.rb'
require 'csv'

class MerchantRepository
  include RepoMethodHelper
  
  attr_reader :list

  def initialize(merchants)
    @list = merchants
  end

  def find_all_by_name(name)
    downcased_name = name.downcase
    @list.find_all do |merchant|
      merchant.name.downcase.include?(downcased_name)
    end
  end

  def create(merchant_name)
    @list << Merchant.new({
      name: merchant_name[:name],
      id: create_id,
      created_at: Time.now,
      updated_at: Time.now
      })
  end

  def update(id, attributes)
    find_by_id(id).name = attributes[:name] unless attributes[:name].nil?
  end
end
