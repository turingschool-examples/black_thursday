require 'csv'

class SalesEngine

  def csv_to_hash(path)
    raw_input = CSV.read(path)
    raw_input.map do | pre_hash |
      pre_hash.to_h
    end
  end

  def hashes_to_repos(hashes, blank_repo)
    hashes.each do | hash |
      blank_repo.create(hash)
    end
  end
  def from_csv(paths)
    item_hashes = csv_to_hash(paths[:items])
    @items = ItemRepository.new
    hashes_to_repos(item_hashes, @items)

    merchant_hashes = csv_to_hash(paths[:merchants])
    @merchants = MerchantRepository.new
    hashes_to_repos(merchant_hashes, @merchants)
  end


end
