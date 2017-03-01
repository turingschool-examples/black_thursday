# require_relative "../test/test_helper"

module DataAccess
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent,
              :status,
              :customer_id
  #status and customer_id are invoice readers.
  #Consider whether it's drier to initialize invoice here
  #(with extra instance variables) or in invoice
  #(with similar/repeated instance variables)

  #check if merchants.all has unneeded nil instance variables.
  #Would .compact help?

  #OR, could we make a RepoDataAccess, and ItemDataAccess?

  def initialize(data, parent=nil)
    @id  = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price =  data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at = data[:updated_at]
    @parent = parent
    @customer_id = data[:customer_id]
    @status = data[:status]
  end

###
#all
###

  # def populate_repo
  #   repos = [Item, Merchant]#, Invoice]

  #   repos.each {|repo| csv_file.each do |row|
  #     object = repo.new({:id => row[:id].to_i,
  #       :name => row[:name],
  #       :description => row[:description],
  #       :unit_price => transform_price(row[:unit_price]),
  #       :merchant_id => row[:merchant_id].to_i,
  #       #make time methods, time.now

  #       :created_at => Time.parse(row[:created_at]),
  #       :updated_at => Time.parse(row[:updated_at])}, self)
  #       @all << object unless object.nil?

  #       #return an array, then you can nix @all
  #     end
  #   }
  # end


#####
#ItemRepo Methods
#####

  def transform_price(price)
    formatted_price = (BigDecimal.new(price.to_i)/100)
  end

  def find_by_id(id)
    all.find{ |item| item.id == id }
  end

  def find_by_name(name)
    all.find{ |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description)
    all.select{ |item| item.description.downcase == description.downcase }
  end

  def find_all_by_merchant_id(merchant_id)
    all.select{ |item| item.merchant_id == merchant_id }
  end

  def find_all_by_price(unit_price)
    all.select{ |item| item.unit_price == unit_price }
  end

  def find_all_by_price_in_range(range)
    all.select{ |item| range.include?(item.unit_price)  }
  end


#####
#MerchantRepo Methods
#####

  # # def find_by_id(id)
  # #   all.find{ |merchant| merchant.id == id }
  # # end

  # def find_by_name(name)
  #   all.find{ |merchant| merchant.name.downcase == name.downcase }
  # end

  def find_all_by_name(name_frag)
    all.select{ |merchant| merchant.name.downcase.include?(name_frag.downcase) }
  end

  # def inspect
  #   "#<#{self.class} #{@merchants.size} rows>"
  # end

  def inspect
    "#<#{self.class} #{@instance.size} rows>" unless @instance.nil?
  end
end
