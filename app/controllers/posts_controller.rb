class PostsController < ApplicationController
  def do_something
    respond_to :js
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate page: params[:page], per_page: 2

    if pjax_request?
      render layout: false
    else
      respond_to :html
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    if pjax_request?
      render layout: false
    else
      respond_to :html
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    if pjax_request?
      render layout: false
    else
      respond_to :html
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

    if pjax_request?
      render layout: false
    else
      respond_to :html
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    if @post.save
      flash[:notice] = 'Created!'
      redirect_pjax_to :show, @post
    else
      redirect_pjax_to :new
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      flash[:notice] = 'Updated!'
      redirect_pjax_to :show, @post
    else
      redirect_pjax_to :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    @posts = Post.paginate page: params[:page], per_page: 2
    redirect_pjax_to :index
  end
end
