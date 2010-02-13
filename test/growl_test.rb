require "test/unit"
require 'fileutils'
require 'pathname'

FileUtils.cd(Pathname(__FILE__).parent.realpath)  # enable relative paths (even in require)

require '../lib/growl'

class GrowlTest < Test::Unit::TestCase
  include GrowlRubyApi
  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Test that the default fields are defaulting appropriately
  def test_initialize_defaulting_of_defaults
    growl = Growl.new
    assert(
        growl.default_app == Pathname($0).basename,
        "default_app failed to default to #{Pathname($0).basename.to_s.inspect}"
    )
    assert(
        growl.default_title == Pathname($0).basename,
        "default_title failed to default to #{Pathname($0).basename.to_s.inspect}"
    )
    assert(
        growl.all_notifications == ["Notify"],
        "all_notifications failed to default to #{["Notify"].inspect}"
    )
    assert(
        growl.enabled_notifications == growl.all_notifications,
        "enabled_notifications failed to default to #{growl.all_notifications.inspect}"
    )
    assert(
        growl.default_notification == growl.enabled_notifications.first,
        "default_notification failed to default to #{growl.enabled_notifications.first.inspect}"
    )
    assert(
        growl.default_image_type == :none,
        "default_image_type failed to default to #{:none.inspect}"
    )
    assert(
        growl.default_image == nil,
        "default_image failed to default to nil"
    )
  end

  # Test that notify correctly sends notification
  def test_notify
    growl = Growl.new
    growl.notify("Test message 1", :title => "Title")
    if growl.growl_enabled
      puts "Verify that growl notification with 'Title' and 'Test message 1' appeared on screen."
    else
      puts "Verify that the following message was output to console: 'Notify: Title: Test message 1'"
    end
  end

  # Test that notify correctly sends a sticky notification
  def test_notify_sticky
    growl = Growl.new
    growl.notify("Test message 2", :sticky => true)
    if growl.growl_enabled
      puts "Verify that STICKY growl notification with '#{growl.default_title}' and 'Test message 2' appeared on screen."
    else
      puts "Verify that the following message was output to console: 'Notify: #{growl.default_title}: Test message 2'"
    end
  end

  # Test fully configured setup
  def test_initialize_assigning_all_defaults
    growl = Growl.new(
        :default_app => "Growl Test",
        :default_title => "Default Title",
        :all_notifications => ["Notify", "Status", "Critical"],
        :enabled_notifications => ["Notify", "Critical"],
        :default_notification => "Critical",
        :default_image_type => :app_icon,
        :default_image => "ClamXav.app"
    )
    growl.notify("Test message 3")
    if growl.growl_enabled
      puts "Verify that growl notification with 'Default Title' and 'Test message 3' appeared on screen."
    else
      puts "Verify that the following message was output to console: 'Critical: Default Title: Test message 3'"
    end
  end

end