require 'CSV'
require 'pry'
require './lib/merchants'


class MerchantRepository
  def initialize(filepath)
    @merchants = []
    load_merchants(filepath)
  end

  def all
    @merchants
  end

  def load_merchants(filepath)
      csv_objects = CSV.open(filepath, headers: true, header_converters: :symbol)
      csv_objects.map do |object|
        object[:id] = object[:id].to_i
        @merchants << object.to_h
      end
    end
  end