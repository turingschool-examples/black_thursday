require 'csv'

class MerchantRepository
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def data
    CSV.open(@file_path, headers: true, header_converters: :symbol)
  end

  def all
    data.map {|row| Merchant.new(row)}
  end

  def find_by_id(id)
    all.find {|merch| merch.id == id}
  end

  def find_by_name(name)
    all.find {|merch| merch.name.upcase == name.upcase}
  end

  def find_all_by_name(fragment)
    all.find_all do |merch|
      merch.name.upcase.include?(fragment.upcase)
    end
  end
end
