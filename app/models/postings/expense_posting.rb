class ExpensePosting < Posting
  belongs_to :expense
  belongs_to :transaction
end
