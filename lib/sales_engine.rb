require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'load_data'
require          'csv'

class SalesEngine
  attr_reader :repo_rows
  attr_accessor :items, :merchants

  def initialize(repo_rows)
    @items                = ItemRepository.new(repo_rows[:items], self)
    @merchants            = MerchantRepository.new(repo_rows[:merchants], self)
    @repo_rows            = repo_rows
    # MerchantRepository.new(repo_rows[:merchants], SalesEngine.new)
    # That will allow me to call sales engine anywhere within the branching
  end

  def self.from_csv(csv_hash)
    repo_rows = csv_hash.map do |type, filename|
      [type, LoadData.load_data(filename)]
    end.to_h

    SalesEngine.new(repo_rows)
    #pass in self to each one of the repos as its second argument
  end

end
