module Repo

  def find_by_id(id)
    all.find do |thing|
      thing.id == id
    end
  end

  def find_highest_id
    highest = all.max_by do |thing|
      thing.id
    end
    highest.id
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end

  def find_by_name(name)
    all.find do | thing |
      thing.name.downcase == name.downcase
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.select do | item |
      merchant_id == item.merchant_id
    end
  end

end
