class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(attributes, repository)
    @repository = repository
    @id = attributes[:id].to_i
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

  def change_first_name(change)
    @first_name = change
  end

  def change_last_name(change)
    @last_name = change
  end

  def new_updated_time
    @updated_at = Time.now
  end
end
