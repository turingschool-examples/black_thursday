class Merchant

  attr_reader :name,
              :id

  def initialize(merchant_hash)
    @name = merchant_hash[:name]
    @id = merchant_hash[:id]
    @created_at = Time.now
    @updated_at = Time.now
  end

  def create_id(new_id)
    @id = new_id
  end

  def change_name(name)
    @name = name
  end

  def change_updated_at
    @updated_at = Time.now
  end

end
