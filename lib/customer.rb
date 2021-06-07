require 'time'

class Customer
  attr_reader :repo
  attr_accessor :id,
                :first_name,
                :last_name,
                :created_at,
                :updated_at

  def initialize(customer_hash, repo)
    @id = customer_hash[:id].to_i
    @first_name = customer_hash[:first_name]
    @last_name = customer_hash[:last_name]
    @created_at = Time.parse(customer_hash[:created_at].to_s)
    @updated_at = Time.parse(customer_hash[:updated_at].to_s)
    @repo = repo
  end

  def to_hash
    self_hash = Hash.new
    self_hash[:id] = @id
    self_hash[:first_name] = @first_name
    self_hash[:last_name] = @last_name
    self_hash[:created_at] = @created_at
    self_hash[:updated_at] = @updated_at
    self_hash
  end

end
