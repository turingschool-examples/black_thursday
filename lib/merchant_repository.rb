require 'pry'

require_relative 'csv_parse'
require_relative 'finderclass'

require_relative 'merchant'

class MerchantRepository

  attr_reader :all

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @merchants = []
    make_merchants
    @all = @merchants
  end

  def make_merchants
    @csv.each { |key, value|
      number = key.to_s.to_i
      name = value[:name]
      merch = Merchant.new({id: number, name: name })
      @merchants << merch
    }
  end


  # --- Find By ---

  def find_by_id(id)
    FinderClass.find_by(all, :id, id)
  end

  def find_by_name(name)
    FinderClass.find_by_insensitive(all, :name, name)
  end

  def find_all_by_name(frag)
    FinderClass.find_by_fragment(all, :name, frag)
  end

end
