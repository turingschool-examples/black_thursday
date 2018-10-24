class SalesEngine
  attr_reader :merchants

  def initialize(merch_repo, item_repo)
    @merchants = merch_repo
    #@items = item_repo
  end

    def self.from_csv(csv_data_paths)
      merch_repo = MerchantRepository.new(csv_data_paths[:merchants])
      item_repo = "ItemRepo"#ItemRepository.new
      self.new(merch_repo, item_repo)
    end

end
