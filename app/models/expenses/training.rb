class Training < Expense
  before_save :set_end_at

  private

    def set_end_at
      self.end_at = start_at
    end

end
