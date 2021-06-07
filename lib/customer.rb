require 'csv'
require 'time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(info, repo)
    @id = info[:id].to_i
    @first_name = info[:first_name]
    @last_name = info[:last_name]
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @repo = repo
  end

  def self.create(attributes, repo)
    customer = Hash.new
    time = Time.now.utc.strftime("%d-%m-%Y %H:%M:%S %Z")
    customer[:id] = repo.new_customer_id_number
    customer[:first_name] = attributes[:first_name]
    customer[:last_name] = attributes[:last_name]
    customer[:created_at] = time
    customer[:updated_at] = time
    new(customer, repo)
  end

  def update(attributes)
    unless attributes[:first_name].nil?
      @first_name = attributes[:first_name]
    end
    unless attributes[:last_name].nil?
      @last_name = attributes[:last_name]
    end
    @updated_at = Time.now
  end
end
