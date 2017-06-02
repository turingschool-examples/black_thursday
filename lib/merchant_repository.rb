require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all,
              :sales_engine,
              :merchants

  def initialize(file, sales_engine)
    @all = []
    @sales_engine = sales_engine
    populate_merchant_repo(file)
  end

  def populate_merchant_repo(file)
    merchant_lines = CSV.open(file, headers: true, header_converters: :symbol)
    merchant_lines.each do |row|
      merchant = Merchant.new(row, self)
      all << merchant
    end
    merchant_lines.close
  end

  def add_merchants(merchant)
    all <<(merchant)
  end

  def find_by_id(id)
    all.find do |merch|
      merch.id == id
    end
  end

  def find_by_name(name)
    all.find do |merch|
      merch.name == name
    end
  end

  def find_all_by_name(name2)
    all.find_all do |merch|
      merch.name.include?(name2)
    end
  end

  def items_in_merch_repo(merchant_id)
    @sales_engine.collected_items(merchant_id)
  end

  def merchant(item_id)
    find_by_id(item_id)
  end

end
