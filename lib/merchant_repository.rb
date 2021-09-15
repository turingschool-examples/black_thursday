require 'csv'
require_relative './sales_engine'

class MerchantRepository

  def initialize(merch_hash)
    @merch_hash = {}
  end

  def to_hash
    merchants.map {|merch| @merch_hash[merch[:id]] = merch }
  end

  def all
    to_hash.count
  end

  def find_by_id(id)
  end

  def find_by_name(name)
  end

  def find_all_by_name(name)
  end

  def create(attributes)
  end

  def updates(id, attributes)
  end

  def delete(id)
  end

end
