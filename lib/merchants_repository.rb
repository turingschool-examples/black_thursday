require 'csv'
require './lib/merchant'

class MerchantsRepository
  attr_reader :repository

  def initialize(file)
    @merchants = CSV.read(file, headers: true, header_converters: :symbol)
    @repository = @merchants.map do |merchant|
                  Merchant.new({:id => merchant[:id], :name => merchant[:name]})
                end
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @repository.find do |merchant|
      merchant.name == name
    end
  end

  # def find_all_by_name(name)
  #   @repository.find_all do |merchant|


end
