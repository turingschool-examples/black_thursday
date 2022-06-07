module Repositable

  def find_by_id(id)
    @all.find do |source|
      if source.id == id
        return source
      end
    end
  end

  def find_by_name(name)
    @all.find do |source|
      if source.name.downcase == name.downcase
        return source
      end
    end
  end

  def delete(id)
    source = find_by_id(id)
    @all.delete(source)
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |source|
      source.merchant_id == merchant_id
    end
  end
end
