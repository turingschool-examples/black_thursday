require 'pry'
require 'csv'

class MerchantRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def add_merchants(merchant)
    all <<(merchant)
  end

  def find_by_id(id)
    all.find do |merch|
      merch.id == id
    end
  end

  def find_by_name(name)
    all.find do |merch|
      merch.name == name
    end
  end

  def find_all_by_name(name2)
    all.find_all do |merch|
      merch.name.include?(name2)
    end
  end
end
