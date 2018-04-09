# Sales Engine
class SalesEngine
  def self.from_csv(data)
    se = new
    data.each do |model, file_path|
      binding.pry
      repo = se.create_repository_for(model)
      CSV.foreach(file_path, headers: true) do |row|
        repo.collection << create_model_for(model, row)
      end
    end
    se
  end

  def create_repository_for(model)
    key = convert_model_key_to_repo_key(model)
    repo = create_model_from_symbol(key).new
    instance_variable_set(key.to_s, repo)
  end

  def create_model_for(model, row)
    create_model_from_symbol(model).new(row)
  end

  def create_model_from_symbol(model)
    {
      item: Item,
      merchant: Merchant,
      item_repository: ItemRepository,
      merchant_repository: MerchantRepository,
      transacton_repository: TransactionRepository,
      transaction: Transaction
      }[model]
  end

  def convert_model_key_to_repo_key(model)
    (model.to_s + '_repository').to_sym
  end
end
# se = SalesEngine.from_csv(
# data = {
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
#
# mr = se.merchants
# merchant = mr.find_by_name("CJsDecor")
# # => <Merchant>
