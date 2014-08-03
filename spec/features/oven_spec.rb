feature 'Oven' do
  scenario 'Creating an account' do
    sign_up_with('myemail@test.com', 'abcdefgh', 'abcdefgh')
    expect(current_path).to eq(root_path)

    oven = User.last.ovens.first
    expect(oven).to_not be_nil
    expect(oven.name).to eq('My First Oven')
    expect(page).to have_content(oven.name)
  end

  scenario 'Viewing an oven page' do
    user = create_and_signin
    oven = user.ovens.first

    visit root_path

    click_link oven.name
    expect(current_path).to eq(oven_path(oven))
    expect(page).to have_content oven.name
  end
end
