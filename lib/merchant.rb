class Merchant
  attr_accessor :id,
                :name,
                :created_at,
                :updated_at

  def initialize(merchant_info, repo)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
    @created_at = Time.parse(merchant_info[:created_at].to_s)
    @updated_at = Time.parse(merchant_info[:updated_at].to_s)
    @repo = repo
  end

  def update_name(attributes)
    @name = attributes[:name]
  end

  def update_id(new_id)
    @id = new_id + 1 
  end
end
