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
    all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    all.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(fragment)
    all.select {|merchant| merchant.name.downcase.include?(fragment.downcase)}
  end
end
