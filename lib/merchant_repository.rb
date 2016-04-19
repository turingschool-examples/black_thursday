require './lib/merchant'
# require './lib/find'

class MerchantRepository

  def initialize(sales_engine)
    @merchants = []
    @sales_engine = sales_engine
  end

  def <<(merchant_object)
    @merchants.push(merchant_object)
  end

  #need this on all repos
  def all
    @merchants
  end


  def find_by_id(id)
    #find_by({:id => id})
  end



  #hash is {:field => search_term}
  def find_by(search_hash)
    # all.each do |instance|
    #if instance.send(search_hash.keys[0]) == search_term
    #return instance
  end

  #works for strings only
  def find_all_by_fragment(search_hash)
    #matches = []
    # all.each do |instance|
    #if instance.send(search_hash.keys[0]).downcase.include?( search_term.downcase)
    # add instance to matches
    #return matches
  end

  #works for strings only
  def find_all_by_full(search_hash)
    #matches = []
    # all.each do |instance|
    #if instance.send(search_hash.keys[0]).downcase == search_term.downcase
    # add instance to matches
    #return matches
  end


end
