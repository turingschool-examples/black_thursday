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

  # def all
  #   @repository
  # end

  # def find_by_id(id_search)
  #   @repository.find do |merchant|
  #     merchant.id == id
  #   end
  # end

  # def find_by_name(name)
  #   @repository.find do |merchant|
  #     merchant.name == name
  #   end
  # end

  def find_by_name(name)
    find_all_by_name(name).first
  end

  def find_all_by_name(name)
    @repository.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    # new_id = @repository.sort_by do |merchant|
    #             merchant.id
    #           end.last
    # new_id = new_id.id.to_i
    # new_id += 1
    Merchant.new({id: new_id.to_s, name: attributes})
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name]
  end

  def delete(id)
    merchant = find_by_id(id)
    @repository.delete(merchant)
  end

end
