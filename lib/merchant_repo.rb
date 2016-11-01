require './lib/merchant'
require './lib/data_parser'

class MerchantRepo
  include DataParser
  attr_reader :all
  def initialize
    @all = parse_data('./data/merchants.csv').map { |row| Merchant.new(row) }
  end

  def find_by_id(id)
    @all.find(id) {|merchant| merchant.id.eql?(id)}
  end

  def find_by_name(name)
    @all.find(name) {|merchant| merchant.name.downcase.eql?(name.downcase)}
  end

  def find_all_by_name(name_fragment)
    @all.find_all {|merchant| merchant.name.downcase.include?(name_fragment)}
  end
end
