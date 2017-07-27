require_relative 'item'
require 'pry'
class ItemRepo

    attr_reader :items

    def initialize(file,se = nil)
      @items = {}
      open_file(file)

    end

    def open_file(file)
      CSV.foreach file,  headers: true, header_converters: :symbol do |row|
        data = row.to_h
        items[data[:id].to_i] = Item.new(data, self)
      end
    end

    def all
      items.values
    end

    def find_by_id
      items[:id]

    end

    def find_by_name
      all.find {|item| item.name.downcase == name.downcase}


    end

    def find_all_with_description


    end
end
