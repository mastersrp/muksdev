class Subscriber < CouchRest::Model::Base
  unique_id :id
  # property <name>
  property :email
  property :name
end
