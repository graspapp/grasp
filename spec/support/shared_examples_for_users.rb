shared_examples "a user" do
  describe "attributes" do
    it { is_expected.to respond_to :first_name }
    it { is_expected.to respond_to :last_name }

    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
  end
end

shared_examples "a user's homepage" do
  describe "user info" do
    it { is_expected.to have_content full_name(user) }
    it { is_expected.to have_title full_name(user) }
  end

  describe "course index" do
    it "has course names" do
      user.courses.each do |c|
        expect(page).to have_content c.name
      end
    end
  end

  example "editing profile" do
    expect {
      first(:link, "Modify profile").click
      
      fill_in "Email", with: FactoryGirl.attributes_for(:user)[:email]
      fill_in "Current password", with: user.password
      click_button "Update"

      user.reload
    }.to change(user, :email)
  end
end
