module SalesRepoReusable

  def find_by_id(id)
    @merchants.find {|merchant| merchant.id == id}
  end

  def update(id, attributes)
    item_to_update = find_by_id(id)
    if item_to_update != nil
        attributes.each do |key, value|
          if ![:id, :created_at].include?(key)
            item_to_update.last_name = value
            item_to_update.updated_at = (Time.now + 1)
          end
        end
    end
    item_to_update
  end

end
