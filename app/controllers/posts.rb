PadrApp.controllers :posts do
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
  
  post :create, :map => '/posts/create', :with => :id do
    if ( current_account != nil ) then
       @post = Post.create(:title => nil, :body => params[:body], :created_at => DateTime.now, :account => current_account )
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
