shared_examples "a user" do
  let(:user) { FactoryGirl.create(described_class.name.underscore.to_sym) }

  subject { user }

  describe "attributes" do
    it { should respond_to :first_name }
    it { should respond_to :last_name }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :password_confirmation }
  end

  context "no first name" do
    before { user.first_name = "" }
    it { should_not be_valid }
  end

  context "no last name" do
    before { user.last_name = "" }
    it { should_not be_valid }
  end

  context "no email" do
    before { user.email = "" }
    it { should_not be_valid }
  end

  context "no password" do
    before { user.password = "" }
    it { should_not be_valid }
  end

  context "no password confirmation" do
    before { user.password_confirmation = "" }
    it { should_not be_valid }
  end
end
