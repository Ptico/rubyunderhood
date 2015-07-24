module UseCases
  module User
    class Read < UseCase
      attr_reader :result
    end

    class Write < UseCase
      attr_reader :params

      def call
        validator = Validator.new(params)
        validator.valid? ? success : failure(validator.result)
      end

    private

      def success
        write
        finally
      rescue Sequel::Error => e
        failure(Validation::ResultKind.new(e))
      end

      def failure(errors)
        @errors = errors
      end

      def attrs
        @params.attributes
      end

      def finally; end
    end
  end
end

require 'app/use_cases/user/write/validator'
require 'app/use_cases/user/write/params'
require 'app/use_cases/user/write/mailer'
require 'app/use_cases/user/read/decorator'

require 'app/use_cases/user/list'
require 'app/use_cases/user/show'
require 'app/use_cases/user/create'
require 'app/use_cases/user/update'
require 'app/use_cases/user/destroy'
