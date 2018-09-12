class Merchant

  attr_reader :id

  attr_accessor :name

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @created_at = Time.now.getutc
    @updated_at = Time.now.getutc
  end

  def create_id(new_id)
    @id = new_id
  end

  def change_name(name)
    @name = name
  end

  def change_updated_at
    @updated_at = Time.now.getutc
  end

end
