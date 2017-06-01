require 'csv'
require_relative '../lib/merchant'

class MerchantRepository

  attr_reader :all_merchant_data

  def initialize(filename)
    @all_merchant_data = CSV.foreach(filename,
    headers: true, header_converters: :symbol).map do |row|
      Merchant.new(row)
    end
  end

  def all
    @all_merchant_data
  end

  def find_by_id(id)
    @all_merchant_data.find{|merchant| merchant.id == id.to_s}
  end

  def find_by_name(name)
    @all_merchant_data.find{|merchant| merchant.name == name}
  end

  def find_all_by_name(name)
    @all_merchant_data.find_all{|merchant| /#{name}/i =~ merchant.name}
  end
end
