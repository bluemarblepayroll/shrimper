# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    # A grouping is an inverted collection, meaning, it iterates each child once per record
    # instead of only one time.  It also provides a mechanic to traverse data to tap
    # nested child data (through the property attribute.)
    class Grouping < AttributeBasedObject
      include Compiling::Compilable

      attr_accessor :property

      attr_writer :children

      def children
        Array(@children)
      end

      def compile(data, formatter:, resolver:)
        records = array(resolver.resolve(property, data))

        records.map do |record|
          Collection.new(children: children).compile(
            record,
            formatter: formatter,
            resolver: resolver
          )
        end.flatten
      end
    end
  end
end
