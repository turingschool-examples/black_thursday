# require './lib/merchant'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(merchant_contents)
    @merchants = make_merchants(merchant_contents)
  end

  def make_merchants(merchant_contents)
    merchant_contents.map do |row|
      Merchant.new(make_prepared_data(row))
    end
  end

  def make_prepared_data(row)
    { id:   row[:id].to_i,
      name: row[:name]
    }
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |merc| merc.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merc| merc.name.upcase == name.upcase }
  end

  def find_all_by_name(name)
    @merchants.find_all { |merc| merc.name.upcase.include? name.upcase }
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
