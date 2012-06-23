# encoding: UTF-8

class UsersController < ApplicationController
  before_filter :set_user, except: :index
  authorize_resource

  # GET /users
  # GET /users.json
  def index
    if params[:approved] == "false"
      @users = User.find_all_by_is_approved(false)
    else
      @users = User.all
    end

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Používateľ bol úspešne zmenený.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url}
      format.json { head :ok }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

end

