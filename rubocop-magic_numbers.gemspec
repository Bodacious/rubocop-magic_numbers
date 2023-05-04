# frozen_string_literal: true

$LOAD_PATH << File.expand_path('lib', __dir__)
require 'rubocop/cop/magic_numbers/version'

Gem::Specification.new do |s|
  s.name = 'magic-numbers'
  s.version = RuboCop::Cop::MagicNumbers::VERSION
  s.summary = 'rubocop/magic_numbers implements a rubocop cop for detecting the use ' \
              'of bare numbers when linting'
  s.description = 'rubocop/magic_numbers implements a rubocop cop for detecting the use ' \
                  'of bare numbers when linting'

  s.files =
    Dir.glob('lib/**/*') +
    %w[README.md]

  s.require_path = 'lib'
  s.required_ruby_version = Gem::Requirement.new('>= 3.2.0')

  s.authors = ['Gavin Morrice', 'Fell Sunderland']
  s.email = ['gavin@gavinmorrice.com', 'fell@meetcleo.com']

  s.homepage = 'https://github.com/Bodacious/no-magic-numbers-cop'

  s.add_dependency('parser')
  s.add_dependency('rubocop')

  s.license = 'MIT'
  s.metadata['rubygems_mfa_required'] = 'true'
end