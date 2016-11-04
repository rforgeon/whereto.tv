class PostsController < ApplicationController


  def show
    @post = Post.find(params[:id])
  end

  def new
    @place = Place.find(params[:place_id])
    @post = Post.new
  end

  def create
     @post = Post.new
     @post.title = params[:post][:title]
     @post.link = params[:post][:link]
     @post.body = params[:post][:body]

     @place = Place.find(params[:place_id])
     @post.place = @place

     if @post.save
       flash[:notice] = "Post was saved."
       redirect_to [@place, @post]
     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :new
     end
   end

   def destroy
     @post = Post.find(params[:id])

     if @post.destroy
       flash[:notice] = "\"#{@post.title}\" was deleted successfully."
       redirect_to @post.place
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
   end


   def edit
      @post = Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id])
      @post.title = params[:post][:title]
      @post.link = params[:post][:link]
      @post.body = params[:post][:body]

      if @post.save
        flash[:notice] = "Post was updated."
        redirect_to [@post.place, @post]
      else
        flash.now[:alert] = "There was an error saving the post. Please try again."
        render :edit
      end
    end

end
