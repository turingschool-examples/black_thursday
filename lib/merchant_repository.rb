require 'time'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(file_path, engine)
    @engine = engine
    @merchants = create_repository(file_path)
  end

  def create_repository(file_path)
    file = CSV.readlines(file_path, headers: true, header_converters: :symbol)
    file.map do |row|
      Merchant.new(row)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id.to_i == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.casecmp(name).zero?
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def max_merchant_id
    @merchants.max_by do |merchant|
      merchant.id
    end.id
  end

  def create(attributes) #needs test
    @merchants.push(Merchant.new({
                                  id: max_merchant_id + 1,
                                  name: attributes[:name],
                                  created_at: Time.now, #lookinto sriptime
                                  updated_at: Time.now
                                  }))
  end

  def update(id, attribute)
    return nil if find_by_id(id).nil?
    find_by_id(id).name = attribute[:name]
    find_by_id(id).updated_at = Time.now.round
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end
end
