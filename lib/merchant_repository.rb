require_relative 'merchant'
require_relative 'repository_assistant'

class MerchantRepository
  include RepositoryAssistant

  def initialize(data_file)
    @repository = data_file.map {|merchant| Merchant.new(merchant)}
  end

  def find_all_by_name(name)
    @repository.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = create_new_id_number
    @repository << Merchant.new(attributes)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
