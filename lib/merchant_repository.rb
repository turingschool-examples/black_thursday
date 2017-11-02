require_relative '../lib/merchant'
require_relative '../lib/create_elements'

class MerchantRepository

  include CreateElements

  attr_reader :merchants, :parent, :merchants_file

  def initialize(merchants_file, parent)
    @merchants = create_elements(merchants_file).map {|merchant| Merchant.new(merchant, self)}
    @parent = parent
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

  def item(id)
    parent.item(id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
