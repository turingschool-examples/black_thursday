require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'load_data'
require          'csv'

class SalesEngine
  attr_reader :repo_rows
  attr_accessor :items, :merchants

  def initialize(repo_rows)
    start_up_engine(repo_rows)
  end

  def self.from_csv(csv_hash)
    repo_rows = csv_hash.map do |type, filename|
      [type, LoadData.load_data(filename)]
    end.to_h

    SalesEngine.new(repo_rows)
  end

  def start_up_engine(repo_rows)
    @items                = ItemRepository.new(repo_rows[:items], self)
    @merchants            = MerchantRepository.new(repo_rows[:merchants], self)
  end
end
