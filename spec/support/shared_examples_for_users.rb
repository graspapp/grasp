shared_examples "a user" do
  describe "attributes" do
    it { should respond_to :first_name }
    it { should respond_to :last_name }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :password_confirmation }

    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
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
  end
end
