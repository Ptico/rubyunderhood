module UseCases
  module User
    class Update < Write
    private
      def initialize(*)
        super
        user    = DB[:users].where(id: @data[:id].to_i).first
        @params = Params.new(user)

        @params.attributes = @data
      end

      def write
        DB[:users].update(attrs)
      end

    end
  end
end
