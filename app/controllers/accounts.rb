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

  get :index do
  	render 'accounts/index'
  end
  
  get :all do
  	if ( Padrino.env == :development ) then
	  	@accounts = Account.all
  		render 'accounts/all'
  	else
  		redirect url(:home,:index)
  	end
  end
  
  get :view, :with => :id do
  	@account = Account.get( params[:id] )
  	render 'accounts/view'
  end

	get :new do
		# Set up temporary redirect. Clean up this mess!
		redirect url(:accounts,:create)
	end

	get :create do
		render 'accounts/create'
	end

  post :create do
		params[:account][:role] = :user
		@account = Account.create(params[:account])
		if @account.save!
			flash[:notice] = 'Account was successfully created.'
			redirect url(:accounts,:view, :id => @account.id)
		else
			render 'accounts/create'
		end
  end

  post :update, :with => :id do
		@account = Account.get(params[:id])
		if @account != current_account and current_account[:role] != "admin" then
			flash[:notice] = "You do not have permission to change this account."
			redirect url(:accounts,:view,:id => @account.id)
		end
		if @account.update_attributes(params[:account])
			flash[:notice] = 'Account was successfully updated.'
			redirect url(:accounts,:view, :id => @account.id)
		else
			render 'accounts/index'
		end
  end
  
  post :login do
		if params.index "assertion" != nil then
			p params["assertion"]
		end
  	if account = Account.authenticate( params[:email], params[:password] )
  		set_current_account(account)
  		redirect url(:home,:index)
  	else
  		params[:email],params[:password] = h(params[:email]), h(params[:password])
			flash[:warning] = "Login or password wrong."
			redirect url(:accounts,:new)
  	end
  end
  
  get :logout do
  	set_current_account(nil)
  	redirect url(:home,:index)
  end

  get :edit do
  end
	
end
