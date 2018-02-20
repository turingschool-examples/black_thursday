require './lib/searching'

class MerchantRepository
  include Searching
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def all
    data.map {|row| Merchant.new(row)}
  end

  def find_all_by_name(fragment)
    all.find_all do |merch|
      merch.name.upcase.include?(fragment.upcase)
    end
  end
end
