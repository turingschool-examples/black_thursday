require_relative "merchant_repository"
require_relative 'item'
require_relative 'merchant'
require 'csv'
class SalesEngine
  attr_reader :stash
  def initialize
    @stash = []
  end
  def self.from_csv(files)
    engine = SalesEngine.new
    files.each do |key, filepath|
      formatted_key = key.to_s.delete("_").delete_suffix("s").capitalize
      reader = CSV.open(filepath, headers: true, header_converters: :symbol)
      reader.each {|line| engine.stash << eval("#{formatted_key}.new(#{line})")}
    end
    engine
  end
  def merchants
    MerchantRepository.new(@stash)
  end
  def items
    ItemRepository.new(@stash)
  end
end
require "pry"; binding.pry
