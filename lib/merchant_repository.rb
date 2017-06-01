require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(file)
    @all = []
    populate_merchant_repo(file)
  end

  def populate_merchant_repo(file)
    merchant_lines = CSV.open(file, headers: true, header_converters: :symbol)
    merchant_lines.each do |row|
      merchant = Merchant.new(row)
      all << merchant
    end
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
end
