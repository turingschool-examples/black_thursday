require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :path,
              :merchants

<<<<<<< HEAD
  def initialize
    @merchants = []
=======
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
>>>>>>> 928bc9d8a654d179c3b485c15b80461fcba49580
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

<<<<<<< HEAD
=======
  def find_highest_id
    merchants.map do |merchant|
      merchant.id
    end.max
  end

  def create_new_id
    find_highest_id + 1
  end

  def create(attributes)
    attributes[:id] = create_new_id
    merchants << Merchant.new(attributes)
  end

  def update(id, attributes)
    delete(id)
    attributes[:id] = id
      merchants << Merchant.new(attributes)
  end

  def delete(id)
    merchants.delete_if do |merchant|
      merchant.id == id
    end
  end

>>>>>>> 928bc9d8a654d179c3b485c15b80461fcba49580
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
