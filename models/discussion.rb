class Discussion < CouchRest::Model::Base
  unique_id :id

  property :title
  property :views
  
  belongs_to :account
  collection_of :posts
  validates_presence_of :title
	validates_uniqueness_of :title
end
