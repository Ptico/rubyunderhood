module UseCases
  module User
    class List < Read
      def call
        ds = DB[:users]
        ds = ds.limit(@data[:limit]) if @data.has_key?(:limit)

        @result = ds.map do |attrs|
          Decorator.new(attrs)
        end
      end
    end
  end
end
