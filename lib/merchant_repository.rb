require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository
  attr_reader :repository
  def initialize(data)
    @repository = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Merchant.new(data)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    if repository.keys.include?(id)
      return repository[id]
    else
      return nil
    end
  end

  def find_by_name(name)
    # repository.select{|key, hash| hash == value}
    merchants = repository.values
    merchants.each do |merchant|
      if merchant.name == name
        return merchant
      end
    end
  end
end
