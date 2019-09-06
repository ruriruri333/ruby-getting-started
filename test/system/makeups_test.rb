require "application_system_test_case"

class MakeupsTest < ApplicationSystemTestCase
  setup do
    @makeup = makeups(:one)
  end

  test "visiting the index" do
    visit makeups_url
    assert_selector "h1", text: "Makeups"
  end

  test "creating a Makeup" do
    visit makeups_url
    click_on "New Makeup"

    fill_in "St", with: @makeup.st
    click_on "Create Makeup"

    assert_text "Makeup was successfully created"
    click_on "Back"
  end

  test "updating a Makeup" do
    visit makeups_url
    click_on "Edit", match: :first

    fill_in "St", with: @makeup.st
    click_on "Update Makeup"

    assert_text "Makeup was successfully updated"
    click_on "Back"
  end

  test "destroying a Makeup" do
    visit makeups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Makeup was successfully destroyed"
  end
end
