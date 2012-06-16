class Posting < ActiveRecord::Base
    POSTING_TYPES = %w{ expense_posting participation_posting user_posting }
end
