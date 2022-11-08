require './lib/modules/repository_queries'

class MerchantRepository
include RepositoryQueries

  def initialize(records, engine)
    @records = create_merchants(records)
    # @engine = engine
  end
  
  # def all
  #   @records
  # end

  def find_by_id(id) 
    nil if !a_valid_id?(id)

    @records.find do |merchant|
      merchant.id == id
    end
  end

  def a_valid_id?(id)
    @records.any? do |merchant| merchant.id == id
    end 
  end
  
  def find_by_name(name)
    @records.find{|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(string)
    @records.find_all do |merchant|
      merchant.name.downcase.include?(string.downcase)
    end
  end

  def create(attribute)
    new_id = @records.last.id + 1
    @records << Merchant.new({:id => new_id, :name => attribute}, self)
  end

  def update(id, name)
    @records.each do |merchant|
      if merchant.id == id
        merchant_new_name = merchant.name.replace(name)
        return merchant_new_name
      end
    end
  end

  def delete(id)
    @records.delete(find_by_id(id))
  end

  #### Merchant Repository will make individual records
  def create_merchants(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
   
    make_merchant_object(contents)
  end

  def make_merchant_object(contents)
    contents.map do |row|
      info = {:id => row[:id].to_i, :name => row[:name]}
      Merchant.new(info, self)
    end
  end
  
  def inspect
    "#<#{self.class} #{@records.size} rows>"
  end
end