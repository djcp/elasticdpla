class Item
  include Tire::Model::Persistence

  DC_PROPERTIES = %W|title subject description type relation coverage creator publisher contributor rights date format identifier language audience provenance rights_holder instructional_method accrual_method accrual_periodicity accrual_policy|

  validates_presence_of :title

  property :title 
  property :subject
  property :description
  property :type
  property :source
  property :relation
  property :coverage
  property :creator
  property :publisher
  property :contributor
  property :rights
  property :date, :type => 'date', :include_in_all => false
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

  property :original_record, :class => [Hash]
  property :record_source, :class => [RecordSource]

  def to_s
    "#{title.inspect}"
  end

end
