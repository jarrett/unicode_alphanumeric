# Encoding: utf-8

require 'test_helper'

# Test the gem's public API.
class ApiTest < MiniTest::Unit::TestCase
  def test_scan
    assert_equal ['+', '?', '¿'], UnicodeAlphanumeric.scan('abc Ω + 123 ? ¿ Ñ def', :spaces => true)
    assert_equal [' ', '¿'], UnicodeAlphanumeric.scan('abc ¿Ñ')
  end
  
  def test_filter
    assert_equal 'abc Ω  123   Ñ def', UnicodeAlphanumeric.filter('abc Ω + 123 ? ¿ Ñ def', :spaces => true)
    assert_equal 'abcΩ123Ñdef', UnicodeAlphanumeric.filter('abc Ω + 123 ? ¿ Ñ def')
  end
  
  def test_replace
    assert_equal 'abc Ω _ 123 _ _ Ñ def', UnicodeAlphanumeric.replace('abc Ω + 123 ? ¿ Ñ def', '_', :spaces => true)
    assert_equal 'abc_Ω___123_____Ñ_def', UnicodeAlphanumeric.replace('abc Ω + 123 ? ¿ Ñ def', '_')
  end
  
  def test_map
    assert_equal(
      'abc Ω ++ 123 ?? ¿¿ Ñ def',
      UnicodeAlphanumeric.map('abc Ω + 123 ? ¿ Ñ def', :spaces => true) do |char|
        char * 2
      end
    )
    assert_equal(
      'abc  Ω  ++  123  ??  ¿¿  Ñ  def',
      UnicodeAlphanumeric.map('abc Ω + 123 ? ¿ Ñ def') do |char|
        char * 2
      end
    )
  end
end