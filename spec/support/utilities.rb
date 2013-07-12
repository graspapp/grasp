include ApplicationHelper

def sign_in(person)
  visit sign_in_path
  fill_in "Email", with: person.email
  fill_in "Password", with: person.password
  click_button "Sign in"
end
