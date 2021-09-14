require 'merchant.rb'
require 'csv'

class MerchantRepository
  attr_reader :path,
              :all

  def initialize(path)
    @path = path
    @all  = read_file
  end

  def read_file
    rows = CSV.read(@path, headers: true, header_converters: :symbol)

    rows.map do |row|
      Merchant.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id
    end
  end
end
