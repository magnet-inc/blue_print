require 'spec_helper'
require 'generators/rspec/blue_print_generator'

describe Rspec::BluePrintGenerator do
  destination File.expand_path('spec/tmp')

  before do
    prepare_destination
    run_generator arguments
  end

  after do
    FileUtils.rm_rf destination_root
  end

  context 'with Staff' do
    let(:arguments) { %w(Staff) }

    specify 'be generated' do
      expect(destination_root).to(have_structure do
        directory 'spec/blue_prints' do
          file 'staff_context_spec.rb' do
            contains 'StaffContext'
          end
        end
      end)
    end
  end

  context 'with Staff user:staff:customer' do
    let(:arguments) { %w(Staff user:staff:customer_user) }

    specify 'be generated' do
      expect(destination_root).to(have_structure do
        directory 'spec/blue_prints/staff_context' do
          file 'staff_spec.rb' do
            contains 'StaffContext::Staff'
          end

          file 'customer_user_spec.rb' do
            contains 'StaffContext::CustomerUser'
          end
        end
      end)
    end
  end
end
