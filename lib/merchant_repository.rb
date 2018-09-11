require 'pry'

require_relative 'csv_parse'
require_relative 'merchant'
require './lib/finder'


class MerchantRepository
  include Finder

  attr_reader :all

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @all = []
    make_merchants
  end


  def make_merchants

    @csv.each { |key, value|
      number = key.to_s.to_i
      name = value[:name]
      merch = Merchant.new({id: number, name: name })
      @all << merch
    }
    @all.flatten!
  end

  # Customized find methods that retain permission rights
  def all
    merchants
  end

  def find_by_id(id)
    find_by(merchants, id)
  end

  def find_by_name(specific_name)
    # repo w/ permission, column/method, specific string
    find_by(merchants, :name, specific_name)
  end

  def find_all_by_name(specific_name)
    find_all_by(merchants, :name, specific_name)
  end

  # Customized CRUD methods that retain permission rights
  # def create(hash)
  #   # {id: number, name: name }
  #   # id needs to be max + 1
  # end
  #
  # def update(id, new_name)
  #   object = find_by_id(id)
  #   update_obj(object, :name, new_name)
  # end
  #
  # def delete(id)
  #   @merchants.delete_if(id)
  # end
end

