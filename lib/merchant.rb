class Merchant

  attr_reader :id

  attr_accessor :name

  def initialize(attributes)
    time = Time.now
    @name = attributes[:name]
    @id = attributes[:id]
    @created_at = Time.parse(time.to_s)
    @updated_at = Time.parse(time.to_s)
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
