# frozen_string_literal: true

require 'minitest/autorun'
require 'test_helper'

module RuboCop
  module Cop
    module MagicNumbers
      class NoAssignment
        module Float
          class GlobalVariableTest < Minitest::Test
            def test_ignores_magic_numbers_assigned_to_global_variables_when_config_false
              matched_numerics(:float).each do |num|
                inspect_source(<<~RUBY)
                  def test_method
                    $GLOBAL_VARIABLE = #{num}
                  end
                RUBY

                assert_no_offenses
              end
            end

            private

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
                  'ForbiddenNumerics' => 'Float'
                }
              )
            end
          end
        end
      end
    end
  end
end
