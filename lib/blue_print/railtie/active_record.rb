::ActiveRecord::Base.send(:include, BluePrint::Helper)
::ActiveRecord::Relation.send(:include, BluePrint::Helper)
::ActiveRecord::Associations::CollectionAssociation.send(
  :include, BluePrint::Helper
)
