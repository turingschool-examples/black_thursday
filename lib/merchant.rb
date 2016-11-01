require 'pry'
require 'csv'

class FakeRepository
  attr_accessor  :merchants_repo

  def initialize
    @handle =  CSV.open './data/merchants_test.csv', headers: true, header_converters: :symbol
    @merchants_repo = []
  end

  def merchant_list
    @handle.each do |line|
      @merchants_repo << Merchant.new(line).merchant
    end
  puts @merchants_repo
  end
end

class Merchant < FakeRepository
  attr_accessor  :merchant

  def initialize(line)
    @line = line
    @merchant = { "id" => id, "name" => name }
  end

  def id
    @line[:id]
  end

  def name
    @line[:name]
  end

end

FakeRepository.new.merchant_list
