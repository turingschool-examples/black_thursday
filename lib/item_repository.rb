require './lib/csv_parser'
require './lib/item'

class ItemRepository
include CsvParser

attr_accessor :items

    def initialize(file_name)
        @items = []
        item_parse_data(file_name)
    end

end
