require_relative 'sales_engine'
require_relative 'merchant'
require 'pry'
class MerchantRepository
# Responsible for holding and searching our Merchant instances.

attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end

  def parse_csv
    repository = {}
    @merchants.each do |row|
      repository[row[0]] = {
                    row.headers[0] => row[0],
                    row.headers[1] => row[1],
                    row.headers[2] => row[2],
                    row.headers[3] => row[3]
                   }
    end
    repository
  end

  def all
    merchant_objects = []
    @merchants.each do |merchant|
      merchant_objects << Merchant.new(merchant)
    end
    merchant_objects
  end

  def find_by_id(id)
    all.find do |merchant|
      id == merchant.id
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      name == merchant.name
    end
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.include?(name)
    end
  end

  def create(attributes)
    # create a new Merchant instance with the provided attributes. The new Merchant’s id should be the current highest Merchant id plus 1.
  end

  def update_id(id, attributes)
    # update the Merchant instance with the corresponding id with the provided attributes. Only the merchant’s name attribute can be updated.
  end

  def delete(id)
    # delete the Merchant instance with the corresponding id. The data can be found in data/merchants.csv so the instance is created and used like this:
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
