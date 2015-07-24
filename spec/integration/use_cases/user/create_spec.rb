RSpec.describe 'User creation' do
  let(:usecase) { UseCases::User::Create.new(params) }

  let(:name)     { "Taras Shevchenko #{rand(400)}" }
  let(:email)    { 'taras@example.org' }
  let(:birthday) { Date.parse('1814-03-09') }

  let(:params) do
    {
      name:     name,
      email:    email,
      birthday: birthday
    }
  end

  let(:user) { DB[:users].where(email: 'taras@example.org').first }

  before(:each) do
    usecase.call
  end

  context 'when all data valid' do
    let(:user_name)     { user[:name] }
    let(:user_birthday) { user[:birthday].to_date }

    it { expect(usecase).to be_success }

    it 'writes user details to database' do
      expect(user).to_not      be(nil)
      expect(user_name).to     eql(name)
      expect(user_birthday).to eql(birthday)
    end

    it 'sends welcome email' do
      expect(usecase).to have_sent_email.from('noreply@example.com')
      expect(usecase).to have_sent_email.to(email)
      expect(usecase).to have_sent_email.matching_body(/Hello #{name}/)
    end
  end

  context 'when data invalid' do
    let(:errors) { usecase.errors }
    let(:name)   { '' }

    it { expect(usecase).to_not be_success }

    it 'do not write user to database' do
      expect(user).to be(nil)
    end

    it 'do not send email' do
      expect(usecase).to_not have_sent_email.to(email)
    end

    it 'returns an errors object' do
      expect(errors).to_not be(nil)
      expect(errors.fields).to contain_exactly(:name)
      expect(errors.errors[:name]).to contain_exactly('must be specified')
    end
  end
end
