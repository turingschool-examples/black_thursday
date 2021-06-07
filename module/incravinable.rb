module Incravinable

  def find_with_id(id)
    @all.find do |element|
      element.id == id
    end
  end

  def find_with_name(name)
    @all.find do |element|
      element.name.downcase == name.downcase
    end
  end

  def remove(id)
    to_delete = @all.find do |element|
      element.id == id
    end
    @all.delete(to_delete)
  end

  def find_all_with_name(name)
    @all.find_all do |element|
      element.name.downcase.include?(name)
    end
  end

  def find_all_with_merchant_id(id)
    @all.find_all do |element|
      element.merchant_id == id
    end
  end

  def time_update
    @updated_at = Time.now
  end
end
