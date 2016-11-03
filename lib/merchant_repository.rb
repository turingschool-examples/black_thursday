require_relative 'merchant'
require_relative 'csv_parser'

class MerchantRepository

  include CSV_parser

  attr_reader :all,
              :parent

  def initialize(file, parent = nil)
    @all = parse(file).map do |row|
      Merchant.new({:id => row[:id], :name => row[:name]}, self)
    end
    @parent = parent
  end

  def find_by_id(id)
    all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    all.find {|merchant| merchant.name.upcase == name.upcase}
  end

  def find_all_by_name(name_fragment)
    all.find_all do |merchant|
      merchant.name.upcase.include?(name_fragment.upcase)
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_invoices(merchant_id)
    parent.find_invoices_by_merchant_id(merchant_id)
  end

  def find_items(merchant_id)
    parent.find_items_by_merchant_id(merchant_id)
  end

end


