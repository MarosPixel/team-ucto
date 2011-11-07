class ParticipationPosting < Posting
  belongs_to :event
  belongs_to :user
end
