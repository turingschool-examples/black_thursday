require 'CSV'

require_relative './cleaner'
require_relative './merchant'


class MerchantRepository
  attr_accessor :merchants
  attr_reader :engine

  def initialize(file = './data/merchants.csv', engine)
    @engine = engine
    @file = file
    @merchants = {}
    @data = CSV.open(@file, headers: true, header_converters: :symbol)
    build_merchants
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def build_merchants
    @data.each do |merchant|
      cleaner = Cleaner.new
      @merchants[merchant[:id].to_i] = Merchant.new({

                                      id: cleaner.clean_id(merchant[:id]),
                                      name: cleaner.clean_name(merchant[:name]),
                                      created_at: cleaner.clean_date(merchant[:created_at]),
                                      updated_at: cleaner.clean_date(merchant[:updated_at])}, self)
      # @merchants << merch
      end
    # @merchants
  end

  def all
    @merchants.values
  end

  def find_by_id(id)
    @merchants[id]
  end

  def find_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end[0]
  end

  def find_all_by_name(search_term)
    all.find_all do |merchant|
      merchant.name.upcase.include?(search_term.upcase)
    end
  end

  def max_id
    @merchants.keys.max
  end

  def create(attributes)
    new = Merchant.new(attributes, self)
    new.id = (max_id + 1)
    @merchants[new.id] = new
  end
  # def create(attributes)
  #   new_id = (sort_by_id[-1].id + 1 )
  #   attributes_final = {:id => new_id}
  #   attributes.each do |attribute_key, attribute_value|
  #     attributes_final[attribute_key] = attribute_value
  #   end
  #   @merchants[new_id] = Merchant.new(attributes_final, self)
  #   all.last
  # end
  #
  # def max_id
  #   merch = @merchants.sort_by do |merchant|
  #     merchant.id
  #   end
  # end

  def update(id, attributes)
    merchant = find_by_id(id)
    if merchant != nil
      attributes.each do |attribute_key, attribute_value|
        merchant.update({attribute_key => attribute_value})
      end
    end
    merchant
  end

  def delete(id)
    @merchants = @merchants.reject do |merchant|
      merchant.id == id
    end
  end
end
