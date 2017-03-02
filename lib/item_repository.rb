require_relative 'item'
require 'pry'
require 'time'
require_relative '../lib/data_access'

class ItemRepository
  include DataAccess
  attr_reader :csv_file,
              :all,
              :parent

  def initialize(path, parent=nil)
    @csv_file = CSV.open(path, headers: true, header_converters: :symbol)
    @all = []
    @parent = parent
    populate_repo
  end

  def populate_repo
    csv_file.each do |row|
      item = Item.new({:id => row[:id].to_i,
        :name => row[:name],
        :description => row[:description],
        :unit_price => transform_price(row[:unit_price]),
        :merchant_id => row[:merchant_id].to_i,
        :created_at => Time.parse(row[:created_at]),
        :updated_at => Time.parse(row[:updated_at])}, self)
        @all << item
      end
  end
end