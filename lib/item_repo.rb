require_relative '../lib/item'
require_relative '../lib/repo'

class ItemRepo
  attr_reader :items,
              :contents,
              :parent,
              :repository

def initialize(data, parent)
    @repository = data.map do |row| 
      Item.new(row, self)
    end
    @parent = parent
  end

end
