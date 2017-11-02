require './lib/merchant'

class MerchantRepository

  attr_reader :merchants, :engine, :merchants_file

  def initialize(merchants_file, engine)
    @merchants = merchants_file.map {|merchant| Merchant.new(merchant, self)}
    @engine = engine
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id.to_s
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
    engine.find_item(id)
  end

end
