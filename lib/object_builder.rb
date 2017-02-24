require_relative 'merchant'
require_relative 'item'
require 'csv'
require 'pry'

class ObjectBuilder
  def initialize

  end

  def read_csv(args)
    { merchant: build_object(args[:merchants], Merchant),
      item:     build_object(args[:items], Item) }
  end

  def build_object(path, class_type)
    get_lines(path).map do |row|
      class_type.new(row)
    end
  end

  def get_lines(path)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def assign_parents(repos)
    repos.each { |repo| repo.all.each { |object| object.parent = repo } }
  end
end
