require './lib/merchant'
require 'csv'
require 'pry'

class MerchantRepo
  def initialize(file, sales_engine=nil)
    # @parent = sales_engine
    @all = []
    parse_file(file)
  end

  def parse_file(file)
    CSV.foreach(file) do |row|
      next if row[0] == "id"
      add_merchant(row)
    end
  end

  def add_merchant(row)
    data = {:id => row[0],
        :name => row[1],
        :created_at => row[2],
        :updated_at => row[3]
        }
    @all << Merchant.new(data, self)
  end

  def all
    @all
  end

  def find_by_id(desired_id)
    desired_id.to_i
    @all.find do |merchant| 
       merchant.id == desired_id
    end
  end

  def find_by_name(desired_name)
    desired_name.to_s.downcase
    @all.find {|merchant| merchant.name == desired_name}
  end

  def find_all_by_name(fragment)
    suggested_merchants = []
    fragment.to_s.downcase
    @all.find do |merchant|
    binding.pry
      if merchant.name.include?(fragment)
      binding.pry
        suggested_merchants << merchant.name
      else
        suggested_merchants
      end
    end
  end

end

