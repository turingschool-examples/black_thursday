require './lib/merchant'
require 'csv'

class MerchantRepo
  attr_reader :all

  def initialize
    @all = to_array
  end

  def to_array
  merchants = []
  CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
    headers = row.headers
    merchants << Merchant.new(row.to_h)
  end
  merchants
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

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_highest_id
    highest = all.max_by do |merchant|
      merchant.id
    end
    highest.id
  end


  def create(attributes)
    all << Merchant.new({id: find_highest_id + 1, name: attributes[:name]})
  end

  def update(id, attributes)
    find_by_id(id).change_name(attributes[:name])
  end


end
