require_relative 'file_loader'
require_relative 'merchant_repository'
require_relative 'merchant'
# require_relative 'item'
# require_relative 'item_repository'
require_relative 'sales_analyst'
class SalesEngine
    attr_reader :data
  def intialize(data)
    @data = data
  end
end
