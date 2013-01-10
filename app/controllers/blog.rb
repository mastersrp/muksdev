PadrApp.controllers :blog do

  get :index do
  	@entry = Entry.all
  	render 'blog/index'
  end
	
	get :browse do
		render 'blog/browse'
	end

  get :view, :with => :id do
  	@entry = Entry.get params[:id]
		@entry.views = @entry.views.to_i() + 1
		@entry.save!
  	render 'blog/view'
  end
  
  get :new do
  	render 'blog/new'
  end

	post :create do	
		if current_account != nil then
			@entry = Entry.create(:title => params[:title], :body => params[:body], :created_on => DateTime.now, :account => current_account )
			@entry.save!
			if !@entry then
				flash[:error] = "Could not create entry!"
				redirect url(:blog,:new)
			 end
       redirect url(:blog,:view,:id => @entry.id)
    else
			redirect url(:accounts,:new)
  	end
  end

	post :update, :with => :id do
		if current_account != nil then
			@entry = Entry.get( params[:id] )
		else
			flash[:warning] = "You do not have permissions to this!"
			redirect url(:blog,:view,:id => params[:id])
		end
	end

	get :destroy, :with => :id do
		if current_account != nil then
			if current_account.role == "admin" then
				@entry = Entry.get( params[:id] )
				@entry.destroy
				redirect url(:blog,:index)
			else
				flash[:warning] = "You do not have permissions to do this!"
				redirect url(:blog,:index)
			end
		else
			flash[:warning] = "You do not have permissions to do this!"
			redirect url(:blog,:index)
		end
	end
end
