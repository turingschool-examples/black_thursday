require_relative './reposable'
require_relative './customer'

class CustomerRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_all_by_first_name(first_name)
    all.select do |customer|
      customer.first_name.include?(first_name)
    end
  end

  def find_all_by_last_name(last_name)
    all.select do |customer|
      customer.last_name.include?(last_name)
    end
  end

  def create(attributes)
    all.push(Customer.new({ :id         => next_id,
                            :first_name => attributes[:first_name],
                            :last_name  => attributes[:last_name],
                            :created_at => attributes[:created_at],
                            :updated_at => attributes[:updated_at]
                            }))
  end

  def update(id,attributes)
    if find_by_id(id) == nil 
      return
    else
      find_by_id(id).updated_at = Time.now
      attributes.each do |att,val|
        case att
        when :first_name
          find_by_id(id).first_name = val
        when :description
          find_by_id(id).last_name = val
        end
      end
    end
  end
end