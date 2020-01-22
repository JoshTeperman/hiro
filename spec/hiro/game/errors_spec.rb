
RSpec.describe 'test module' do
  let(:dummy_class) { Class.new { include Hiro::Game::Errors } }

  it 'returns hello world' do
    expect(dummy_class.greeting).to eq 'hello world'
  end
end
