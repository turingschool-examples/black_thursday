require_relative '../lib/merchant'
require 'csv'

class MerchantRepository
  attr_reader :all, :engine
  def initialize(file = nil, engine = nil)
    @all = []
    @engine = engine
    load_data(file)
  end

  def add_merchant(merchant_object)
    @all << merchant_object
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      name.casecmp?(merchant.name)
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.upcase.include?(name.upcase)
    end
  end

  def create(attributes)
    new = Merchant.new(attributes)
    new.id = @all.max_by do |merchant|
      merchant.id
    end.id + 1
    @all << new
    new
  end

  def update(id, attributes)
    return unless attributes[:name]
    update_merchant = find_by_id(id)
    update_merchant.name = attributes[:name]
  end

  def delete(id)
    delete_merchant = find_by_id(id)
    @all.delete(delete_merchant)
  end

  def load_data(file)
    return nil unless file
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      add_merchant(Merchant.new(row, self))
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_all_by_merchant_id(id)
    @engine.find_all_by_merchant_id(id)
  end
end
