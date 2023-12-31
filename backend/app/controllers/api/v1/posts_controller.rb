class Api::V1::PostsController < ApplicationController

    def index
        @posts = Post.all
        render json: @posts
    end

    def show
        @post = Post.find(params[:id])
        render json: @post 
    end

    def create
        Post.create(post_params)
    end

    def update
        @post = Post.find(params[:id])
        @post.update(post_params)
    end
    
    def destroy 
        @post = Post.find(params[:id])
        @post.destroy
    end

    private
    def post_params
        params.require(:post).permit(:name, :content)
    end

end
