require 'spec_helper'
require 'generators/rails/blue_print_generator'

describe Rails::Generators::BluePrintGenerator do
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
        directory 'app/blue_prints' do
          file 'staff_context.rb' do
            contains 'StaffContext'
          end
        end
      end)
    end
  end

  context 'with Staff --parent=SpecContext' do
    let(:arguments) { %w(Staff --parent=SpecContext) }

    specify 'be generated' do
      expect(destination_root).to(have_structure do
        directory 'app/blue_prints' do
          file 'staff_context.rb' do
            contains 'StaffContext < SpecContext'
          end
        end
      end)
    end
  end

  context 'with Staff --active-if=staff,spec' do
    let(:arguments) { %w(Staff --active_if=staff spec) }

    specify 'be generated' do
      expect(destination_root).to(have_structure do
        directory 'app/blue_prints' do
          file 'staff_context.rb' do
            contains 'active_if :staff, :spec'
          end
        end
      end)
    end
  end

  context 'with Staff user:staff:customer' do
    let(:arguments) { %w(Staff user:staff:customer) }

    specify 'be generated' do
      expect(destination_root).to(have_structure do
        directory 'app/blue_prints' do
          file 'staff_context.rb' do
            contains 'act ::User, as: [Staff, Customer]'
          end

          directory 'staff_context' do
            file 'staff.rb' do
              contains 'StaffContext::Staff'
            end

            file 'customer.rb' do
              contains 'StaffContext::Customer'
            end
          end
        end
      end)
    end
  end
end
