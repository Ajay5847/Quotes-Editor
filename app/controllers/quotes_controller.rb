class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  def index
    @quotes = Quote.all.ordered
  end

  def show
    @line_item_dates = @quote.line_item_dates.includes(:line_items).ordered
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Quote successfully created!" }
        format.turbo_stream { flash.now[:notice] = "Quote successfully created!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @quote.update(quote_params)
      redirect_to quotes_path, notice: "Quote successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy
    
    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote successfully destroyed!" }
      format.turbo_stream { flash.now[:notice] = "Quote successfully destroyed!" }
    end
  end

  private 

  def set_quote
    @quote = Quote.find_by(id: params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
