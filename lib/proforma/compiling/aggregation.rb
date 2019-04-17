# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Compiling
    # This class is a group of aggregators that knows how to process records.
    class Aggregation
      attr_reader :aggregators, :resolver

      def initialize(aggregators, resolver)
        @aggregators  = Array(aggregators)
        @counters     = {}
        @resolver     = resolver
      end

      def add(records)
        records.each do |record|
          aggregators.each do |aggregator|
            property  = aggregator.property
            value     = resolver.resolve(property, record)
            name      = aggregator.name

            entry(name).add(value)
          end
        end

        self
      end

      def to_hash
        aggregators.map { |aggregator| execute(aggregator) }.to_h
      end

      private

      attr_reader :counters

      def entry(name)
        counters[name.to_s] ||= Counter.new
      end

      def execute(aggregator)
        name      = aggregator.name
        function  = aggregator.function

        raise ArgumentError, "bad func: #{function}" unless entry(name).respond_to?(function)

        value = entry(name).send(function)

        [name, value.to_s('f')]
      end
    end
  end
end
