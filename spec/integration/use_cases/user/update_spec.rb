RSpec.describe 'User update' do
  let(:usecase) { UseCases::User::Update.new(updated_params) }

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

  let(:updated_params) do
    { id: user_id, name: updated_name }
  end

  let(:updated) { DB[:users].where(id: user_id).first[:name] }
  let(:user_id) { DB[:users].insert(params) }

  before(:each) do
    usecase.call
  end

  context 'when data valid' do
    let(:updated_name) { 'Taras Shevchenko' }

    it { expect(usecase).to be_success }

    it 'updates name in database' do
      expect(updated).to eql(updated_name)
    end
  end

  context 'when data invalid' do
    let(:updated_name) { '' }
    let(:errors) { usecase.errors }

    it { expect(usecase).to_not be_success }

    it 'do not update name in database' do
      expect(updated).to_not eql(updated_name)
    end

    it 'returns an errors object' do
      expect(errors).to_not be(nil)
      expect(errors.fields).to contain_exactly(:name)
      expect(errors.errors[:name]).to contain_exactly('must be specified')
    end
  end
end
