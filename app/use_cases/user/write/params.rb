module UseCases
  module User
    class Write
      class Params
        include Virtus.model

        attribute :name,     String, default: ''
        attribute :email,    String, default: ''
        attribute :birthday, Date
      end
    end
  end
end
