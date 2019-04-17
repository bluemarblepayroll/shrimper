# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'data_table/aggregator'
require_relative 'data_table/column'

module Proforma
  module Modeling
    # A table that understands how to be compiled against a data source.
    class DataTable < AttributeBasedObject
      include Compiling::Compilable

      attr_accessor :property

      attr_writer :aggregators,
                  :columns,
                  :empty_message

      def empty_message
        @empty_message.to_s
      end

      def aggregators
        Array(@aggregators)
      end

      def columns
        Array(@columns)
      end

      def compile(data, formatter:, resolver:)
        records = array(resolver.resolve(property, data))

        return Text.new(value: empty_message) if show_empty_message?(records)

        meta_data = make_aggregator_meta_data(records, resolver: resolver)

        Table.new(
          body: make_body(records, formatter: formatter, resolver: resolver),
          footer: make_footer(meta_data, formatter: formatter, resolver: resolver),
          header: make_header({}, formatter: formatter, resolver: resolver)
        )
      end

      private

      def make_aggregator_meta_data(records, resolver:)
        Compiling::Aggregation.new(aggregators, resolver).add(records).to_hash
      end

      def footer?
        columns.select(&:footer?).any?
      end

      def header?
        columns.select(&:header?).any?
      end

      def show_empty_message?(records)
        records.empty? && !empty_message.empty?
      end

      def make_footer(meta_data, formatter:, resolver:)
        return Table::Section.new unless footer?

        rows = [
          make_row(:compile_footer_cell, meta_data, formatter: formatter, resolver: resolver)
        ]

        Table::Section.new(rows: rows)
      end

      def make_header(meta_data, formatter:, resolver:)
        return Table::Section.new unless header?

        rows = [
          make_row(:compile_header_cell, meta_data, formatter: formatter, resolver: resolver)
        ]

        Table::Section.new(rows: rows)
      end

      def make_body(records, formatter:, resolver:)
        rows = records.map do |record|
          make_row(:compile_body_cell, record, formatter: formatter, resolver: resolver)
        end

        Table::Section.new(rows: rows)
      end

      def make_row(method, record, formatter:, resolver:)
        cells = columns.map do |column|
          column.send(method, record, formatter: formatter, resolver: resolver)
        end

        Table::Row.new(cells: cells)
      end
    end
  end
end
