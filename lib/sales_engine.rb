require 'csv'
require 'pry'


class SalesEngine
attr_reader :items, :merchants, :merchant_lines, :item_lines

  def self.from_csv(data)
    @merchant_lines = File.readlines data[:merchants]
    @item_lines = File.readlines data[:items]
    [@merchant_lines, @item_lines]
    end


  end
