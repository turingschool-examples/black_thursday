require 'csv'

class MerchantRepository
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def all
    data = CSV.open(@file_path, headers: true, header_converters: :symbol)
    data.map {|row| Merchant.new(row)}
  end

  def find_by_id(id)
    all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    all.find {|merchant| merchant.name.upcase == name.upcase}
  end
end
