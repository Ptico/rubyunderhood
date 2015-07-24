RSpec.describe 'User list' do
  let(:usecase) { UseCases::User::List.new(params) }

  let(:params)  { {} }
  let(:result)  { usecase.result }

  let(:birthday) { Date.parse('1814-03-09') }
  before(:each) do
    2.times do |i|
      DB[:users].insert({
        name:    "Taras Shevchenko #{i}",
        email:   "taras-#{i}@example.org",
        birthday: birthday
      })
    end

    usecase.call
  end

  context 'when params empty' do
    it 'returns collection of decorated users' do
      result.each_with_index do |user, i|
        expect(user.name).to       eql("Taras Shevchenko #{i}")
        expect(user.email).to      eql("taras-#{i}@example.org")
        expect(user.birthday).to   eql(birthday)
        expect(user.birth_year).to eql(birthday.year)
      end
    end
  end

  context 'when limit set' do
    let(:params) { {limit: 1} }

    it { expect(result.length).to equal(1) }
  end
end
