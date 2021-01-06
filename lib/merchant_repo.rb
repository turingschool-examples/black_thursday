require 'CSV'
require './lib/cleaner.rb'
require './lib/merchant.rb'

class MerchantRepository

  def initialize(file = './data/merchants.csv')
    @file = file
    @merchants = []
    @data = CSV.open(@file, headers: true, header_converters: :symbol)
  end

  def build_merchants
    @data.map do |merchant|
      cleaner = Cleaner.new
      merch = Merchant.new({ id: cleaner.clean_id(merchant[:id]),
                            name: cleaner.clean_name(merchant[:name]),
                            created_at: cleaner.clean_date(merchant[:created_at]),
                            updated_at: cleaner.clean_date(merchant[:updated_at])})
      @merchants << merch
      end
    @merchants
  end

  def find_id(id)
    build_merchants.select do |merchant|
          merchant.id == id
    end
  end

  def find_by_id(id)
    if find_id(id).empty?
      nil
    else
      find_id(id)
    end
  end

  def find_by_name(name)
    found_name = []
    build_merchants.each do |merchant|
        if merchant.name.upcase == name.upcase
          found_name << merchant
        end
    end
    found_name
  end

  def find_all_by_name(search_term)
    all_names = []
    build_merchants.each do |merchant|
      if merchant.name.upcase.include?(search_term.upcase)
        all_names << merchant
      end
    end
    all_names
  end

  def create(attributes)
    Merchant.new({id: (sort_by_id[-1].id + 1), name: attributes})
  end

  def sort_by_id
    build_merchants.sort_by do |merchant|
      merchant.id
    end
  end
end
