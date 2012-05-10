module NeatPages::Implants
  module MongoidCriteriaImplant
    def paginate(current)
      if current
        current.set_total_items self.count

        raise NeatPages::OutOfBound if current.out_of_bound?

        return self.offset(current.offset).limit(current.limit)
      else
        raise 'You need to initialize the pagination'
      end
    end
  end
end

Mongoid::Criteria.send :include, NeatPages::Implants::MongoidCriteriaImplant if defined? Mongoid
