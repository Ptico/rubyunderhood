module UseCases
  module User
    class Write
      class Mailer
        def deliver
          mail = Mail.new

          mail.from('noreply@example.com')
          mail.to(@user.email)
          mail.subject('You have been registered')
          mail.body(render_body)

          mail.deliver!
        end

      private

        def initialize(params)
          @user = params
        end

        def render_body
          <<-MESSAGE_BODY
            Hello #{@user.name}
            Welcome to our awesome website!
          MESSAGE_BODY
        end
      end
    end
  end
end
