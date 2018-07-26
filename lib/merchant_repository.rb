require 'csv'
require 'pry'
require_relative './merchant'
class MerchantRepository

  attr_reader     :filepath,
                  :all
  def initialize(filepath)
    @filepath = filepath
    @all = []
  end

  def create_all_from_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row)
    end
  end

  def find_by_id(id)
    @all.find do|object|
      id == object.id
    end
  end

  def find_by_name(name)
    @all.find do |object|
      object.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |object|
      object.name.downcase.include?(name.downcase)
    end
  end

  def find_highest_id
    @all.max_by do |object|
      object.id
    end
  end

  def create(attributes)
    attributes[:id] = find_highest_id.id.to_i + 1
    mr = Merchant.new(attributes)
    @all << mr
    return mr
  end

  # def update(id, attributes)
  #   merchant = find_by_id(id.to_s)
  #   merchant.attributes[:name] = attributes[:name]
  #   #binding.pry
  #   merchant.name = attributes[:name]
  # end
  def update(id, attributes)
    merchant = find_by_id(id)
    return if merchant.nil?
    merchant.name = attributes[:name] || merchant.name
    merchant.updated_at = Time.now
    merchant
  end


  def delete(id)
    @all = @all.reject do |object|
      object.id == id
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

#mr = MerchantRepository.new("./data/dummy_merchants.csv")
#mr.create_all_from_csv("./data/dummy_merchants.csv")
# p mr.find_by_id("12334112")
# p mr.find_all_by_name("Candi")
# p mr.find_highest_id
#puts mr.all.count
# p mr.all[0].id
# p mr.create({:name => "Donald's"})
# puts mr.all.count
#mr.update(12334105, {:id => 12334105, :name => "Jerry's"})
#p mr.all[0]
