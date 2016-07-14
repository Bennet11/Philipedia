class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wikis saved successfully"
      redirect_to wiki_path(@wiki)
    else
      flash[:alert] = "Failed to save wiki"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    if @wiki.update(wiki_params)
      flash[:notice] = "Update Successful!"
      redirect_to wiki_path(@wiki)
    else
      flash[:alert] = "Update failed"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Successfuly deleted Wiki"
      redirect_to wikis_path
    else
      flash[:notice] = "Failed to delete Wiki"
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
