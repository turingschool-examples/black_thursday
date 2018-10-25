module Fixturable
  def sample(merch_ids = nil)
    merch_ids = [12334105, 12334141, 12334185, 12334195, 12334207, 12334213, 12334235] unless merch_ids
    instance_variables.each do |var|
      related_array =
      if var == :@merchants
        instance_variable_get(var).all.select{|instance| merch_ids.include?(instance.id)}
      else
        instance_variable_get(var).all.select{|instance| merch_ids.include?(instance.merchant_id)}
      end
      file_name = "test_#{var.to_s.delete('@')}.csv"
      CSV.open(file_name, "wb") do |csv|
        csv << to_arr_of_hashes(related_array)[0].keys # adds the attributes name on the first line
        to_arr_of_hashes(related_array).each do |hash|
          csv << hash.values
        end
      end
    end
  end
  def to_arr_of_hashes(arr_of_objects)
    arr_of_objects.reduce([]) do |arr, ob|
      arr << to_h(ob)
    end
  end
  def to_h(object)
    new_hash = {}
    object.instance_variables.each do |var|
      new_hash[var.to_s.delete("@")] = object.instance_variable_get(var)
    end
    new_hash
  end
end
