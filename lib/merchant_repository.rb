require 'pry'

require_relative 'csv_parse'
require_relative 'merchant'
require './lib/finderclass'


class MerchantRepository
  # include Finder

  attr_reader :all,
              :merchants

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @all = []
    make_merchants
    @merchants = all
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

  def find_by_id(id)
    FinderClass.find_by(@all, :id, id)
  end

  def find_by_name(name)
    FinderClass.find_by(@all, :name, name)
  end

  def find_all_by_name(frag)
    FinderClass.find_by_fragment(@all, :name, frag)
  end

end
