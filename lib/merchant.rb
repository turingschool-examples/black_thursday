class Merchant

  attr_reader :name,
              :id

  def initialize(merchant_hash)
    @name = merchant_hash[:name]
    @id = merchant_hash[:id]
    @created_at = merchant_hash[:created_at]
    @updated_at = merchant_hash[:updated_at]
  end

  def create_id(new_id)
    @id = new_id
  end

  def change_name(name)
    @name = name
  end

end
