class MerchantRepository
  attr_reader :csv_array,
              :created_merchants

  def initialize(csv_array)
    @csv_array = csv_array
    @created_merchants = []
  end
end
