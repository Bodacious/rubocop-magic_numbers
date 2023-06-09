# frozen_string_literal: true

require 'minitest/autorun'
require 'test_helper'

module RuboCop
  module Cop
    module MagicNumbers
      class NoAssignment
        class SetterTest < Minitest::Test
          def test_ignores_magic_numbers_assigned_via_setters_outside_of_methods
            matched_numerics.each do |num|
              inspect_source(<<~RUBY)
                self.set_attribute = #{num}
              RUBY

              assert_no_offenses
            end
          end

          def test_detects_magic_numbers_assigned_via_setters_on_self
            matched_numerics.each do |num|
              inspect_source(<<~RUBY)
                def test_method
                  self.set_attribute = #{num}
                end
              RUBY

              assert_property_offense
            end
          end

          def test_detects_magic_numbers_assigned_via_setters_on_another_object
            matched_numerics.each do |num|
              inspect_source(<<~RUBY)
                def test_method
                  foo.set_attribute = #{num}
                end
              RUBY

              assert_property_offense
            end
          end

          private

          def assert_property_offense
            assert_offense(
              cop_name: cop.name,
              violation_message: described_class::PROPERTY_MSG
            )
          end

          def described_class
            RuboCop::Cop::MagicNumbers::NoAssignment
          end

          def cop
            @cop ||= described_class.new(config)
          end

          def config
            @config ||= RuboCop::Config.new('MagicNumbers/NoAssignment' => { 'Enabled' => true })
          end
        end
      end
    end
  end
end
