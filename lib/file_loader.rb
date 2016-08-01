require 'forwardable'
class FileLoader

  extend Forwardable
  def_delegators :@sales_engine,
                 :item_repo,
                 :merchant_repo,
                 :invoice_repo,
                 :invoice_item_repo,
                 :customer_repo,
                 :transaction_repo

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def load_repos_from_csv(file_path_details)
    file_path_details.keys.each do |key|
      add(file_path_details[key], repo_name(key))
    end
  end

  def repo_name(key)
    # we are aware that this is potentially VERY dangerous, but it
    # makes the load_repos_from_csv method so nice...
    if is_a_repo?(key)
      eval("#{key.to_s.chop}_repo")
    end
  end

  def is_a_repo?(key)
    valid_repos = [
      "merchant_repo",
      "item_repo",
      "invoice_repo",
      "invoice_item_repo",
      "transaction_repo",
      "customer_repo"
    ]
    valid_repos.include?("#{key.to_s.chop}_repo")
  end

  def add(path, repo)
    CSV.foreach(path, headers:true, header_converters: :symbol) do |row|
      repo.add(row)
    end
  end


end
