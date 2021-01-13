require "rails_helper"

describe "As an existing user" do
	describe "I can" do
		before :each do
			@user = create(:user, email: "user@example.com", password: "password", password_confirmation: "password", role: 0)
			@user1= create(:user, email: "user1@example.com", password: "password", password_confirmation: "password", role: 1)
			@user2 = create(:user, email: "user2@example.com", password: "password", password_confirmation: "password", role: 2)
		end

		it 'login' do
			visit root_path

			click_link "Login"

			expect(current_path).to eq(new_user_session_path)

			fill_in "user[email]", with: "user@example.com"
			fill_in "user[password]", with: "password"
			click_button "Log in"

			expect(page).to have_content("Signed in successfully.")
			expect(current_path).to eq(root_path)
		end

		it 'logout customer' do
			login_as @user
			visit root_path
			click_link "Log Out"
			expect(page).to have_content("Signed out successfully.")
			expect(current_path).to eq(root_path)
		end
	end
end