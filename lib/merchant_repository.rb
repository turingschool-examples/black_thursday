require 'csv'
require_relative 'merchant'
require_relative 'repository'

# silent hound
class MerchantRepository < Repository

  def initialize(location_hash, engine)
    super(location_hash, engine)
    all_merchants
  end

  def all_merchants
    @csv_array = []
    CSV.parse(File.read(@location_hash[:merchants]), headers: true).each do |merchant|
      @csv_array << Merchant.new(id: merchant[0],
                                 name: merchant[1],
                                 created_at: Time.parse(merchant[2]),
                                 updated_at: Time.parse(merchant[3]),
                                 repository: self)
    end
  end

  def find_all_by_name(name)
    @csv_array.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    merchant_new = Merchant.new(id: max_id_number_new,
                                name: attributes[:name],
                                created_at: Time.now,
                                updated_at: Time.now,
                                repository: self)
    @csv_array << merchant_new
    merchant_new
  end

  def update(id, name_hash)
    new = find_by_id(id)
    unless new.nil?
      new.name = name_hash[:name] unless name_hash[:name].nil?
      new.updated_at = Time.now
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
