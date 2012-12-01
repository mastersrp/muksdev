class Post < CouchRest::Model::Base
  unique_id :id

  property :body
  property :created_at
  
  belongs_to :account
  validates_presence_of :body
end
