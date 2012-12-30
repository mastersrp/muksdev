class Post < CouchRest::Model::Base
  unique_id :id

  property :body
  property :created_at

	collection_of :upvotes
	collection_of :downvotes
  
  belongs_to :account
	belongs_to :discussion
  validates_presence_of :body
end
