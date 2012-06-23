# encoding: UTF-8

class ExpensesController < ApplicationController
  before_filter :set_expense, only: [ :show, :edit, :update, :destroy ]
  authorize_resource

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = get_class.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = get_class.new
    @expense.total_price = 0
    @expense.team_fee = 0
    @expense.player_fee = 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = get_class.new(params[get_type])
    @expense.creator_id = current_user.id

    respond_to do |format|
      if @expense.save and @expense.create_expense_posting(price: @expense.calc_expense_posting_price)
        format.html { redirect_to @expense, notice: 'Udalosť bola úspešne vytvorená.' }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update_attributes(params[get_type])
        update_paps
        format.html { redirect_to @expense, notice: 'Udalosť bola úspešne zmenená.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :ok }
    end
  end

  private

    def get_type
      params[:type]
    end

    def get_class
      get_type.classify.constantize
    end

    def set_expense
      @expense = get_class.find(params[:id])
    end

    def update_paps
      # zmen cenu expense_postingu
      @expense.expense_posting.price = @expense.calc_expense_posting_price
      @expense.expense_posting.save
      # zmen ceny prislsnych participation_postingov
      @expense.participation_postings.update_all(price: calc_paps_price)
    end

    def calc_paps_price
      if @expense.type == 'Training'
        # pri treningu je v "player_fee" cena pre jedneho hraca
        - @expense.player_fee
      else # 'Tournament' a 'OtherExpense'
        # pri ostatnych udalostiach sa cena pre jedneho hraca vyrata ako 
        # "player_fee za kazdeho + team_fee na pocet_hracov"
        - @expense.player_fee - (@expense.team_fee / @expense.users.count)
      end
    end

end
