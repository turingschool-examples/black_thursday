require 'pry'
require 'csv'

class MerchantRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def read_csv_into_array
  array = []
  contents = CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol
  contents.map do |line|
    array << line[:id]
    puts array
    end

  end

  def find_by_id(array)
    # array.map do |name|
    #will take arguement of item_id
  end

  def find_by_name
    nil
    #will take argument of item_name
  end

  def find_all_by_name
    []
  end

end
final = MerchantRepository.new
final.read_csv_into_array
