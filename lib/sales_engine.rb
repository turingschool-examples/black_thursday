class SalesEngine


  def initialize(data)
    @data = data
  end

  def self.from_csv(file_location)
   file_location.each do |repository, file_path|
      merchants = MerchantRepo.new(file_location[:merchants])
      items = ItemsRepo.new(file_location[:items])
     binding.pry
    end

  end
end
