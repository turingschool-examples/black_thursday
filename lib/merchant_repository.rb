require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_merchants(path)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def create_merchants(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |merchant|
    @all << Merchant.new(merchant, self)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.upcase == name.upcase
    end
  end

  def find_all_by_name(name)
    @all.select do |merchant|
        merchant.name.downcase.include?name.downcase
    end
  end

  def next_highest_merchant_id
    @all.max_by do |merchant|
      merchant.id
    end.id + 1
  end

  def create(attributes)
    new_merchant = Merchant.create_merchants(attributes, self)
    @all << new_merchant
  end

  def update(id, attributes)
    # require "pry"; binding.pry
    # if find_by_id(id) !nil?
    find_by_id(id).update(attributes)
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end

end
