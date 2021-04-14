require './lib/merchants'
require 'csv'

class MerchantRepo
  attr_reader :merchants_list

  def initialize(csv_files)
    @merchants_list = merchant_instances(csv_files)
    # require'pry';binding.pry
  end

  def merchant_instances(csv_files)
    merchants = CSV.open(csv_files, headers: true,
    header_converters: :symbol)

    @merchants_list = merchants.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def all
    @merchants_list
  end

  def find_by_id(id)
    @merchants_list.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants_list.find do |merchant|
      (merchant.name).downcase == name.downcase
    end
  end

  def find_all_by_name(fragment)
    @merchants_list.find_all do |merchant|
      (merchant.name).downcase.include?(fragment.downcase)
    end
  end

  def create(attributes)
    new_merchant = Merchant.new(attributes)
    find_max_id = @merchants_list.max_by do |merchant|
      merchant.id
    end
    new_merchant.id = (find_max_id.id + 1)
    merchants_list << new_merchant
  end
end
