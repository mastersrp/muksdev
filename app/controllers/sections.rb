PadrApp.controllers :sections do

	get :browse do
		@sections = Section.all
		render 'sections/browse'
	end

	post :create do
		@section = params[:section]
		section = Section.create(@section)
		if section.save then
			section.save!
			redirect PadrApp.url(:sections,:browse)
		else
			flash[:error] = "Could not create section!"
			redirect PadrApp.url(:sections,:browse)
		end		
	end

end
