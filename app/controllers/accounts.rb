PadrApp.controllers :accounts do
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

  get :index, :map => "/account" do
  	@accounts = Account.all
  	render 'accounts/index'
  end
  
  get :view, :with => :id do
  	@id = :id
  	@account = Account.get( :id )
  	render 'accounts/view'
  end

  get :new, :map => "/account/new" do
  	@accounts = Account.all
  	render 'accounts/new'
  end

  post :create, :map => "/account/signup" do
  end

  post :update, :map => "/account/update" do
  end
  
  post :login, :map => "/account/login" do
  end

  get :edit do
  end

end
