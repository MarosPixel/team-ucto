class CashPosting < Posting
  self.abstract_class = true
  belongs_to :user
end
