require_relative '../lib/item'

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
