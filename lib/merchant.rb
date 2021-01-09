class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(csv_data, repository)
    @repository = repository
    @id = csv_data[:id].to_i
    @name = csv_data[:name]
    @created_at = csv_data[:created_at]
    @updated_at = csv_data[:updated_at]
  end

  def item_name
    @repository.find_item_by_id(@id)
  end
end
