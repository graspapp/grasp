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

shared_examples "a user's homepage" do
  describe "user info" do
    it { should have_content full_name(user) }
    it { should have_title full_name(user) }
  end

  describe "course index" do
    it "has course names" do
      user.courses.each do |c|
        expect(page).to have_content c.name
      end
    end

    it "shows units after clicking on each course", js: true do
      user.courses.each do |c|
        click_link c.name
        # TODO: Change this to check for units instead of the course's id
        expect(page).to have_content c.id
      end
    end
  end
end
