require 'csv'
require_relative '../lib/merchant'

class MerchantRepository

  attr_reader :all,
              :parent

  def initialize(file_path, parent)
    contents = CSV.open(file_path, headers: true, header_converters: :symbol)
    @all = contents.map do |row|
      Merchant.new({:id => row[:id], :name => row[:name]}, self)
    end
    @parent = parent
  end

  def call_sales_engine_items(id)
    parent.get_items(id)
  end

  def call_sales_engine_invoices(id)
    parent.get_invoices(id)
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    all.select do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end
