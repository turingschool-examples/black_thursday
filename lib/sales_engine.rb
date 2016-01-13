require_relative 'merchant_repository'
require 'pry'
require 'csv'

class SalesEngine
  attr_reader :contents

  def initialize
    #takes Repos as args
  end

  def self.from_csv(hash_of_csv_files)
    #create the needed CSV objects
    #create MerchRepo
    #create ItemRepo

    SalesEngine.new#(merchrepo, itemrepo)

    # create instance of Sales Engine
    # make sure the sales engine that I'm returning has a merchant repo and a items repo

    # @csv_files = {}
    # hash_of_csv_files.each do |key, value|
    #   csv_file_object = CSV.open value, headers: true, header_converters: :symbol
    #   @csv_files[key] = csv_file_object
    # end
    #return an instance of the SalesEngine
  end

  def self.merchants
    mr = MerchantRepository.new(@csv_files[:merchants])
  end

  def self.items
    ir = ItemsRepository.new(@csv_files[:items])
  end

end

if __FILE__ == $0

se = SalesEngine.from_csv({:merchants => './data/merchants.csv'})
binding.pry
mr = SalesEngine.merchants
# mr = se.merchants
# puts mr.all
puts mr.find_by_name("Shopin1901")
# puts mr.find_by_name("jejum")

end
