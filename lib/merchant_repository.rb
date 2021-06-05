require 'spec_helper'

class MerchantRepository
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
  
  attr_reader :all

  def initialize(path)
    @all = []
    create_merchants(path)
  end

  def create_merchants(path)
    merchants = CSV.foreach(path, headers: true, header_converters: :symbol) do |merchant_data|
      merchant_hash = {
        id:         merchant_data[:id].to_i,
        name:       merchant_data[:name],
        created_at: merchant_data[:created_at],
        updated_at: merchant_data[:updated_at]
      }
      @all << Merchant.new(merchant_hash)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name)
    end
  end

  def create(attributes)
    highest_id = @all.max_by { |merchant| merchant.id }
    merchant = Merchant.new(attributes)
    merchant.new_id(highest_id.id + 1)
    @all << merchant
  end

  def update(id, attributes)
    update1 = @all.find do |merchant|
      merchant.id == id
    end
    update1.update_name(attributes)
  end

  def delete(id)
    merchant = @all.find do |merchant|
      merchant.id == id
    end
    @all.delete(merchant)
  end
end
