require "./lib/items_repo"


class SalesEngine

  def self.from_csv(file_location)
   file_location.each do |repository, file_path|
      merchants = MerchantRepo.new(file_location[:merchants])
      items = ItemsRepo.new(file_location[:items])
    end
    se = self.new
  end
end
