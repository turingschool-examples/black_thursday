
class Merchant

  attr_reader :id,
              :created_at,
              :updated_at

  attr_accessor :name

  def initialize(attributes, created_at=Time.now, updated_at=Time.now)
    @name = attributes[:name]
    @id = attributes[:id]
    @created_at = Time.parse((attributes[:created_at]).to_s)
    @updated_at = Time.parse((attributes[:updated_at]).to_s)
  end

  def create_id(new_id)
    @id = new_id
  end

  def change_name(name)
    @name = name
  end

  def change_updated_at
    time = Time.now
    @updated_at = Time.parse(time.to_s)
  end

end
