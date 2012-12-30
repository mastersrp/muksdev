class Downvote < CouchRest::Model::Base
	unique_id :id

	belongs_to :account
end
