from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class Checkout:

    def __init__(self):
        self.seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')

    @keyword
    def verify_if_items_selected_and_items_added_to_cart_are_same(self, productsList):
        self.seleniumlib.wait_until_element_is_visible("xpath://div[@class='media-body']/h4[@class='media-heading']")
        i = 1
        addeditems = self.seleniumlib.get_webelements("xpath://div[@class='media-body']/h4[@class='media-heading']/a")
        for addeditem in addeditems:
            if addeditem.text in productsList:
                items = self.seleniumlib.get_text("xpath:(//div[@class='media-body']/h4[@class='media-heading'])[" + str(i) + "]/a")
                print("The added items are " + str(items))
            i = i + 1