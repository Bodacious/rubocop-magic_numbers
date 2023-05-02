# frozen_string_literal: true

module Custom
  class NoMagicNumbers < ::RuboCop::Cop::Cop
    ILLEGAL_SCALAR_TYPES = %i[float int].freeze
    ASSIGNS_VIA_ATTR_WRITER_PATTERN = '(send ({send self} ... ) _ (${int float} _))'
    LVASGN_MSG = 'Do not use magic number local variables'
    IVASGN_MSG = 'Do not use magic number instance variables'
    SEND_MSG = 'Do not use magic numbers to set properties'

    def on_lvasgn(node)
      return unless magic_number_lvar?(node)

      add_offense(node, location: :expression, message: LVASGN_MSG)
    end

    def on_ivasgn(node)
      return unless magic_number_ivar?(node)

      add_offense(node, location: :expression, message: IVASGN_MSG)
    end

    def on_send(node)
      return unless anonymous_setter_assign?(node)

      add_offense(node, location: :expression, message: SEND_MSG)
    end

    private

    def magic_number_lvar?(node)
      return false unless node.lvasgn_type?

      value = node.children.last
      ILLEGAL_SCALAR_TYPES.include?(value.type)
    end

    def magic_number_ivar?(node)
      return false unless node.ivasgn_type?

      value = node.children.last
      ILLEGAL_SCALAR_TYPES.include?(value.type)
    end

    def anonymous_setter_assign?(node)
      return false unless node.send_type?
      return false unless RuboCop::AST::NodePattern.new(ASSIGNS_VIA_ATTR_WRITER_PATTERN).match(node)

      value = node.children.last
      ILLEGAL_SCALAR_TYPES.include?(value.type)
    end
  end
end
