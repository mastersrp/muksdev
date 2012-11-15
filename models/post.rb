class Post < CouchRest::Model::Base
  unique_id :id

  property :title
  property :body
  property :created_at
  
  belongs_to :account
	validates_presence_of :title
  validates_presence_of :body
end
