PadrApp.controllers :forum do

  get :index do
  	@discussions = Discussion.all
  	render 'forum/index'
  end

	get :browse do
		@discussions = Discussion.all
		render 'forum/browse'
	end

  get :view, :with => :id do
  	@discussion = Discussion.get params[:id]
		@discussion.views = @discussion.views.to_i() + 1
		@discussion.save!
  	render 'forum/view'
  end
  
  get :new do
  	render 'forum/new'
  end

	post :create do	
		if current_account != nil then
			@post = Post.create(:title => params[:title], :body => params[:body], :created_at => DateTime.now, :account => current_account )
			if !@post then
				flash[:error] = "Could not create post!"
				redirect url(:forum,:new)
			end
			@discussion = Discussion.create(:title => params[:title], :account => current_account, :views => 0)
			@post[:discussion] = @discussion.id
			@post.save!
			@discussion.posts << Post.get( @post.id )
			@discussion.save!
			if !@discussion then
				flash[:error] = "Could not create new discussion!"
				redirect url(:forum,:new)
			 end
       redirect url(:forum,:view,:id => @discussion.id)
    else
			redirect url(:accounts,:new)
  	end
  end

	post :update, :with => :id do
		if current_account != nil then
			@discussion = Discussion.get( params[:id] )
		else
			flash[:warning] = "You do not have permissions to this!"
			redirect url(:forum,:view,:id => params[:id])
		end
	end

	get :destroy, :with => :id do
		if current_account != nil then
			if current_account.role == "admin" then
				@discussion = Discussion.get( params[:id] )
				@discussion.posts.each do |post|
					post.destroy
				end
				@discussion.destroy
				redirect url(:forum,:index)
			else
				flash[:warning] = "You do not have permissions to do this!"
				redirect url(:forum,:index)
			end
		else
			flash[:warning] = "You do not have permissions to do this!"
			redirect url(:forum,:index)
		end
	end
end

PadrApp.controllers :posts do
  
  post :create, :with => :id do
    if ( current_account != nil ) then
			@discussion = Discussion.get( params[:id] )
			@post = Post.create(:body => params[:post][:body], :created_at => DateTime.now, :account => current_account, :discussion => @discussion )
			if !@post.save! then
				flash[:error] = "Could not create new post!"
				redirect url(:forum,:view,:id => @discussion.id)
			end
			@discussion.posts << Post.get( @post.id )
			@discussion.save!
			redirect url(:forum,:view,:id => @discussion.id)
		else
			flash[:warning] = "Warning: You need to be logged in to create new posts."
			redirect url(:accounts,:new)
		end
	end  

	post :destroy do
		if params.index :id == nil then nil end
		if current_account != nil then
			unless current_account.role == "admin" then
				flash[:warning] = "You do not have permissions to do this!"
			end
			@post = Post.get( params[:id] )
			@post.destroy
			redirect url(:forum,:view, :id => @post.discussion)
		else
			flash[:warning] = "You do not have permission to do this!"
			redirect url(:forum,:view, :id => @post.discussion)
		end
	end
end
