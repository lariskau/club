require 'test_helper'

class ClubUserTest < ActionDispatch::IntegrationTest


  def setup
    @user = users(:michael)
    @users = User.all
  end

#On verifie que les liens dans la page club_non_connecter sont présent 
  test "Should not be to the club page" do
    get club_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
  end

# On verifie que la page renvoie bien le nom des users
  test "root should have link log" do
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    get root_path
    assert_select "a[href=?]", club_path
    get club_path
    @users.each do |user|
      assert_select "p", "#{@user.name}"
    end
  end
end
