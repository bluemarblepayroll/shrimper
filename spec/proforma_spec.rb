# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe ::Proforma do
  it 'should process each snapshot successfully' do
    dir = File.join('spec', 'fixtures', 'snapshots', '*.yml')

    Dir[dir].each do |file|
      contents = yaml_read(file)

      expected_documents = contents['documents']

      actual_documents = described_class.render(
        contents['data'],
        contents['template'],
        formatter: contents['formatter'] || ::Proforma::Compiling::Formatter.new,
        renderer: contents['renderer'] || ::Proforma::Renderers::PlainTextRenderer.new,
        resolver: contents['resolver'] || ::Proforma::Compiling::Resolver.new
      )

      expect(actual_documents).to eq(expected_documents)
    end
  end
end
