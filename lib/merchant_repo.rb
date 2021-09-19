require 'csv'
require_relative '../lib/merchant'
require_relative '../lib/repo_module'

class MerchantRepo
  include Repo
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def to_array
  merchants = []
  CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
    headers = row.headers
    merchants << Merchant.new(row.to_h)
  end
  merchants
  end
  #
  # def find_by_id(id)
  #   all.find do |merchant|
  #     merchant.id == id
  #   end
  # end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_highest_id
    highest = all.max_by do |merchant|
      merchant.id
    end
    highest.id
  end


  def create(attributes)
    id = find_highest_id + 1
    current_time = Time.now.strftime("%F")
    attributes = {
      id: id.to_s,
      name: attributes[:name],
      created_at: current_time,
      updated_at: current_time
    }
    @all << Merchant.new(attributes)
    end

  def update(id, attributes)
    find_by_id(id).change_name(attributes[:name])
  end

  def delete(id)
    all.delete(find_by_id(id))
  end
end
