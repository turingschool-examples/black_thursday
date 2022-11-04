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
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @repo       = repo
  end
end