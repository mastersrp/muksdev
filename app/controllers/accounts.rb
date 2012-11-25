require 'digest'

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
  	render 'accounts/index'
  end
  
  get :all, :map => "/account/all" do
  	if ( Padrino.env == :development ) then
	  	@accounts = Account.all
  		render 'accounts/all'
  	else
  		redirect url(:home,:index)
  	end
  end
  
  get :view, :with => :id do
  	@id = params[:id]
  	@account = Account.get( params[:id] )
  	render 'accounts/view'
  end

  get :new, :map => '/account/new' do
  	render 'accounts/new'
  end

  post :create, :map => '/account/create' do
  	@info = {:email => params[:email],:username => params[:username]}
  	@hash = Digest::SHA2.hexdigest( "-#{Time.now.to_s}-#{params[:email]}-" ).upcase().to_s
  	@info[:password] = @hash[rand(@hash.length-8),8].to_s
	 	account = Account.create(:email => @info[:email], :name => @info[:username], :title => "Member", :password => @info[:password], :password_confirmation => @info[:password], :role => "member", :balance => 0.0 )
	 	if account.valid?
#	  	email(
#	  		:from => "tcg.thegamer@gmail.com",
#	  		:to => @info[:email],
#	  		:subject => "Welcome!",
#	  		:body => render('email/welcome',nil,:layout => 'email'),
#	  		:via => :sendmail
#	  	) # Commented out, since it doesn't seem to work very well yet.
	  	render 'accounts/new/success'
	  else
	  	@error = account.errors.full_messages
	  	render 'accounts/new/failed'
	  end
  end

  post :update, :map => "/account/update" do
  	if current_account == nil then redirect url(:accounts,:index) end
  	if !current_account.has_password? params[:current_password] then redirect url(:accounts,:index) end
  	@updatehash = {}
  	if (current_account[:name] != params[:name]) then
  		@account = Account.get_by_name params[:name]
  		if @account == nil then
	  			@updatehash[:name] = params[:name]
	  	else
	  		redirect url(:accounts,:index)
	  	end
	  end
	  @updatehash[:email] = params[:email]
  	if (current_account[:title] != params[:title]) then
  		@updatehash[:title] = params[:title]
  	end
  	if (params[:new_password] == params[:new_password_confirm]) & ( params[:new_password] != nil ) then
  		@updatehash[:password] = params[:new_password]
  		@updatehash[:password_confirmation] = params[:new_password_confirm]
  	end
  	if ( Padrino.env == :development ) & ( params[:balance].to_f > 0.0 ) then @updatehash[:balance] = params[:balance].to_f end
  	current_account.update_attributes(@updatehash)
  	current_account.save!
  	@error = current_account.errors.full_messages
		render 'accounts/update/failed'
  end
  
  post :login, :map => "/account/login" do
  	@info = {:email => params[:email],
  	 :password => params[:password]}
  	account = Account.authenticate( @info[:email], @info[:password] )
  	if account then
  		set_current_account(account)
  		render 'accounts/login/success'
  	else
  		render 'accounts/login/failed'
  	end
  end
  
  get :logout, :map => "/account/logout" do
  	set_current_account(nil)
  	redirect url(:home,:index)
  end

  get :edit do
  end
	
end
