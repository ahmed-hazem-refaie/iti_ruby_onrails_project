require "application_system_test_case"

class ActivitesTest < ApplicationSystemTestCase
  setup do
    @activite = activites(:one)
  end

  test "visiting the index" do
    visit activites_url
    assert_selector "h1", text: "Activites"
  end

  test "creating a Activite" do
    visit activites_url
    click_on "New Activite"

    fill_in "Action", with: @activite.action
    fill_in "User", with: @activite.user_id
    click_on "Create Activite"

    assert_text "Activite was successfully created"
    click_on "Back"
  end

  test "updating a Activite" do
    visit activites_url
    click_on "Edit", match: :first

    fill_in "Action", with: @activite.action
    fill_in "User", with: @activite.user_id
    click_on "Update Activite"

    assert_text "Activite was successfully updated"
    click_on "Back"
  end

  test "destroying a Activite" do
    visit activites_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Activite was successfully destroyed"
  end
end
