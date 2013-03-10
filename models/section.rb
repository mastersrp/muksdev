class Section < CouchRest::Model::Base
  unique_id :id

  property :title,		String

	view_by :title

  collection_of :discussions
  validates_presence_of :title
	validates_uniqueness_of :title
end
