require_relative 'searching'
require_relative 'merchant'

# Creates and manages merchant repository
class MerchantRepository
  include Searching
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = add_merchants
  end

  def add_merchants
    data.map { |row| Merchant.new(row) }
  end

  def find_all_by_name(fragment)
    @all.find_all do |obj|
      obj.name.upcase.include?(fragment.upcase)
    end
  end
end
