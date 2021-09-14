require 'merchant.rb'
require 'csv'

class MerchantRepository
  attr_reader :path,
              :all

  def initialize(path)
    @path = path
    @all  = read_file
  end

  def read_file
    rows = CSV.read(@path, headers: true, header_converters: :symbol)

    rows.map do |row|
      Merchant.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      id == merchant.id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      name.downcase == merchant.name.downcase
    end
  end

  def find_all_by_name(name) # include
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end
end
