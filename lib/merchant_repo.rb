require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository

  attr_reader :engine, :contents

  def initialize(csvfile, engine)
    @engine = engine
    @merchants = load_merchants(csvfile)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def load_merchants(csvfile)
    contents = CSV.open csvfile, headers: true, header_converters: :symbol
    all_merchants = {}
    contents.each do |row|
      all_merchants[row[:id]] = Merchant.new(row, self)
    end
    all_merchants
  end

  def all
    @merchants.values
  end

  def find_by_id(id)
    @merchants[id.to_s]
  end

  def find_by_name(name)
    all.find do |merchant|
      if merchant.name == name.downcase
        return merchant
      end
    end
  end

  def find_all_by_name(name)
    array_of_matching_merchants = []
    all.find_all do |merchant|
      if merchant.name.downcase.start_with?(name)
        array_of_matching_merchants << merchant
      end
    end
    array_of_matching_merchants
  end

end
