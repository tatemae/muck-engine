def login_as(user)
  success = UserSession.create(user)
  if !success
    errors = user.errors.full_messages.to_sentence
    message = 'User has not been activated' if !user.active?
    raise "could not login as #{user.to_param}.  Please make sure the user is valid. #{message} #{errors}"
  end
  UserSession.find
end

def assure_logout
  user_session = UserSession.find
  user_session.destroy if user_session
end

def ensure_flash(val)
  assert_contains flash.values, val, ", Flash: #{flash.inspect}"
end

def ensure_flash_contains(val)
  flash.values.each do |flv|
    return true if flv.include?(val)
  end
  false
end

# Add more helper methods to be used for testing xml
def assert_xml_tag(xml, conditions)
  doc = HTML::Document.new(xml)
  assert doc.find(conditions),
    "expected tag, but no tag found matching #{conditions.inspect} in:\n#{xml.inspect}"
end

def assert_no_xml_tag(xml, conditions)
  doc = HTML::Document.new(xml)
  assert !doc.find(conditions),
    "expected no tag, but found tag matching #{conditions.inspect} in:\n#{xml.inspect}"
end

def make_parent_params(parent)
  { :parent_id => parent.id, :parent_type => parent.class.to_s }
end