require 'csv'
require 'pry'

class Repository

  attr_reader :path, :data, :klass

  def initialize(path, klass)
    @path = path
    @data = []
    @klass = klass
    load_file
  end

  def load_file
    CSV.foreach @path, headers: true, header_converters: :symbol do |row|
      @data << @klass.new(row.to_hash)
    end
    data
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
