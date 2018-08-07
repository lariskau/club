require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end


  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should get profil" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_select "h1", "Nom: #{@user.name}"
  end
#vérification du lien logout de la nav bar
  test "should have link to logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_select "a[href=?]", logout_path
  end

#vérification du lien de la navbar vers show
  test "should go to profil" do
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    get root_path
#    assert_select "a[href=?]", current_user
  end

  #vérification du lien logout de la nav bar
    test "should have information" do
      get login_path
      post login_path, params: { session: { email:    @user.email,
                                            password: 'password' } }
      assert is_logged_in?
      assert_redirected_to @user
      follow_redirect!
      assert_select "p", "Email: #{@user.email}"
    end
end
