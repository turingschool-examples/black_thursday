require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository

  attr_reader :engine, :contents

  def initialize(csvfile, engine)
    @engine = engine
    @merchants = csvfile
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
    @contents.values
  end

  def find_by_id(id)
    @contents[id.to_s]
  end

  def find_by_name(name)
    content_array = all
    content_array.find do |merchant|
      if merchant.name == name
        return merchant
      end
    end
  end

  def find_all_by_name(name)
    content_array = all
    content_array.find_all do |merchant|
      if merchant.name.start_with?(name)
        merchant
      end
    end
  end

end
