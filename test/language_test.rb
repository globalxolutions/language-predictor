require 'test/unit'
require 'tempfile'
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/language.rb'))

class LanguageTest < Test::Unit::TestCase
  def setup
    language_data = <<-EOL
    abcdefghijklmnopqrstuvwxyz
    ABCDEFGHIJKLMNOPQRSTUVWXYZ
    !~.@#$%^&*()_+'?[]“”‘’—<>»«›‹–„/
    ïëéüòèöÄÖßÜøæåÅØóąłżŻśęńŚćźŁ
    EOL
    language_file = Tempfile.new('langfile')
    language_file.write(language_data)
    language_file.close
    
    @language = Language.new(language_file.path, 'English')
  end
  
  def test_alpha_frequencies
    ('a'..'z').to_a.map do |alpha|
      assert_equal 2, @language.frequency_for(alpha), alpha
    end
  end
  
  def test_punctuation_frequencies
    "!~.@#$%^&*()_+'?[]“”‘’—<>»«›‹–„/".split(//).each do |punc|
      assert_equal 0, @language.frequency_for(punc)
    end
  end
  
  def test_special_frequencies
    "ïëéyüòèöÄÖßÜøæåÅØóąłżŻśęńŚćźŁ".split(//).each do |special|
      assert_equal 1, @language.frequency_for(special)
    end
  end
end