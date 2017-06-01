require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository

  attr_reader :merchants,
              :engine

  def initialize(csv, engine)
    @merchants = {}
    @engine = engine
    self.add(csv)

  end

  def add(csv)
    csv.each do |row|
      stuff = row.to_h
      merchants[stuff[:id]] = Merchant.new(stuff, self)
    end
  end

  def all
    merchants.values
  end

  def find_by_id(id)
    merchants[id]
  end

  def find_by_name(name)
    all.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name_frag)
    all.find_all { |merchant| merchant.name.downcase.include?(name_frag.downcase)}
  end

  def all_merchant_items(merchant_id)
    engine.all_merchant_items(merchant_id)
  end
end
