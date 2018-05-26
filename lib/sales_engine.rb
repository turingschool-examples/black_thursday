require './lib/file_loader.rb'
require './lib/merchant_repository.rb'

class SalesEngine
  include FileLoader
  attr_reader :content

  def initialize(content)
    @content = content
    @merchants = nil
  end

  def self.from_csv(content)
    new(content)
  end

  def merchants
    @merchants = MerchantRepository.new(load_file(content[:merchants]))
  end
end
