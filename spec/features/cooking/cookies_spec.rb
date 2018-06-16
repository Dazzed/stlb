feature 'Cooking cookies' do
  scenario 'Cooking a single cookie' do
    user = create_and_signin
    oven = user.ovens.first

    visit oven_path(oven)

    expect(page).to_not have_content 'Chocolate Chip'
    expect(page).to_not have_content 'Your Cookie is Ready'

    # allow(CookieWorker).to receive(:perform_async).with(instance_of(Cookie)).and_return :result_from_service

    allow(CookieWorker).to receive(:perform_async) do |arg|
      cookie = Cookie.find(arg)
      cookie.ready = true
      cookie.save!
    end

    click_link_or_button 'Prepare Cookie'
    fill_in 'Fillings', with: 'Chocolate Chip'
    fill_in 'Quantity', with: 10
    click_button 'Mix and bake'

    sleep(12)
    expect(current_path).to eq(oven_path(oven))    
    # expect(CookieWorker).to receive_message_chain(:new, :async, :perform)
    expect(page).to have_content 'Chocolate Chip'
    expect(page).to have_content 'Your 10 cookies are Ready'

    click_button 'Retrieve Cookie'
    expect(page).to_not have_content 'Chocolate Chip'
    expect(page).to_not have_content 'Your Cookie is Ready'

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content '10 Cookies'
    end
  end

  scenario 'Trying to bake a cookie while oven is full' do
    user = create_and_signin
    oven = user.ovens.first

    oven = create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button 'Prepare Cookie'
    fill_in 'Fillings', with: 'Chocolate Chip'
    click_button 'Mix and bake'

    click_link_or_button  'Prepare Cookie'
    expect(page).to have_content 'A cookie is already in the oven!'
    expect(current_path).to eq(oven_path(oven))
    expect(page).to_not have_button 'Mix and bake'
  end

  scenario 'Baking multiple cookies' do
    user = create_and_signin
    oven = user.ovens.first

    oven = create(:oven, user: user)
    visit oven_path(oven)

    3.times do
      allow(CookieWorker).to receive(:perform_async) do |arg|
        cookie = Cookie.find(arg)
        cookie.ready = true
        cookie.save!
      end

      click_link_or_button 'Prepare Cookie'
      fill_in 'Fillings', with: 'Chocolate Chip'
      fill_in 'Quantity', with: 12
      click_button 'Mix and bake'
      sleep(12)
      click_button 'Retrieve Cookie'
    end

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content '36 Cookies'
    end
  end
end
