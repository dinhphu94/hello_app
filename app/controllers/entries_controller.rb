class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def home
    @posts = Entry.paginate(page: params[:page])
  end

  def index
    @entries = Entry.all.paginate(page: params[:page]).per_page(10)
  end

  def show
      @entry = Entry.find(params[:id])
      @comment  = @entry.comments.build
      @comments = @entry.comments.includes(:user)
      @entries = Entry.where.not(id: params[:id]).limit(10)
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  

  def edit
      @entry = Entry.find(params[:id])
  end

  def update
      @entry = Entry.find(params[:id])
      if @entry.update_attributes(entry_params)
        flash[:success] = "entry updated"
        redirect_to @entry
      else
        render 'edit'
      end
  end

  def destroy
    @entry.destroy
    flash[:success] = "entry deleted"
    redirect_to request.referrer || root_url
  end

  private
    def entry_params
      params.require(:entry).permit(:title,:content, :picture)
    end
    
    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
