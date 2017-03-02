class Customer

  attr_reader   :id,
                :first_name,
                :last_name,
                :created_at,
                :updated_at
  attr_accessor :repository

  def initialize(row, repository = nil)
    @id          = row[:id].to_i
    @first_name  = row[:first_name]
    @last_name   = row[:last_name]
    @created_at  = Time.parse(row[:created_at])
    @updated_at  = Time.parse(row[:updated_at])
    @repository  = repository
  end
end
