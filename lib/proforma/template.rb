# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  # A Template instance is a set of modeling objects with directions on how to compile it into
  # a Prototype object.  The prototype instance can then be rendered into an end-result such as
  # a text, pdf, or spreadsheet file.
  class Template < Prototype
    include Compiling::Compilable

    module OutputType
      COLLECTION  = :collection
      RECORD      = :record
    end
    include OutputType

    attr_writer :output

    def output
      @output || COLLECTION
    end

    def compile(data, formatter:, resolver:)
      if output == COLLECTION
        compile_collection(data, formatter: formatter, resolver: resolver)
      elsif output == RECORD
        compile_record(data, formatter: formatter, resolver: resolver)
      else
        raise ArgumentError, "Cannot compile output type: #{output}"
      end
    end

    private

    def compile_collection(data, formatter:, resolver:)
      compiled_children = Modeling::Collection.new(children: children).compile(
        data,
        formatter: formatter,
        resolver: resolver
      )

      [
        Prototype.new(
          children: compiled_children,
          title: resolve_title({}, formatter: formatter, resolver: resolver)
        )
      ]
    end

    def resolve_title(data, formatter:, resolver:)
      evaluate_text(
        title,
        data,
        formatter: formatter,
        resolver: resolver
      )
    end

    def compile_record(data, formatter:, resolver:)
      default_grouping = Modeling::Grouping.new(children: children)

      array(resolver.resolve(nil, data)).map do |record|
        compiled_children = default_grouping.compile(
          record,
          formatter: formatter,
          resolver: resolver
        )

        Prototype.new(
          children: compiled_children,
          title: resolve_title(record, formatter: formatter, resolver: resolver)
        )
      end
    end
  end
end
