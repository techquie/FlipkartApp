require "application_system_test_case"

class WalletsTest < ApplicationSystemTestCase
  setup do
    @wallet = wallets(:one)
  end

  test "visiting the index" do
    visit wallets_url
    assert_selector "h1", text: "Wallets"
  end

  test "creating a Wallet" do
    visit wallets_url
    click_on "New Wallet"

    fill_in "Amount", with: @wallet.amount
    fill_in "Customer", with: @wallet.customer_id
    fill_in "Pin", with: @wallet.pin
    click_on "Create Wallet"

    assert_text "Wallet was successfully created"
    click_on "Back"
  end

  test "updating a Wallet" do
    visit wallets_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @wallet.amount
    fill_in "Customer", with: @wallet.customer_id
    fill_in "Pin", with: @wallet.pin
    click_on "Update Wallet"

    assert_text "Wallet was successfully updated"
    click_on "Back"
  end

  test "destroying a Wallet" do
    visit wallets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wallet was successfully destroyed"
  end
end
