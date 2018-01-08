require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants,
              :parent

  def initialize(path, sales_engine = "")
    @merchants = {}
    @parent = sales_engine
    merchant_creator_and_storer(path)
  end

  def merchant_creator_and_storer(path)
    argument_raiser(path, String)
    csv_opener(path).each do |merchant|
      new_merchant = Merchant.new(merchant, self)
      @merchants[new_merchant.id] = new_merchant
    end
  end

  def csv_opener(path = "./data/merchants.csv")
    argument_raiser(path, String)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def items_by_id(id)
    argument_raiser(id)
    @parent.items_by_id(id)
  end

  def all
    @merchants.values
  end

  def find_by_id(id)
    argument_raiser(id)
    @merchants[id]
  end

  def find_by_name(name)
    argument_raiser(name, String)
    all.find do |merchant|
      merchant.downcaser == name.downcase
    end
  end

  def find_all_by_name(name)
    argument_raiser(name, String)
    all.select do |merchant|
      merchant.downcaser.include?(name.downcase)
    end
  end

  def assign_item_count(id, num)
    argument_raiser(id)
    @merchants[id].item_count = num
  end

  def assign_total_revenue(id, num)
    @merchants[id].total_revenue = num
  end

  def find_invoice_by_merchant_id(id)
    argument_raiser(id)
    @parent.find_invoice_by_merchant_id(id)
  end

  def find_all_customers_by_merchant_id(id)
    @parent.find_all_customers_by_merchant_id(id)
  end

  def argument_raiser(data_type, desired_class = Integer)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
