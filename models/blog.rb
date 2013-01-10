class Entry < CouchRest::Model::Base
  unique_id :id

  property :title,		String
	property :body
	property :created_on
	property :tags
  property :views,		Integer
  
  belongs_to :account
  validates_presence_of :title
	validates_presence_of :body
end
