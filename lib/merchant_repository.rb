require 'pry'

require_relative 'finderclass'

require_relative 'merchant'



class MerchantRepository

  attr_reader :all

  def initialize(data)
    @data = data
    @merchants = []
    make_merchants(data)
    @all = @merchants
  end

  def make_merchants(data = @data)
    data.each { |key, value|
      number = key.to_s.to_i
      name = value[:name]
      merch = Merchant.new({id: number, name: name })
      @merchants << merch
    }
  end


  # --- Spec Harness Requirement ---

  # TO DO - TEST ME
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end


  # --- Find By ---

  def find_by_id(id)
    FinderClass.find_by(all, :id, id)
  end

  def find_by_name(name)
    FinderClass.find_by_insensitive(all, :name, name)
  end

  def find_all_by_name(frag)
    FinderClass.find_by_fragment(all, :name, frag)
  end


  # --- CRUD ---

  def create(hash)
    last = FinderClass.find_max(all, :id)
    new_id = last.id + 1
    hash[:id] = new_id
    merchant = Merchant.new(hash)
    @merchants << merchant
    return merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.make_update(attributes) if merchant
  end

  def delete(id)
    @merchants.delete_if{ |merch| merch.id == id }
  end



end
