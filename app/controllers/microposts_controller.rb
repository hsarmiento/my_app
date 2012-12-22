class MicropostsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy
  # GET /microposts
  # GET /microposts.json
  def index
    @microposts = Micropost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @microposts }
    end
  end


  # GET /microposts/new
  # GET /microposts/new.json
  def new
    @micropost = Micropost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @micropost }
    end
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost creado"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end



  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    if @micropost.nil?
      redirect_to root_url
    end
  end
end
