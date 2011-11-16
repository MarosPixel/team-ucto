class UserPosting < Posting
  belongs_to :user
  belongs_to :transaction
end
