require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'load_data'
require          'csv'

class SalesEngine
  attr_reader :repo_rows

  def initialize(repo_rows)
    # {:merchants => [{:id => 1, :name => "pizza"}], :items => [{:id => 1, :price => 3}]}
    @repo_rows = repo_rows
  end

  def self.from_csv(csv_hash)
    repo_rows = csv_hash.map do |type, filename|
      [type, LoadData.load_data(filename)]
    end.to_h

    SalesEngine.new(repo_rows)
  end

  def items
    ItemRepository.new(repo_rows[:items])
  end

  def merchants
    MerchantRepository.new(repo_rows[:merchants], items)
  end

end
