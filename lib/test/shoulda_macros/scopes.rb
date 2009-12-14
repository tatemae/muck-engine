# Named scopes tested by these macros:
#
# named_scope :by_title, :order => "name ASC"
# named_scope :by_name, :order => "name ASC"
# named_scope :recent, lambda { { :conditions => ['created_at > ?', 1.week.ago] } }
# named_scope :newest, :order => "created_at DESC"
# named_scope :oldest, :order => "items.created_at ASC"
# named_scope :latest, :order => "items.updated_at DESC"
# named_scope :before, lambda { |time| {:conditions => ["items.created_at < ?", time || DateTime.now] } }
# named_scope :since, lambda { |time| {:conditions => ["items.created_at > ?", time || DateTime.now] } }
# named_scope :only_public, :conditions => ["items.is_public = ?", true]
# named_scope :created_by, lambda { |item_object| {:conditions => ["items.source_id = ? AND items.source_type = ?", item_object.id, item_object.class.to_s] } }
#
module MuckNamedScopeMacros

  # Test for 'by_title' named scope which orders by title:
  # named_scope :by_title, :order => "title ASC"
  # requires that the class have a shoulda factory
  def should_scope_by_title
    klass = model_class
    context "'by_title' title scope for #{klass.name}" do
      setup do
        klass.delete_all
        @first = Factory(klass.name.to_sym, :title => 'a')
        @second = Factory(klass.name.to_sym, :title => 'b')
      end
      should "sort by name" do
        assert_equal @first, klass.by_title[0]
        assert_equal @second, klass.by_title[1]
      end
    end
  end
    
  # Test for 'by_name' named scope which orders by name:
  # named_scope :by_name, :order => "name ASC"
  # requires that the class have a shoulda factory
  def should_scope_by_name
    klass = model_class
    context "'by_name' named scope for #{klass.name}" do
      setup do
        klass.delete_all
        @first = Factory(klass.name.to_sym, :name => 'a')
        @second = Factory(klass.name.to_sym, :name => 'b')
      end
      should "sort by name" do
        assert_equal @first, klass.by_name[0]
        assert_equal @second, klass.by_name[1]
      end
    end
  end
  
  # For 'latest named scope which orders by updated at:
  #  named_scope :latest, :order => "{klass}.updated_at DESC"
  def should_scope_latest
    klass = model_class
    context "'newest' named scope for #{klass.name}" do
      setup do
        klass.delete_all
        @first = Factory(klass.name.to_sym, :updated_at => 1.day.ago)
        @second = Factory(klass.name.to_sym, :updated_at => 1.week.ago)
      end
      should "sort by created_at" do
        assert_equal @first, klass.newest[0]
        assert_equal @second, klass.newest[1]
      end
    end
  end
  
  # Test for 'newest' named scope which orders by 'created_at DESC'
  # named_scope :newest, :order => "created_at DESC"
  # requires that the class have a shoulda factory
  def should_scope_newest
    klass = model_class
    context "'newest' named scope for #{klass.name}" do
      setup do
        klass.delete_all
        @first = Factory(klass.name.to_sym, :created_at => 1.day.ago)
        @second = Factory(klass.name.to_sym, :created_at => 1.week.ago)
      end
      should "sort by created_at" do
        assert_equal @first, klass.newest[0]
        assert_equal @second, klass.newest[1]
      end
    end
  end
  
  # Test for 'oldest' named scope which orders by 'created_at ASC'
  # named_scope :oldest, :order => "items.created_at ASC"
  # requires that the class have a shoulda factory
  def should_scope_oldest
    klass = model_class
    context "'oldest' named scope for #{klass.name}" do
      setup do
        klass.delete_all
        @first = Factory(klass.name.to_sym, :created_at => 1.day.ago)
        @second = Factory(klass.name.to_sym, :created_at => 1.week.ago)
      end
      should "sort by created_at" do
        assert_equal @first, klass.oldest[1]
        assert_equal @second, klass.oldest[0]
      end
    end
  end
  
  # Test for 'recent' named scope which orders by items created recently
  # named_scope :recent, lambda { { :conditions => ['items.created_at > ?', 1.week.ago] } }
  # requires that the class have a shoulda factory
  def should_scope_recent
    klass = model_class
    context "'recent' named scope for #{klass.name}" do
      setup do
        klass.delete_all
        @recent = Factory(klass.name.to_sym)
        @not_recent = Factory(klass.name.to_sym, :created_at => 10.weeks.ago)
      end
      should "get recent #{klass.name}s" do
        assert klass.recent.include?(@recent)
      end
      should "not get recent #{klass.name}s" do
        assert !klass.recent.include?(@not_recent)
      end
    end
  end
  
  # Tests 'before' named scope
  # named_scope :before, lambda { |time| {:conditions => ["items.created_at < ?", time || DateTime.now] } }
  def should_scope_before
    klass = model_class
    context "'before' named scope for #{klass.name}" do
      setup do
        @old = Factory(klass.name.to_sym, :created_at => 6.weeks.ago)
        @new = Factory(klass.name.to_sym)
      end
      should "only find #{klass.name}s older than a given date" do
        items = klass.before(1.week.ago)
        assert items.include?(@old), "since didn't find older #{klass.name}"
        assert !items.include?(@new), "since found new #{klass.name}"
      end
    end
  end

  # Tests 'since' named scope
  # named_scope :since, lambda { |time| {:conditions => ["items.created_at > ?", time || DateTime.now] } }
  def should_scope_since
    klass = model_class
    context "'since' named scope for #{klass.name}" do
      setup do
        klass.delete_all
        @old = Factory(klass.name.to_sym, :created_at => 6.weeks.ago)
        @new = Factory(klass.name.to_sym)
      end
      should "get newer #{klass.name}s" do
        assert klass.since.include?(@new), "since didn't find new item"
      end
      should "not get older #{klass.name}s" do
        assert !klass.since.include?(@old), "since found older item"
      end
    end
  end

  # Tests 'is_public' named scope
  # named_scope :only_public, :conditions => ["items.is_public = ?", true]
  def should_scope_only_public
    context "public" do
      setup do
        @private_item = Factory(klass.name.to_sym, :is_public => false)
        @public_item = Factory(klass.name.to_sym, :is_public => true)
      end
      should "only find public items" do
        assert klass.only_public.include?(@public_item), "didn't find public item"
        assert !klass.only_public.include?(@private_item), "found private item"
      end
    end
  end

  # Tests 'created_by' named scope.
  # named_scope :created_by, lambda { |item_object| {:conditions => ["items.source_id = ? AND items.source_type = ?", item_object.id, item_object.class.to_s] } }  
  def should_scope_created_by
    context "created_by" do
      setup do
        @user = Factory(:user)
        @user1 = Factory(:user)
        @item = Factory(klass.name.to_sym, :user => @user)
        @item1 = Factory(klass.name.to_sym, :user => @usera)
      end
      should "find items by the source they are associated with" do
        items = klass.created_by(@user)
        assert items.include?(@item), "created_by didn't find item created by user"
        assert !items.include?(@itema), "created_by found item not created by user"
      end
    end
  end
  
end


ActiveSupport::TestCase.extend(MuckNamedScopeMacros)
Test::Unit::TestCase.extend(MuckNamedScopeMacros)
ActionController::TestCase.extend(MuckNamedScopeMacros)
