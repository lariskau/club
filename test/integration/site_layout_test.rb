require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
#test pour la homepage non-log
  test "root should have link" do
    get root_path
    assert_select "a[href=?]", signup_path
 end

#test pour la homepage en étant log
 test "root should have link log" do
   post login_path, params: { session: { email:    @user.email,
                                         password: 'password' } }
   assert is_logged_in?
   assert_redirected_to @user
   follow_redirect!
   get root_path
   assert_select "a[href=?]", club_path
 end

#test pour la navbar
  test "nav bar sould have link" do
    get root_path
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
  end
end
