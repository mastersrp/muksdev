class Discussion < CouchRest::Model::Base
  unique_id :id
  # property <name>
  property :title
  
  belongs_to :account
  collection_of :posts
end
