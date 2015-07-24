module UseCases
  module User
    class Destroy < Write

      def call
        @user = DB[:users].where(id: @data[:id])
        @user.any? ? success : failure(Validation::ResultKind.new('User not found'))
      end

    private

      def write
        @user.delete
      end

    end
  end
end
