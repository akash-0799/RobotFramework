from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn

# library can be imported directly since it is not a robot file, we can get using BuiltIn class in constructor
# method name will be converted to keyword name     Hello World
# we are using customize keywords


@library
class Shop:

    def __init__(self):
        self.SelLib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def hello_world(self):
        print("hello")

    @keyword
    def add_items_to_cart_and_checkout(self, products_list):
        i = 1
        products_titles = self.SelLib.get_webelements("css:.card-title")
        for products_title in products_titles:
            if products_title.text in products_list:
                self.SelLib.click_button("xpath:(//button[@class='btn btn-info'])["+str(i)+"]")

            i = i+1
        self.SelLib.click_link("css:li.active a")





