class Item
  include Tire::Model::Persistence

  validates_presence_of :title

  property :title, :default => []
  property :subject, :default => []
  property :description
  property :type
  property :source
  property :relation
  property :coverage
  property :creator
  property :publisher
  property :contributor
  property :rights
  property :date
  property :format
  property :identifier
  property :language
  property :audience
  property :provenance
  property :rights_holder
  property :instructional_method
  property :accrual_method
  property :accrual_periodicity
  property :accrual_policy

end
