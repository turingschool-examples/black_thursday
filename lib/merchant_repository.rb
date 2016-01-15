require_relative 'merchant'
require          'csv'
require          'pry'

class MerchantRepository
  attr_reader   :all, :merchant_instances
  attr_accessor :items_repo

  def initialize(csv_hash, items_repo = nil)
    @merchant_instances = csv_hash.map do |csv_hash|
      merchant = Merchant.new(csv_hash)
    end
    @items_repo = items_repo
  end

  def all
    merchant_instances
  end

  def stdrd(data_to_be_standardized)
    data_to_be_standardized.to_s.downcase.gsub(" ", "")
  end

  def find_by_id(merchant_id_inputed)
    stdrd_merchant_id = stdrd(merchant_id_inputed)
    found_item_instances =
      merchant_instances.find {|item| stdrd(item.id) == stdrd_merchant_id}
    found_item_instances.nil? ? nil : found_item_instances
  end

  def find_by_name(merchant_name_inputed)
    stdrd_merchant_name = stdrd(merchant_name_inputed)
    found_item_instances =
      merchant_instances.find {|item| stdrd(item.name) == stdrd_merchant_name}
    found_item_instances.nil? ? nil : found_item_instances
  end

  def find_all_by_name(merchant_name_inputed)
    stdrd_merchant_name = stdrd(merchant_name_inputed)
    found_item_instances =
      merchant_instances.find_all {|item| item.name.downcase.include?(standard_merchant_name)}
    found_item_instances.nil? ? [] : found_item_instances
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
