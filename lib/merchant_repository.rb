require_relative 'merchant'

class MerchantRepository
  attr_reader :merchant_repo,
              :parent

  def initialize(loaded_file, parent)
    @merchant_repo = loaded_file.map { |merchant| Merchant.new(merchant, self)}
    @parent = parent
  end

  def all
    @merchant_repo
  end

  def find_by_id(id)
    @merchant_repo.find {|merchant| merchant.id == id}
  end

end
