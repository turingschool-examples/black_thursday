require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'load_data'
require          'csv'

class SalesEngine
  attr_reader :repo_rows

  def initialize(repo_rows)
    @repo_rows = repo_rows
  end

  def self.from_csv(csv_hash)
    repo_rows = {}

    if csv_hash[:merchants]
      filename = csv_hash[:merchants]
      rows = LoadData.load_data(filename)
      repo_rows[:merchants] = rows
    end

    if csv_hash[:items]
      filename = csv_hash[:items]
      rows = LoadData.load_data(filename)
      repo_rows[:items] = rows
    end

    SalesEngine.new(repo_rows)
  end

  def items
    ItemRepository.new(repo_rows[:items])
  end

  def merchants
    MerchantRepository.new(repo_rows[:merchants])
  end

end
