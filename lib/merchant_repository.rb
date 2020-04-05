require_relative '../lib/merchant'
require_relative '../lib/create_elements'

class MerchantRepository

  include CreateElements

  attr_reader :merchants, :engine, :merchants_file

  def initialize(merchants_file, engine)
    @merchants = create_elements(merchants_file).map {|merchant|
       Merchant.new(merchant, self)}
    @engine = engine
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id.to_i == id.to_i
    end
  end

  def all
    return merchants
  end

  def count
    merchants.count
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_item(id)
    engine.find_item_by_merchant_id(id)
  end

  def invoices(id)
    engine.find_invoices(id)
  end

  def find_customers_by_merchant_id(id)
    engine.find_customers_by_merchant_id(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
