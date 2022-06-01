require 'CSV'
class MerchantRepository

  attr_reader :merchants,
              :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row)
      # require "pry"; binding.pry
    end
    @all
  end

  def self.from_csv(data)
    MerchantRepository.new(data[:merchants])
  end

  def find_by_id(id)
    @all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(name)
    @all.find_all {|names| names.name.include?(name)}
  end
end
