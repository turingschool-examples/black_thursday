module Find


  #{id => 23}
  def find_by(search_hash)
    all.find do |instance|
      instance.send(search_hash.keys[0]) == search_hash.values[0]
    end
  end

  # def find_by_string_full_match(full)
  #   @merchants.find do |merchant|
  #     merchant.name.downcase == name.downcase
  #   end
  # end
  #
  # def find_all_by_partial_match(partial)
  #   matches = @merchants.find_all do |merchant|
  #     merchant.name.downcase.include?(partial.downcase)
  #   end
  #   if matches.nil?
  #     []
  #   else
  #     matches
  #   end
  # end
end
