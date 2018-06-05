require_relative 'repo_methods'
require_relative 'merchant'

class MerchantRepository
  include RepoMethods
  attr_reader :collection

  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end

  def get_data_from_csv(data_from_csv)
    data_from_csv.map do |line|
      [line[:id].to_i, Merchant.new(line)]
    end.to_h
  end

  def create(attributes)
    attributes[:id] = new_id
    @collection[new_id] = Merchant.new(attributes)
  end

  def update(current_id, new_attributes)
    if @collection[current_id] == nil
    else
      @collection[current_id].update_name(new_attributes) if new_attributes[:name]
      @collection[current_id].update_updated_at(Time.now)
    end
  end
end
