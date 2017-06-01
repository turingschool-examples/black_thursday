require './lib/merchant_repository'

merchant_repo = MerchantRepository.new("./data/merchants.csv")
merchant_repo.find_by_name("Shopin1901")
merchant_repo.find_by_id(12334105)
merchant_repo.find_all_by_name("shop")
