require 'csv'
require_relative 'merchant'
require_relative 'helper_methods'

class MerchantRepository
  include HelperMethods
  attr_reader :all, :engine

  def initialize(file_path, engine)
    @file_path = file_path.to_s
    @engine = engine
    @all = Array.new
    create_items
  end

  def create_items
    data = CSV.parse(File.read(@file_path), headers: true) do |line|
      @all << Merchant.new(line.to_h, self).to_hash
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def create(attributes)
    Merchant.new(
      {
        'id' => create_new_id,
        'name' => attributes[:name]
        }, self
      )
  end

  def update(id, attributes)
    result = find_by_id(id)
    result[:name] = attributes[:name]
    result
  end

end
