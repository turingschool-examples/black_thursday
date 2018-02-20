# frozen_string_literal: true

require 'CSV'
require 'pry'
require_relative 'merchant'

# Merchant Repository gets data from CSV
class MerchantRepository
  def initialize(filepath)
    @merchants = []
    load_merchants(filepath)
  end

  def all
    @merchants
  end

  def load_merchants(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data)
    end
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.casecmp?(name)
    end
  end

  def find_all_by_name(segment)
    segment = segment.downcase
    @merchants.select do |merchant|
      merchant.name.downcase.include?(segment)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.length} rows>"
  end
end
