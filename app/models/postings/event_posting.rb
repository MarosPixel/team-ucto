class EventPosting < Posting
  belongs_to :event
  belongs_to :transaction
end
