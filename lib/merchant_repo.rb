require_relative 'merchant'
require_relative 'sales_engine'

class MerchantRepository
  attr_reader :merchants, :sales_engine

  def initialize(merchant_file, sales_engine)
    @merchants = read_merchants_file(merchant_file)
    @sales_engine = sales_engine
  end

  def read_merchants_file(merchant_file)
    merchant_list = []
    CSV.foreach(merchant_file,headers: true,header_converters: :symbol) do |row|
      id = row[:id]
      name = row[:name]
      merchant_list << Merchant.new({ :id => id, :name => name}, self)
    end
    merchant_list
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    merchants.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(fragment)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def merchant_items(merchant_id)
    sales_engine.find_merchant_items(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
