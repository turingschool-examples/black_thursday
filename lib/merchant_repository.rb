require 'csv'
require './lib/merchant.rb'

class MerchantRepository
  attr_reader :merchants

  def initialize(path, sales_engine)
    @merchants = []
    merchant_creator_and_storer(path)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.select {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @merchants.find {|merchant| merchant.name.downcase == name.downcase}
  end


  def find_all_by_name
    @merchants.select {|merchant| merchant.name.downcase = name.downcase}
  end

  def csv_opener(path)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def merchant_creator_and_storer(path)
    csv_opener(path).each do |merchant|
      @merchants << Merchant.new(merchant, self)
    end
  end

end
