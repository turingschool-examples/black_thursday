class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repo

  def initialize(info, repo)
    @id = info[:id].to_i
    @first_name = info[:first_name]
    @last_name = info[:last_name]
    @created_at = info[:created_at].is_a?(Time) ? info[:created_at] : Time.parse(info[:created_at])
    @updated_at = info[:updated_at].is_a?(Time) ? info[:updated_at] : Time.parse(info[:updated_at])
    @repo = repo
  end

  def update_customer(attributes)
    @first_name = attributes[:first_name] unless attributes[:first_name].nil?
    @last_name = attributes[:last_name] unless attributes[:last_name].nil?
    @updated_at = Time.now
  end
end
