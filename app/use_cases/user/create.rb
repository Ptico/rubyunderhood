module UseCases
  module User
    class Create < Write
    private
      def initialize(*)
        super
        @params = Params.new(@data)
      end

      def write
        DB[:users].insert(attrs)
      end

      def finally
        Mailer.new(params).deliver
      end
    end
  end
end
