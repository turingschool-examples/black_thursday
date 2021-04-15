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
      @csv_array << Merchant.new( id: merchant[0],
                                   name: merchant[1],
                                   created_at: merchant[2],
                                   updated_at: merchant[3],
                                   repository: self )
    end
  end

  def find_all_by_name(name)
    @csv_array.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    merchant_new = Merchant.new( id: max_id_number_new,
                   name: attributes[:name],
                   repository: self )
    @csv_array << merchant_new
    merchant_new
  end

  def update(id, name_hash)
    new = find_by_id(id)
    if new.nil?
      nil
    else
      new.name = name_hash[:name]
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
