module UseCases
  module User
    class Show < Read
      def call
        attrs = DB[:users].where(id: @data[:id]).first
        @result = Decorator.new(attrs)
      end
    end
  end
end
