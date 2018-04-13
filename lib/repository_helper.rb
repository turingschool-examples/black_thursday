# frozen_string_literal: true

# Module with funtions to help search objects.
module RepositoryHelper
  def all
    @repository
  end

  def find_by_id(id)
    @repository[id]
  end

  def find_all_by_merchant_id(merchant_id)
    @merchant_id[merchant_id]
  end
end
