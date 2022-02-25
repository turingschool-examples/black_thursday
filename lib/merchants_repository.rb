require 'csv'
require './lib/merchant'
require './lib/repository_aide'

class MerchantsRepository
  include RepositoryAide
  attr_reader :repository

  def initialize(file)
    @merchants = CSV.read(file, headers: true, header_converters: :symbol)
    @repository = @merchants.map do |merchant|
                  Merchant.new({:id => merchant[:id], :name => merchant[:name]})
                end
  end

  def find_by_name(name)
    find_all_by_name(name).first
  end

  def find_all_by_name(name)
    @repository.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    Merchant.new({id: new_id.to_s, name: attributes})
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name]
  end

end
