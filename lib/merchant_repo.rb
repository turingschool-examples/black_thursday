require_relative 'black_thursday_helper'
class MerchantRepo
  #how do we indent this?
  include Black_Thursday_Helper

  def initialize(file_path)
    @merchants = []
    populate(file_path)
  end

  def all
    @merchants
  end


end
