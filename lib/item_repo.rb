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

    def all
        @repository
    end

    def find_by_id(id)
        repository.find do |child|
            child.id == id
        end
    end

    def find_by_name(name)
        repository.find do |child|
            child.name.downcase == name.downcase
        end
    end
    
    def find_all_with_description(description)
    end



end
