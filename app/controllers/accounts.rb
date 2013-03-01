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
	 	@accounts = Account.all
  	render 'accounts/all'
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
		params[:account][:permissions] = "thread_create blog_entry_create"
		@account = Account.create(params[:account])
		if !@account then
			flash[:error] = 'Account could not be created!'
			render 'accounts/create'
		else
			@account.save!
			flash[:notice] = 'Account was successfully created.'
			redirect url(:accounts,:view, :id => @account.id)
		end
  end

  post :update, :with => :id do
		@account = Account.get(params[:id])
		if @account != current_account then
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
		# Slight hackish workaround.
		# TODO: Make pretty and readable.
		params[:email] = params[:account][:email]
		params[:password] = params[:account][:password]
  	if account = Account.authenticate( params[:email], params[:password] ) then
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
