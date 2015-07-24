module UseCases
  module User
    class Read
      class Decorator < Write::Params
        attribute :id, Integer

        def birth_year
          birthday.year
        end
      end
    end
  end
end
