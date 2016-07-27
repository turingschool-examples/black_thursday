require "./lib/sales_engine"
require "csv"
class MerchantRepository
attr_reader :all
  def initialize(csv)
    @csv = csv
    @all = []
    @self
  end

  def csv?
    @csv.is_a?(CSV)
  end

  def csv_opener
    @csv.read.each_with_index do |row, index|
      hash = Hash.new{:id => row[0].to_i,:name => row[1]}
      binding.pry
  end
end
