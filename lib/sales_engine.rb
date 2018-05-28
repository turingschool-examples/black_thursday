require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'


class SalesEngine
  attr_reader :merchants, :items

  def initialize(file_paths)
    @merchants = MerchantRepository.new(from_csv(file_paths)[:merchants])
    # @items     = ItemRepository.new(from_csv(file_paths)[:items])
  end

  def from_csv(file_paths)
    repositories = Hash.new
    file_paths.map do |repo, path|
      repositories[repo] = parse_csv(path)
    end
    repositories
  end

  def parse_csv(path)
    repository = Hash.new
    CSV.foreach(path, headers:true, header_converters: :symbol) do |row|
      repository[row[0]] = {
                      row.headers[0] => row[0],
                      row.headers[1] => row[1],
                      row.headers[2] => row[2],
                      row.headers[3] => row[3]
                     }
    end
    repository
  end
end
