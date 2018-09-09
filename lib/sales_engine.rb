require 'pry'
require 'csv'
class SalesEngine
  def initialize(items_and_merchants)
    @items = items_and_merchants[:items]
    @merchants = items_and_merchants[:merchants]
  end

  def self.from_csv(file)
    csv_object = CSV.open("file", headers: true, header_converters: :symbol)
    csv_object.map do |object|
      object[]
end
