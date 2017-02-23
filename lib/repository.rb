require 'csv'
require 'pry'


class Repository

  attr_reader :path, :data

  def initialize(path, klass)
    @path = path
    @data = []
    @klass = klass
  end


  def load_file
    CSV.foreach @path, headers: true, header_converters: :symbol do |row|
      @data << @klass.new(row.to_hash)
    end
  end

end
