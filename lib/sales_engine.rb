require 'pry'
require 'csv'
class SalesEngine
  attr_reader :items, :merchants
  def initialize(table_hash)
      @items = []
    @merchants = []
  end

  def self.from_csv(path_hash)
    table_hash = Hash.new
    path_hash.each do |name, path|
      csv = CSV.read(path, headers: true, header_converters: :symbol)
      table_hash[name] = csv
      # binding.pry
    end

    SalesEngine.new(table_hash)
  end
end
