RSpec.describe 'User show' do
  let(:usecase) { UseCases::User::Show.new(id: user_id) }

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
  let(:result)  { usecase.result }

  before(:each) do
    usecase.call
  end

  it 'returns decorated user' do
    expect(result.id).to         equal(user_id)
    expect(result.name).to       eql(name)
    expect(result.email).to      eql(email)
    expect(result.birthday).to   eql(birthday)
    expect(result.birth_year).to eql(birthday.year)
  end
end
