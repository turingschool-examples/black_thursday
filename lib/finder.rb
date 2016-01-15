module Finder

  def find_by_id(number)
    all.find do |x|
      x.id == number
    end
  end

  def find_by_name(name)
    all.find do |x|
      x.name.downcase == name.downcase
    end
  end

  def find_all_by_merchant_id(id)
    all.find_all { |x| x.merchant_id == id }
  end

end
