require_relative '../lib/merchant'
class MerchantRepository
  attr_reader :list_of_merchants,
              :parent_engine

  extend Forwardable
  def_delegators :@parent_engine, :find_items, :find_invoices, :find_customers

  def initialize(merchants_data, parent_engine)
    @parent_engine = parent_engine
    @list_of_merchants = populate_merchants(merchants_data)
  end

  def populate_merchants(merchants_data)
    merchants_data.map do |datum|
      Merchant.new(datum, self)
    end
  end

  def all
    list_of_merchants
  end

  def find_by_id(id_to_find)
    @list_of_merchants.find do |merchant|
      merchant.id == id_to_find
    end
  end

  def find_by_name(name_to_find)
    @list_of_merchants.find do |merchant|
      merchant.name.downcase == name_to_find.downcase
    end
  end

  def find_all_by_name(name_fragment_to_find)
    @list_of_merchants.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment_to_find.downcase)
    end
  end

  # just for the spec harness
  def inspect
  end
end
