require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository
  attr_reader :repository
  def initialize(data, sales_engine = nil)
    @repository = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Merchant.new(data)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    if repository.keys.include?(id)
      return repository[id]
    end
  end

  def find_by_name(name)
    merchants = repository.values
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    merchants = repository.values
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
