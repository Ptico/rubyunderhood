RSpec.describe 'User destroy' do
  let(:usecase) { UseCases::User::Destroy.new(updated_params) }

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

  let(:user_id) { DB[:users].insert(params) }
  let(:updated) { DB[:users].where(id: user_id).first }

  before(:each) do
    usecase.call
  end

  context 'when record exists' do
    let(:updated_params) { {id: user_id} }

    it { expect(usecase).to be_success }

    it 'destroys record in database' do
      expect(updated).to be(nil)
    end
  end

  context 'when record does not exists' do
    let(:updated_params) { {id: user_id+1} }
    let(:errors) { usecase.errors }

    it { expect(usecase).to_not be_success }

    it 'returns an errors object' do
      expect(errors).to_not be(nil)
      expect(errors.orphans).to contain_exactly('User not found')
    end
  end
end
