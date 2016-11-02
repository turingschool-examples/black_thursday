require_relative './merchant'
require_relative './data_parser'

class MerchantRepo
  include DataParser
  attr_reader :all

  def initialize(file = nil)
    raw_file = file || './data/merchants.csv'
    @all     = parse_data(raw_file).map { |row| Merchant.new(row) }
  end

  def find_by_id(id)
    @all.find {|merchant| merchant.id.eql?(id)}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name.downcase.eql?(name.downcase)}
  end

  def find_all_by_name(name_fragment)
    @all.find_all {|merchant| merchant.name.downcase.include?(name_fragment)}
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
