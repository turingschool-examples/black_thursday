require 'CSV'

require_relative './cleaner'
require_relative './merchant'


class MerchantRepository
  attr_accessor :merchants
  attr_reader :engine

  def initialize(file = './data/merchants.csv', engine)
    @engine = engine
    @file = file
    @merchants = []
    @data = CSV.open(@file, headers: true, header_converters: :symbol)
    build_merchants
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def build_merchants
    @data.map do |merchant|
      cleaner = Cleaner.new
      merch = Merchant.new({
        id: cleaner.clean_id(merchant[:id]),
        name: cleaner.clean_name(merchant[:name]),
        created_at: cleaner.clean_date(merchant[:created_at]),
        updated_at: cleaner.clean_date(merchant[:updated_at])}, self)
      @merchants << merch
      end
    @merchants
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.select do |merchant|
          merchant.id == id
    end[0]
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.upcase == name.upcase
    end
  end

  def find_all_by_name(search_term)
    @merchants.find_all do |merchant|
      merchant.name.upcase.include?(search_term.upcase)
    end
  end

  def create(attributes)
    new_id = (sort_by_id[-1].id + 1 )
    attributes_final = {:id => new_id}
    attributes.each do |attribute_key, attribute_value|
      attributes_final[attribute_key] = attribute_value
    end 
    new_merch = Merchant.new(attributes_final, self)
    @merchants << new_merch
    new_merch
  end

  def sort_by_id
    merch = @merchants.sort_by do |merchant|
      merchant.id
    end
  end

  def update(id, attributes)
    find_by_id(id).update(attributes)
  end


  def delete(id)
    @merchants = @merchants.reject do |merchant|
      merchant.id == id
    end
  end
end
