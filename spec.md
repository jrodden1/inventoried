# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
   * Using Rails 5.2.3
   * Using Ruby 2.4.1
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
   * User has_many Items
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
   * Item belongs_to User
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
   * User has many location_items, through: locations
   * Location has_many items, through: location_items
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
   * Location has many items, through: location_items
   * Item has many locations, through: location items
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
   * location_item.quantity - how much of a specific item is in stock at a specific location
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
   * User - validates name & email for presence; email for uniqueness
   * Location - validates name for presence and uniqueness
   * LocationItem - validates quantity for presence
   * Item validates name for presence
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
   * Item.search URL: /items - Item.search is chainable - this is done in ItemController #index
- [x] Include signup (how e.g. Devise)
   * manually created UserController #signup method and route.
- [x] Include login (how e.g. Devise)
   * manually created SessionController #login method and route.
- [x] Include logout (how e.g. Devise)
   * manually created SessionController #logout method and route.
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
   * used omniauth-facebook gem and created method under User called .find_or_create_by_facebook_omniauth
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
   * locations/2/location_items/5 - show
   * locations/2/location_items - index
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
   * locations/2/location_items/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
   * I use flash messaging to display errors on the form pages like new, edit
   * Currently I am not styling the form fields with errors any different -- though they are getting the class of `field_with_errors` when errors are found.  

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate