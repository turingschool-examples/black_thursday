require 'csv'
require_relative './merchant'
require_relative './merchant_repository'
require_relative './item'
require_relative './item_repository'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(merchant_repo, item_repo)
    @merchants = merchant_repo
    @items = item_repo
  end

  def self.generate_and_add_to_repo(class_to_create, repo, csv_data)
    CSV.foreach(csv_data, headers: true, header_converters: :symbol) do |row|
      repo.add_to_repo(class_to_create.new(row))
    end
  end

  def self.from_csv(data)
    mr = MerchantRepository.new
    ir = ItemRepository.new

    generate_and_add_to_repo(Item, ir, data[:items])
    generate_and_add_to_repo(Merchant, mr, data[:merchants])
    
    SalesEngine.new(mr, ir)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end

end
