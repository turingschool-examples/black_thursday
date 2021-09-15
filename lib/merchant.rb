# require './merchantrepository'
require 'csv'
class Merchant
  # include MerchantRepository
  attr_reader :id,
              :name,
              :merchants
  @@filename = './data/sample.csv'

  def initialize(info)
    @id = info[:id]
    @name = info[:name]
  end

  def self.all
    rows = CSV.read(@@filename, headers: true)
    rows.by_row

    csv_2_array = rows.map do |row|
      row.to_a.flatten
    end

    csv_2_array
  end

  def self.find_by_id(id)
    rows = CSV.read(@@filename, headers: true)
    rows.by_row

    csv_2_hash = rows.map do |row|
      row.to_hash
    end

    csv_2_hash.find do |merchant|
      merchant["id"] == id.to_s
    end
  end

  def self.find_by_name(name)

    name_1 = name.upcase

    rows = CSV.read(@@filename, headers: true)
    rows.by_row

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

    rows = CSV.read(@@filename, headers: true)
    rows.by_row

    csv_2_hash = rows.map do |row|
      row = row.to_hash
    end

    csv_2_hash.find_all do |merchant|
      merchant.values[1].upcase!
      merchant["name"].include?(name_1)
    end
  end

end
