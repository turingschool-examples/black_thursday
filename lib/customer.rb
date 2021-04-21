class Customer
  attr_reader :id,
                :first_name,
                :last_name,
                :created_at,
                :updated_at,
                :repo

  def initialize(customer_info, repo)
    @id = customer_info[:id].to_i
    @first_name = customer_info[:first_name].to_s
    @last_name = customer_info[:last_name].to_s
    @created_at = Time.parse(customer_info[:created_at].to_s)
    @updated_at = Time.parse(customer_info[:updated_at].to_s)
    @repo = repo
  end
end
