require 'CSV'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
  end

  

end
