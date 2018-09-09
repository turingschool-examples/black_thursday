require_relative 'crud.rb'
require_relative 'merchant_repository'
require './test/test_helper'

class SalesEngine
  include Crud
  
  attr_reader :filepath 
  attr_accessor :merchants,

  def initialize(filepath)
    @filepath = filepath
    @merchants = MerchantRepository.new(load(filepath[:merchants]))

    binding.pry
  end

  def self.from_csv(hash)
    merchant_file = hash[:merchants]
    merchant_array = load(filepath[:merchants])
  end
end
