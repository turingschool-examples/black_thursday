require_relative '../lib/merchant'
require_relative '../lib/modules/repo_queries'
require 'csv'

class MerchantRepository
  include RepoQueries
  attr_reader :data, :engine

  def initialize(file = nil, engine = nil)
    @data = []
    @engine = engine
    @child = Merchant
    load_data(file)
  end

  def add_merchant(merchant_object)
    all << merchant_object
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.upcase.include?(name.upcase)
    end
  end

  def update(id, attributes)
    return if attributes.empty?
    update_merchant = find_by_id(id)
    update_merchant.name = attributes[:name]
  end

  def find_all_items_by_merchant_id(id)
    @engine.find_all_items_by_merchant_id(id)
  end

  def find_all_invoices_by_merchant_id(id)
    @engine.find_all_invoices_by_merchant_id(id)
  end
end
