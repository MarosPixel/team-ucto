# encoding: UTF-8

class AppSettingsController < ApplicationController
  
  # GET /settings
  def index
    @app_settings = AppSettings.first
    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # PUT /settings
  def update
    respond_to do |format|
      if AppSettings.first.update_attributes(params[:app_settings])
        format.html { redirect_to settings_path, notice: "Úspešne uložené." }
      else
        format.html { render action: :index, alert: "Chyba pri ukladaní. Skuste znovu." }
      end
    end
  end

end
