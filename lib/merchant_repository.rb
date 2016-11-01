require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository

  attr_reader   :contents,
                :merchants

  def initialize(path)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @merchants = contents.map do |line|
      Merchant.new(line)
    end
  end

  def all
    @merchants
  end

  def id(id_number)
    value = nil
    merchants.each do |merchant|
      if merchant.id == id_number
        value = merchant
      end
    end
    value
  end

  def find_by_name(name)
    value = nil
     merchants.each do |merchant|
      if merchant.name == name
        value = merchant
      end
    end
    value
  end

  def find_all_by_name(partial_search)
    by_name = []
    merchants.each do |merchant|
      if merchant.name.include? partial_search
        by_name << merchant
      end
    end
      by_name
  end

end