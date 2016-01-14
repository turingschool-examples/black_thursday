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
  
end
