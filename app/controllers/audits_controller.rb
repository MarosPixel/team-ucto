class AuditsController < ApplicationController
  def index
    @audits = Audit.find_by_sql("SELECT * FROM audits ORDER BY created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
