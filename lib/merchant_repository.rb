require_relative 'sales_engine'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants, :engine

  def initialize(path, engine)
    @merchants = []
    @engine = engine
    make_merchants(path)
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end

  def make_merchants(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row, self)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    max_id = @merchants.max_by do |merchant|
      merchant.id
    end
    attributes[:id] = max_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @merchants << Merchant.new(attributes, self)
  end

  def update(id, attributes)
    if attributes.keys[0] != :name
      return
    else
      updatee = find_by_id(id)
      updatee.name.replace(attributes[:name])
    end
  end

  def delete(id)
    deletee = find_by_id(id)
    @merchants.delete(deletee)
  end

  def all_items
    @engine.all_items
  end

  def merchants_created_in_month(month)
    @merchants.each_with_object([]) do |merchant, array|
      if merchant.created_at.strftime("%B") == month
        array << merchant
      end
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    items_hash = @engine.items_created_in_month(month)

    array = @merchants.each_with_object([]) do |merchant, array|
      # require 'pry'; binding.pry
      if merchants_created_in_month(month).include?(merchant)
        # require 'pry'; binding.pry
        if  items_hash[merchant.id]!= nil && items_hash[merchant.id] == 1
          # require 'pry'; binding.pry
          array << merchant
        end
      end
    end
    # require 'pry'; binding.pry
  end
end
