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
    if file_path_details[:merchants]
      add(file_path_details[:merchants], merchant_repo)
    end
    if file_path_details[:items]
      add(file_path_details[:items], item_repo)
    end
    if file_path_details[:invoices]
      add(file_path_details[:invoices], invoice_repo)
    end
    if file_path_details[:invoice_items]
      add(file_path_details[:invoice_items], invoice_item_repo)
    end
    if file_path_details[:customers]
      add(file_path_details[:customers], customer_repo)
    end
    if file_path_details[:transactions]
      add(file_path_details[:transactions], transaction_repo)
    end
  end

  def add(path, repo)
    CSV.foreach(path, headers:true, header_converters: :symbol) do |row|
      repo.add(row)
    end
  end


end
