class FullRoundProjectSerializer < ActiveModel::Serializer
  #attributes :id
  has_one :project, serializer: FullProjectSerializer
  has_one :bucket, serializer: FullBucketSerializer
end