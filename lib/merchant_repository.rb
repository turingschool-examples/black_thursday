require 'csv'
require './lib/merchant.rb'

class MerchantRepository
  attr_reader :merchants

  def initialize(path, sales_engine = "")
    @merchants = []
    merchant_creator_and_storer(path)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    argument_raiser(id, Integer)
    @merchants.find {|merchant| merchant.id.to_i == id}
  end

  def find_by_name(name)
    argument_raiser(name)
    @merchants.find {|merchant| merchant.name.downcase == name.downcase}
  end


  def find_all_by_name(name)
    argument_raiser(name)
    @merchants.select {|merchant| merchant if merchant.name.downcase.include?(name.downcase)}
  end

  def csv_opener(path)
    argument_raiser(path)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def merchant_creator_and_storer(path)
    argument_raiser(path)
    csv_opener(path).each do |merchant|
      @merchants << Merchant.new(merchant, self)
    end
  end

  def argument_raiser(data_type, desired_class = String)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

end
