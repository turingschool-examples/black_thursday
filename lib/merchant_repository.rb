require 'pry'
require 'CSV'
require './lib/merchant'
require './lib/sales_module'

class MerchantRepository

  include Repository

  attr_reader :repository

  def initialize(csv_merchants)
    @repository = []
    create_merchant(csv_merchants)
  end

  def create_merchant(csv_merchants)
    row_objects = CSV.read(csv_merchants, headers: true, header_converters: :symbol)
        @repository = row_objects.map do |row|
          Merchant.new(row)
      end
  end
  #
  # def all
  #   @merchants.count
  # end
  #
  # def find_by_id(id)
  #   @merchants.find do |merchant|
  #     merchant.id == id
  #   end
  # end
  #
  # def find_by_name(name)
  #   @merchants.find do |merchant|
  #     merchant.name.upcase == name.upcase
  #   end
  # end
  #
  # def find_all_by_name(name)
  #   @merchants.find_all do |merchant|
  #     merchant.name.upcase == name.upcase
  #   end
  # end

  # def create(attributes)
  # end

end
