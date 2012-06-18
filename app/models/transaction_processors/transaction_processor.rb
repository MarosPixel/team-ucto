class TransactionProcessor

  def self.extract_all
    transaction_processor::extract_all
  end

  private

    def transaction_processor
      APP_CONFIG['processors']['transaction'].constantize
    end

end