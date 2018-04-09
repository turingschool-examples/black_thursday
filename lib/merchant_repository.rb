require 'csv'
require './lib/merchant'

class MerchantRepository
  attr_reader :path,
              :merchants

  def initialize(path)
    @merchants = []
    @path      = path
    @time      = Time.new
    pack_merchants(path)
  end

  def pack_merchants(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |merchant|
    merchants << Merchant.new(merchant)
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    found = merchants.map do |merchant|
      if merchant.name.downcase.include?(name.downcase)
        merchant.name
      end
    end
    found.compact
  end

  def find_highest_id
    merchants.map do |merchant|
      merchant.id
    end.max
  end

  def create_new_id
    find_highest_id + 1
  end

  # def create(attributes)
  #   attributes[:id] = create_new_id
  #   attributes[:name] =
  #   binding.pry
  #   merchants << Merchant.new(attributes)
  # end

  def update(id, name)
  end

  def delete(id)
    merchants.delete_if do |merchant|
      merchant.id == id
    end
  end

end
