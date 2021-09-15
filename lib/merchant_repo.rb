require './lib/merchant'
require 'csv'

class MerchantRepo

  def initialize
    @all = to_array
  end

  def to_array
  merchants = []
  CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
    headers = row.headers
    merchants << Merchant.new(row.to_h)
  end
  merchants
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_highest_id
    highest = all.max_by do |merchant|
      merchant.id
    end
    highest.id
  end


  def create(attributes)
    CSV.open('./data/merchants.csv', 'a') do |csv|
      csv << [find_highest_id + 1, attributes[:name], Time.now.strftime("%F"), Time.now.strftime("%F")]
    end
  end

  def update(id, attributes)
    # found_merchant = nil
    # all.each do |merchant|
    #   if all[:id] == id
    #     merchant[:name] = attributes[:name]
    #   end
    # end
    # all.
    CSV.open('./data/merchants.csv', 'a+') do |csv|
      csv.each do |row|
        if row[:id] == id
          row[:name] = attributes[:name]
        end
      end
      output << row
    end
  end

end
