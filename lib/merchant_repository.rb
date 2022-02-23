require_relative '../lib/merchant'
require 'CSV'
require 'pry'

class MerchantRepository

  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def rows
    rows = CSV.read(@filename, headers: true, header_converters: :symbol)
  end

  def current_highest_id
    sorted = rows.sort_by {|row| row[:id]}
    highest_id = sorted[-1][:id]
    highest_id.to_i
  end

  def all
    result = rows.map {|row| Merchant.new(row)}
  end

  def find_by_id(id)
    result = rows.map do |row|
      Merchant.new(row) if row[:id] == id
    end
    !result.empty? ? result[0] : nil
  end

  def find_by_name(name)
    result = rows.map do |row|
      Merchant.new(row) if row[:name] == name
    end
    !result.empty? ? result[0] : nil
  end

  def find_all_by_name(fragment)
    result = rows.find_all do |row|
      row[:name].include?(fragment)
    end
    !result.empty? ? result.map {|row| Merchant.new(row)} : nil
  end

  def create(name)
    id = current_highest_id + 1
    id = id.to_s
    Merchant.new(id: id, name: name)
  end

end
