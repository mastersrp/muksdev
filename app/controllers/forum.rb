PadrApp.controllers :forum do

  get :index do
  	@discussions = Discussion.all
  	render 'forum/index'
  end

  get :view, :with => :id do
  	@discussion = Discussion.get params[:id]
  	render 'forum/view'
  end
  
  get :new do
  	render 'forum/new'
  end

  post :create do	
    if ( current_account != nil ) then
       @post = Post.create(:title => params[:title], :body => params[:body], :created_at => DateTime.now, :account => current_account )
#       if ( Discussion.find_by_title( params[:title] ) != nil ) then
#       	redirect url( :forum,:new )
#       end
       @discussion = Discussion.create(:title => params[:title], :posts => [@post], :account => current_account)
       redirect url(:forum,:view,:id => @discussion[:_id])
    else
			redirect url(:accounts,:new)
  	end
  end

end

PadrApp.controllers :posts do
  
  post :create, :with => :id do
    if ( current_account != nil ) then
       @post = Post.create(:body => params[:body], :created_at => DateTime.now, :account => current_account )
       if !@post then
        #dunno
        puts "bad thing?"
       end
       p @post
       @discussion = Discussion.get( params[:id] )
       @discussion.posts << Post.get( @post[:_id] )
       @discussion.save!
       p @discussion
       redirect url(:forum,:view,:id => @discussion[:_id])
    else
			redirect url(:accounts,:new)
  	end
  end

  
end
