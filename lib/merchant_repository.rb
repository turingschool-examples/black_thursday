require 'csv'

class MerchantRepository
  attr_reader :path,
              :merchants

  def initialize(path)
    @path = path
    @merchants = []
  end
end
