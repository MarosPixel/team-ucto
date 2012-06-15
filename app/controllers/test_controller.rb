class TestController < ApplicationController
  skip_before_filter :authenticate_user!, only: :index

  def index
    @test_content = Mail::download_new_mails()
    #@test_content = SlspTransList.extract_hb('_podklady/obr-szu.txt')

    respond_to do |format|
      format.html # index.html.erb
    end
  end

end