module Find

  def find_by_id_overall(type, id)
    type.find do |type_singular|
      type_singular.id == id
    end
  end

  def find_by_name_overall(type, name)
    type.find do |type_singular|
      type_singular.name.casecmp?(name)
    end
  end

  def find_all_by_name_overall(type, name)
    type.find_all do |type_singular|
      type_singular.name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_merchant_id_overall(type, merch_id)
    type.find_all do |type_singular|
      type_singular.merchant_id == merch_id
    end
  end
end