require 'pry'
require 'csv'
require_relative '../lib/merchant'
require_relative '../lib/file_opener'

class MerchantRepository
  include FileOpener
  attr_reader :all_merchant_data,
              :sales_engine,
              :all

  def initialize(csv_data, sales_engine)
    @sales_engine = sales_engine
    @all_merchant_data = open_csv(csv_data)
    @all = @all_merchant_data.map do |row|
      Merchant.new(row, self)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.upcase == name.upcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      (/#{name}/i) =~ merchant.name
    end
  end

end
