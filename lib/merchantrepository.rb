require 'csv'
require './lib/merchant'
# require './data/merchants'
# require './data/sample.csv'

class MerchantRepository

  @@filename = './data/sample.csv'
  @rows = CSV.read(@@filename, headers: true).by_row
  def initialize

  end



  def self.all
    csv_2_array = @rows.map do |row|
      row.to_hash
    end
    csv_2_array
  end

  def self.find_by_id(id)
    csv_2_hash = @rows.map do |row|
      row.to_hash
    end
    csv_2_hash.find do |merchant|
      merchant["id"] == id.to_s
    end
  end

  def self.find_by_name(name)
    name_1 = name.upcase
    csv_2_hash = @rows.map do |row|
      row = row.to_hash
    end
    csv_2_hash.find_all do |merchant|
      merchant.values[1].upcase!
      merchant["name"] == name_1
    end
  end

  def self.find_all_by_name(name)
    name_1 = name.upcase

    csv_2_hash = @rows.map do |row|
      row = row.to_hash
    end

    csv_2_hash.find_all do |merchant|
      merchant.values[1].upcase!
      merchant["name"].include?(name_1)
    end
  end

  def self.create(name, created_at, updated_at)
    csv_2_hash = @rows.map do |row|
      row = row.to_hash
    end

    last_id = csv_2_hash.last['id'].to_i
    new_id = last_id += 1
    new_biz = [new_id, name, created_at, updated_at]

    # CSV.open(@@filename, "a+") do |csv|
    #   csv << new_biz
    #   end
  end

  def self.update(id, attributes)
    object = self.find_by_id(id)
    object["name"] = attributes
    object
  end

end
