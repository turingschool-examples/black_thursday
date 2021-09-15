require 'csv'
require_relative './sales_engine'

class MerchantRepository

  def initialize(path)
    @merchants = to_hash(path)
  end

  def to_hash(path)
    repo = {}
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      repo[row[:id]] = row.to_hash
    end
    require "pry"; binding.pry
  end

  def all
    @merch_hash
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
