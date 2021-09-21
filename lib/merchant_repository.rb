# frozen_string_literal: true

require 'csv'
require_relative 'merchant'
require_relative 'csv_readable'

class MerchantRepository
  include CSV_readable

  attr_reader :all

  def initialize(path)
    @all = generate(path)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def generate(path)
    rows = read_csv(path)

    rows.map do |row|
      Merchant.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      id == merchant.id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      name.downcase == merchant.name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    @all << Merchant.new(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.update_name(attributes[:name]) if attributes[:name]
    merchant
  end

  def delete(id)
    merchant = find_by_id(id)

    @all.delete(merchant)
  end
end
