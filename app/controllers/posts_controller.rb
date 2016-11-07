class PostsController < ApplicationController

  before_action :require_sign_in, except: :show

  def show
    @post = Post.find(params[:id])
  end

  def new
    @place = Place.find(params[:place_id])
    @post = Post.new
  end

  def create

     @place = Place.find(params[:place_id])
     @post = @place.posts.build(post_params)
     @post.user = current_user

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
      @post.assign_attributes(post_params)


      if @post.save
        flash[:notice] = "Post was updated."
        redirect_to [@post.place, @post]
      else
        flash.now[:alert] = "There was an error saving the post. Please try again."
        render :edit
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :link, :body)
    end

end
