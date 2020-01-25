RSpec.shared_examples_for 'Errors' do
  subject { describe_class }

  it 'has an error object' do
    expect(subject.errors).to be_instance_of(Hiro::Game::Errors)
  end
end
