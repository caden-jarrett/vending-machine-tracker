require 'rails_helper'

RSpec.describe 'as a visitor, when I visit the snack show page' do

  scenario 'I can see the name of that snack' do
    owner = Owner.create(name: "Sam's Snacks")
        dons  = owner.machines.create(location: "Don's Mixed Drinks")
        turing = owner.machines.create(location: "Turing Basement")
        snack1 = Snack.create(name: "Potato Chips", price: 2)
        snack2 = Snack.create(name: "Chocolate Bar", price: 4)
        snack3 = Snack.create(name: "Pop Tart", price: 7)
        snack4 = Snack.create(name: "Health Bar", price: 12)
        snack5 = Snack.create(name: "Peanuts", price: 1)

        dons.snacks << [snack1, snack2, snack3]
        turing.snacks << [snack3, snack4, snack5]

    visit snack_path(snack3)

    within '#snack-info' do
      expect(page).to have_content('Snack: Pop Tart')
      expect(page).not_to have_content('Snack: Tea')
    end
  end

  scenario 'I can see the locations of that snack' do
    owner = Owner.create(name: "Sam's Snacks")
        dons  = owner.machines.create(location: "Don's Mixed Drinks")
        turing = owner.machines.create(location: "Turing Basement")
        snack1 = Snack.create(name: "Potato Chips", price: 2.5)
        snack2 = Snack.create(name: "Chocolate Bar", price: 1.75)
        snack3 = Snack.create(name: "Pop Tart", price: 2.75)
        snack4 = Snack.create(name: "Health Bar", price: 3.25)
        snack5 = Snack.create(name: "Peanuts", price: 1.75)

        dons.snacks << [snack1, snack2, snack3]
        turing.snacks << [snack3, snack4, snack5]

    visit snack_path(snack3)
    
    within '#snack-info' do
      expect(page).to have_content('Locations:')
      expect(page).to have_content("Don's Mixed Drinks (3 kinds of snacks, average price of $2.33)")
      expect(page).to have_content("Turing Basement (3 kinds of snacks, average price of $2.58)")
    end
  end
end
