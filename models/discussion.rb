class Discussion < CouchRest::Model::Base
  unique_id :id

  property :title
  
  belongs_to :account
  collection_of :posts
  validates_presence_of :title
end
