#*************************************************************************************
# Insert the method paginate in an ActiveRecord model. This method will be use the limit
# the number of results returned by a query.
#*************************************************************************************
module NeatPages::Implants::ActiveRecordImplant
  def paginate(current)
    if current
      current.set_total_items self.count(:all)

      raise NeatPages::OutOfBound if current.out_of_bound?

      return self.offset(current.offset).limit(current.limit)
    else
      raise NeatPages::Uninitalized, 'You need to initialize the pagination'
    end
  end
end

ActiveRecord::Relation.send :include, NeatPages::Implants::ActiveRecordImplant if defined? ActiveRecord
