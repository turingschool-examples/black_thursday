class Customer


  attr_reader   :id,
                :first_name,
                :last_name,
                :created_at,
                :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @first_name = hash[:first_name]
    @last_name = hash[:last_name]
    @created_at = Time.parse(hash[:created_at])
    @updated_at = Time.parse(hash[:updated_at])
  end

  def update_fname(name)
    @first_name = name
  end

  def update_lname(name)
    @last_name = name
  end

  def update_updated_at
    @updated_at = Time.now
  end
end
