require 'pry'
class Merchant
  attr_reader :name,
              :repository,
              :id,
              :items



  def initialize(data, parent = nil)
    @name = data[:name]
    @id = data[:id]
    @repository = parent
    # @items = []
  end

 def items
  #  binding.pry
  repository.find_items_belonging_to_merchant(id)

end

end
