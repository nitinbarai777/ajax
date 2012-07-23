Given /^default user exists$/ do
  u=Factory(:user, :email => 'user@dee.de')
  u.authentication_tokens.create(:token => "foobar")
end

Given /^default user with activity$/ do
  u=User.find_by_email('user@dee.de')
end
