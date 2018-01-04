require 'csv'
require './lib/merchant.rb'

class MerchantRepository
  attr_reader :merchants,
              :parent

  def initialize(path, sales_engine = "")
    @merchants = {}
    merchant_creator_and_storer(path)
    parent_generator(sales_engine)
  end

  def parent_generator(parent)
    parent
  end

  def csv_opener(path)
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

  def items
    parent_generator(parent).items
  end

  def argument_raiser(data_type, desired_class = String)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

end
