require 'unicode'

module UnicodeAlphanumeric
  def self.filter(str, options = {})
    replace(str, '', options)
  end
  
  def self.replace(str, replacement, options = {})
    str.gsub(ascii_regex(options)) do |char|
      alphanumeric?(char, options) ? char : replacement
    end
  end
  
  def self.scan(str, options = {})
    non_alphanumeric = []
    str.scan(ascii_regex(options)) do |char|
      non_alphanumeric << char if !alphanumeric?(char, options)
    end
    non_alphanumeric
  end
  
  def self.map(str, options = {})
    str.gsub(ascii_regex(options)) do |char|
      alphanumeric?(char, options) ? char : yield(char)
    end
  end
  
  private
  
  def self.alphanumeric?(char, options)
    # If there's any intersection between the string's categories and the alphanumeric
    # categories, then the character is alphanumeric.
    !(alphanumeric_categories(options) & Unicode.categories(char)).empty?
  end
  
  def self.alphanumeric_categories(options)
    categories = [:Lowercase_Letter, :Uppercase_Letter, :Decimal_Number]
    if options[:spaces]
      categories << :Space_Separator
    end
    categories
  end
  
  def self.ascii_regex(options)
    if options[:spaces]
      /[^a-zA-Z0-9 ]/
    else
      /[^a-zA-Z0-9]/
    end
  end  
end