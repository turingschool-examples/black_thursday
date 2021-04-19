class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(row, merchant_repo)
    @id = (row[:id]).to_i
    @name = row[:name]
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @merchant_repo = merchant_repo
  end

  def update(attributes)
    update_name(attributes)
    update_time_stamp
  end

  def update_name(attributes)
    return if attributes[:name].nil?
    @name.replace(attributes[:name])
  end

  def update_time_stamp
    @updated_at = Time.now
  end
end