<<<<<<< HEAD
require 'pry'
require 'csv'
class SalesEngine
  def initialize(items_and_merchants)
    @items = items_and_merchants[:items]
    @merchants = items_and_merchants[:merchants]
=======
require_relative './merchant_repository'
require_relative './merchant'
require_relative './item_repository'
require_relative './item'
require 'csv'
require 'bigdecimal'
require 'time'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(merchants_filepath, items_filepath)
    @merchants = MerchantRepository.new(merchants_filepath)
    @items = ItemRepository.new(items_filepath)
  end

  def self.from_csv(filepath_hash)
    merchants_filepath = filepath_hash[:merchants]
    items_filepath = filepath_hash[:items]
    SalesEngine.new(merchants_filepath, items_filepath)
>>>>>>> f383e696193518f2683634daad455d6f6829953c
  end

  def self.from_csv(file)
    csv_object = CSV.open("file", headers: true, header_converters: :symbol)
    csv_object.map do |object|
      object[]
end
