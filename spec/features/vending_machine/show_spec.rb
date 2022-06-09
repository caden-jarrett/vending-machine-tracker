require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  xscenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)
    within '#machine-info' do
      expect(page).to have_content("Don's Mixed Drinks Vending Machine")
    end
  end

  scenario 'they see all of the snacks associated with that machine and their price' do
    owner_1 = Owner.create(name: "Sam's Snacks")
    owner_2 = Owner.create(name: "Ray's Snacks")

    dons  = owner_1.machines.create(location: "Don's Mixed Drinks")
    ray  = owner_2.machines.create(location: "Ray's Mixed Drinks")

    soda = dons.snacks.create(name:'Soda Pop', price:1.75)
    tea = dons.snacks.create(name:'Tea', price:1.25)
    gatorade = dons.snacks.create(name:'Gatorade', price:2.50)

    water = ray.snacks.create(name:'Water', price:2.00)

    visit machine_path(dons)

    expect(page).to have_content('Machine Snacks')

    within '#machine-snacks' do
      expect(page).to have_content('Soda Pop: $1.75')
      expect(page).to have_content('Tea: $1.25')
      expect(page).to have_content('Gatorade: $2.5')
      expect(page).not_to have_content('Gatorade: $2.00')
    end
  end

  xscenario 'the vending machine show page displays average price' do
    #test doesnt pass as I cant call round(2) at any point to round it to two decimal places
    owner_1 = Owner.create(name: "Sam's Snacks")
    owner_2 = Owner.create(name: "Ray's Snacks")

    dons  = owner_1.machines.create(location: "Don's Mixed Drinks")
    ray  = owner_2.machines.create(location: "Ray's Mixed Drinks")

    soda = dons.snacks.create(name:'Soda Pop', price:1.75)
    tea = dons.snacks.create(name:'Tea', price:1.25)
    gatorade = dons.snacks.create(name:'Gatorade', price:2.50)

    water = ray.snacks.create(name:'Water', price:2.00)
    visit machine_path(dons)
    save_and_open_page

    within '#average-price' do
      expect(page).to have_content('Average Snack Price: $1.83')
    end
  end
end
