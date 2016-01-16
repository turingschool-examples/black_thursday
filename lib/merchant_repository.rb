require_relative 'merchant'
require          'csv'
require          'pry'

class MerchantRepository
  attr_reader   :all, :merchant_instances

  def initialize(csv_hash, engine = nil)
    @merchant_instances = csv_hash.map do |csv_hash|
      merchant = Merchant.new(csv_hash, engine)
    end
  end

  def all
    merchant_instances
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end


  def standard(data_to_be_standardized)
    data_to_be_standardized.to_s.downcase.gsub(" ", "")
  end

  def find_by_id(merchant_id)
    merchant_instances.find { |item| item.id == merchant_id.to_i}
  end

  def find_by_name(merchant_name)
    merchant_instances.find {|merchant| standard(merchant.name) == standard(merchant_name)}
  end

  def find_all_by_name(merchant_name)
    merchant_instances.find_all { |merchant| merchant.name.downcase.include? standard(merchant_name) }
  end


end
