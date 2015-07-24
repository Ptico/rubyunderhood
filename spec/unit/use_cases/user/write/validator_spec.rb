RSpec.describe UseCases::User::Write::Validator do
  let(:validator) { described_class.new(user) }
  let(:result)    { validator.result }

  let(:orphans) { result.orphans }
  let(:fields)  { result.fields  }
  let(:errors)  { result.errors  }

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

  let(:user) { instance_double('UseCases::User::Write::Params', params) }

  describe 'name' do
    context 'when not present' do
      let(:name) { '' }

      it { expect(validator).to_not be_valid }
      it { expect(fields).to include(:name) }
      it { expect(errors[:name]).to include('must be specified') }
    end

    context 'when present' do
      it { expect(validator).to be_valid }
    end
  end

  describe 'email' do
    context 'when not present' do
      let(:email) { '' }

      it { expect(validator).to_not be_valid }
      it { expect(fields).to include(:email) }
      it { expect(errors[:email]).to include('must be specified') }
    end

    context 'when present but not valid' do
      let(:email) { 'foo' }

      it { expect(validator).to_not be_valid }
      it { expect(fields).to include(:email) }
      it { expect(errors[:email]).to include('must be valid email address') }
    end

    context 'when present and valid' do
      it { expect(validator).to be_valid }
    end
  end

  describe 'age' do
    context 'when not present' do
      let(:birthday) { nil }

      it { expect(validator).to_not be_valid }
      it { expect(fields).to include(:birthday) }
      it { expect(errors[:birthday]).to include('must be specified') }
    end

    context 'when child' do
      let(:birthday) { Time.now.to_date }

      it { expect(validator).to_not be_valid }
      it { expect(orphans).to include('You must be adult to use our services') }
    end

    context 'when present and adult' do
      it { expect(validator).to be_valid }
    end
  end
end
