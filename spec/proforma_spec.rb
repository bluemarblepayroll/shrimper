# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe ::Proforma do
  let(:snapshot_dir) { File.join('spec', 'fixtures', 'snapshots', '*.yml') }

  let(:snapshot_filenames) { Dir[snapshot_dir] }

  it 'should process each snapshot successfully' do
    snapshot_filenames.each do |file|
      contents = yaml_read(file)

      expected_documents = contents['documents']

      actual_documents = described_class.render(
        contents['data'],
        contents['template'],
        evaluator: contents['evaluator'] || Proforma::Evaluators::HashEvaluator.new,
        renderer: contents['renderer'] || Proforma::Renderers::PlainTextRenderer.new
      )

      expect(actual_documents).to eq(expected_documents)
    end
  end
end
