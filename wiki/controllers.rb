Wiki.controllers  do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end
  
  layout :default
  
  get :index do
  	render 'wiki/index'
  end
  
  get :all do
  	@articles = Article.all
  	render 'wiki/all'
  end
  
  get :view, :with => :id do
  	render 'wiki/view'
  end
  
  get :edit, :with => :id do
  	render 'wiki/edit'
  end
  
  post :create do
  	@article = Article.new
  	@article[:title] = params[:title]
  	@article.save!
  	
  	redirect url(:wiki,:edit,:id => @article[:_id])
  end
  
  post :update do
  end

  
end
