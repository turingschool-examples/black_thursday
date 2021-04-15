require 'csv'
require_relative './merchant'
require_relative './repository'

# silent hound
class MerchantRepository < Repository

  def initialize(location_hash, engine)
    super(location_hash, engine)
    all_merchants
  end

  def all_merchants
    @csv_array = []
    CSV.parse(File.read(@location_hash[:merchants]), headers: true).each do |merchant|
      @csv_array << Merchant.new({ id: merchant[0],
                                   name: merchant[1],
                                   created_at: merchant[2],
                                   updated_at: merchant[3] }, self)
    end
  end

  def find_all_by_name(name)
    @csv_array.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(name)
    Merchant.new({ id: max_id_number_new,
                   name: name }, self)
  end

  def update(id, name)
    new = find_by_id(id)

    new.name = name
  end
end
