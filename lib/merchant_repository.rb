require 'pry'
require_relative '../lib/merchant'


class MerchantRepository

  attr_reader :merchants

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants = []
  end

  def all
    @merchants
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end


  def find_by_id(id)
    id.to_s
    result = nil
    @merchants.each do |merchant|
      if merchant.id == id
        result = merchant
      end
    end
    result
  end

  def find_by_name(name)
    result = nil
    @merchants.each do |merchant|
      if merchant.name.downcase == name.downcase
        result = merchant
      end
    end
    result
  end

  def find_all_by_name(name)
    results = []
    @merchants.each do |merchant|
      down = merchant.name.downcase
      if down.include?(name.downcase)
        results << merchant
      end
    end
    results
  end

  def from_csv(path)
    rows = CSV.open path, headers: true, header_converters: :symbol
    rows.each do |data|
      add_data(data)
    end
  end

  def add_data(data)
    @merchants << Merchant.new(data.to_hash, @sales_engine)
  end


end
# merchant = MerchantRepository.new
# binding.pry
