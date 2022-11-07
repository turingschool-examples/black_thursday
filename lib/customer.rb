class  Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(info, repo)
    @id         = info[:id]
    @first_name = info[:first_name]
    @last_name  = info[:last_name]
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @repo       = repo
  end

  def update(info)
    (@first_name = info[:first_name]) if info[:first_name] != nil
    (@last_name  = info[:last_name]) if info[:last_name] != nil
    @updated_at = Time.now
  end
end