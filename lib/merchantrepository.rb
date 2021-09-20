require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(all)
    @all = all
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    name_1 = name.upcase

    @all.find do |merchant|

      merchant.name.upcase!
      merchant.name == name_1
    end
  end

  def find_all_by_name(name)
    name_1 = name.upcase

    @all.find_all do |merchant|
      merchant.name.upcase!
      merchant.name.include?(name_1)
    end
  end

  def create(name, created_at, updated_at)

    last_id = @all.last.id
    new_id = last_id += 1
    new_biz = [new_id, name, created_at, updated_at]

    # CSV.open('./data/merchants.csv', "a+") do |csv|
    #   csv << new_biz
    # end
  end

  def update(id, attributes)

     @all.find do |merchant|
      merchant.id == id
        merchant.name = attributes
      attributes
    end
  end

  def delete(id)
    @all.delete_if do |row|
      row.id == id
    end
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
 end
end
