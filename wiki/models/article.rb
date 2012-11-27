class Article < CouchRest::Model::Base
  unique_id :id
  
  property :title
  property :body
  property :created_at
  property :last_modified
  
end
