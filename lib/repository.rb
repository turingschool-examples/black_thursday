require 'csv'
require 'pry'

class Repository

  attr_reader :path, :data, :klass, :sales_engine

  def initialize(sales_engine, path, klass)
    @path = path
    @data = []
    @klass = klass
    @sales_engine = sales_engine
    load_file
  end

  def load_file
    CSV.foreach path, headers: true, header_converters: :symbol do |row|
      data << klass.new(row.to_hash, self)
    end
    data
  end

  def inspect
   "#<#{self.class} #{repository.size} rows>"
  end

end
