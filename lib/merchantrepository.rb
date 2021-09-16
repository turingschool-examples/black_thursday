require 'csv'
require './lib/merchant'
# require './data/merchants'
# require './data/sample.csv'

class MerchantRepository

  @@filename = './data/sample.csv'

  def initialize
    @rows = CSV.read(@@filename, headers: true)
  end

  def self.all
    @rows.by_row

    csv_2_array = rows.map do |row|
      row.to_hash
    end

    csv_2_array
  end

  def self.find_by_id(id)
    @rows.by_row

    csv_2_hash = rows.map do |row|
      row.to_hash
    end

    csv_2_hash.find do |merchant|
      merchant["id"] == id.to_s
    end
  end

  def self.find_by_name(name)
    name_1 = name.upcase
    @rows.by_row

    csv_2_hash = rows.map do |row|
      row = row.to_hash
    end

    csv_2_hash.find_all do |merchant|
      merchant.values[1].upcase!
      merchant["name"] == name_1
    end
  end

  def self.find_all_by_name(name)
    name_1 = name.upcase
    @rows.by_row

    csv_2_hash = rows.map do |row|
      row = row.to_hash
    end

    csv_2_hash.find_all do |merchant|
      merchant.values[1].upcase!
      merchant["name"].include?(name_1)
    end
  end

  def self.create(name, created_at, updated_at)
    @rows.by_row

    csv_2_hash = rows.map do |row|
      row = row.to_hash
    end

    last_id = csv_2_hash.last['id'].to_i
    new_id = last_id += 1



    # new_biz = [new_id, name, created_at, updated_at]
    # CSV.open(@@filename, "a+") do |csv|
    #   csv << new_biz
    #   end
  end

end
