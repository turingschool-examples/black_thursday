require_relative 'merchant'
require_relative 'item'
require_relative 'invoice'
require 'csv'
require 'pry'

class ObjectBuilder
  def initialize

  end

  def read_csv(args)
    { merchant: build_object(args[:merchants], Merchant),
      item:     build_object(args[:items], Item),
      invoice:  build_object(args[:invoices], Invoice) }
  end

  def build_object(path, class_type)
    get_lines(path).map { |row| class_type.new(row) }
  end

  def get_lines(path)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def assign_parents(repos)
    repos.each { |repo| repo.all.each { |object| object.repository = repo } }
  end
end
