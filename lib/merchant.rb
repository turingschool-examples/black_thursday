# require './merchantrepository'
require 'csv'
class Merchant
  # include MerchantRepository
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  @@filename = './data/sample.csv'

  def initialize(info)
    @id = info[:id]
    @name = info[:name]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
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

  def self.create(name, created_at, updated_at)

    rows = CSV.read(@@filename, headers: true)
    rows.by_row

    csv_2_hash = rows.map do |row|
      row = row.to_hash
    end

    id = csv_2_hash.map do |merchant|
      merchant[:id] += 1
    end

    # id = csv_2_hash.last += 1


    new_biz = [id, name, created_at, updated_at]
    CSV.open(@@filename, "a+") do |csv|
      csv << new_biz
      end
  end

end
