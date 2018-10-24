class SalesEngine

  def initialize(mech_repo, item_repo)
    #@mmerchant repo
    #item repo
  end

    def self.from_csv(csv_data_paths)
      merch_repo = MerchantRepository.new(csv_data_paths[:merchants])
      item_repo = "ItemRepo"#ItemRepository.new
      self.new(merch_repo, item_repo)
    end

end
