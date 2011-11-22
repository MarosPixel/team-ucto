class ParticipationPosting < Posting
  belongs_to :expense
  belongs_to :user
end
