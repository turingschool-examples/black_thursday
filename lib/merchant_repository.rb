require 'csv'
require_relative 'merchant.rb'

class MerchantRepository
  attr_reader :merchants,
              :parent

  def initialize(path, sales_engine = "")
    @merchants = {}
    @parent = sales_engine
    merchant_creator_and_storer(path)
  end

  def items_by_id(id)
    @parent.items_by_id(id)
  end

  def csv_opener(path = "./data/merchants.csv")
    argument_raiser(path)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def merchant_creator_and_storer(path)
    argument_raiser(path)
    csv_opener(path).each do |merchant|
      new_merchant = Merchant.new(merchant, self)
      @merchants[new_merchant.id.to_i] = new_merchant
    end
  end

  def all
    @merchants.values
  end

  def find_by_id(id)
    argument_raiser(id, Integer)
    @merchants[id]
  end

  def find_by_name(name)
    argument_raiser(name)
    @merchants.find {|id, merchant| merchant.downcaser == name.downcase}[1]
  end

  def find_all_by_name(name)
    argument_raiser(name)
    @merchants.select {|id, merchant| merchant.downcaser.include?(name.downcase)}.values
  end

  def assign_item_count(id, num)
    @merchants[id].item_count = num
  end

  def argument_raiser(data_type, desired_class = String)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

end
