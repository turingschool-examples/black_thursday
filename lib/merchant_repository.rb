require 'CSV'
require 'pry'
require_relative 'merchants.rb'
require_relative 'crud.rb'

class MerchantRepository
include Crud
	attr_reader :collection

  def initialize(filepath)
    @collection = []
    load(filepath)
  end

  def load(filepath)
      csv_objects = CSV.open(filepath, headers: true, header_converters: :symbol)
      csv_objects.map do |object|
        object[:id] = object[:id].to_i
        @collection << object.to_h
      end
  end
end
