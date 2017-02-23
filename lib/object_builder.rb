require './lib/merchant'
require 'csv'
require 'pry'

class ObjectBuilder
  def initialize

  end

  def read_csv(args)
    { merchant: build_object(args[:merchant], Merchant),
      item:     build_object(args[:item], Item) }
  end

  def build_object(path, class_type)
    line = CSV.open path, headers: true, header_converters: :symbol
    line.map { |row| class_type.new(row) }
  end
end
