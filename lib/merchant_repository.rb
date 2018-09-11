require 'pry'

require_relative 'csv_parse'
require_relative 'merchant'
require './lib/finder'


class MerchantRepository
  include Finder

  attr_reader :all

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @all = []
    make_merchants
  end


  def make_merchants

    @csv.each { |key, value|
      number = key.to_s.to_i
      name = value[:name]
      merch = Merchant.new({id: number, name: name })
      @all << merch
    }
    @all.flatten!
  end
end

