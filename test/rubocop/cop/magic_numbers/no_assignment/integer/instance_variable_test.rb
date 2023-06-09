# frozen_string_literal: true

require 'minitest/autorun'
require 'test_helper'

module RuboCop
  module Cop
    module MagicNumbers
      class NoAssignment
        module Integer
          class InstanceVariableTest < Minitest::Test
            def setup
              @matched_numerics = TestHelper::INTEGER_LITERALS
            end

            def test_detects_magic_numbers_assigned_to_instance_variables
              @matched_numerics.each do |num|
                inspect_source(<<~RUBY)
                  def test_method
                    @instance_variable = #{num}
                  end
                RUBY

                assert_instance_variable_offense
              end
            end

            private

            def assert_instance_variable_offense
              assert_offense(
                cop_name: cop.name,
                violation_message: described_class::INSTANCE_VARIABLE_ASSIGN_MSG
              )
            end

            def described_class
              RuboCop::Cop::MagicNumbers::NoAssignment
            end

            def cop
              @cop ||= described_class.new(config)
            end

            def config
              @config ||= RuboCop::Config.new(
                'MagicNumbers/NoAssignment' => {
                  'Enabled' => true,
                  'ForbiddenNumerics' => 'Integer'
                }
              )
            end
          end
        end
      end
    end
  end
end
