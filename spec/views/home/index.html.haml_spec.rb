require 'rails_helper'

RSpec.describe 'home/index.html.haml', type: :view do
  before do
    stub_template 'home/partials/_slider.html.haml' => 'slider'
    render
  end

  it 'displays get started' do
    expect(rendered).to match(/#{t('home.welcome')}/)
  end
end
