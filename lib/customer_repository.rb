require 'time'
require 'CSV'
require 'customer'

class CustomerRepository
  attr_reader :all

  def initialize(path)
    @all = []
    populate_repository(path)
  end

  def populate_repository(path)
    CSV.read(path, headers: true, header_converters: :symbol) do |row|
      info_hash = {
        id: row[:id].to_i,
        first_name: row[:first_name],
        last_name: row[:last_name],
        created_at: Time.parse(row[:created_at]),
        updated_at: Time.parse(row[:updated_at])
      }
      @all << Customer.new(info_hash)
    end
  end
end
