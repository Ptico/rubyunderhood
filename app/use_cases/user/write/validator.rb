module UseCases
  module User
    class Write
      class Validator < Validation
        EIGHTEEN_YEARS = 568036800
        EMAIL_REGEXP = /.+@.+\..+/.freeze

        def validate
          ensure_name_presence
          ensure_email_presence
          ensure_email_validity
          ensure_age_presence
          ensure_adult
        end

      private

        def ensure_name_presence
          add_error(:name, 'must be specified') if object.name == ''
        end

        def ensure_email_presence
          add_error(:email, 'must be specified') if object.email == ''
        end

        def ensure_email_validity
          add_error(:email, 'must be valid email address') unless EMAIL_REGEXP.match(object.email)
        end

        def ensure_age_presence
          if object.birthday.nil? || object.birthday == ''
            add_error(:birthday, 'must be specified')
          end
        end

        def ensure_adult
          if object.birthday
            add_error('You must be adult to use our services') unless
              (Time.now - EIGHTEEN_YEARS).to_date > object.birthday
          end
        end
      end
    end
  end
end
