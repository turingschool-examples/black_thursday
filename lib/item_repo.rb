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
        item[data[:id].to_i] = Merchant.new(data, self)
    end

    def all
      items.values
    end

    def find_
