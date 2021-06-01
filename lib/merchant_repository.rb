require_relative 'helper_methods'

class MerchantRepository
  include HelperMethods
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path.to_s
    @all = Array.new
    data = CSV.parse(File.read(@file_path), headers: true) do |line|
      @all << line.to_h
    end
  end

  def create(attributes)
    create_new_id
    Merchant.new({
      :id => create_new_id,
      :name => attributes[:name]
      })
  end

end
