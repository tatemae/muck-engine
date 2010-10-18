# Scopes tested by these macros:
#
# scope :by_title, order("title ASC")
# scope :by_name, order("name ASC")
# scope :recent, lambda { |*args| where("created_at > ?", args.first || 7.days.ago.to_s(:db)) }
# scope :newest, order("created_at DESC")
# scope :oldest, order("items.created_at ASC")
# scope :latest, order("items.updated_at DESC")
# scope :before, lambda { |*args| where("created_at < ?", args.first || DateTime.now) }
# scope :since, lambda { |*args| where("created_at > ?", args.first || 1.day.ago.to_s(:db)) }
# scope :only_public, where(["is_public = ?", true])
# scope :created_by, lambda { |creator| where("creator_id = ? AND creator_type = ?", creator.id, creator.class.to_s) } }
# scope :created_by, lambda { |creator_id| where("creator_id = ?", creator_id) }
# scope :sorted, order("sort ASC")

# The following macros are available:
# it { should scope_by_title }
# should_scope_by_alpha_title
# should_scope_by_name
# should_scope_latest
# should_scope_newest
# should_scope_by_newest
# should_scope_oldest
# should_scope_by_oldest
# should_scope_recent
# should_scope_before
# should_scope_since
# should_scope_only_public
# should_scope_public
# should_scope_created_by
# should_scope_by_creator
# should_scope_sorted
module MuckNamedScopeMacros

  # Test for 'by_title' named scope which orders by title:
  # scope :by_title, :order => "title ASC"
  # requires that the class have a shoulda factory
  def it { should scope_by_title }
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'by_title' title scope" do
      setup do
        klass.delete_all
        @first = Factory(factory_name, :title => 'a')
        @second = Factory(factory_name, :title => 'b')
      end
      should "sort by name" do
        assert_equal @first, klass.by_title[0]
        assert_equal @second, klass.by_title[1]
      end
    end
  end
    
  # Test for 'by_alpha' named scope which orders by title:
  # scope :by_alpha, :order => "title ASC"
  # requires that the class have a shoulda factory
  def should_scope_by_alpha_title
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'by_alpha' title scope" do
      setup do
        klass.delete_all
        @first = Factory(factory_name, :title => 'a')
        @second = Factory(factory_name, :title => 'b')
      end
      should "sort by name" do
        assert_equal @first, klass.by_alpha[0]
        assert_equal @second, klass.by_alpha[1]
      end
    end
  end
    
  # Test for 'by_name' named scope which orders by name:
  # scope :by_name, :order => "name ASC"
  # requires that the class have a shoulda factory
  def should_scope_by_name
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'by_name' named scope" do
      setup do
        klass.delete_all
        @first = Factory(factory_name, :name => 'a')
        @second = Factory(factory_name, :name => 'b')
      end
      should "sort by name" do
        assert_equal @first, klass.by_name[0]
        assert_equal @second, klass.by_name[1]
      end
    end
  end
  
  # For 'latest named scope which orders by updated at:
  #  scope :latest, :order => "{klass}.updated_at DESC"
  def should_scope_latest
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'latest' named scope" do
      setup do
        klass.delete_all
        @first = Factory(factory_name, :updated_at => 1.day.ago)
        @second = Factory(factory_name, :updated_at => 1.week.ago)
      end
      should "sort by created_at" do
        assert_equal @first, klass.latest[0]
        assert_equal @second, klass.latest[1]
      end
    end
  end
  
  # Test for 'newest' named scope which orders by 'created_at DESC'
  # scope :newest, :order => "created_at DESC"
  # requires that the class have a shoulda factory
  def should_scope_newest
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'newest' named scope" do
      setup do
        klass.delete_all
        @first = Factory(factory_name, :created_at => 1.day.ago)
        @second = Factory(factory_name, :created_at => 1.week.ago)
      end
      should "sort by created_at" do
        assert_equal @first, klass.newest[0]
        assert_equal @second, klass.newest[1]
      end
    end
  end
  
  def should_scope_by_newest
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'by_newest' named scope" do
      setup do
        klass.delete_all
        @first = Factory(factory_name, :created_at => 1.day.ago)
        @second = Factory(factory_name, :created_at => 1.week.ago)
      end
      should "sort by created_at" do
        assert_equal @first, klass.by_newest[0]
        assert_equal @second, klass.by_newest[1]
      end
    end
  end
  
  # Test for 'oldest' named scope which orders by 'created_at ASC'
  # scope :oldest, :order => "items.created_at ASC"
  # requires that the class have a shoulda factory
  def should_scope_oldest
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'oldest' named scope" do
      setup do
        klass.delete_all
        @first = Factory(factory_name, :created_at => 1.day.ago)
        @second = Factory(factory_name, :created_at => 1.week.ago)
      end
      should "sort by created_at" do
        assert_equal @first, klass.oldest[1]
        assert_equal @second, klass.oldest[0]
      end
    end
  end
  
  def should_scope_by_oldest
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'by_oldest' named scope" do
      setup do
        klass.delete_all
        @first = Factory(factory_name, :created_at => 1.day.ago)
        @second = Factory(factory_name, :created_at => 1.week.ago)
      end
      should "sort by created_at" do
        assert_equal @first, klass.by_oldest[1]
        assert_equal @second, klass.by_oldest[0]
      end
    end
  end
  
  # Test for 'recent' named scope which orders by items created recently
  # scope :recent, lambda { { :conditions => ['items.created_at > ?', 1.week.ago] } }
  # requires that the class have a shoulda factory
  def should_scope_recent
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'recent' named scope" do
      setup do
        klass.delete_all
        @recent = Factory(factory_name)
        @not_recent = Factory(factory_name, :created_at => 10.weeks.ago)
      end
      should "get recent" do
        assert klass.recent.include?(@recent), "since didn't include recent #{klass.name}"
      end
      should "not get recent" do
        assert !klass.recent.include?(@not_recent), "since did include recent #{klass.name}"
      end
    end
  end
  
  # Tests 'before' named scope
  # scope :before, lambda { |time| {:conditions => ["items.created_at < ?", time || DateTime.now] } }
  def should_scope_before
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'before' named scope" do
      setup do
        klass.delete_all
        @old = Factory(factory_name, :created_at => 6.weeks.ago)
        @new = Factory(factory_name)
      end
      should "only find older than a given date" do
        items = klass.before(1.week.ago)
        assert items.include?(@old), "since didn't find older #{klass.name}"
        assert !items.include?(@new), "since found new #{klass.name}"
      end
    end
  end

  # Tests 'since' named scope
  # scope :since, lambda { |time| {:conditions => ["items.created_at > ?", time || DateTime.now] } }
  def should_scope_since
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'since' named scope" do
      setup do
        klass.delete_all
        @old = Factory(factory_name, :created_at => 6.weeks.ago)
        @new = Factory(factory_name)
      end
      should "get newer" do
        assert klass.since(1.day.ago).include?(@new), "since didn't find new #{klass.name}"
      end
      should "not get older" do
        assert !klass.since(1.day.ago).include?(@old), "since found older #{klass.name}"
      end
    end
  end

  # Tests 'only_public' named scope
  # scope :only_public, :conditions => ["items.is_public = ?", true]
  def should_scope_only_public
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "public" do
      setup do
        klass.delete_all
        @private_item = Factory(factory_name, :is_public => false)
        @public_item = Factory(factory_name, :is_public => true)
      end
      should "only find public items" do
        assert klass.only_public.include?(@public_item), "didn't find public item"
        assert !klass.only_public.include?(@private_item), "found private item"
      end
    end
  end

  # Tests 'public' named scope
  # scope :public, :conditions => "is_public = true"
  def should_scope_public
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "public" do
      setup do
        klass.delete_all
        @private_item = Factory(factory_name, :is_public => false)
        @public_item = Factory(factory_name, :is_public => true)
      end
      should "only find public items" do
        assert klass.public.include?(@public_item), "didn't find public item"
        assert !klass.public.include?(@private_item), "found private item"
      end
    end
  end

  # Tests 'created_by' named scope.
  # scope :created_by, lambda { |item_object| {:conditions => ["items.source_id = ? AND items.source_type = ?", item_object.id, item_object.class.to_s] } }  
  def should_scope_created_by
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "created_by" do
      setup do
        klass.delete_all
        @user = Factory(:user)
        @user1 = Factory(:user)
        @item = Factory(factory_name, :user => @user)
        @item1 = Factory(factory_name, :user => @user1)
      end
      should "find items by the source they are associated with" do
        items = klass.created_by(@user)
        assert items.include?(@item), "created_by didn't find item created by user"
        assert !items.include?(@item1), "created_by found item not created by user"
      end
    end
  end
  
  # Tests 'by_creator' named scope.
  # scope :by_creator, lambda { |creator_id| { :conditions => ['creator_id = ?', creator_id || 0] } }
  def should_scope_by_creator
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "by_creator" do
      setup do
        klass.delete_all
        @user = Factory(:user)
        @user1 = Factory(:user)
        @item = Factory(factory_name, :creator => @user)
        @item1 = Factory(factory_name, :creator => @user1)
      end
      should "find items by the source they are associated with" do
        items = klass.by_creator(@user)
        assert items.include?(@item), "created_by didn't find item created by user"
        assert !items.include?(@item1), "created_by found item not created by user"
      end
    end
  end
  
  # Tests 'sorted' named scope
  # scope :sorted, :order => "sort ASC"
  def should_scope_sorted
    klass = get_klass
    factory_name = name_for_factory(klass)
    context "'sorted' named scope" do
      setup do
        klass.delete_all
        @first = Factory(factory_name, :sort => 1)
        @second = Factory(factory_name, :sort => 2)
      end
      should "sort by 'sort' field" do
        assert_equal @first, klass.sorted[0]
        assert_equal @second, klass.sorted[1]
      end
    end
  end
  
  def name_for_factory(klass)
    klass.name.underscore.to_sym
  end
  
  def get_klass
    self.name.gsub(/Test$/, '').constantize
  end
  
end


ActiveSupport::TestCase.extend(MuckNamedScopeMacros)
Test::Unit::TestCase.extend(MuckNamedScopeMacros)
ActionController::TestCase.extend(MuckNamedScopeMacros)
